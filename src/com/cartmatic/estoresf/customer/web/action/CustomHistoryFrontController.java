package com.cartmatic.estoresf.customer.web.action;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.CatalogConstants;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.catalog.service.ProductMediaManager;
import com.cartmatic.estore.catalog.service.ProductReviewManager;
import com.cartmatic.estore.catalog.service.ProductStatManager;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductMedia;
import com.cartmatic.estore.common.model.catalog.ProductReview;
import com.cartmatic.estore.common.model.catalog.ProductStat;
import com.cartmatic.estore.common.model.customer.CustomHistory;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.Favorite;
import com.cartmatic.estore.common.model.system.AppUser;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.customer.service.CustomHistoryManager;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.FavoriteManager;
import com.cartmatic.estore.webapp.util.RequestContext;

@Controller
public class CustomHistoryFrontController extends GenericStoreFrontController<CustomHistory> {

	@Autowired
	private CustomHistoryManager customHistoryManager;
	@Autowired
	private ProductManager productManager;
	@Autowired
	private ProductMediaManager productMediaManager = null;
	
	@Autowired
	private FavoriteManager favoriteManager;
	@Autowired
	private CustomerManager customerManager;
	@Autowired
	private ProductStatManager productStatManager;
	@Autowired
	private ProductReviewManager productReviewManager;
	
	@RequestMapping(value="/customHistory/save.html", method=RequestMethod.POST)
	public ModelAndView save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = null;
		AjaxView av = new AjaxView(response);
		av.setStatus(Short.valueOf("3"));
		String productId = request.getParameter("productId");
		Product product = this.productManager.getById(Integer.parseInt(productId));
		AppUser user = (AppUser) RequestContext.getCurrentUser();
		CustomHistory ch = this.customHistoryManager.findUniqueCH(user.getAppuserId(), Integer.parseInt(productId));
		if(ch == null){
			ch = new CustomHistory();
			ch.setAppUser(user);
			ch.setProduct(product);
			ch.setUpdateTime(new Date(System.currentTimeMillis()));
			this.customHistoryManager.save(ch);
			av.setStatus(Short.valueOf("1"));
		}else{
			av.setStatus(Short.valueOf("2"));
		}
		
		Store store=ConfigUtil.getInstance().getStore();
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		Favorite f = favoriteManager.loadFavorite(store.getStoreId(),customer.getAppuserId(), product.getProductId());
		if(f == null){
			Favorite entity = new Favorite();
			entity.setStore(store);
			entity.setCustomer(customer);
			entity.setProduct(product);
			favoriteManager.save(entity);
			favoriteManager.updateFavoriteStat(store.getStoreId(),product.getProductId());
			//更新索引
			CatalogHelper.getInstance().indexNotifyUpdateEvent(product.getProductId());
		}
		
		return av;
//		return mv;
	}
	
	@RequestMapping(value="/custom/talent.html", method=RequestMethod.GET)
	public ModelAndView talent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
/*		ModelAndView mv = new ModelAndView("custom/talent");
		List<CustomHistory> chList = this.customHistoryManager.getAllOrdered("updateTime", true);
		for(CustomHistory ch : chList){
			List<ProductMedia>productMoreImages=productMediaManager.findProductMediaByProductIdAndType(ch.getProduct().getProductId(), CatalogConstants.PRODUCT_MEDIA_TYPE_MORE_IMAGE);
			if(productMoreImages != null){
				ch.setUrl(productMoreImages.get(0).getMediaUrlLarge());
			}
		}
		mv.addObject("chList", chList);*/
		ModelAndView mv = new ModelAndView("custom/talent");
		Store store = ConfigUtil.getInstance().getStore();
        List<ProductReview> rs = productReviewManager.getAll();
		for(ProductReview pr : rs){
			ProductStat proStat = productStatManager.getProductStat(store.getStoreId(), pr.getProductId());
			pr.setLoveCount(proStat.getFavoriteCount());
			List<ProductMedia>productMoreImages=productMediaManager.findProductMediaByProductIdAndType(pr.getProductId(), CatalogConstants.PRODUCT_MEDIA_TYPE_MORE_IMAGE);
			if(productMoreImages != null){
				pr.setUrl(productMoreImages.get(0).getMediaUrlLarge());
			}
		}
		mv.addObject("rsList", rs);
		return mv;
	}
	
	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		this.mgr = this.customHistoryManager;
	}

	public CustomHistoryManager getCustomHistoryManager() {
		return customHistoryManager;
	}

	public void setCustomHistoryManager(CustomHistoryManager customHistoryManager) {
		this.customHistoryManager = customHistoryManager;
	}

	public ProductMediaManager getProductMediaManager() {
		return productMediaManager;
	}

	public void setProductMediaManager(ProductMediaManager productMediaManager) {
		this.productMediaManager = productMediaManager;
	}

	
}
