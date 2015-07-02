<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<html>
	<head>
<title>我的收藏</title>
</head>
<body>


<div class="maincontent">
         
			           <%@include file="../common/myaccount_head.jsp" %>
                
	                <div class="bottom_about">
	       
			           <%@include file="../common/myaccount_left.jsp" %>
			           
			           <div class="down_right left_border" id="tab1">
				             <p class="account_info_title">
				               账户：${customer.email}
				               <span class="header_breadcrumb">我的收藏</span>
				             </p>
				             <p class="cus_id">会员级别：${membership.membershipName}</p>
				             <table class="account_table" cellspacing="0" cellpadding="0">
				               <thead>
				                 <tr>
				                    <th width="20%">
				                      商品图像
				                    </th>
				                    <th width="35%">
				                      商品名称
				                    </th>
				                    <th width="15%">
				                      收藏时间
				                    </th>
				                    <th width="30%">
				                      操作
				                    </th>
				                 </tr>
				               </thead><!--thead-->
				               <tbody>
				               <c:forEach var="favorite" items="${favoriteList}" varStatus="s">
				                 <tr>
				                    <td class="wish_img">
				                  	  <product:productImg product="${favorite.product}" size="e" width="110" height="110" isLazyload="true"/>
				                    <td>
										<product:productName product="${favorite.product}" />
									</td>
				                    <td><fmt:formatDate value="${favorite.createTime}" pattern="yyyy-MM-dd" /></td>
				                    <td>
				                      <button name="cancel_wish" class="btn_small btn-black" type="button" onclick="fnRemoveFavorite(${favorite.id});">
				                          <i class="fa fa-times padding_right10"></i>
				                          取消收藏
				                      </button>
				                    </td>
				                 </tr>
				                 </c:forEach>
				               </tbody>
				             </table>
				
				           </div><!--down_right-->
				           
			         </div>
                
</div>

	<script type="text/javascript">
		function fnRemoveFavorite(id){
			if(confirm("确定要取消该商品收藏？")){
				window.location.href=__ctxPath+"/myaccount/favorite/delete/"+id+".html"
			}
		}
	</script>
	
</body>
</html>