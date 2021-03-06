
package com.cartmatic.estoresf.cart.web.action;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.cart.CheckoutConstants;
import com.cartmatic.estore.cart.model.CheckoutPagingModel;
import com.cartmatic.estore.cart.service.CheckoutManager;
import com.cartmatic.estore.cart.service.ShoppingcartManager;
import com.cartmatic.estore.cart.util.CheckoutUtil;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.cart.Shoppingcart;
import com.cartmatic.estore.common.model.customer.Address;
import com.cartmatic.estore.common.model.customer.AddressModel;
import com.cartmatic.estore.common.model.customer.CustomerRegister;
import com.cartmatic.estore.common.model.order.SalesOrder;
import com.cartmatic.estore.common.model.sales.GiftCertificate;
import com.cartmatic.estore.common.model.system.PaymentMethod;
import com.cartmatic.estore.common.model.system.ShippingRate;
import com.cartmatic.estore.common.model.system.Wrap;
import com.cartmatic.estore.common.service.CheckoutService;
import com.cartmatic.estore.common.service.GiftCertificateService;
import com.cartmatic.estore.common.service.OrderService;
import com.cartmatic.estore.common.service.PaymentMethodService;
import com.cartmatic.estore.common.service.ShoppingcartService;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.customer.service.AddressManager;
import com.cartmatic.estore.exception.GiftCertificateStateException;
import com.cartmatic.estore.exception.OutOfStockException;
import com.cartmatic.estore.sales.service.GiftCertificateManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;
import com.cartmatic.estore.webapp.util.SessionUtil;

@Controller
public class CheckoutPagingController extends BaseStoreFrontController {
	@Autowired
	private AddressManager addressManager=null;
	@Autowired
	private PaymentMethodService paymentMethodService=null;
	@Autowired
	private CheckoutService checkoutService=null;
	@Autowired
	private CheckoutManager checkoutManager=null;
	@Autowired
	private ShoppingcartService shoppingcartService=null;
	@Autowired
	private OrderService orderService=null;
	@Autowired
	private GiftCertificateService giftCertificateService=null;
	@Autowired
	private ShoppingcartManager shoppingcartManager;
	@Autowired
	private GiftCertificateManager giftCertificateManager;
	
	
	private void setCurrentStep(HttpServletRequest request,HttpServletResponse response){
		request.setAttribute("isCheckout",true);
		CheckoutPagingModel checkoutPagingModel=CheckoutUtil.getInstance().getCheckoutPagingModel(request);
		String uri=request.getRequestURI();
		if(uri.indexOf("login")!=-1){
			checkoutPagingModel.setCurrentStep(2);
		}else if(uri.indexOf("shippingAddress")!=-1){
			checkoutPagingModel.setCurrentStep(3);
		}else if(uri.indexOf("paymentProcess")!=-1){
			checkoutPagingModel.setCurrentStep(4);
		}else if(uri.indexOf("orderReview")!=-1){
			checkoutPagingModel.setCurrentStep(5);
		}
	}
	

	@RequestMapping(value="/checkout/orderReview.html")
	public ModelAndView orderReview(HttpServletRequest request, HttpServletResponse response) {
		setCurrentStep(request, response);
		String orderNo=request.getParameter("orderNo");
		Integer storeId=ConfigUtil.getInstance().getStore().getStoreId();
		SalesOrder salesOrder=orderService.getSalesOrder(storeId,orderNo, RequestContext.getCurrentUserId());
		if(salesOrder!=null){
			request.setAttribute("salesOrder",salesOrder);
			if(salesOrder.getPaymentMethodId()!=null){
				PaymentMethod paymentMethod=paymentMethodService.getPaymentById(salesOrder.getPaymentMethodId());
				request.setAttribute("paymentMethod",paymentMethod);
			}
			List<PaymentMethod> paymentMethodList = paymentMethodService.getPaymentMethodByCart(false);
			request.setAttribute("paymentMethodList", paymentMethodList);
			
			return new ModelAndView("cart/checkout_orderReview");
		}
		return null;
	}
	
	/**
	 * 下单流程检查
	 * @param request
	 * @param response
	 * @return
	 */
	private ModelAndView check(HttpServletRequest request,HttpServletResponse response){
		String uri=request.getRequestURI();
		ModelAndView mv=null;
		//判断ShoppingCart是否为空（checkout流程每一步都需要）
//		Shoppingcart cart = ShoppingCartUtil.getInstance().getCurrentUserShoppingcart();
		Shoppingcart cart = shoppingcartService.loadCookieCart(request);
		if(cart==null||cart.getBuyNowItemsCount().intValue()==0){
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			saveMessage(Message.error("checkout.shippingCart.empty"));
			mv=new ModelAndView(new RedirectView("/cart/shoppingcart.html"));
		}
		request.setAttribute("shoppingcart",cart);
		
		//判断是否已经登录了（checkout流程每一步都需要）
		if(mv==null&&RequestContext.isAnonymousUser()){
			request.getSession().setAttribute(Constants.CHECKOUT_TARGET_URL,request.getRequestURL().toString());
			//匿名Checkout的跳到登录/注册页
			request.setAttribute("customerRegister",new CustomerRegister());
			mv= new ModelAndView("/cart/checkout_signup");
		}
		
		//检查地址是否已选择，（checkout流程中paymentProcess,doCK需要）
		/*if(mv==null&&(uri.indexOf("paymentProcess")!=-1||StringUtils.isNotBlank(request.getParameter("doCK")))){
			Address shippingAddress=null;
			Integer shippingAddressId=	CheckoutUtil.getInstance().getCheckoutPagingModel(request).getShippingAddressId();	 //new Integer(request.getParameter("shippingAddressId"));	//
			//检查是否已经选择了运输地址及session是否已过期
			if(shippingAddressId!=null){
				//获取显示已选择的运输地址及发票地址
				shippingAddress=addressManager.getAddressByIdAndAppUserId(shippingAddressId,RequestContext.getCurrentUserId());
			}
			//下单过程中删除了运输地址
			if(shippingAddress==null){
				SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
				saveMessage(Message.error("checkout.shippingAddress.required"));
				mv=new ModelAndView(new RedirectView("/checkout/paymentProcess.html"));
			}
			request.setAttribute("shippingAddress",shippingAddress);
			
			//检查发票地址是否为空（检查发票地址是否被恶意删除）
			if(mv==null){
				Address billingAddress=addressManager.getDefBillingAddress(RequestContext.getCurrentUserId());
				if(billingAddress==null){
					SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
					saveMessage(Message.error("checkout.billingAddress.required"));
					mv=new ModelAndView(new RedirectView("/checkout/paymentProcess.html"));
				}
				request.setAttribute("billingAddress",billingAddress);
			}
		}*/
		return mv;
	}

	@RequestMapping(value="/checkout/login.html", method=RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		setCurrentStep(request, response);
		ModelAndView mv=check(request, response);
		if(mv==null){
			//302到Checkout的shipping_address页面
			mv=new ModelAndView(new RedirectView("/checkout/paymentProcess.html"));
		}
		return mv;
	}

	@RequestMapping(value="/checkout/shippingAddress.html",method=RequestMethod.GET)
	public ModelAndView shippingAddress(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		setCurrentStep(request, response);
		ModelAndView mv=check(request, response);
		if(mv!=null){
			return mv;
		}
		if(request.getParameter("change")==null){
			Integer shippingAddressId=CheckoutUtil.getInstance().getCheckoutPagingModel(request).getShippingAddressId();
			//检查是否已经选择了运输地址及session是否已过期
			if(shippingAddressId!=null){
				Address shippingAddress=addressManager.getAddressByIdAndAppUserId(shippingAddressId, RequestContext.getCurrentUserId());
				Address billingAddress=addressManager.getDefBillingAddress(RequestContext.getCurrentUserId());
				if(shippingAddress!=null&&billingAddress!=null){
					return new ModelAndView(new RedirectView("/checkout/paymentProcess.html"));
				}
			}
		}else{
			request.getSession().removeAttribute("checkout_shippingAddressId");
		}
		
		//获取运输地址及发票地址
		Integer currentUserId=RequestContext.getCurrentUserId();
		List<Address> shippingAddressList=addressManager.getAllShippingAddressByAppuserId(currentUserId);
		Address billingAddress=addressManager.getDefBillingAddress(currentUserId);
		if(billingAddress==null){
			request.setAttribute("createShippingAndBilling", true);
		}
		request.setAttribute("shippingAddressList", shippingAddressList);
		request.setAttribute("billingAddress", billingAddress);
		request.setAttribute("address", new AddressModel());
		return new ModelAndView("cart/checkout_shippingAddress");
	}
	

	@RequestMapping(value="/checkout/paymentProcess.html")
	public ModelAndView paymentProcess(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		setCurrentStep(request, response);
		ModelAndView mv=check(request, response);
		if(mv!=null){
			return mv;
		}
		Shoppingcart cart = (Shoppingcart)request.getAttribute("shoppingcart");
		Address shippingAddress=(Address)request.getAttribute("shippingAddress");
		
		//配送地址列表
		Integer currentUserId=RequestContext.getCurrentUserId();
		List<Address> shippingAddressList=addressManager.getAllShippingAddressByAppuserId(currentUserId);
		request.setAttribute("shippingAddressList", shippingAddressList);
		
		//根据地址获取相应的运输方式
//		if(shippingAddressList != null && shippingAddressList.size() > 0){
			List<ShippingRate> shippingRateList=CheckoutUtil.getInstance().statCartShipping(null, cart);
			request.setAttribute("shippingRateList",shippingRateList);
//		}
		
		//读取支付方式
		List<PaymentMethod> paymentMethodList = paymentMethodService.getPaymentMethodByCart(cart.hasVirtualItem());
		request.setAttribute("paymentMethodList",paymentMethodList);
		//读取包装方式
		List<Wrap> wrapList =  checkoutService.getSystemWraps();
		request.setAttribute("wrapList", wrapList);
		//已绑定的礼券
//		List<GiftCertificate> gcList = giftCertificateService.getBindedGiftCard(RequestContext.getCurrentUserId());
//		if (gcList != null && gcList.size() > 0)
//		{
//			for (GiftCertificate gc: gcList)
//			{
//				gc.setShoppingCartItems(cart.getBuyNowItemsCount());
//			}
//		}
//		request.setAttribute("gcList", gcList);
		
//		request.setAttribute("giftCertificateNos", request.getParameter("giftCertificateNos"));
//		request.setAttribute("giftCertificate", request.getParameter("giftCertificate"));
		
		String gcStr = cart.getGiftCertificateNos();
		if(gcStr != null){
			GiftCertificate gc = giftCertificateManager.getGiftCertificate(gcStr.split(":")[0]);
//			gc.bindToCustomer(RequestContext.getCurrentUserId());
			if(gc != null){
				if(gc.getCustomerId() == null || gc.getCustomerId() == Constants.USERID_ANONYMOUS){
					gc.bindToCustomer(RequestContext.getCurrentUserId());
					giftCertificateManager.save(gc);
				}
			}
		}
		
		return new ModelAndView("cart/checkout_paymentProcess");
	}
	
	/**
	 * 最终的checkout动作
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
    @RequestMapping(value="/checkout/paymentProcess.html",params="doAction=doCK",method=RequestMethod.POST)
	public ModelAndView doCK(HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mv=check(request, response);
		if(mv!=null){
			return mv;
		}
		try {
			checkoutManager.doPlaceOrder(request, response);
			SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
			Shoppingcart cart = shoppingcartService.loadCookieCart(request);
			shoppingcartManager.deleteById(cart.getId());
		    return new ModelAndView(new RedirectView("/checkout/orderReview.html?orderNo="+salesOrder.getOrderNo()));
			
		} catch (Exception e) {
			e.printStackTrace();
			if(e instanceof OutOfStockException){
				String result = CheckoutUtil.getInstance().checkInventoryForShoppingcart(request, response);
				request.setAttribute("errorMsg_OutOfStoc", result);
			}
			else if(e instanceof GiftCertificateStateException){
				GiftCertificateStateException ee = (GiftCertificateStateException)e;
				Short state = ee.getState();
				String msg = "";
				if(state.equals(GiftCertificate.STATE_EXPIRE)){
					msg = getMessage("giftCertificate.error.expire");
				}
				else if(state.equals(GiftCertificate.STATE_INVALID)){
					msg = getMessage("giftCertificate.error.notAgiftCertificate");
				}
				else if(state.equals(GiftCertificate.STATE_NOT_ENOUGH_REMAINEDAMT)){
					msg = getMessage("giftCertificate.error.noMoney");
				}
				else if(state.equals(GiftCertificate.STATE_UNACTIVE)){
					msg = getMessage("giftCertificate.error.inactive");
				}
				else{
					msg = getMessage("giftCertificate.error.onUsing");
				}
				request.setAttribute("errorMsg_Gc", ee.getGiftCertificateNo()+":"+msg);
			}
			else{
				request.setAttribute("errorMsg_other", e.toString());
			}
		}
		return null;
	}
    
	@RequestMapping(value="/checkout/paymentProcess.html",params="doAction=doUseGc",method=RequestMethod.POST)
	public ModelAndView doUseGc(HttpServletRequest request, HttpServletResponse response) {
		AjaxView ajaxView = new AjaxView(response);
		String gcNo = request.getParameter("giftCertificateNo");
		String money = request.getParameter("money");
		if(StringUtils.isBlank(gcNo)){
			ajaxView.setMsg(getMessage("giftCertificate.error.required"));
			ajaxView.setStatus(new Short("-1"));
			return ajaxView;
		}
		Short gcState = giftCertificateService.checkGiftcertificate(gcNo);
		
		Shoppingcart cart = shoppingcartService.loadCookieCart(request);
		BigDecimal decMoney = BigDecimal.valueOf(Double.valueOf(money));
		BigDecimal m = new BigDecimal(0.00);
		
		if (gcState.equals(GiftCertificate.STATE_AVAILABLE)) {
			m = giftCertificateService.mockUseGiftCertificate(gcNo,decMoney,cart.getBuyNowItemsCount());
			
		}else if(GiftCertificate.STATE_INVALID.equals(gcState)){
			ajaxView.setMsg(getMessage("giftCertificate.error.notAgiftCertificate"));
		}else if(GiftCertificate.STATE_EXPIRE.equals(gcState)){
			ajaxView.setMsg(getMessage("giftCertificate.error.expire"));
		}else if(GiftCertificate.STATE_UNACTIVE.equals(gcState)){
			ajaxView.setMsg(getMessage("giftCertificate.error.inactive"));
			GiftCertificate gc = giftCertificateManager.getGiftCertificate(gcNo);
			gc.bindToCustomer(RequestContext.getCurrentUserId());
			giftCertificateManager.save(gc);
//			gc.setStatus(GiftCertificate.STATUS_ACTIVE);
//			giftCertificateManager.save(gc);
			gcState = giftCertificateManager.getState(gc);
			if (gcState.equals(GiftCertificate.STATE_AVAILABLE)) {
				m = giftCertificateService.mockUseGiftCertificate(gcNo,decMoney,cart.getBuyNowItemsCount());
			}
		}else if(GiftCertificate.STATUS_UNDEAL.equals(gcState)){
			ajaxView.setMsg(getMessage("giftCertificate.error.onUsing"));
		}else if(GiftCertificate.STATE_REMAINEDAMT_IS_ZERO.equals(gcState)){
			ajaxView.setMsg(getMessage("giftCertificate.error.noMoney"));
		}
		if(gcState.equals(GiftCertificate.STATE_AVAILABLE)){
			cart.setGiftCertificateNos(gcNo + ":" + m.setScale(2).toString());
		}else{
			cart.setGiftCertificateNos(null);
		}
		
		shoppingcartManager.save(cart);
		ajaxView.setData(m);
		ajaxView.setStatus(gcState);
		return ajaxView;
	}
	
    @RequestMapping(value="/checkout/paymentProcess.html",params="doAction=notuseGc",method=RequestMethod.POST)
	public ModelAndView notuseGc(HttpServletRequest request, HttpServletResponse response)
    {
        //return defaultAction(request, response);
        Shoppingcart cart = shoppingcartService.loadCookieCart(request);
        if(cart != null){
        	 cart.setGiftCertificateNos(null);
             shoppingcartManager.save(cart);
        }
        AjaxView ajaxView = new AjaxView(response);
        ajaxView.setData(0);
        return ajaxView;
    }
	
	@RequestMapping(value="/checkout/paymentProcess.html",params="doAction=doUseShopPoint",method=RequestMethod.POST)
	public ModelAndView doUseShopPoint(HttpServletRequest request, HttpServletResponse response) {
		String selectPoint = request.getParameter("selectPoint");
		Shoppingcart cart = shoppingcartService.loadCookieCart(request);
		cart.setShopPoint(Integer.parseInt(selectPoint));
		shoppingcartManager.save(cart);
		return null;
	}
	
}