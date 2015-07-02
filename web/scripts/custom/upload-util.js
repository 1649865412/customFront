
function fnUploadMoreImage_d_Handler(file){
	showUploadProudctMedia_d('personalMoreImages_d',0,file);
}

function showUploadProudctMedia_d(divId,uploadInputMediaType,file){
	debugger;
	var id = "1" + new Date().getTime().toString().substr(6);
	var inputUploadHtml = "";
	var productMedia_img = "media_noPhoto.gif";
	var productDetail_media_url_desc = "";
	inputUploadHtml += '<div class="personal-media" id="personalMedia_div_' + id + '">';
	inputUploadHtml += '<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="no-border">';
	inputUploadHtml += '<tr>';
	inputUploadHtml += '<td class="list" width="15%" align="center"><input type="hidden" id="-' + id + '" name="personalMediaIds" value="-' + id + '""><input type="hidden" name="personalMediaTypes" value="' + uploadInputMediaType + '">';
	if (uploadInputMediaType == 0) {
		inputUploadHtml += '<img id="personalMedia_img_' + id + '" src="' + __mediaPath +file.previewUrl+'" width="60" height="60" />';
		inputUploadHtml += '&nbsp;&nbsp;<input name="remove_empty_item" type="image" src="' + __ctxPath + '/images/icon/icon_del.gif" onclick="fnRemoveUploadMedia('+ id+',this);return false;" title="' + __FMT.productDetail_moreImage_removeThisImage + '"/>';
	} else {
		inputUploadHtml += '<img id="personalMedia_img_' + id + '" src="' + __ctxPath + '/images/accessorie_hight_light.gif" width="60" height="60" />';
	}
	inputUploadHtml += '<input type="hidden" id="personalMedia_deleteds_' + id + '" name="productMedia_deleteds" value="0">';
	//inputUploadHtml += '</td><td class="list" width="24%">';
	inputUploadHtml += '<input id="personalMedia_url_' + id + '" name="personalMedia_urls" type="hidden" style="width:400px;" value="'+file.url+'"/></span>';
	//inputUploadHtml += '</td><td class="list">';
	
	inputUploadHtml += '</td>';
	inputUploadHtml += '</tr>';
	inputUploadHtml += '</table>';
	inputUploadHtml += '</div>';
	$("#" + divId).append(inputUploadHtml);
	//fnInitValidProductMedia();
}

function removeAllProductImg(id){
	$("#" + id).html("");
}

function fnRemoveUploadMedia(id,obj){
	//$j('#productMedia_div_' + id).remove();
	var $this = $(obj);
	$this.parents(".personal-media").remove();
}

