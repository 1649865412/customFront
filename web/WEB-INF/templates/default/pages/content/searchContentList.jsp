<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cms" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
		<title>帮助中心 | 搜索结果  </title>
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
				
				<div class="main">
				 <div class="help-content">
					<%-- 搜索结果 --%>
					<h2>搜索结果</h2>
					<c:forEach items="${contentList}" var="content" varStatus="s">
			            	<h3>${content.contentTitle}</h3>
			                <dd>
			                    	${content.contentBody}
			                </dd>
					</c:forEach>
				</div>
				</div>
			</div>

	</body>
</html>