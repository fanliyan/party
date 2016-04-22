<#macro materialListForm  materialLists processList>
	<form class="form-horizontal" id="materialForm" >
		<input type="hidden" name="policyId" id="policyId4Material" value="${(policy.policyId)!}">
		<div class="col-md-12">
			<div class="form-group pull-right">
				 <a class="btn btn-xs btn-info" onclick="$.addMaterialListRow();"><i class="fa fa-plus"> 增加流程材料</i></a>
			</div>
		</div>
		<div id="materialListRow">
			<div id="materialListTemplete" style="display:none;">
				<div class="form-group">
					<div class="col-md-3">
						<label for="exampleInputEmail1" class="col-md-4 control-label">材料名称</label>
						<div class="col-md-8">
							<input type="input" class="form-control input-sm" placeholder="必填,字符最大长度50" name="materialName#id#"
							 {parsleyTrue}
							 data-parsley-maxlength="50"
							 data-parsley-maxlength-message="内容不能超过50字"/>
						</div>
					</div><!-- /form-group -->
					
					<div class="col-md-3">
						<label for="exampleInputEmail1" class="col-md-4 control-label">所属流程</label>
						<div class="col-md-8">
							<select class="form-control" id="policyProcessId#id#" name="policyProcessId#id#" data-placeholder="请选择流程">
								<#if processList?? && processList?size gt 0>
								<option value="" disabled>请选择流程</option>
									<#list processList as process>
										<option value="${process.policyProcessId}">${(process.processName)!}</option>
									</#list>
								</#if>
							</select>
						</div>
					</div><!-- /form-group -->
					
					<div class="col-md-3">
						<label for="exampleInputEmail1" class="col-md-4 control-label">是否必须</label>
						<div class="col-md-8">
							<label class="label-radio inline">
								<input type="radio" name="isMust#id#" checked="checked" value="true">
								<span class="custom-radio"></span>
								是
							</label>
							<label class="label-radio inline">
								<input type="radio" name="isMust#id#" value="false" >
								<span class="custom-radio"></span>
								否
							</label>
						</div>
					</div><!-- /form-group -->
					
					<div class="col-md-3">
						<a class="btn btn-xs btn-danger pull-right" onclick="$('#materialListCount#id#').remove();"><i class="fa fa-trash-o"></i></a>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-md-6">
						<label for="exampleInputEmail1" class="col-md-2 control-label">材料说明</label>
						<div class="col-md-10">
							 <textarea class="form-control " rows="5" placeholder="可空,字符最大长度1000" name="materialDesc#id#"
							 data-parsley-maxlength="1000"
							 data-parsley-maxlength-message="内容不能超过1000字"
							 ></textarea>
						</div>
					</div><!-- /form-group -->
					
					<div class="col-md-6">
						<label for="exampleInputEmail1" class="col-md-2 control-label">办理指引</label>
						<div class="col-md-10">
							<input type="input" class="form-control input-sm" placeholder="可空,字符最大长度100" name="flowGuide#id#"
							 data-parsley-maxlength="100"
							 data-parsley-maxlength-message="内容不能超过100字"/>
						</div>
					</div><!-- /form-group -->
				</div>
				
				<div class="form-group">
					<div class="col-md-12">
						<label for="exampleInputEmail1" class="col-md-1 control-label">示例文件</label>
						<div class="col-md-11">
							<input type="hidden" name="materialDemo#id#" id="materialDemo#id#">
							<a class="btn btn-sm btn-primary insertFile" maxFile="1" selectIndex="#id#"><i class="fa fa-book"></i> 选择文件</a>
							<a href="" id="materialDemo#id#Value"></a>
						</div>
					</div><!-- /form-group -->
				</div>
				
				<div class="form-group border-bottom">&nbsp;</div>
			</div>
			<#assign flag=0>
			
			<#if materialLists?? && materialLists?size gt 0>
				<#list materialLists as materialList>
					<#assign flag=flag+1>
					<div id="materialListCount${flag}" >
						<div class="form-group">
							<div class="col-md-3">
								<label for="exampleInputEmail1" class="col-md-4 control-label">材料名称</label>
								<div class="col-md-8">
									<input type="input" class="form-control input-sm" placeholder="必填,字符最大长度50" name="materialName${flag}"
									 data-parsley-required="true"
									 data-parsley-maxlength="50"
									 data-parsley-maxlength-message="内容不能超过50字"
									 value="${(materialList.materialName)!}" />
								</div>
							</div>
							
							<div class="col-md-3">
								<label for="exampleInputEmail1" class="col-md-4 control-label">所属流程</label>
								<div class="col-md-8">
									<select class="form-control" id="policyProcessId${flag}" name="policyProcessId${flag}" data-placeholder="请选择流程">
										<#if processList?? && processList?size gt 0>
										<option value="" disabled>请选择流程</option>
											<#list processList as process>
												<option value="${process.policyProcessId}" <#if materialList.policyProcessId ?? && process.policyProcessId==materialList.policyProcessId>selected</#if>>${(process.processName)!}</option>
											</#list>
										</#if>
									</select>
								</div>
							</div>
							
							<div class="col-md-3">
								<label for="exampleInputEmail1" class="col-md-4 control-label">是否必须</label>
								<div class="col-md-8">
									<label class="label-radio inline">
											<input type="radio" name="isMust${flag}" <#if materialList.isMust>checked="checked"</#if> value="true">
											<span class="custom-radio"></span>
											是
										</label>
										<label class="label-radio inline">
											<input type="radio" name="isMust${flag}" <#if !materialList.isMust>checked="checked"</#if> value="false" >
											<span class="custom-radio"></span>
											否
										</label>
								</div>
							</div>
						
							<div class="col-md-3">
								<a class="btn btn-xs btn-danger pull-right" onclick="$('#materialListCount${flag}').remove();"><i class="fa fa-trash-o"></i></a>
							</div>
						</div>
					
						<div class="form-group">
							<div class="col-md-6">
								<label for="exampleInputEmail1" class="col-md-2 control-label">材料说明</label>
								<div class="col-md-10">
									 <textarea class="form-control " rows="5" placeholder="可空,字符最大长度1000" name="materialDesc${flag}"
									 data-parsley-maxlength="1000"
									 data-parsley-maxlength-message="内容不能超过1000字"
									 >${(materialList.materialDesc)!}</textarea>
								</div>
							</div><!-- /form-group -->
							
							<div class="col-md-6">
								<label for="exampleInputEmail1" class="col-md-2 control-label">办理指引</label>
								<div class="col-md-10">
									<input type="input" class="form-control input-sm" placeholder="可空,字符最大长度100" name="flowGuide${flag}"
									 data-parsley-maxlength="100"
									 data-parsley-maxlength-message="内容不能超过100字"
									 value="${(materialList.flowGuide)!}"/>
								</div>
							</div>
						</div><!-- /form-group -->
						
						
						<div class="form-group">
							<div class="col-md-12">
								<label for="exampleInputEmail1" class="col-md-1 control-label">示例文件</label>
								<div class="col-md-11">
									<input type="hidden" id="materialDemo${flag}" >
									<a class="btn btn-sm btn-primary insertFile" maxFile="1" selectIndex="${flag}"><i class="fa fa-book"></i> 选择文件</a>
									&nbsp;<a href="" id="materialDemo${flag}Value"></a>
								</div>
							</div><!-- /form-group -->
						</div>
						
						<div class="form-group border-bottom">&nbsp;</div>
					</div>
				</#list>
			</#if>
			<input type="hidden" id="materialListCount" name="materialListCount" value="${flag}" />
			</div>
			<div class="col-md-12 text-center">
				<div class="form-group ">
					<button type="button" class="btn btn-success" onclick="materialSubmit();">保存</button>
				</div>
			</div>
		</div>
	</form>
<script language="javascript">
	$.addMaterialListRow = function(){
		var idCount = parseInt($("#materialListCount").val());
		idCount++;
		$("#materialListRow").append('<div id="materialListCount' + idCount + '">' + $("#materialListTemplete").html()
			.replace(new RegExp(/#id#/g),idCount)
			.replace(new RegExp(/{parsleytrue}/g),"data-parsley-required='true'")
			 + '</div>');
		$("#materialListCount").val(idCount);
	}
	function materialSubmit(){
		if($('#materialForm').parsley().validate()){
			$.ajax({
				cache: true,
				type: "POST",
				url:"${basePath}/policy/saveMaterial",
				data:$('#materialForm').serialize(),
				async: false,
				error: function(request) {
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){   
					alertify.alert("操作成功！");
					}
					else{
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}
	}
	
	$(function(){
		$(".insertFile").selectFile(function(clickbutton,uploadFiles){
			if(uploadFiles.length > 0){
				var id = clickbutton.attr("selectindex");
				$("#materialDemo"+id).val(uploadFiles[0]);
				$("#materialDemo"+id+"Value").text(uploadFiles[0]);
				$("#materialDemo"+id+"Value").val(uploadFiles[0]);
			}
		});
	});
</script>
</#macro>