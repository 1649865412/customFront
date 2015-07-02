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
		<link href="${resPath }/custom/styles/product_list_page.css" rel="stylesheet" type="text/css">
		<link href="${resPath }/custom/styles/loginDialog.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="${ctxPath}/scripts/custom/jquery-1.11.1.min.js" ></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/custom/3deye.min.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/custom/jquery.ad-gallery.js" ></script>
		<link href="${resPath }/custom/styles/jquery.ad-gallery.css" rel="stylesheet" type="text/css">
		
		 <link href="${resPath }/styles/comment.css" rel="stylesheet" type="text/css">
		 
		 <style>
		   #gallery {
		    padding: 20px;
		    /*background: #e1eef5;*/
		  }
		 </style>
		 
		 <script type="text/javascript" src="${ctxPath }/scripts/detail/jquery.raty.js"></script>
		 
		<script type="text/javascript">
		var _pageSize = "${pageSize}";
		var pageNo = 1;
		var q = "";
		var startIndex = 0;
		
		$(function(){

			var flag = false;
			
		 	var init=1;
			$("#options").find("li").click(function(eve){

				$(this).addClass("selected").siblings().removeClass("selected");
				var uid=$(this).closest("ul").attr("id");
				var si=$(this).attr("si");
				if(si){
					$(this).closest("ul").nextAll().hide();
					si=$("#"+si).show();
				}
				var vi=$(this).attr("vi");
				if(vi){
					var as=vi.split(",");
					var lis=$("#"+as[0]).children("li");
					lis.each(function(i){
					   $(this).removeClass("selected").hide();
					   var si=$(this).attr("si");
						if(si){
							si=$("#"+si).hide().children("li").attr("disabled","disabled");
						}
					 });
					 var j=0
					 for(var i=1;i<as.length;i++){
					 	$("li[si='"+as[i]+"']").show();
					 	if(j==0){
					 		$("li[si='"+as[i]+"']").addClass("selected");
					 	}
					 	j++;
					 	si=$("#"+as[i]).children("li").removeAttr("disabled");
					 }
				}
				 
				 if(init==1||($(this).attr("data-velue")&&eve.pageX>0)){
				 	init++;
				 	var selectedValues=$("li.selected[data-velue]");
					var sku="";
					var name="";
					selectedValues.each(function(i){
						if(!$(this).attr("disabled")){
							sku+=$(this).attr("data-velue")+"_";
						   name+=$(this).children("div.attribute-txt").html()+",";
						}
					 });
				 	var image=sku;

				 
				 	var images=new Array();
					$("#name").html(name+" "+image+"1.jpg");
					name = name.substring(0,name.length-1);
					/*
					//此处根据name（产品名称）从后台搜索出相应的图片
					$.post(__ctxPath+"/product/name.html",{name:name},function(json){
						//debugger;
						 	if(json != null && json.length > 0){
							 	if(json[0] == null){
							 		//alert("本网站暂不提供此款定制产品：" + name + "!");
							 	}else{
							 		$("#photo").attr("src","${mediaPath}productMedia/d/" + json[0].mediaUrlLarge);
							 		$("#productId").val(json[0]._productId);
							 		$("#productName").val(name);
								 	for(i=0; i<json.length; i++){
								 		images.push("${mediaPath}productMedia/d/" + json[i].mediaUrlLarge);
								 	}
								 	//debugger;
								 	$("#photo").vc3dEye({images:images});
							 	}
						 	}else{
							 	//alert("本网站暂不提供此款定制产品：" + name + "!");
						 	}
					 },"json");
*/
					debugger;
					
					var nameSplit = name.split(",");
					for(var i in nameSplit){
						q = q + "productName_proN:" + nameSplit[i] + " AND ";
					}
					q = q.substring(0,q.length - 4);
					$.post(__ctxPath+"/search-prod-byName.html",{q:q,pageNo:pageNo},function(json){
						//debugger;
						 	if(json != null && json.length > 0){
							 	if(json[0] == null){
							 		//alert("本网站暂不提供此款定制产品：" + name + "!");
							 	}else{
								 	debugger;
								 	var liAll = "";
								 	for(i=0; i<json.length; i++){
								 		var li = "";
									 	li +="<li>";
							            li += "<a href='"+ "${mediaPath}product/d/" + json[i].media  +  "'>";
							            li += "<img src='"+ "${mediaPath}product/b/" + json[i].media  + "' productName='" + json[i].productName + "' class=''>";
							            li += "</a>"
							            li+="</li>";
							            liAll += li;
								 	}
								 	 $("#mediaList").html(liAll);
								 	$("#p_i_list").html(liAll);
								 	 pageNo = 1;
							 	}
							 	$('.ad-gallery').adGallery({scroll_jump: 150});
						 	}else{
							 	//alert("本网站暂不提供此款定制产品：" + name + "!");
						 	}
					 },"json");
				 }
			}
			);
			
			$("#photo").mouseover(
			  function () {
			    $("#layer-wrap").hide();
			  }
			);
			$("#optionTitle").children("li").click(function(){
				$(this).addClass("selected").siblings().removeClass("selected");
				var si=$(this).attr("si");
				if(si){
					$("#"+si).siblings().hide();
					$("#"+si).show().children("li.selected").click();
				}
			});
			$("#optionTitle").children("li.selected").click();
			
			$("#arrow-holder-left").click(function(){
				var imageList=$("#imageList > li");
				$("#imageList").append(imageList.first());
			});
			$("#arrow-holder-right").click(function(){
				var imageList=$("#imageList > li");
				$("#imageList").prepend(imageList.last());
			});

			$("#prev_p").click(function(){
				var imageList=$("#p_i_list > li");
				$("#p_i_list").append(imageList.first());
			});
			$("#next_p").click(function(){
				var imageList=$("#p_i_list > li");
				$("#p_i_list").prepend(imageList.last());
			});

			//“保存”点击
			$("#buybtn").click(function(){ 
				doRequiredLoginAction(function(){
					saveMyProduct();
				} , 1);
		    }); 
			
		});


		//保存订阅
		function saveUserRss(){
			//debugger;
			var email = $("#email").val();
			if(email == ""){
				alert("请输入email！");
			}else if(!email.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)){
				alert("email格式错误，请修改！");
			}else{
				$.post(__ctxPath+"/customer/addUserRss.html",{userName:'',email:email},function(result){
					if(result.status==1){
						//debugger;
						alert("订阅成功！");
					}else{
					}
				},"json");
			}
		}

		//“保存”操作
	    function saveMyProduct(){
		    var productId = $("#productId").val();
		    $.post(__ctxPath+"/customHistory/save.html",{productId:productId},function(result){
				if(result.status==1){	//购买保存成功
					alert("您此设计产品已保存！");
					doRequiredLoginAction(function(){
						addReviewAction(true);
					} , 1);
				}else if(result.status=2){//此产品已被此用户保存
					alert("您已保存此设计产品！");
					doRequiredLoginAction(function(){
						addReviewAction(true);
					} , 1);
				}else{	//服务器异常
					alert("网络异常，请稍后再试！");
				}
			},"json");
	    }
		</script>
		</head>
		<body>
		<input type="hidden" id="selectedOption" value="">
		

		
			<%-- 公用的左侧栏--%>
			<%@ include file="./common/left.jsp"%>
			<%-- 公用的左侧栏--%>
			
		    <div class="main2" style="height:100%;">
    			<!-- 第一次等高开始-->
		        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%;">
                  <tr>
                    <td width="50%" valign="top">
                    
                    	<div class="big-photo" id="photo"></div>
                    	<%-- --%>
                    	<!-- gallery -->
                    	<div id="container">
						    <div id="gallery" class="ad-gallery">
						      <%--<div class="ad-image-wrapper">
						      </div>--%>
						      <%--<div class="ad-controls">
						      </div>--%>
						      <div class="ad-nav">
						        <div class="ad-thumbs">
						          <ul class="ad-thumb-list" id="mediaList">
						          </ul>
						        </div>
						      </div>
						    </div>
						  </div>
                    	<!-- gallery -->
                    	
                    	     <div class="p_list">
				                <div style="width:100%; float:left;">
				                    <div id="next_p"><a>&gt;</a></div>
				                    <div class="im_list">
				                        <ul id="p_i_list">
				                            <li><a href="#1"><img src="${resPath}/custom/images/product1.jpg" /></a></li>
				                            <li><a href="#2"><img src="${resPath}/custom/images/product2.jpg" /></a></li>
				                            <li><a href="#3"><img src="${resPath}/custom/images/product3.jpg" /></a></li>
				                            <li><a href="#4"><img src="${resPath}/custom/images/product4.jpg" /></a></li>
				                            <li><a href="#5"><img src="${resPath}/custom/images/product5.jpg" /></a></li>
				                            <li><a href="#6"><img src="${resPath}/custom/images/product1.jpg" /></a></li>
				                            <li><a href="#7"><img src="${resPath}/custom/images/product1.jpg" /></a></li>
				                            <li><a href="#8"><img src="${resPath}/custom/images/product1.jpg" /></a></li>
				                        </ul>
				                    </div>
				                    <div id="prev_p"><a>&lt;</a></div>
				                </div>
		          			</div>
                    	
		                <form id="form1" action="${ctxPath }/custom/more.html" method="post">
		                	<input type="hidden" id="productId" name="productId" value=""/>
		                	<input type="hidden" id="productName" name="productName" value=""/>
		                </form>
		                
                        <div class="blank24"></div>
                        
		                <ul class="button">
		                	  <li><a href="javascript:void(0);" onClick="javascript:$('#form1').submit();"><i class="fa fa-legal"></i>&nbsp;&nbsp;购买</a></li>
			                  <li><a href="javascript:void(0);" id="buybtn"><i class="fa fa-floppy-o"></i>&nbsp;&nbsp;保存</a></li>
			                  <li><a href="#"><i class="fa fa-try"></i>&nbsp;&nbsp;试穿</a></li>
			                  <li><a href="#"><i class="fa fa-share-alt"></i>&nbsp;&nbsp;分享</a></li>
		                </ul>
                        
                        <div class="blank10"></div>
                        <span id="name" style="display: none;"></span>
                    
                    </td>
                    <td width="50%" valign="top" style="background-color:#d4d4d4;">
		            	
		            	<!-- 一级选择开始-->
		                <ul class="p-tab" id="optionTitle">
		                	<li id="t-1" class="selected" si="o-1"><a href="#">鞋跟<span></span></a></li>
		                    <li id="t-2" si="o-2"><a href="#">鞋头<span></span></a></li>
		                    <li id="t3" si="o5"><a href="#">鞋款<span></span></a></li>
		                    <li id="t3" si="o-3"><a href="#">个性化<span></span></a></li>
		                </ul>
		                <!-- 一级选择结束-->
		                <div class="attribute" id="options">
		                	<!-- 二级选择开始-->
		                    <ul class="sub1" id="o-1" style="display: none;">
		                    	<li class="selected" si="o1">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1.png" ></div>
		                            <div class="attribute-txt">跟高</div>
		                        </li>
                                <li class="sline"></li>
		                        <li si="o2">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2.png" ></div>
		                            <div class="attribute-txt">跟型</div>
		                        </li>
                                <li class="sline"></li>
                                <li si="o13">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_3.png" ></div>
		                            <div class="attribute-txt">跟料</div>
		                        </li>
		                    </ul>
		                    <!-- 二级选择结束-->
		                    <!-- 三级选择开始-->
		                    <ul class="sub2" id="o1" style="display: none;">
		                    	<li  data-velue="7">
		                                <div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1_7.png" ></div>
		                                <div class="attribute-txt">1.5cm</div>
		                        </li>
                                <li data-velue="8">
		                                <div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1_8.png" ></div>
		                                <div class="attribute-txt">2.5cm</div>
		                        </li>
                                <li data-velue="1">
		                                <div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1_1.png" ></div>
		                                <div class="attribute-txt">4.5cm</div>
		                        </li>
		                        <li data-velue="2">
		                                <div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1_2.png" ></div>
		                                <div class="attribute-txt">5.5cm</div>
		                        </li>
                                <li data-velue="3">
		                                <div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1_3.png" ></div>
		                                <div class="attribute-txt">7.5cm</div>
		                        </li>
                                <li data-velue="4">
		                                <div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1_4.png" ></div>
		                                <div class="attribute-txt">8.5cm</div>
		                        </li>
                                <li data-velue="5">
		                                <div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1_5.png" ></div>
		                                <div class="attribute-txt">10.5cm</div>
		                        </li>
                                <li data-velue="6">
		                                <div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1_6.png" ></div>
		                                <div class="attribute-txt">11.5cm</div>
		                        </li>
		                    </ul>
		                    <!-- 三级选择结束-->
		                    <!-- 二级选择开始-->
		                    <!-- 
		                    <ul class="sub1" id="o2">
		                    	<li>
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1.png" ></div>
		                            <div class="attribute-txt">跟高</div>
		                        </li>
		                        <li >
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2.png" ></div>
		                            <div class="attribute-txt">跟型</div>
		                        </li>
		                    </ul>
		                     -->
		                    <!-- 二级选择结束-->
		                    <!-- 三级选择开始-->
		                    <ul class="sub2" id="o2"  style="display: none;">
		                    	<li   data-velue="3">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_1.png" ></div>
		                            <div class="attribute-txt">细跟</div>
		                        </li>
		                        <li data-velue="4">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_2.png" ></div>
		                            <div class="attribute-txt">粗跟</div>
		                        </li>
                                 <li data-velue="5">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_3.png" ></div>
		                            <div class="attribute-txt">坡跟</div>
		                        </li>
		                    </ul>
		                    <!-- 三级选择结束-->
                             <!-- 三级选择开始-->
		                    <ul class="sub2" id="o13"  style="display: none;">
		                    	<li   data-velue="31">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_1.jpg" ></div>
		                            <div class="attribute-txt">石头纹跟</div>
		                        </li>
		                        <li data-velue="32">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_2.jpg" ></div>
		                            <div class="attribute-txt">烤漆跟</div>
		                        </li>
                                <li data-velue="33">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_3.jpg" ></div>
		                            <div class="attribute-txt">电镀跟</div>
		                        </li>
                                <li data-velue="34">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_4.jpg" ></div>
		                            <div class="attribute-txt">牛皮包跟</div>
		                        </li>
                                <li data-velue="35">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_5.jpg" ></div>
		                            <div class="attribute-txt">漆皮包跟</div>
		                        </li>
                                <li data-velue="36">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_6.jpg" ></div>
		                            <div class="attribute-txt">图腾拼接跟</div>
		                        </li>
                                <li data-velue="37">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_2_7.jpg" ></div>
		                            <div class="attribute-txt">镶亚克力跟</div>
		                        </li>
		                         <li data-velue="38">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_1_1_7.png" ></div>
		                            <div class="attribute-txt">橡胶跟片</div>
		                        </li>
		                    </ul>
		                    <!-- 三级选择结束-->
		                     <!-- 分隔线，一级第二个属性值--鞋头---的显示在下面-->
		                     <!-- 二级选择开始-->
		                    <ul class="sub1" id="o-2" style="display: none;">
		                    	<li class="selected"  si="o3">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_1.png" ></div>
		                            <div class="attribute-txt">型头</div>
		                        </li>
                                <li class="sline"></li>
		                        <li si="o4">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_2.png" ></div>
		                            <div class="attribute-txt">水台</div>
		                        </li>
		                    </ul>
		                    <!-- 二级选择结束-->
		                    <!-- 三级选择开始-->
		                    <ul class="sub2" id="o3" style="display: none;">
		                    	<li   data-velue="7">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_1_1.png" ></div>
		                            <div class="attribute-txt">圆头</div>
		                        </li>
		                        <li  data-velue="8">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_1_2.png" ></div>
		                            <div class="attribute-txt">尖头</div>
		                        </li>
                                <li  data-velue="82">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_1_3.png" ></div>
		                            <div class="attribute-txt">方头</div>
		                        </li>
		                    </ul>
		                    <!-- 三级选择结束-->
		                    <!-- 二级选择开始-->
		                    <!-- 
		                    <ul class="sub1" >
		                    	<li>
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_1.png" ></div>
		                            <div class="attribute-txt">型头</div>
		                        </li>
		                        <li >
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_2.png" ></div>
		                            <div class="attribute-txt">水台</div>
		                        </li>
		                    </ul>
		                     -->
		                    <!-- 二级选择结束-->
		                    <!-- 三级选择开始-->
		                    <ul class="sub2" id="o4" style="display: none;">
		                    	<li   data-velue="13">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_2_3.jpg" ></div>
		                            <div class="attribute-txt">无水台</div>
		                        </li>
                                <li data-velue="9">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_2_1.png" ></div>
		                            <div class="attribute-txt">内水台</div>
		                        </li>
		                        <li data-velue="10">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_2_2_2.png" ></div>
		                            <div class="attribute-txt">外水台</div>
		                        </li>
		                        
		                    </ul>
		                  <!-- 三级选择结束-->
		                    <!-- 分隔线，一级第三个属性值--鞋款--的显示在下面-->
		                    <!-- 二级选择开始-->
		                    <ul class="sub1" id="o5" style="display: none;">
		                    	<li style="margin-left:40px; width:8px;"></li>
                                <li class="selected" vi="o-3,o6,o7" data-velue="11">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_3_1.png" ></div>
		                            <div class="attribute-txt">基本款</div>
		                        </li>
                                <li class="sline"></li>
		                        <li vi="o-3,o9,o10" data-velue="12">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_3_2.png" ></div>
		                            <div class="attribute-txt">时尚款</div>
		                        </li>
		                    </ul>
		                    <!-- 二级选择结束-->
		                    <ul class="sub1" id="o-3" style="display: none;">
		                    	<li style="margin-left:40px; width:8px;"></li>
                                <li  si="o6">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1.png" ></div>
		                            <div class="attribute-txt">皮料</div>
		                        </li>
                                <li class="sline"></li>
		                        <li si="o7">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_2.png" ></div>
		                            <div class="attribute-txt">颜色</div>
		                        </li>
                                 <li class="sline"></li>
                                 <li si="o9">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_4.png" ></div>
		                            <div class="attribute-txt">颜色布料</div>
		                        </li>
		                        <li class="sline"></li>
                                 <li si="o10">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1.png" ></div>
		                            <div class="attribute-txt">附加属性</div>
		                        </li>
		                    </ul>
		                    <ul class="sub2" id="o6" style="display: none;">
		                    	<li  data-velue="41">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_1.jpg" ></div>
		                            <div class="attribute-txt">马毛</div>
		                        </li>
		                        <li data-velue="42">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_2.jpg" ></div>
		                            <div class="attribute-txt">牛皮</div>
		                        </li>
                                <li data-velue="43">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_3.jpg" ></div>
		                            <div class="attribute-txt">漆皮</div>
		                        </li>
                                <li data-velue="44">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_4.jpg" ></div>
		                            <div class="attribute-txt">迷彩皮</div>
		                        </li>
                                <li data-velue="45">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_5.jpg" ></div>
		                            <div class="attribute-txt">鸵鸟皮</div>
		                        </li>
                                <li data-velue="46">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_6.jpg" ></div>
		                            <div class="attribute-txt">羊皮</div>
		                        </li>
                                <li data-velue="47">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_7.jpg" ></div>
		                            <div class="attribute-txt">蛇纹</div>
		                        </li>
                                <li data-velue="48">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_8.jpg" ></div>
		                            <div class="attribute-txt">石头纹</div>
		                        </li>
                                <li data-velue="49">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_9.jpg" ></div>
		                            <div class="attribute-txt">胎牛</div>
		                        </li>
                                <li data-velue="50">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_1_10.jpg" ></div>
		                            <div class="attribute-txt">羊猄</div>
		                        </li>
		                    </ul>
		                    <ul class="sub2" id="o7" style="display: none;">
		                    	<li  data-velue="51">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_2_1.jpg" ></div>
		                            <div class="attribute-txt">黑色</div>
		                        </li>
		                        <li data-velue="52">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_2_2.jpg" ></div>
		                            <div class="attribute-txt">红色</div>
		                        </li>
                                 <li data-velue="53">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_2_3.jpg" ></div>
		                            <div class="attribute-txt">白色</div>
		                        </li>
                                 <li data-velue="54">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_2_4.jpg" ></div>
		                            <div class="attribute-txt">裸色</div>
		                        </li>
                                 <li data-velue="55">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_2_5.jpg" ></div>
		                            <div class="attribute-txt">灰色</div>
		                        </li>
                                 <li data-velue="56">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_2_6.jpg" ></div>
		                            <div class="attribute-txt">咖啡色</div>
		                        </li>
		                    </ul>
		                    
		                    <ul class="sub2" id="o9" style="display: none;">
		                    	<li data-velue="91">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_1.jpg" ></div>
		                            <div class="attribute-txt">白色牛皮</div>
		                        </li>
		                        <li data-velue="92">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_2.jpg" ></div>
		                            <div class="attribute-txt">海军蓝迷彩皮</div>
		                        </li>
                                 <li data-velue="93">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_3.jpg" ></div>
		                            <div class="attribute-txt">黑色马毛</div>
		                        </li>
                                 <li data-velue="94">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_4.jpg" ></div>
		                            <div class="attribute-txt">黑色牛皮</div>
		                        </li>
                                 <li data-velue="95">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_5.jpg" ></div>
		                            <div class="attribute-txt">黑色漆皮</div>
		                        </li>
                                 <li data-velue="96">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_6.jpg" ></div>
		                            <div class="attribute-txt">黑色蛇纹</div>
		                        </li>
		                         <li data-velue="97">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_7.jpg" ></div>
		                            <div class="attribute-txt">黑色石头纹</div>
		                        </li>
		                         <li data-velue="98">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_8.jpg" ></div>
		                            <div class="attribute-txt">黑色胎牛皮</div>
		                        </li>
		                        <li data-velue="99">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_9.jpg" ></div>
		                            <div class="attribute-txt">黑色鸵鸟皮</div>
		                        </li>
		                         <li data-velue="100">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_4_1.jpg" ></div>
		                            <div class="attribute-txt">黑色羊猄</div>
		                        </li>
		                         <li data-velue="101">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_4_2.jpg" ></div>
		                            <div class="attribute-txt">黑色羊皮</div>
		                        </li>
		                         <li data-velue="102">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_4_3.jpg" ></div>
		                            <div class="attribute-txt">红色马毛</div>
		                        </li>
		                             <li data-velue="103">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_4_5.jpg" ></div>
		                            <div class="attribute-txt">红色牛皮</div>
		                        </li>
		                             <li data-velue="104">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_4_6.jpg" ></div>
		                            <div class="attribute-txt">红色漆皮</div>
		                        </li>
		                             <li data-velue="105">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_4_7.jpg" ></div>
		                            <div class="attribute-txt">红色胎牛皮</div>
		                        </li>
		                             <li data-velue="106">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_4_8.jpg" ></div>
		                            <div class="attribute-txt">红色羊猄</div>
		                        </li>
		                          <li data-velue="107">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_4_9.jpg" ></div>
		                            <div class="attribute-txt">红色羊皮</div>
		                        </li>
		                           <li data-velue="108">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_0.jpg" ></div>
		                            <div class="attribute-txt">灰色迷彩皮</div>
		                        </li>  
		                         <li data-velue="109">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_1.jpg" ></div>
		                            <div class="attribute-txt">灰色胎牛</div>
		                        </li>
		                       <li data-velue="110">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_2.jpg" ></div>
		                            <div class="attribute-txt">灰色羊皮</div>
		                        </li>
		                    <li data-velue="111">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_3.jpg" ></div>
		                            <div class="attribute-txt">金色迷彩皮</div>
		                        </li>
		                       <li data-velue="112">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_4.jpg" ></div>
		                            <div class="attribute-txt">咖啡色漆皮</div>
		                        </li>
		                        <li data-velue="113">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_5.jpg" ></div>
		                            <div class="attribute-txt">裸色牛皮</div>
		                        </li>
		                        <li data-velue="114">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_6.jpg" ></div>
		                            <div class="attribute-txt">裸色漆皮</div>
		                        </li>
		                       <li data-velue="115">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_7.jpg" ></div>
		                            <div class="attribute-txt">绿色迷彩皮</div>
		                        </li>
		                        <li data-velue="116">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_8.jpg" ></div>
		                            <div class="attribute-txt">深咖色马毛</div>
		                        </li>
		                       <li data-velue="117">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_5_9.jpg" ></div>
		                            <div class="attribute-txt">深绿色石头纹</div>
		                        </li>
		                    <li data-velue="118">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_6_0.jpg" ></div>
		                            <div class="attribute-txt">棕色石头纹</div>
		                        </li>
		                    </ul>
		                     <ul class="sub2" id="o10" style="display: none;">
		                    	 <li data-velue="119">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_3.jpg" ></div>
		                            <div class="attribute-txt">黑色马毛</div>
		                        </li>
                                 <li data-velue="120">
		                        	<div class="attribute-img"><img src="${resPath}/custom/product-img/s_4_3_4.jpg" ></div>
		                            <div class="attribute-txt">黑色牛皮</div>
		                        </li>
		                      </ul>
		                </div>
		            </td>
                  </tr>
                </table>

		        <!-- 第一次等高结束-->
				<!-- 第二次等高开始-->
		        <div class="product-wrap height2">
		           <div class="product-left p-l-bg">
		                <div style="width:100%; float:left;">
		                    <div id="arrow-holder-right"><a>&gt;</a></div>
		                    <div class="product_list_li_c">
		                        <ul id="imageList">
		                            <li><a href="#1"><img src="${resPath}/custom/images/product1.jpg" /></a></li>
		                            <li><a href="#2"><img src="${resPath}/custom/images/product2.jpg" /></a></li>
		                            <li><a href="#3"><img src="${resPath}/custom/images/product3.jpg" /></a></li>
		                            <li><a href="#4"><img src="${resPath}/custom/images/product4.jpg" /></a></li>
		                            <li><a href="#5"><img src="${resPath}/custom/images/product5.jpg" /></a></li>
		                            <li><a href="#6"><img src="${resPath}/custom/images/product1.jpg" /></a></li>
		                            <li><a href="#7"><img src="${resPath}/custom/images/product1.jpg" /></a></li>
		                            <li><a href="#8"><img src="${resPath}/custom/images/product1.jpg" /></a></li>
		                        </ul>
		                    </div>
		                    <div id="arrow-holder-left"><a>&lt;</a></div>
		                </div>
		            </div>
		            <div class="product-right">
						<div class="subscribe">
		                	<div class="subscribe-txt">STAY UP TO DATE</div>
		                    <form action="" method="get">
		                    	<div class="left"><input id="email" type="text" class="box-input" placeholder="Your Email Address" value="" style="height:40px; width:235px;line-height:20px; border:1px solid #252525;color:#000; text-indent:4px;" /></div>
		                        <div class="btn-subscribe">
		                        	<a href="javascript:void(0)" onClick="saveUserRss();">SUBSCRIBE</a>
		                        </div>
		                    </form>
		                        
    <%--<form action="${ctxPath }/search-prod-byName.html">
    	<input type="text" name="q"/>
    	<input type="text" name="pageNo"/>
    	<input type="submit" value="submit"/>
    </form>--%>
		                </div>
		            </div>
		        </div>
		        <!-- 第二次等高结束-->
		        <!-- 第三次等高开始-->
		        <div class="product-wrap height3">
		           <div class="product-left"> 
		              <div class="half-ad">
                      				<FIGURE class="effect-sadie"><img src="${resPath}/custom/images/1.jpg" /><FIGCAPTION>
                        <div class="ad-txt">
                        	精彩的设计让人充满愉悦
                            <div class="blank10"></div>
                            <div style="border:2px solid #fff; width:100px; height:40px; line-height:40px; margin:auto;">每周设计</div>
                        </div>
				 </FIGCAPTION></FIGURE>
                      </div>
		              <div class="half-ad">
                                <FIGURE class="effect-sadie"><img src="${resPath}/custom/images/1.jpg" /><FIGCAPTION>
                                <div class="ad-play"><div class="play"><div class="play2"></div></div></div>
				 </FIGCAPTION></FIGURE>
                      </div>
		           </div>
		           <div class="product-right"> 
		               <div class="half-ad">
                      				<FIGURE class="ad2"><img src="${resPath}/custom/images/1.jpg" /><FIGCAPTION>
                        <div class="ad-txt">
                        	会员有限期为本网站存续期内，白金会员及黑钻会员自升级之日起有效期为1年。会员有限期为本网站存续期内，白金会员及黑钻会员自升级之日起有效期为1年。会员有限期为本网站存续期内，白金会员及黑钻会员自升级之日起有效期为1年。
                        </div>
				 </FIGCAPTION></FIGURE>
                      </div>
		              <div class="half-ad">
                                <FIGURE class="effect-sadie"><img src="${resPath}/custom/images/1.jpg" /><FIGCAPTION>
                                <div class="ad-play"><div class="play"><div class="play2"></div></div></div>
				 </FIGCAPTION></FIGURE>
                      </div>
		           </div>
		        </div>
		        <!-- 第三次等高结束-->
		    </div>
		    
</body>
	
</html>