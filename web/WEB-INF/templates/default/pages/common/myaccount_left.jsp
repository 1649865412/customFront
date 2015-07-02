
<%@ include file="/common/taglibs.jsp"%>

<div class="remote_nav">

<ul id="remote_nav_ul">
	 <li><a id="t1" href="${ctxPath}/myaccount/order/list.html" title="我的订单" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/order/')!=-1}"> class="current"</c:if>>我的订单</a></li>
	<%--<li><a id="t2" href="${ctxPath}/myaccount/favorites.html" title="我的收藏" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/favorites.html')!=-1}"> class="current"</c:if>>我的收藏</a></li>
	<li><a id="t3" href="${ctxPath}/myaccount/review/list.html" title="我的评价" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/review/')!=-1}"> class="current"</c:if>>我的评价<span id="reviews_count"></span></a>--%></li>
	<li><a id="t4" href="${ctxPath}/myaccount/settings.html" title="个人资料" <c:if test="${fn:endsWith(OriginalRequestURL,'/myaccount/settings.html')}"> class="current"</c:if>>个人资料</a></li>
	<li><a id="t5" href="${ctxPath}/myaccount/address.html" title="收货地址 " <c:if test="${fn:endsWith(OriginalRequestURL,'/myaccount/address.html')}"> class="current"</c:if>>收货地址</a></li>
	<li><a id="t6" href="${ctxPath}/myaccount/shopPoint.html" title="积分" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/shopPoint.html')!=-1}"> class="current"</c:if>>积分</a></li>
	<li><a id="t7" href="${ctxPath}/myaccount/giftCouponQuery.html" title="优惠劵" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/giftCouponQuery.html')!=-1}"> class="current"</c:if>>优惠劵</a></li>
 </ul>
 
</div><!--remote_nav-->