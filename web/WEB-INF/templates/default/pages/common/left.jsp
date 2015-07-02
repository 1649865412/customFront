
<%@ include file="/common/taglibs.jsp"%>

<div class="sidebar">
 	<div class="sidebar-wrap">
     	<ul class="nav">
         	<li <c:if test="${index=='index' }"> class="selected"</c:if>><a href="${ctxPath }/index.html">创造</a></li>
             <li <c:if test="${fn:endsWith(OriginalRequestURL,'custom/talent.html')}"> class="selected"</c:if>><a href="${ctxPath }/custom/talent.html">设计达人</a></li>
             <%--<li <c:if test="${fn:endsWith(OriginalRequestURL,'custom/square.html')}"> class="selected"</c:if>><a href="${ctxPath }/custom/square.html">广场</a></li>--%>
             <li <c:if test="${fn:endsWith(OriginalRequestURL,'customer_service/_18.html')}"> class="selected"</c:if>><a href="${ctxPath }/customer_service/_18.html">关于我们</a></li>
             <li <c:if test="${fn:endsWith(OriginalRequestURL,'customer_service/_27.html')}"> class="selected"</c:if>><a href="${ctxPath }/customer_service/_27.html">联系我们</a></li>
         </ul>
         <ul class="logo">
            <li>
            	<a href="${ctxPath }/index.html">
            	<%--<img src="${resPath}/custom/images/logo.jpg" width="144" height="58" />--%>
            	<img src="${ctxPath}/images/logo.png" width="95%" height="168" />
            	</a>
            	<%--<div>
                	<a href="http://www.sifangstreet.com" target="_blank">
                		<img src="${resPath}/custom/images/si_logo.png" />
                		<img src="${ctxPath}/images/logo.png" />
                	</a>
                </div>
                
            --%></li>
        </ul>
         <div class="side-bottom">
         	<div><i class="fa fa-question fa-1" style="margin-right:12px;"></i><a href="${ctxPath }/aboutus/help_catalog.html">帮助中心</a></div>
	         <ul class="tabs">
	         	<li id="loginPromptHolder"></li>
                <li id="loginPromptHolderTemplateLogout">
                    <i class="fa fa-sign-out" style="margin-right:3px;"></i>
					<a rel="nofollow" href="/myaccount/account.html" onclick="window.location.href='/myaccount/account.html'">登录</a>/
                    <a rel="nofollow" href="/signup.html" onclick="window.location.href='/signup.html'">注册</a>
                </li>
                <li id="loginPromptHolderTemplateLogin" style="display: none;">
                        <i class="fa fa-user-md" style="margin-right:4px;"></i>
						<a rel="nofollow" href="${ctxPath}/myaccount/account.html" onclick="window.location.href='${ctxPath}/myaccount/account.html'">我的账号</a>
                   		 (<a href="${ctxPath}/j_acegi_logout" rel="nofollow" onclick="window.location.href='${ctxPath}/j_acegi_logout'">退出</a>)
                </li>
	         </ul>
             <div><i class="fa fa-shopping-cart fa-1" style="margin-right:7px;"></i><a href="${ctxPath}/cart/shoppingcart.html">购物车</a></div>
             
             <script type="text/javascript">
			//$mnc.refresh();
			fillLoginPrompt();
			</script>
			
             <div class="search">
             	<form action="" method="get">
                 <div class="left"><input type="text" class="box-input" value="" style="height:30px; width:130px;background-color:#363636; border:none; color:#fff;" /></div>
                 <div style="height:32px; float:left; width:20px; background-color:#363636; position:relative; z-index:100; left:110px; top:-32px;"><i class="fa fa-search" style="margin-top:8px;"></i></div>
                 </form>
             </div>
         </div>
     </div>
 </div>
