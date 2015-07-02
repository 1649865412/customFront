<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<HTML>
	<HEAD>
		<TITLE>Manager Reviews</TITLE>
	</HEAD>
	<BODY>
		
		<div class="maincontent">
         
			         <%@include file="../common/myaccount_head.jsp" %>
                
	                <div class="bottom_about">
	       
			           <%@include file="../common/myaccount_left.jsp" %>
			           
			           <div class="down_right left_border"  id="tab3">
				             <p class="account_info_title">
				               账户：${customer.email}
				               <span class="header_breadcrumb">我的评价</span>
				             </p>
				             <p class="cus_id">会员级别：${membership.membershipName}</p>
				             <div class="comment_part">
				             
				               <c:forEach var="review" items="${productReviewList}" varStatus="varStatus">
										             
					               <div class="div_comment">           
					                 <div class="left_comment wish_img">
					                     <a href="${ctxPath }/product/${review.product.productId}.html">
												<img src="${mediaPath}product/e/${review.product.defaultProductSku.image}"/>	
												<p>${review.product.productName }</p>				                     
					                     </a>
					                 </div><!--left_comment-->
					                 <div class="right_comment">
					                 <div class="meta-info">
					                   <div class="author">
					                     <p><a href="#">${review.subject}</a></p>
					                   </div><!--author-->
					                   <div class="date">
					                     <fmt:formatDate value="${review.createTime}" pattern="MM/dd/yyyy HH:mm:ss" />
					                   </div><!--date-->
					                   <br>
					                 </div><!--meta-info-->
					                 <p class="comment-text">
					                       ${review.message}
					                 </p>
					                 <div class="comment_button">
					                     <button name="change_comment" class="btn btn-gold" type="button" onclick="javascript:window.location.href='${ctxPath}/myaccount/review/${review.productReviewId}.html'">
					                        <i class="fa fa-pencil padding_right10"></i>
					                        编辑
					                     </button>
					                     <button name="delete_comment" class="btn btn-black" type="button" onclick="fnDeleteReview('${review.productReviewId}');">
					                        <i class="fa fa-times padding_right10"></i>
					                        删除
					                     </button>
					                 </div><!--comment_button-->
					                 </div><!--right_comment-->
					               </div><!--div_comment-->
					            
					           </c:forEach>
				               
				             </div><!--comment_part-->
				             
				             <c:if test="${not empty productReviewList }">
								<div class="pagebar">
								<%@ include file="/common/pagingOnlyNew.jsp"%>
								</div>
							</c:if>
												
				           </div><!--down_right-->
			           
			         </div>
                
			</div>
			
			<script type="text/javascript">
				function fnDeleteReview($id)
				{
					if (confirm("Are you sure you want to delete review?"))
					{
						window.location.href=__ctxPath+"/myaccount/review/delete/"+$id+".html";
					}
				}
			</script>
		
		
	</BODY>
</HTML>