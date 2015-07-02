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
		
		<style>
		.swfupload{
			width:70px;
			height:70px;
			background-image: url("${ctxPath}/scripts/swfupload/up_s2.jpg");
			border-radius: 8px;
			border: 2px solid #000;
		}
		</style>
		
		<link href="${resPath }/custom/styles/style.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="${ctxPath}/scripts/custom/jquery-1.11.1.min.js" ></script>
		<script type="text/javascript" src="${ctxPath}/scripts/custom/3deye.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/custom/upload-util.js"></script>

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
		</head>
		<body>
		<input type="hidden" id="selectedOption" value="" />
		
		<div class="lyt-wrap">
		
			<%-- 公用的左侧栏--%>
			<%@ include file="../common/left.jsp"%>
			<%-- 公用的左侧栏--%>
			
		    <div class="main">
    			<div class="buy-banner"><img src="${resPath}/custom/images/banner.jpg" /></div>
			      <div class="update-wrap">
						   <div class="upload">
			                <h2>上传鞋款图片</h2>
			                <div align="center"><span>为了成功制作您指定的款式，您至少需要提供以下三个不同方向的照片</span></div>
			                <div class="blank6"></div>
			                <div class="upadate">
			                  <div class="up-left">
			                        正面
			                    <div class="blank6"></div>
			                    <img src="${resPath}/custom/images/up1_1.jpg" alt="上传后的图片放这里">
			                  </div>
			                  <div class="up-right">
			                  	<div class="tips"><img src="${resPath}/custom/images/up1_2.png" alt="范例图片"></div>
			                    <div class="example"><img src="${resPath}/custom/images/up1_2.jpg" alt="范例图片"></div>
			                  </div>
			                </div>
			                <div class="upadate">
			                  <div class="up-left">
			                        正侧
			                    <div class="blank6"></div>
			                    <img src="${resPath}/custom/images/up2_1.jpg" >
			                  </div>
			                  <div class="up-right">
			                  	<div class="tips"><img src="${resPath}/custom/images/up2_2.png" alt="范例图片"></div>
			                    <div class="example"><img src="${resPath}/custom/images/up2_2.jpg" alt="范例图片"></div>
			                  </div>
			                </div>
			                <div class="upadate">
			                  <div class="up-left">
			                        背面
			                    <div class="blank6"></div>
			                    <img src="${resPath}/custom/images/up3_1.jpg" >
			                  </div>
			                  <div class="up-right">
			                  	<div class="tips"><img src="${resPath}/custom/images/up3_2.png" alt="范例图片"></div>
			                    <div class="example"><img src="${resPath}/custom/images/up3_2.jpg" alt="范例图片"></div>
			                  </div>
			                </div>
			                <div class="blank24"></div>
			                <div align="center"><span>如果方便你还可以上传其它角度或者细节的图片</span></div>
			                <div class="up">
			                    <div class="upload-photo"><a href="#"></a></div>
			                    <div class="left">
			                       <a href="#">
				                       <%--<img src="${resPath}/custom/images/up_s2.jpg" >--%>
				                       <span id="personalMediaImageBtnPlaceHolderId_d"></span>
			                       </a>
			                     	<span id="uploadProcess"></span>
			                    </div>
			                </div>
			            </div>
			        	
			            
			            <form id="form1" action="${ctxPath }/cart/shoppingcart.html" method="post">
			            	<input type="hidden" name="doAction" value="addProductAndOptions"/>
			            	<textarea rows="20" cols="20" style="display: none;" id="moreOptions" name="moreOptions"></textarea>
		                	<input type="hidden" id="productId" name="productId" value="${productId }"/>
							<input type="hidden" id="productName" name="productName" value="${productName }"/>
		                
			            <!-- ############### 上传操作  ################# -->
			            <div>
			            	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table-content">
								<%--<tr>
									<td width="50%">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="no-border">
											<tr>
												<td width="15%" align="center">
													<span id="personalMediaImageBtnPlaceHolderId_d"></span>
												</td>
												<td>
													（<a href="#" onclick="removeAllProductImg('personalMoreImages_d');">移除所有产品大图</a>）
												</td>
											</tr>
										</table>
									</td>
								</tr>--%>
								<tr>
									<td>
										<div id="personalMoreImages_d">
											<c:forEach items="${personalImages}" var="personalMoreImage">
												<div class="personal-media" id="personalMedia_div_${personalMoreImage.id}">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="no-border">
														<tr>
															<td class="list" align="center">
																<input type="hidden" name="personalMediaIds" value="${personalMoreImage.id}">
																<input type="hidden" name="personalMediaTypes" value="${personalMoreImage.mediaType}">
																<cartmatic:img url="${personalMoreImage.mediaUrl}" mediaType="personalMedia" size="d" width="60" height="60" id="personalMedia_img_${personalMoreImage.id}"></cartmatic:img>
																<input type="hidden" id="personalMedia_deleteds_${personalMoreImage.id}" name="personalMedia_deleteds" value="0">
															</td>
														</tr>
													</table>
												</div>
											</c:forEach>
										</div>
									</td>
						        </tr>
							</table>
							<cartmatic:swf_upload btnPlaceHolderId="personalMediaImageBtnPlaceHolderId_d" uploadCategory="personalMedia" uploadFileTypes="*.jpg; *.jpeg; *.png; *.gif" onComplete="fnUploadMoreImage_d_Handler" objId="${sc.shoppingcartId}" previewSize="v" isMultiFiles="true" button_text="上传" fileImageSize="v"  fileSizeLimit="5MB"></cartmatic:swf_upload>
			            </div>
			            
			            </form>
			            
			            <%--<div class="blank24"></div>--%>
			            <h2>您的私人尺码</h2>
			            <div class="u-left">前掌宽度</div><div class="u-middle">*</div>
			            <div class="help">
			            	<a>
			                    <img src="${resPath}/custom/images/icon.jpg" width="12" height="13">
			                <div class="help-layer">
			                        <div class="layer-img"></div>
			                        <div class="layer-txt">
			                            <p>这里是帮助信息</p>
			                            <p><img src="${resPath}/custom/images/help_layer.jpg" width="222" height="272"></p>
			                        </div>
			                    </div>
			                </a>
			            </div>
			            <div class="input"><input id='field1' name="field1" type="text" class=""></div>
			            <div class="blank24"></div>
                        <div class="u-left">日常鞋码</div><div class="u-middle">*</div>
			            <div class="help">
			                <a>
			                    <img src="${resPath}/custom/images/icon.jpg" width="12" height="13">
			                    <div class="help-layer">
			                        <div class="layer-img"></div>
			                        <div class="layer-txt"><p>这里是帮助信息</p></div>
			                    </div>
			                </a>
			            </div>
			            <div class="input"><input id='field2' name="field2" type="text" class=""></div>
			            <div class="blank24"></div>
                        <div class="u-left">脚长</div><div class="u-middle">*</div>
			            <div class="help">
			                <a>
			                    <img src="${resPath}/custom/images/icon.jpg" width="12" height="13">
			                    <div class="help-layer">
			                        <div class="layer-img"></div>
			                        <div class="layer-txt"><p>这里是帮助信息</p></div>
			                    </div>
			                </a>
			            </div>
			            <div class="input"><input id='field3' name="field3" type="text" class=""></div>
			            <div class="blank24"></div>
                        <div class="u-left">脚宽</div><div class="u-middle">*</div>
			            <div class="help">
			                <a>
			                    <img src="${resPath}/custom/images/icon.jpg" width="12" height="13">
			                    <div class="help-layer">
			                        <div class="layer-img"></div>
			                        <div class="layer-txt"><p>这里是帮助信息</p></div>
			                    </div>
			                </a>
			            </div>
			            <div class="input"><input  id='field4' name="field4" type="text" class=""></div>
			            <div class="blank24"></div>
			            <div align="center" style="font-size:16px; color:#d4bc8c;">更多定制选项</div>
			        	<div class="left" >靴筒类别</div>
			        	<div id='field5' name="field5">
				            <ul class="v-title">
				            	<li class="selected" ref="content1">
				            		<input value="靴筒类别1" type="hidden"/>
				                	<a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/shuxing1.jpg" ><p>厚底</p></dd>
				                        </dl>
				                    </a>
				                    <span><strong></strong></span>
				                </li>
				                <li ref="content2">
				                	<input value="靴筒类别2" type="hidden"/>
				                	<a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/shuxing2.jpg" ><p>厚底</p></dd>
				                        </dl>
				                    </a>
				                    <span><strong></strong></span>
				                </li>
				            </ul>
			            </div>
			            <div class="v-content" id="content1">
			            	<div class="u-left">小腿围度</div>
			                <div class="help">
			                    <a>
			                        <img src="${resPath}/custom/images/icon.jpg" width="12" height="13">
			                    <div class="help-layer">
			                            <div class="layer-img"></div>
			                            <div class="layer-txt"><p>这里是帮助信息</p></div>
			                        </div>
			                    </a>
			                </div>
			                <div class="input"><input  id='field6' name="field6" type="text" class=""></div>
			                <div class="blank24"></div>
			                <div class="u-left">脚踝高度</div>
			                <div class="help">
			                    <a>
			                        <img src="${resPath}/custom/images/icon.jpg" width="12" height="13">
			                    <div class="help-layer">
			                            <div class="layer-img"></div>
			                            <div class="layer-txt"><p>这里是帮助信息</p></div>
			                        </div>
			                    </a>
			                </div>
			                <div class="input"><input  id='field7' name="field7" type="text" class=""></div>
			                <div class="blank24"></div>
			                <div class="u-left">膝盖高度</div>
			                <div class="help">
			                    <a>
			                        <img src="${resPath}/custom/images/icon.jpg" width="12" height="13">
			                    <div class="help-layer">
			                            <div class="layer-img"></div>
			                            <div class="layer-txt"><p>这里是帮助信息</p></div>
			                        </div>
			                    </a>
			                </div>
			                <div class="input"><input id='field8' name="field8" type="text" class=""></div>
			            </div>
			            <div class="clear"></div>
			            <div class="v-content" id="content2" style="display: none;">
			                <div class="u-left">大腿围度&nbsp;&nbsp;&nbsp;</div>
			                <div class="help">
			                    <a>
			                        <img src="${resPath}/custom/images/icon.jpg" width="12" height="13">
			                    	<div class="help-layer">
			                            <div class="layer-img"></div>
			                            <div class="layer-txt"><p>这里是帮助信息</p></div>
			                        </div>
			                    </a>
			                </div>
			                <div class="input"><input  id='field9' name="field9" type="text" class=""></div>
			                <div class="blank24"></div>
			                <div class="u-left">过膝高度</div>
			                <div class="help">
			                    <a>
			                        <img src="${resPath}/custom/images/icon.jpg" width="12" height="13">
			                        <div class="help-layer">
			                            <div class="layer-img"></div>
			                            <div class="layer-txt"><p>这里是帮助信息</p></div>
			                        </div>
			                    </a>
			                </div>
			                <div class="input"><input id='field10' name="field10" type="text" class=""></div>
			             </div>
			            <div class="blank24"></div>
			            <div class="left">闭合类别</div>
			            <div id='field11' name="field11">
				            <ul class="v-title">
				                <li class="selected" ref="content7">
				                	<input value="闭合类别1" type="hidden"/>
				                	<a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/shuxing1.jpg" ><p>厚底</p></dd>
				                        </dl>
				                    </a>
				                </li>
				                <li ref="content8">
				                	<input value="闭合类别2" type="hidden"/>
				                	<a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/shuxing2.jpg" ><p>厚底</p></dd>
				                        </dl>
				                    </a>
				                </li>
				            </ul>
			            </div>
			            <div class="blank24"></div>
			            <div class="left">大底类别</div>
			            <ul class="v-title">
			                <li class="selected" ref="content11">
			                	<input value="大底类别1" type="hidden"/>
			                	<a>
			                    	<dl>
			                        	<dt></dt>
			                            <dd><img src="${resPath}/custom/images/shuxing1.jpg" ><p>厚底</p></dd>
			                        </dl>
			                    </a>
			                    <span><strong></strong></span>
			                </li>
			                <li ref="content12">
			                	<input value="大底类别2" type="hidden"/>
			                	<a>
			                    	<dl>
			                        	<dt></dt>
			                            <dd><img src="${resPath}/custom/images/shuxing2.jpg" ><p>厚底</p></dd>
			                        </dl>
			                    </a>
			                    <span><strong></strong></span>
			                </li>
			            </ul>
			            <div id='field12' name="field12">
				            <div class="v-content" id="content11">
				                <ul class="sub-v">
				                    <li class="selected">
				                    	<input value="黑色橡胶底" type="hidden"/>
				                        <a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/sub_2.jpg" ><div class="blank10"></div>黑色橡胶底</dd>
				                        </dl>
				                    </a>
				                    </li>
				                    <li>
				                    	<input value="棕色橡胶底" type="hidden"/>
				                        <a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/sub_3.jpg" ><div class="blank10"></div>棕色橡胶底</dd>
				                        </dl>
				                    </a>
				                    </li>
				                </ul>
				            </div>
				            <div class="v-content" id="content12" style="display: none;">
				                <ul class="sub-v">
				                    <li>
				                    	<input value="红色橡胶底" type="hidden"/>
				                        <a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/sub_1.jpg" ><div class="blank10"></div>红色橡胶底</dd>
				                        </dl>
				                    </a>
				                    </li>
				                    <li>
				                    	<input value="黑色橡胶底" type="hidden"/>
				                        <a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/sub_2.jpg" ><div class="blank10"></div>黑色橡胶底</dd>
				                        </dl>
				                    </a>
				                    </li>
				                </ul>
				            </div>
			            </div>
			            <div class="blank24"></div>
			            <div class="left">内里类别</div>
			            <ul class="v-title">
			                <li class="selected" ref="content13">
			                	<input value="内里类别1" type="hidden"/>
			                	<a>
			                    	<dl>
			                        	<dt></dt>
			                            <dd><img src="${resPath}/custom/images/shuxing1.jpg" ><p>厚底</p></dd>
			                        </dl>
			                    </a>
			                    <span><strong></strong></span>
			                </li>
			                <li ref="content14">
			                	<input value="内里类别2" type="hidden"/>
			                	<a>
			                    	<dl>
			                        	<dt></dt>
			                            <dd><img src="${resPath}/custom/images/shuxing2.jpg" ><p>厚底</p></dd>
			                        </dl>
			                    </a>
			                    <span><strong></strong></span>
			                </li>
			            </ul>
			            <div id='field13' name="field13">
				            <div class="v-content"  id="content13" >
				                <ul class="sub-v">
				                    <li class="selected">
				                    	<input value="灰毛兔毛里" type="hidden"/>
				                        <a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/sub_1.jpg" ><div class="blank10"></div>灰毛兔毛里</dd>
				                        </dl>
				                    </a>
				                    </li>
				                    <li>
				                    	<input value="黑色兔毛里" type="hidden"/>
				                        <a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/sub_2.jpg" ><div class="blank10"></div>黑色兔毛里</dd>
				                        </dl>
				                    </a>
				                    </li>
				                </ul>
				            </div>
				             <div class="v-content"  id="content14" style="display: none;">
				                <ul class="sub-v">
				                    <li>
				                    	<input value="黑色兔毛里" type="hidden"/>
				                        <a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/sub_2.jpg" ><div class="blank10"></div>黑色兔毛里</dd>
				                        </dl>
				                    </a>
				                    </li>
				                    <li>
				                    	<input value="白色兔毛里" type="hidden"/>
				                        <a>
				                    	<dl>
				                        	<dt></dt>
				                            <dd><img src="${resPath}/custom/images/sub_3.jpg" ><div class="blank10"></div>白色兔毛里</dd>
				                        </dl>
				                    </a>
				                    </li>
				                </ul>
				            </div>
			            </div>
			            <div class="blank24"></div>
			            <div class="btn-buy"><input name="" type="button" value="提交"  onclick="getValue();"/></div>
			            <div class="blank24"></div>
			            <div class="blank24"></div>
			            
			      </div>
                  <div class="blank24"></div>
                  <div class="m-section-general">
<a class="m-button-simple-plus js-mail-popup hover">Join Our Mailing List</a><ul class="list-horiontal"><li><a href="#">Artists Frame Service</a></li><li><a href="#">Chicago&nbsp;Art&nbsp;Source</a></li><li><a href="#">Jayson&nbsp;Home</a></li><li><a href="#">Bella + Prisma</a></li><li><a href="#">1-800Artwork.com</a></li></ul><p>&copy; The Goltz Group. All rights reserved. Site&nbsp;by&nbsp;<a href="#">Knoed</a>&nbsp;and&nbsp;<a href="#">Static</a>.</p></div>
	 		 </div>
		</div>
		
		<script type="text/javascript">
			function getValue(){
				var msg = "<div>";

				/*
				$("div.main").find("li.selected").each(function(){
					var val = $(this).find("input").val();
					msg = msg + val + "</br>";
				});
				*/
				
				debugger;
				
				var f1 = $("#field1").val();
				var f2 = $("#field2").val();
				var f3 = $("#field3").val();
				var f4 = $("#field4").val();

				var f5 = $("#field5").find("li.selected").find("input").val();
				
				var f6 = $("#field6").val();
				var f7 = $("#field7").val();
				var f8 = $("#field8").val();
				var f9 = $("#field9").val();
				var f10 = $("#field10").val();

				var f11 = $("#field11").find("li.selected").find("input").val();
				var f12 = $("#field12").find("li.selected").find("input").val();
				var f13 = $("#field13").find("li.selected").find("input").val();

				msg += "前掌宽度：" + f1 + "<br/>";
				msg += "日常鞋码：" + f2 + "<br/>";
				msg += "脚长：" + f3 + "<br/>";
				msg += "脚宽：" + f4 + "<br/>";
				msg += "靴筒类别：" + f5 + "<br/>";
				msg += "小腿围度：" + f6 + "<br/>";
				msg += "脚踝高度：" + f7 + "<br/>";
				msg += "膝盖高度：" + f8 + "<br/>";
				msg += "大腿围度：" + f9 + "<br/>";
				msg += "过膝高度：" + f10 + "<br/>";
				msg += "闭合类别：" + f11 + "<br/>";
				msg += "大底类别：" + f12 + "<br/>";
				msg += "内里类别：" + f13 + "<br/>";

				msg += "</div>";
				//msg = msg + f1 + "<br/>" + f2 + "<br/>" + f3 + "<br/>" + f4 + "<br/>" + f5 + "<br/>" + f6 + "<br/>" + f7 + "<br/>" 
				//				   + f8 + "<br/>" + f9 + "<br/>" + f10 + "<br/>" + f11 + "<br/>" + f12 + "<br/>" + f13 + "<br/>"

				//alert(msg);

				$("#moreOptions").text(msg);
				 
				$("#form1").submit();
			}
		</script>
		
	</body>

<%--
	field1	前掌宽度（input）
	field2	日常鞋码（input）
	field3	脚长（input）
	field4	脚宽 （input）
	field5	靴筒类别（li）
	field6	小腿围度（input）
	field7	脚踝高度（input）
	field8	膝盖高度（input）
	field9	大腿围度（input）
	field10	过膝高度（input）
	field11	闭合类别（li）
	field12	大底类别（li）
	field13	内里类别（li）
 --%>

</html>


