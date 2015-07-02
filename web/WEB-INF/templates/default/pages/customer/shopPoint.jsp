<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"	src="${ctxPath}/scripts/cartmatic/common/region.js"></script>
<title>积分查询/兑换</title>


<div class="maincontent">
         
			         <%@include file="../common/myaccount_head.jsp" %>
                
	                <div class="bottom_about">
	       
			           <%@include file="../common/myaccount_left.jsp" %>
			           
			           
			           <div class="down_right left_border" id="tab6">
				             <p class="account_info_title">
				               账户：${customer.email}
				               <span class="header_breadcrumb">积分</span>
				             </p>
				             <p class="cus_id">会员级别：${membership.membershipName}</p>          
				             <div class="score_top">
				               <div class="leftright_form">
				                 <h3 class="padding_left10">积分情况</h3>
				                 <div class="score_info">
				                   <div class="score_info_left">
				                     <p>我的积分:</p>
				                     <p>已使用:</p>
				                     <p>未使用:</p>
				                     <p>更新:	</p>
				                   </div><!--score_info_left-->
				                   <div class="score_info_right">
				                     <p>${shopPoint.gainedTotal}</p>
				                     <p>${shopPoint.usedTotal }</p> 
				                     <p>${shopPoint.total }</p>
				                     <p><fmt:formatDate value="${shopPoint.updateTime}" pattern="MM/dd/yyyy hh:mm:ss" />&nbsp;</p>
				                   </div><!--score_info_right-->
				                 </div><!--score_info-->
				               </div><!--leftright_form-->
				             </div><!--score_top-->
                             <div class="clear"></div>
				             <div class="score_top">
				               <h3 class="score_detail_title">积分明细</h3>
				               <table class="account_table" cellspacing="0" cellpadding="0" width="100%">
				                 <thead>
				                   <tr>
				                      <th width="35%">
				                        时间
				                      </th>
				                      <th width="15%">
				                        类型
				                      </th>
				                      <th width="30%">
				                        描述
				                      </th>
				                      <th width="20%">
				                        积分
				                      </th>
				                   </tr>
				                 </thead><!--thead-->
				                 <tbody>
				                 <c:forEach var="shopPointHistory" items="${shopPointHistoryList}" >
				                   <tr>
				                      <td> <fmt:formatDate value="${shopPointHistory.createTime}" pattern="MM/dd/yyyy hh:mm:ss" /></td>
				                      <td><fmt:message key="shopPoint.shopPointType_${shopPointHistory.shopPointType}" /></td>
				                      <td>${shopPointHistory.description }</td>
				                      <td>${shopPointHistory.amount}</td>
				                   </tr>
				                  </c:forEach>
				                 </tbody>
				               </table>
				               <div class="pagebar">
								<%@ include file="/common/pagingOnlyNew.jsp"%>
								</div>
				             </div><!--score_bottom-->
				           </div><!--down_right-->
				           
			         </div>
                
			</div>