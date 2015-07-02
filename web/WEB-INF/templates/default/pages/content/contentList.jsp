<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cms" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
		<title>${category.categoryName}</title>
		<meta name="keywords" content="${not empty category.metaKeyword?category.metaKeyword:category.categoryName}" />
		<meta name="description" content="${not empty category.metaDescription?category.metaDescription:category.categoryDescription}" />
	</head>
	<body>
	</body>
</html>

