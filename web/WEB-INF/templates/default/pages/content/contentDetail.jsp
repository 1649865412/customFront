<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cms" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
		<title>${content.contentTitle} | ${category.categoryName}  </title>
		<meta name="keywords" content="${not empty content.metaKeyword?content.metaKeyword:content.contentTitle}" />
		<meta name="description" content="${content.metaDescription}" />
		
		<link href="${resPath }/custom/styles/style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${ctxPath}/scripts/custom/jquery-1.11.1.min.js" ></script>
		
		<script type="text/javascript">
		$(function(){
		$(".v-title").children("li").click(function(){
			var lis=$(this).siblings().removeClass("selected");
			lis.each(function(i){
				if($(this).attr("ref")){
					$("#"+$(this).attr("ref")).hide();
				}
			 });
			 if($(this).attr("ref")){
				$("#"+$(this).addClass("selected").attr("ref")).show();
			}
		});
		$(".sub-v").children("li").click(function(){$(this).addClass("selected").siblings().removeClass("selected");});
		});
		</script>
		
		
      <script type="text/javascript">
	  $(document).ready(function() {
	  $("a.icon_a").hover(function() {
			  $(this).children(".icon_width").children(".fa").removeClass("icon_nohover");
			  $(this).children(".icon_width").children(".fa").addClass("icon_hover");
		  }, function() {
			  $(this).children(".icon_width").children(".fa").removeClass("icon_hover");
			  $(this).children(".icon_width").children(".fa").addClass("icon_nohover");
		  });
	  });
	  </script>
		
	</head>
	
	<body>
	
			<div class="lyt-wrap">
		
				<%-- 公用的左侧栏--%>
				<%@ include file="../common/left.jsp"%>
				<%-- 公用的左侧栏--%>
				
				<%-- 关于我们 --%>
				<c:if test="${content.id == 18 }">
					<div class="main">
				 		<div class="buy-banner"><img src="${resPath}/custom/images/table-chair-city.jpg" ></div>    	
				      	<div class="contact">
					           <div class="sec2">
					             <img src="${resPath}/custom/images/press.png">
					           </div>
					           <div class="top_about">
					             	<div class="about_us">
						                <p><span class="smalltop">唯定制目前由广州名度网络技术有限公司运营</span>
						                </p><h1 class="about_slogan">我们是唯定制</h1>
						                <h2 class="about_slogan_down">时尚女鞋定制网</h2>
						                <hr>
						                	${content.contentBody}
									</div><!--about_us-->
					           </div><!--top_about-->
					         </div>
				    </div>
				</c:if>
				<%-- 关于我们 --%>
				
	
				<%-- 联系我们 --%>
				<c:if test="${content.id == 27 }">
					<div class="main">
				    	<div class="buy-banner"><img src="${resPath}/custom/images/contactus.jpg"  alt=""></div>
				      <div class="contact">
				        <div class="sec2">
				         <img src="${resPath}/custom/images/fields.png">
				       </div>
				      <h1 class="about_slogan">联系唯定制</h1>
					            <h2 class="contact_us_title_down">如果您在购物过程中遇到问题，我们很愿意为您提供帮助。<br/>我们的服务时间为：周一至周五 09：30&mdash;18:30（节假日除外）</h2>
					            <hr>
					            <ul class="list_icon_items" style="font-size:12px;">
					              <li>
					                <a class="icon_a" href="mailto:cs@sifangstreet.com">
					                
					                <div class="icon_width">
					
					                   <i class="fa fa-envelope fa-5x icon_nohover"></i>
					                 </div>
					                    <p class="secondary">电子邮箱</p>
					                    <p>
					                      <span class="pseudo-link">cs@sifangstreet.com</span>
					                    </p>
					                </a>
								  </li>
					              <li>
					                <a class="icon_a" href="javascript:void(0);">
					                <div class="icon_width">
					                  <i class="fa fa-phone fa-5x icon_nohover"></i>
					                </div>
					                  <p class="secondary">客服专线</p>
					                  <p>
					                        <span id="Pcode" class="pseudo-link">400-661-5677</span>
					                    </p>
					                </a>
					              </li>
					             
					              <li>
					                <a class="icon_a" href="http://weibo.com/sifangstreet">
					                <div class="icon_width">
					                    <i class="fa fa-weibo fa-5x icon_nohover"></i>
					                </div>
					                    <p class="secondary">微博</p>
					                    <p>
					                        <span class="pseudo-link">关注SiFangStreet四方街</span>
					                    </p>
					                </a>
					
					              </li>
					              <li>
					                <a class="icon_a fancybox" href="#inline1">
					                <div class="icon_width">
					                    <i class="fa fa-weixin fa-5x icon_nohover"></i>
					                    
					                </div>
					                
					                    <p class="secondary">微信</p>
					                    <p>
					                        <span class="pseudo-link">搜索sifangstreet四方街或点击打开二维码</span>
					                    </p>
					                </a>
					              </li>
					              <li>
					                <a target="_blank" class="icon_a" href="http://wpa.qq.com/msgrd?v=3&amp;uin=4006615677&amp;site=qq&amp;menu=yes">
					                <div class="icon_width">
					                    <i class="fa fa-qq fa-5x icon_nohover"></i>
					                </div>
					                    <p class="secondary">QQ客服</p>
					                    <p>
					                        <span class="pseudo-link">点击可访问QQ客服</span>
					                    </p>
					                </a>
					
					              </li>
					               <li>
					                <a class="icon_a" href="javascript:void(0);">
					                <div class="icon_width">
					                    <i class="fa fa-comments-o fa-5x icon_nohover"></i>
					                </div>
					                    <p class="secondary">在线客服</p>
					                    <p>
					                        <span class="pseudo-link">点击页面右侧侧边栏</span>
					                    </p>
					                </a>
					
					              </li>
					            </ul>
					            
					            <div id="inline1" class="weixin_QR"></div>
								<div class="blank24"></div>
					
					            <div class="grid-14 center">
								<div class="map_find_us"></div>
								
								<div class="map-lower">
									<div class="grid-9">
										<h3>体验店&nbsp;&amp;&nbsp;办公地址</h3>
					                    <div class="dec">
					                      <p><i class="fa fa-map-marker fa-2x padding_right15"></i>广州市越秀区东风东路753号天誉大厦东塔3104</p>
					                      <p><i class="fa fa-university fa-lg padding_right10"></i>广州名度网络技术有限公司</p>
					                    </div>
									</div>
								</div>
							</div>
				    	</div>
				    </div>
				</c:if>
				<%-- 联系我们 --%>
				
				
				<%-- 帮助中心 --%>
				<c:if test="${!(content.id == 18 || content.id == 27)}">
					<div class="main">
				   	  <div class="help-content">
				        	<h1>帮助中心</h1>
				            <div class="help-left">
				            	<p>此刻开始，我们将尽快把您心仪的产品配送到您的手中，并提供温馨的售后服务，让您享受不一样的时尚购物体验！</p>
				                <div class="blank24"></div>
				                <%--<span>您可以在下方搜索您想要的帮助内容</span>
				                <div class="blank10"></div>
				                <form action="${ctxPath }/Customer_Service/search.html" method="get" onsubmit="return check(this);">
				                	<div class="left" style="width:60%;">
				                		<input name="cq" value="${param.cq}" style="height:50px; border:1px solid #000; width:100%; font-size:14px;" type="text">
				                	</div>
				                	<div class="left">
				                		<input type="image" src="${resPath }/custom/images/help_search.jpg" />
				                	</div>
				                </form>--%>
				            </div>
				            <div class="help-right">
				       	    	<%--<a href="#"><i class="fa fa-comments-o fa-6"><span>点击联系<br/>在线客服</a></span></i>--%>
				            </div>
				            <div class="blank24"></div>
				            <h2>热点问题</h2>
				            <ul>
				            	<content:showContents var="cat_content_list" categoryCode="site-help"></content:showContents>
				            	<c:forEach items="${cat_content_list}" var="cat_content" end="15">
									<content:contentUrl content='${cat_content}' var="contUrl"/>
									<li<c:if test="${fn:endsWith(OriginalRequestURL,contUrl)}"> class="selected"</c:if>>
										<a href="${contUrl}" title="<c:out value="${cat_content.contentTitle}"/>">${cat_content.contentTitle}</a>
									</li>
								</c:forEach>
				            </ul>
				            <div class="blank24"></div>
				            <h2>${content.contentTitle}</h2>
				            <div style=" width:100%; margin-bottom:20px;">
				               ${content.contentBody}
				            </div>  
				      </div>
				    </div>
				    
					<!--百度商桥与百度统计，内嵌链接  -->       
					<div id="BDBridgeFixedWrap"></div>
					 <!-- 百度商桥 -->
					<script type="text/javascript"> 
					var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://"); 
					document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fff1dc2202bf6009c4606bd410be9f10a' type='text/javascript'%3E%3C/script%3E"));
					</script>
				    
				</c:if>
				<%-- 帮助中心 --%>
				
			</div>
			
			<script type="text/javascript">
			function check($frm)
			{
				if ($frm.cq.value == "")
				{
					alert("请输入要搜索的帮助内容！");
					$frm.cq.focus();
					return false;
				}
				return true;
			}
			</script>

	</body>
</html>