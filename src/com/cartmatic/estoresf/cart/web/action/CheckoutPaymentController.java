package com.cartmatic.estoresf.cart.web.action;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.order.OrderShipment;
import com.cartmatic.estore.common.model.order.SalesOrder;
import com.cartmatic.estore.common.model.system.PaymentMethod;
import com.cartmatic.estore.common.service.OrderService;
import com.cartmatic.estore.common.service.PaymentMethodService;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.order.OrderConstants;
import com.cartmatic.estore.order.service.SalesOrderManager;
import com.cartmatic.estore.system.service.PaymentMethodManager;

/**
 * @author huang wenmin 2008-11-13 2010-5-10 重构,只用于paymetn相关的功能.
 */
@Controller
@RequestMapping("/checkout/goToPay.html")
public class CheckoutPaymentController extends BaseStoreFrontController
{

    private PaymentMethodService paymentMethodService=null;
    
    private PaymentMethodManager paymentMethodManager=null;
    
    private SalesOrderManager salesOrderManager = null;
    
    private OrderService orderService;

    public void setOrderService(OrderService orderService)
    {
        this.orderService = orderService;
    }

	@RequestMapping(method=RequestMethod.GET)
    public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response)
    {
        String orderNo = request.getParameter("orderNo");
        SalesOrder salesOrder = this.orderService.getSalesOrderByOrderNo(orderNo);

        if (salesOrder == null)
            return null;

        PaymentMethod paymentMethod = this.paymentMethodService.getPaymentById(salesOrder.getPaymentMethodId());

        if (ConfigUtil.getInstance().getIsDemoMode())
        {

            this.paymentMethodService.savePaymentHistoryForDemo(orderNo, salesOrder.getTotalAmount().divide(
                    salesOrder.getPaidAmount()), paymentMethod.getPaymentMethodId());
            try
            {
                response.sendRedirect(request.getContextPath() + "/");
            }
            catch (Exception e)
            {
            }
            return null;
        }
        else
        {

            if (paymentMethod.getPaymentMethodType().equals(PaymentMethod.PAYMENT_METHOD_TYPE_ONLINE))
            {// 判断是线上支付还是线下支付
                // SalesOrder
                // salesOrder=this.orderService.getSalesOrder(orderNo,
                // RequestContext.getCurrentUserId());
                // SalesOrder
                // salesOrder=this.orderService.getSalesOrderByOrderNo(orderNo);
                if (OrderConstants.PAYMENT_STATUS_PAID.equals(salesOrder.getPaymentStatus()))
                {
                    // 如果订单为空,或者已经支付 了.
                    ModelAndView mv = new ModelAndView(new RedirectView("/myaccount/order/list.html", true));
                    mv.addObject("error", "checkout.error.orderStatus");
                    mv.addObject("salesOrder", salesOrder);
                    return mv;
                }
                return this.redirectPaymentGateway(salesOrder, paymentMethod, request);
            }

        }
        logger.warn("goto payment gateway error");
        ModelAndView mv = new ModelAndView("cart/checkoutSelectOnlinePayment");
        mv.addObject("error", "checkout.error.paymentmethod");
        return mv;
    }

    @RequestMapping(params="doAction=selectOnlinePayment", method=RequestMethod.GET)
	public ModelAndView selectOnlinePayment(HttpServletRequest request,	HttpServletResponse response) {
    	String orderNo = request.getParameter("orderNo");
		SalesOrder obj = orderService.getSalesOrderByOrderNo(orderNo);
		request.setAttribute("orderNo", orderNo);
		String paymentMethodId = request.getParameter("paymentMethodId");
		request.setAttribute("paymentMethodId", paymentMethodId);
		List<PaymentMethod> paymentMethodList = paymentMethodService.getPaymentMethodByCart(false);
		if(paymentMethodList.size()==1){
			return redirectPaymentGateway(obj, paymentMethodList.iterator().next(), request);
		}
		request.setAttribute("paymentMethodList", paymentMethodList);
		ModelAndView mv = new ModelAndView("cart/checkoutSelectOnlinePayment");
		mv.addObject("salesOrder", obj);
		return mv;
	}

    @RequestMapping(params="doAction=gotoPaymentGateway", method=RequestMethod.POST)
    public ModelAndView gotoPaymentGateway(HttpServletRequest request,HttpServletResponse response) {
		// 如果是Trial版本，本方法将不会被执行，下面的注释不要删
		// @TRIAL_NOT_SUPPORT@
		String orderNo = request.getParameter("orderNo");
		PaymentMethod paymentMethod = null;
		String strPaymentMethod = request.getParameter("paymentMethodId");
		if (!empty(strPaymentMethod)) 
		{
			Integer paymentMethodId = new Integer(strPaymentMethod);
	        paymentMethod = this.paymentMethodService.getPaymentById(paymentMethodId);
	        if(!ConfigUtil.getInstance().getStore().getPaymentMethods().contains(paymentMethod)){
	        	paymentMethod=null;
	        }
		}
		
		if(paymentMethod!=null)
		{
			if (ConfigUtil.getInstance().getIsDemoMode()) {
				SalesOrder salesOrder=this.orderService.getSalesOrderByOrderNo(orderNo);
				 this.paymentMethodService.savePaymentHistoryForDemo(orderNo, salesOrder.getTotalAmount().divide( salesOrder.getPaidAmount()), paymentMethod.getPaymentMethodId());
		            try
		            {
		                response.sendRedirect(request.getContextPath() + "/");
		            }
		            catch (Exception e)
		            {
		            }
				return null;
			} else {
				if (!empty(orderNo)&& paymentMethod != null) {
					SalesOrder salesOrder=this.orderService.getSalesOrderByOrderNo(orderNo);
					if (paymentMethod.getPaymentMethodType().equals(PaymentMethod.PAYMENT_METHOD_TYPE_ONLINE)) 
					{//判断是线上支付还是线下支付
						//SalesOrder salesOrder=this.orderService.getSalesOrder(orderNo, RequestContext.getCurrentUserId());
						if (logger.isDebugEnabled())
				        {
				            logger.debug("Processing orderNO:["+orderNo+"] paymentMedodId:["+strPaymentMethod+"] salesOrder-entity:"+salesOrder);
				        }
						if (salesOrder == null || OrderConstants.PAYMENT_STATUS_PAID.equals(salesOrder.getPaymentStatus()))
						{
							//如果订单为空,或者已经支付 了.
							ModelAndView mv = new ModelAndView("cart/checkoutSelectOnlinePayment");
							mv.addObject("error", "checkout.error.orderStatus");
							mv.addObject("salesOrder", salesOrder);
							return mv;
						}
						salesOrder.setPaymentMethodId(Integer.parseInt(strPaymentMethod));
						//农业银行9折优惠
/*						if(paymentMethod.getPaymentMethodCode().equals("abc")){
							BigDecimal temp = new BigDecimal(0);
							BigDecimal dis = new BigDecimal(0);
							BigDecimal rate = new BigDecimal(12);
							if(salesOrder.getOrderShipments().size() > 0) {
								Iterator<OrderShipment> iter = salesOrder.getOrderShipments().iterator();
								while(iter.hasNext()){
									OrderShipment os = iter.next();
									temp = temp.add(os.getItemSubTotal());
									dis = dis.add(os.getDiscountAmount());
								}
							}
							//增加了运费
							if(!(temp.compareTo(salesOrder.getPaidAmount()) == 0)){
								temp = temp.subtract(salesOrder.getPaidAmount());
								if(temp.compareTo(new BigDecimal(100)) < 0){
									salesOrder.setPaidAmount(salesOrder.getPaidAmount().add(salesOrder.getTotalAmount().subtract(rate.add(salesOrder.getPaidAmount())).multiply(new BigDecimal("0.1"))));
								}else{
									salesOrder.setPaidAmount(salesOrder.getPaidAmount().add(salesOrder.getTotalAmount().subtract(salesOrder.getPaidAmount()).multiply(new BigDecimal("0.1"))));
								}
							}
						}*/
						this.salesOrderManager.save(salesOrder);
						return this.redirectPaymentGateway(salesOrder,paymentMethod, request);
					}
				}				
			}
		}
		logger.warn("goto payment gateway error");
		ModelAndView mv = new ModelAndView("cart/checkoutSelectOnlinePayment");
		mv.addObject("error", "checkout.error.paymentmethod");
		return mv;
	}

    /**
     * 跳去指定的Paypal支付网关
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params="doAction=redirectPaymentPaypal")
    public ModelAndView redirectPaymentPaypal(HttpServletRequest request, HttpServletResponse response)
    {
        String orderNo = request.getParameter("orderNo");
        SalesOrder obj = orderService.getSalesOrderByOrderNo(orderNo);
        PaymentMethod paymentMethod = this.paymentMethodService.getPaymentMethodByCode("paypal");
        return redirectPaymentGateway(obj, paymentMethod, request);
    }    

    private ModelAndView redirectPaymentGateway(SalesOrder salesOrder, PaymentMethod paymentMethod, HttpServletRequest request)
    {
        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("paymentMethodId", paymentMethod.getPaymentMethodId());
        if(!empty(request.getParameter("cardTyp"))){
        	request.setAttribute("cardTyp", request.getParameter("cardTyp"));
        }
        // 根据支付方式指定装饰器
        // 不要在controller中判断是否SSL，这样不灵活也不准确。
        // if(paymentMethod.getProtocol().equalsIgnoreCase("HTTPS")){
        // request.setAttribute("SSL",true);
        // }
        return new ModelAndView("system/" + paymentMethod.getProcessorFile(), "salesOrder", salesOrder);
    }
    
    public void setPaymentMethodService(PaymentMethodService paymentMethodService) {
        this.paymentMethodService = paymentMethodService;
    }

	public void setPaymentMethodManager(PaymentMethodManager paymentMethodManager) {
		this.paymentMethodManager = paymentMethodManager;
	}

	public SalesOrderManager getSalesOrderManager() {
		return salesOrderManager;
	}

	public void setSalesOrderManager(SalesOrderManager salesOrderManager) {
		this.salesOrderManager = salesOrderManager;
	}
    
}