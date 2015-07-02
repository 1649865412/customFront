
<%@ include file="/common/taglibs.jsp"%>

<div class="sidebar">
 	<div class="sidebar-wrap">
     	<ul class="nav">
         	<li <c:if test="${index=='index' }"> class="selected"</c:if>><a href="${ctxPath }/index.html">创造</a></li>
             <li <c:if test="${fn:endsWith(OriginalRequestURL,'custom/talent.html')}"> class="selected"</c:if>><a href="${ctxPath }/custom/talent.html">设计达人</a></li>
             <li <c:if test="${fn:endsWith(OriginalRequestURL,'custom/square.html')}"> class="selected"</c:if>><a href="${ctxPath }/custom/square.html">广场</a></li>
             <li <c:if test="${fn:endsWith(OriginalRequestURL,'customer_service/_18.html')}"> class="selected"</c:if>><a href="${ctxPath }/customer_service/_18.html">关于我们</a></li>
             <li <c:if test="${fn:endsWith(OriginalRequestURL,'customer_service/_27.html')}"> class="selected"</c:if>><a href="${ctxPath }/customer_service/_27.html">联系我们</a></li>
         </ul>
         <ul class="logo">
                <li><a href="#"><img src="${resPath}/custom/images/logo.jpg" width="144" height="58">
                    </a>
                </li>
            </ul>
         <div class="side-bottom">
         	<div class="nav-help"><a href="${ctxPath }/aboutus/help_catalog.html">帮助中心</a></div>
	         <ul class="tabs">
	         	<li id="loginPromptHolder"></li>
					<li id="loginPromptHolderTemplateLogout">
						<a rel="nofollow" href="/myaccount/account.html" onclick="window.location.href='/myaccount/account.html'">登录</a>/
						<a rel="nofollow" href="/signup.html" onclick="window.location.href='/signup.html'">注册</a>
					</li>
					<li id="loginPromptHolderTemplateLogin" style="display: none;">您好, 
						<a href="${ctxPath}/myaccount/account.html" rel="nofollow" onclick="window.location.href='${ctxPath}/myaccount/account.html'">{0}</a>&nbsp;&nbsp;
						(<a href="${ctxPath}/j_acegi_logout" rel="nofollow" onclick="window.location.href='${ctxPath}/j_acegi_logout'">退出</a>)
					</li>
					<li>
						<a rel="nofollow" href="${ctxPath}/myaccount/account.html" onclick="window.location.href='${ctxPath}/myaccount/account.html'">我的账号</a>
					</li>
					<li>
						<a rel="nofollow" href="${ctxPath}/myaccount/order/list.html" onclick="window.location.href='${ctxPath}/myaccount/order/list.html'">订单状态</a>
					</li>
	         </ul>
	         
             <div class="blank6"></div>
             
             <div class="mini-cart"><a href="${ctxPath}/cart/shoppingcart.html">购物车</a></div>
             
             <script type="text/javascript">
			//$mnc.refresh();
			fillLoginPrompt();
			</script>
			
             <div class="search">
             	<form action="" method="get">
                 <div class="left"><input type="text" class="box-input" value="" style="height:30px; width:100px;background-color:#363636; border:none; color:#fff;" /></div>
                 <div class="left"><input name="" type="image" src="${resPath}/custom/images/btn_search.jpg"></div>
                 </form>
             </div>
         </div>
     </div>
 </div>

