package com.cartmatic.estoresf.catalog.web.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.catalog.CatalogConstants;
import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.catalog.service.ProductMediaManager;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.catalog.Category;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductMedia;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.textsearch.model.SearchResult;
import com.cartmatic.estore.textsearch.query.QueryCriteria;
import com.cartmatic.estoresf.catalog.model.ProductVO;

/**
 * 
 * @author Administrator
 *
 */
@Controller
public class ProductSearchFrontController extends GenericStoreFrontController<Product> {
	private ProductManager productManager = null;
	@Autowired
	private BrandManager brandManager=null;
	private SolrService solr = null;
	@Autowired
	 private ProductMediaManager productMediaManager = null;
	 
	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		mgr = productManager;
	}

	@Override
    @RequestMapping(value="/search-prod.html")
	public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response) {
		Store store=ConfigUtil.getInstance().getStore();
		ModelAndView mv = getModelAndView("catalog/searchProductList");
		List<Product> results = new ArrayList<Product>();
		SearchResult searchResult = solr.queryProductBySearch(request,store.getCategoryListPerSize());
		List<Integer> ids = (List<Integer>)searchResult.getResultList();
		for (Integer id : ids)
		{
			Product product=productManager.getById(id);
			if(product!=null)
				results.add(product);
		}
		mv.addObject("facetMap", searchResult.getFacetMap());
		mv.addObject("productList", results);
		Integer cat=ServletRequestUtils.getIntParameter(request, "cat", ConfigUtil.getInstance().getStore().getCatalog().getCategoryId());
		Category searcheCategory=CatalogHelper.getInstance().getCategoryById4Front(Constants.CATEGORY_TYPE_CATALOG, cat);
		mv.addObject("category", searcheCategory);
		request.setAttribute("category", searcheCategory);
		Integer brandId=(Integer)request.getAttribute("brandId");
		if(brandId!=null){
			Brand brand=brandManager.getById(brandId);
			request.setAttribute("brand", brand);
		}
		return mv;
	}
	
	/**
	 * 根据产品名称搜索产品（solr）
	 * @param request
	 * @param response
	 * @return
	 */
    @RequestMapping(value="/search-prod-byName.html")
	public ModelAndView searchByName(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Store store=ConfigUtil.getInstance().getStore();
		SearchResult sr =solr.queryProductByNameSearch(request, store.getCategoryListPerSize());
		List<Integer> ids = (List<Integer>)sr.getResultList();
		
//		Map<Integer,List<ProductMedia>> maps = new HashMap<Integer,List<ProductMedia>>();
		
		int pageCount = ((QueryCriteria)request.getAttribute("sc")).getPageCount();
		List<ProductVO> vos = new ArrayList<ProductVO>();
		
		for (Integer id : ids)
		{
			ProductVO vo = new ProductVO();
			Product product=productManager.getById(id);
			vo.setProductId(id);
			vo.setProductName(product.getProductName());
			vo.setPageCount(pageCount);
			List<ProductMedia>productMoreImages=null;
			productMoreImages=productMediaManager.findProductMediaByProductIdAndType(id, CatalogConstants.PRODUCT_MEDIA_TYPE_MORE_IMAGE);
			List<String> medias = new ArrayList<String>();
			for(ProductMedia pm : productMoreImages){
				medias.add(pm.getMediaUrlLarge());
			}
			vo.setMedia(product.getDefaultProductSku().getImage());
			vo.setMedias(medias);
//			maps.put(id, productMoreImages);
			vos.add(vo);
		}
//		JSONArray ja = JSONArray.fromObject(maps);
		JSONArray ja = JSONArray.fromObject(vos);
		PrintWriter out = response.getWriter();
	    out.println(ja);
		return null;
	}

	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}
	public void setSolrService(SolrService avalue)
	{
		this.solr = avalue;
	}

	public ProductMediaManager getProductMediaManager() {
		return productMediaManager;
	}

	public void setProductMediaManager(ProductMediaManager productMediaManager) {
		this.productMediaManager = productMediaManager;
	}
}
