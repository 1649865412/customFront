<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title>${appConfig.store.title}</title>
		<%@ include file="./include/meta.jspf"%>
		<%@ include file="./include/javascripts2.jspf"%>
		<decorator:head />
		<script type="text/javascript">
		function fnCheckSearchContent($frm)
		{
			if ($frm.cq.value == "")
			{
				alert("Please submit the keyword!");
				$frm.cq.focus();
				return false;
			}
			return true;
		}
		</script>	
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/> <decorator:getProperty property="body.onload" writeEntireProperty="true"/> <decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
	
			<decorator:body></decorator:body>
				
	</body>
</html>