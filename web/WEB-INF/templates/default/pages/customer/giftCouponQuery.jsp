<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"	src="${ctxPath}/scripts/cartmatic/common/region.js"></script>
<title>礼券/优惠券查询</title>


<div class="maincontent">
         
			         <%@include file="../common/myaccount_head.jsp" %>
                
	                <div class="bottom_about">
	       
			          <%@include file="../common/myaccount_left.jsp" %>
			           
			           
			           <div class="down_right left_border" id="tab7">
			             <p class="account_info_title">
			               账户：${customer.email}
			               <span class="header_breadcrumb">礼券/优惠劵</span>
			             </p>
			             <p class="cus_id">会员级别：${membership.membershipName}</p>          
			             
			             <form action="${ctxPath }/myaccount/giftCouponQuery.html" method="post" name="giftCouponQueryForm" id="giftCouponQueryForm">
			             
				             <div class="score_top">
				               <div class="leftright_form">
				                 <h3 class="padding_left10">优惠劵查询</h3>
				                 <div class="score_exchange">
				                        <p>请输入您的礼券/优惠劵代码点击查询</p>
				                        <input type="text" class="box-input" id="giftCouponNo" name="giftCouponNo" size="33">
				                        <div class="mark_co input_waring" style="display: inline;">
				                            <div for="giftCouponNo" generated="true" class="red" style="display: none;">
				                            </div>
				                         </div>
				                        <br/>
				                        <br/>
				
				                        <button name="giftCouponbutton" class="btn btn-black" type="submit">
				                           <i class="fa fa-search padding_right10"></i>
				                           查询
				                         </button>
				                 </div><!--score_exchange-->
				               </div><!--leftright_form-->
				             </div><!--score_top-->
			             
			             </form>
			             
			             <!--以下为查询结果，平常应为不可见，查询后可见-->
			             	<c:choose>
								<c:when test="${coupon.state == 1}">
										<div class="score_top">
						               <h3 class="padding_left10">查询结果</h3>
						               <div class="score_info">
						                   <div class="score_info_left">
						                     <p>优惠劵号码:</p>
						                     <p>有效期:</p>
						                     <p>描述:</p>
						                     <p>剩余可使用次数:	</p>
						                   </div><!--score_info_left-->
						                   <div class="score_info_right">
						                     <p>${coupon.couponNo}</p>
						                     <p>
						                     	<c:choose>
												<c:when test="${not empty coupon.promoRule.endTime}">
													<fmt:formatDate value="${coupon.promoRule.endTime}" pattern="MM/dd/yyyy hh:mm:ss" />
												</c:when>
												<c:otherwise>
													<fmt:message key="giftCouponQuery.noEndTime"></fmt:message>
												</c:otherwise>
											</c:choose>	
											</p> 
						                     <p>${coupon.promoRule.name}</p>
						                     <p>${coupon.remainedTimes}</p>
						                   </div><!--score_info_right-->
						                 </div><!--score_info-->
						             </div><!--score_top-->
								</c:when>
								<c:when test="${giftCertificate.state == 1 or giftCertificate.state == -2}">
									<div class="score_top">
						               <h3 class="padding_left10">查询结果</h3>
						               <div class="score_info">
						                   <div class="score_info_left">
						                     <p>礼券号码：</p>
						                     <p>有效期：</p>
						                     <p>面值：</p>
						                     <p>余额：</p>
						                   </div><!--score_info_left-->
						                   <div class="score_info_right">
						                     <p>${giftCertificate.giftCertificateNo}</p>
						                     <p>
						                     	<c:choose>
													<c:when test="${not empty giftCertificate.expireTime}">
														<fmt:formatDate value="${giftCertificate.expireTime}"
															pattern="MM/dd/yyyy hh:mm:ss" />
													</c:when>
													<c:otherwise>
														<fmt:message key="giftCouponQuery.noEndTime"></fmt:message>
													</c:otherwise>
												</c:choose>
											</p> 
						                     <p><system:CurrencyForRate value="${giftCertificate.giftCertAmt}" /></p>
						                     <p><system:CurrencyForRate value="${giftCertificate.remainedAmt}" /></p>
						                   </div><!--score_info_right-->
						                 </div><!--score_info-->
						             </div><!--score_top-->
								</c:when>
								<c:when test="${(not empty coupon and coupon.state != 0)||(not empty giftCertificate and giftCertificate.state != 0)||(coupon.state == 0 and giftCertificate.state == 0)}">
									<div class="score_top">
							               <h3 class="padding_left10">查询结果：此礼券/优惠劵不存在！</h3>
							             </div><!--score_top-->
									<!-- 
									<h5><fmt:message key="giftCouponQuery.tip" /></h5>
									<div class="dashed-line"></div>
									<table cellSpacing="0" cellPadding="0" width="100%" align="center"	class="table-account" border="0">
										<tr>
											<th width="30%">&nbsp;</th>
											<td>
												<font color="red">
													<c:choose>
														<c:when test="${not empty coupon and coupon.state != 0}">
															<fmt:message key="giftCouponQuery.coupon.state${coupon.state}">
																<fmt:param>${giftCouponNo}</fmt:param>
															</fmt:message>
														</c:when>
														<c:when test="${not empty giftCertificate and giftCertificate.state != 0}">
															<fmt:message key="giftCouponQuery.giftCertificate.state${giftCertificate.state}">
																<fmt:param>${giftCouponNo}</fmt:param>
															</fmt:message>
														</c:when>
														<c:when test="${coupon.state == 0 and giftCertificate.state == 0}">
															<fmt:message key="giftCouponQuery.notExist">
																<fmt:param>${giftCouponNo}</fmt:param>
															</fmt:message>
														</c:when>
													</c:choose>
												</font>
											</td>
										</tr>
									</table>
									 -->
								</c:when>
							</c:choose>
			            <!--查询结果到此为止-->
			            
			           </div><!--down_right-->
				           
			         </div>
                
			</div>

	<script type="text/javascript">
	$("#giftCouponQueryForm").validate({rules:{
		giftCouponNo:{required:true}
	},
		messages:{
			giftCouponNo:{
				required:"请输入礼券/优惠劵！"
				}
		}
	});
	</script>