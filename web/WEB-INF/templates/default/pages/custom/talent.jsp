<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>

<html>
	<head>
		<title>${appConfig.store.title}</title>
		<meta name="keywords" content="${appConfig.store.keyWords}" />
		<meta name="description" content="${appConfig.store.description}" />
		<meta name="baidu-site-verification" content="3PsP8afx3G" />
		
		<link href="${resPath }/custom/styles/style.css" rel="stylesheet" type="text/css">
		
		<link href="${resPath }/custom/styles/loginDialog.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="${ctxPath}/scripts/custom/jquery-1.11.1.min.js" ></script>
		<script type="text/javascript" src="${ctxPath}/scripts/custom/3deye.min.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>

		<script type="text/javascript">
		</script>
		</head>
		<body>
		<input type="hidden" id="selectedOption" value="">
		
		<div class="lyt-wrap">
		
			<%-- 公用的左侧栏--%>
			<%@ include file="../common/left.jsp"%>
			<%-- 公用的左侧栏--%>
			
			<%-- 设计达人 --%>
			<div class="main">
		    	<ul class="design">
		    		<c:forEach items="${rsList}" var="productReview" varStatus="s">
						<li>
	                    	<dl>
	                        	<dt><img src="${mediaPath }/productMedia/d/${productReview.url}"/></dt>
	                            <dd>
		                            <div class="date"><i class="fa fa-table"></i>&nbsp;&nbsp;<fmt:formatDate value="${productReview.updateTime}" pattern="yyyy-MM-dd HH:mm"/>
		                            </div>
		                            <div class="love"><i class="fa fa-heart"></i>&nbsp;&nbsp;${productReview.loveCount }个喜欢</div>
	                            </dd>
	                            <dd>
	                            	<h2>${productReview.subject }</h2>
	                            	<p>
	                            		${productReview.message }
									</p>
	                            </dd>
	                        </dl>
	                  	</li>
					</c:forEach>
              </ul><%--
              
		    	<c:forEach items="${chList}" var="ch" varStatus="s">
					<c:if test="${s.index % 3 == 0}"><br/></c:if>
					<img src="${mediaPath }/productMedia/d/${ch.url}"/>
				</c:forEach>
				
		    --%></div>
				<%-- 设计达人 --%>
		
		</div>
		
	</body>
	
</html>
