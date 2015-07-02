<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="customer" tagdir="/WEB-INF/tags/customer"%>
<script type="text/javascript"	src="${ctxPath}/scripts/cartmatic/common/region.js"></script>

<div class="maincontent">
         
			         <%@include file="../common/myaccount_head.jsp" %>
                
	                <%@include file="../common/myaccount_left.jsp" %>
			           
			           
			           <div class="down_right left_border" id="tab5">
			             <p class="account_info_title">
			               账户：${customer.email}
			               <span class="header_breadcrumb">收货地址</span>
			             </p>
			             <p style="text-align: center">会员级别：${membership.membershipName}</p>
			              
						<spring:bind path="address.*">
							<c:if test="${not empty status.errorMessages}">
								<div class="error_box">
								<c:forEach var="error" items="${status.errorMessages}">
									<c:out value="${error}" escapeXml="false" /><br/>
								</c:forEach>
								</div>
							</c:if>
						</spring:bind>
			               
			             <div class="new_address">
			               <h3 class="padding_left10 padding_top10">编辑收货地址</h3>
			               
			               <form id="addressForm" action="${ctxPath}/myaccount/address/add.html" method="post">
			               
			               <div class="new_info_form">
			                    <div class="leftright_form">
			                       <div class="control-group">
			                          <label for="first_name" class="control-label">
			                          收货人
			                          <span class="text-error">*</span>
			                          </label>
			                          <spring:bind path="address.addressId">
											<input type="hidden" class="span12" name="addressId" id="addressId" value="${status.value}" >
										</spring:bind>
			                           <spring:bind path="address.firstname">
											<input type="text" class="span12" name="firstname" id="firstname" value="${status.value}" maxlength="32">
											<div class="mark_co input_waring">
				                            <div for="firstname" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
										</spring:bind>
										<input type="hidden" id="lastname" name="lastname" value="N/A">
			                       </div>
			                       <div class="control-group">
			                           <label for="postcode" class="control-label">
			                          邮政编码
			                          <span class="text-error">*</span>
			                          </label>
			                           			<spring:bind path="address.zip">
													<input value="${status.value}" type="text" name="zip" id="zip" maxlength="10" class="span12" />
													<div class="mark_co input_waring">
				                            <div for="zip" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
												</spring:bind>
			                       </div>
			                       <div class="control-group">
			                          <label for="email" class="control-label">
			                          电子邮件
			                          <span class="text-error">*</span>
			                          </label>
			                           <spring:bind path="address.email">
										<input type="text" name=email value="${status.value}" id="email" maxlength="20" class="span12"/>
										<div class="mark_co input_waring">
				                            <div for="email" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
									</spring:bind>
			                       </div>
			                       <div class="control-group">
			                          <label for="phone" class="control-label">
			                          联系电话
			                          <span class="text-error">*</span>
			                          </label>
			                           <spring:bind path="address.telephone">
											<input type="text" name="telephone" value="${status.value}" id="telephone" maxlength="20" class="span12"/>
											<div class="mark_co input_waring">
				                            <div for="telephone" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
										</spring:bind>
			                       </div>
			                       <div class="control-group">
			                        
			                          <label for="last_name" class="control-label">
			                          地址
			                          <span class="text-error">*</span>
			                          </label>
	                          			<spring:bind path="address.address">
											<input type="text" class="span12" name="address" id="address" value="${status.value}" maxlength="64" size="60">
											<div class="mark_co input_waring">
				                            <div for="address" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
										</spring:bind>
			                       </div>
			                    </div><!--leftright_form-->
			                    
			                    <div class="leftright_form">
			                      <div class="control-group">
			                          <label for="country" class="control-label">省<span class="text-error">*</span></label>
			                           <select id="s_province" name="stateName" class="span12"></select>
			                      </div>
			                      <div class="control-group">
			                          <label for="state" class="control-label">市<span class="text-error">*</span></label>
			                          <select id="s_city" name="cityName" class="span12"></select>	
			                      </div>
			                      <div class="control-group">
			                          <label for="state" class="control-label">区<span class="text-error">*</span></label>
			                          <select id="s_county" name="sectionName" class="span12"></select>	
			                      </div>
			                      <div class="control-group">
			                          <label for="country" class="control-label">性别</label>
									  <select class="span12" name="title" id="title">
				                           <option>请选择性别</option>
				                           <option value="先生">先生</option>
				                           <option value="女士">女士</option>
			                           </select>
			                      </div>
                                  <div class="blank24"></div>
			                      <div class="address_button">
			                       <button id="buttonsave_info" name="buttonsave_info" class="btn-gold new_address_button" type="submit">
			                        <i class="fa fa-floppy-o padding_right10"></i>
			                        保存
			                       </button>
			                       <button id="clearbutton_info" name="clearbutton_info" class="btn-black new_address_button" type="reset">
			                        <i class="fa fa-undo padding_right10"></i>
			                        清除
			                       </button>
			                      </div><!--address_button-->
			                   </div><!--leftright_form--> 
			                  
			                  </div><!--new_info_form-->
			                  
			                  </form>
			                  
			             </div><!--new_address-->
			             
			            
			              <!--省市三级联动-->
						  <script  src="${ctxPath}/scripts/cartmatic/cart/checkout/area.js" type="text/javascript"></script>
			                <script type="text/javascript">
			                _init_area();
			                $(document).ready(function(){

			                	$("select[name='stateName'] option").each(function(){
									if($(this).val().indexOf($.trim('${address.stateName}'))>=0){
										$(this).attr("selected",true);
										change(1);
										return false;
									}
								});
								$("select[name='cityName'] option").each(function(){
									if($(this).val().indexOf($.trim('${address.cityName}')) >= 0){
										$(this).attr("selected",true);
										change(2);
										return false;
									}
								});
								$("select[name='sectionName'] option").each(function(){
									if($(this).val().indexOf($.trim('${address.sectionName}')) >= 0 ){
										$(this).attr("selected",true);
										return false;
									}
								});
								$("select[name='title'] option").each(function(){
									if($(this).val() == '${address.title}'){
										$(this).attr("selected",true);
										return false;
									}
								});
				                
				             });

			                $.validator.setDefaults({focusout:true});
							$.validator.addMethod("tel", function(value) {return /(^[0-9+-]{3,30}$)/.test(value);},"请填写正确的联系电话");
							$("#addressForm").validate({event:blur,
								rules:{
									firstname:{required:true},
									address:{required:true,minlength:5},
									zip:{required:true,minlength:4},
									telephone:{required:true,minlength:5,tel:true},
									email:{required:true,minlength:5,tel:true}
								},
								errorPlacement: function(error, element) {
										error.appendTo(element.parent());
									},
							messages:{
									firstname:{
										required:"请准确填写真实姓名"
										}
									,
									address:{
										required:"请填写详细路名及门牌号"
									},
									zip:{
										required:"请填写正确的邮政编码"
									},
									telephone:{
										required:"电话格式不正确（请输入手机号 或 区号-固话）"
									},
									email:{
										required:"请输入电子邮件地址"
									}
								}
							});
				             
			                </script>
			              <!--end of 省市三级联动-->
			           </div><!--down_right-->
				           
			         </div>
                
			</div>