
package com.cartmatic.estoresf;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.common.service.SolrService;

@Controller
public class MainPageController{
	private SolrService solrService = null;
	private ProductManager productManager=null;
	private BrandManager brandManager = null;

	@RequestMapping("/index.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		ModelAndView mav = new ModelAndView("index");
//		List<Brand> brandList=brandManager.findAllBrands();
//		mav.addObject("brandList", brandList);
		request.setAttribute("index", "index");
		
		Store store=ConfigUtil.getInstance().getStore();
		request.setAttribute("pageSize", store.getCategoryListPerSize());
		return mav;
	}
	
	public void setSolrService(SolrService solrService) {
		this.solrService = solrService;
	}
	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}

	public void setBrandManager(BrandManager brandManager) {
		this.brandManager = brandManager;
	}
	
}
