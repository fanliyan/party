<#macro policyProcessForm processList>
	<form class="form-horizontal" id="processForm" >
		<input type="hidden" name="policyId" id="policyId4Process" value="${(policy.policyId)!}">
		<div class="col-md-12">
			<div class="form-group pull-right">
				 <a class="btn btn-xs btn-info" onclick="$.addProcessRow();"><i class="fa fa-plus"> 增加流程</i></a>
			</div>
		</div>
		<div id="processRow">
			<div id="processTemplete" style="display:none;">
				<div class="form-group">
					<div class="col-md-6">
						<label for="exampleInputEmail1" class="col-md-2 control-label">流程名称</label>
						<div class="col-md-10">
							<input type="input" class="form-control input-sm" placeholder="必填,字符最大长度50" id="processName#id#" name="processName#id#"
							 {parsleyTrue}
							 data-parsley-maxlength="50"
							 data-parsley-maxlength-message="内容不能超过50字"
							 data-parsley-group="group#id#"/>
							 <input type="hidden" id="processId#id#"/>
						</div>
					</div>
					<div class="col-md-4">
						<label for="exampleInputEmail1" class="col-md-3 control-label">第几步</label>
						<div class="col-md-9">
							<input type="input" class="form-control input-sm" placeholder="必填,仅数字" id="step#id#" name="step#id#"
							 {parsleyTrue}
							 data-parsley-pattern="^\d*$"
							 data-parsley-pattern-message="只能填写数字"
							 data-parsley-group="group#id#"/>
						</div>
					</div>
					
					<div class="col-md-1">
						<a class="btn btn-xs btn-success" id="saveBtn#id#" onclick="saveProcess(#id#,'group#id#');"><i class="fa fa-check"></i> 保存</a>
					</div>
					<div class="col-md-1">
						<a class="btn btn-xs btn-danger" onclick="delProcess(#id#);"><i class="fa fa-trash-o"></i></a>
					</div>
					
				</div>
				<div class="form-group">
					<div class="col-md-6">
						<label for="exampleInputEmail1" class="col-md-2 control-label">官方和机构费用</label>
						<div class="col-md-10">
							 <textarea class="form-control " rows="5" placeholder="必填,字符最大长度1000" id="agencyCost#id#" name="agencyCost#id#"
							 {parsleyTrue}
							 data-parsley-maxlength="1000"
							 data-parsley-maxlength-message="内容不能超过1000字"
							 data-parsley-group="group#id#"
							 ></textarea>
						</div>
					</div>
					<div class="col-md-6">
						<label for="exampleInputEmail1" class="col-md-2 control-label">办理内容</label>
						<div class="col-md-10">
							 <textarea class="form-control " rows="5" placeholder="必填,字符最大长度1000" name="processContent#id#" id="processContent#id#" 
							 {parsleyTrue}
							 data-parsley-maxlength="1000"
							 data-parsley-maxlength-message="内容不能超过1000字"
							 data-parsley-group="group#id#"
							 ></textarea>
						</div>
					</div>
					
				</div>
				<div class="form-group">
					<div class="col-md-6">
						<label for="exampleInputEmail1" class="col-md-2 control-label">服务费用</label>
						<div class="col-md-10">
							<input type="input" class="form-control input-sm" placeholder="必填,字符最大长度50" id="serviceCost#id#" name="serviceCost#id#"
							 {parsleyTrue}
							 data-parsley-maxlength="50"
							 data-parsley-maxlength-message="内容不能超过50字"
							 data-parsley-group="group#id#"/>
						</div>
					</div>
					<div class="col-md-6">
						<label for="exampleInputEmail1" class="col-md-2 control-label">办理周期</label>
						<div class="col-md-10">
							<input type="input" class="form-control input-sm" placeholder="必填,字符最大长度50" id="processCycle#id#" name="processCycle#id#"
							 data-parsley-maxlength="50"
							 data-parsley-maxlength-message="内容不能超过50字"
							 {parsleyTrue}
							 data-parsley-group="group#id#"/>
						</div>
					</div>
				</div>
				<div class="form-group border-bottom">&nbsp;</div>
			</div>
			<#assign tempFlag=0>
			<#if processList?? && processList?size gt 0>
				<#list processList as process>
					<#assign tempFlag=tempFlag+1>
					<div id="processTemplete${tempFlag}">
						<div class="form-group">
							<div class="col-md-6">
								<label for="exampleInputEmail1" class="col-md-2 control-label">流程名称</label>
								<div class="col-md-10">
									<input type="input" class="form-control input-sm" placeholder="必填,字符最大长度50" id="processName${tempFlag}" name="processName${tempFlag}"
									 data-parsley-required="true"
									 data-parsley-maxlength="50"
									 data-parsley-maxlength-message="内容不能超过50字"
									 value="${(process.processName)!}"
									 data-parsley-group="group${tempFlag}"/>
									 <input type="hidden" id="processId${tempFlag}" name="processId${tempFlag}" value="${process.policyProcessId}"/>
								</div>
							</div>
							<div class="col-md-4">
								<label for="exampleInputEmail1" class="col-md-3 control-label">第几步</label>
								<div class="col-md-9">
									<input type="input" class="form-control input-sm" placeholder="第几步,仅数字" id="step${tempFlag}" name="step${tempFlag}"
									 data-parsley-required="true"
									 data-parsley-pattern="^\d*$"
									 data-parsley-pattern-message="只能填写数字"
									 value="${(process.step)!}"
									 data-parsley-group="group${tempFlag}"/>
								</div>
							</div>
							<div class="col-md-1">
								<a class="btn btn-xs btn-success" onclick="saveProcess(${tempFlag},'group${tempFlag}');" alt="保存"><i class="fa fa-check"></i> 保存</a>
							</div>
							<div class="col-md-1">
								<a class="btn btn-xs btn-danger" onclick="delProcess(${tempFlag});"><i class="fa fa-trash-o"></i></a>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-6">
								<label for="exampleInputEmail1" class="col-md-2 control-label">官方和机构费用</label>
								<div class="col-md-10">
									<textarea class="form-control " rows="5" placeholder="必填,字符最大长度1000" id="agencyCost${tempFlag}" name="agencyCost${tempFlag}"
									 data-parsley-required="true"
									 data-parsley-maxlength="1000"
									 data-parsley-maxlength-message="内容不能超过1000字"
									 data-parsley-group="group${tempFlag}"
									 >${(process.agencyCost)!}</textarea>
								</div>
							</div>
							<div class="col-md-6">
								<label for="exampleInputEmail1" class="col-md-2 control-label">办理内容</label>
								<div class="col-md-10">
									<textarea class="form-control " rows="5" name="processContent${tempFlag}"
									 placeholder="必填,字符最大长度1000" id="processContent${tempFlag}" 
									 data-parsley-required="true"
									 data-parsley-maxlength="1000"
									 data-parsley-maxlength-message="内容不能超过1000字"
									 data-parsley-group="group${tempFlag}"
									 >${(process.processContent)!}</textarea>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-6">
								<label for="exampleInputEmail1" class="col-md-2 control-label">服务费用</label>
								<div class="col-md-10">
									<input type="input" class="form-control input-sm" placeholder="必填,,字符最大长度50" id="serviceCost${tempFlag}" name="serviceCost${tempFlag}"
									 data-parsley-required="true"
									 data-parsley-maxlength="50"
									 data-parsley-maxlength-message="内容不能超过50字"
									 value="${(process.serviceCost)!}"
									 data-parsley-group="group${tempFlag}"/>
								</div>
							</div>
							<div class="col-md-6">
								<label for="exampleInputEmail1" class="col-md-2 control-label">办理周期</label>
								<div class="col-md-10">
									<input type="input" class="form-control input-sm" placeholder="必填,字符最大长度50" id="processCycle${tempFlag}" name="processCycle${tempFlag}"
									 data-parsley-maxlength="50"
									 data-parsley-maxlength-message="内容不能超过50字"
									 data-parsley-required="true"
									 value="${(process.processCycle)!}"
									 data-parsley-group="group${tempFlag}"/>
								</div>
							</div>
						</div>
						<div class="form-group border-bottom">&nbsp;</div>
					</div>
				</#list>
			</#if>
			<input type="hidden" id="processCount" name="processCount" value="${tempFlag}" >
		</div>
	</form>
<script>
	$.addProcessRow = function(){
		var idCount = parseInt($("#processCount").val());
		idCount++;
		$("#processRow").append('<div class="row" id="processTemplete' + idCount + '">' + $("#processTemplete").html()
			.replace(new RegExp(/#id#/g),idCount)
			.replace(new RegExp(/{parsleytrue}/g),"data-parsley-required='true'")
			 + '</div>');
		$("#processCount").val(idCount);
	}
	
	function saveProcess(id,groupId){
		if($("#policyId").val()==""){
			alertify.alert("请先保存政策基本信息！");
			return;
		}
		if($('#processForm').parsley().validate(groupId)){
			var policyId=$("#policyId").val();
			var processName=$("#processName"+id).val();
			var step=$("#step"+id).val();
			var agencyCost=$("#agencyCost"+id).val();
			var serviceCost=$("#serviceCost"+id).val();
			var processCycle=$("#processCycle"+id).val();
			var processContent=$("#processContent"+id).val();
			var policyProcessId="";
			if($("#processId"+id).val()!=undefined){
				policyProcessId=$("#processId"+id).val();
			}
			$.ajax({
				cache: false,
				type: "POST",
				url:"${basePath}/policy/saveProcess",
				data:encodeURI("policyProcessId="+policyProcessId+"&policyId="+policyId+"&processName="+processName+"&step="+step+"&agencyCost="+agencyCost+"&serviceCost="+serviceCost+"&processCycle="+processCycle+"&processContent="+processContent),
				async: true,
				error: function(request) {
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){
						$("#processId"+id).val(data.processId);
						$("select[name='policyProcessId#id#']").empty();
						$("select[name='policyProcessId#id#']").append("<option value='' selected disabled>请选择流程</option>");
						for(var i=0;i<data.processList.length;i++){
							$("select[name='policyProcessId#id#']").append("<option value='"+data.processList[i].processId+"'>"+data.processList[i].processName+"</option>");
						}
						var listCount=parseInt($("#materialListCount").val());
						if(listCount>0){
							for(var i=1;i<=listCount;i++){
								var temp=$("#policyProcessId"+i).val();
								$("#policyProcessId"+i).empty();
								$("#policyProcessId"+i).append("<option value='' disabled>请选择流程</option>");
								for(var j=0;j<data.processList.length;j++){
									$("#policyProcessId"+i).append("<option value='"+data.processList[j].processId+"'>"+data.processList[j].processName+"</option>");
								}
								$("#policyProcessId"+i).val(temp);
							}
						}
						$.gritter.add({
							title: '<i class="fa fa-check-circle"></i>提示',
							text: '保存成功',
							sticky: false,
							time: '3000',
							class_name: 'gritter-success',
							position: 'bottom-left'
						});
					}
					else{   
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}
	}
	function delProcess(id){
		if($("#processId"+id).val()!=undefined){
			var policyProcessId=$("#processId"+id).val();
			var policyId=$("#policyId").val();
			$.ajax({
				cache: false,
				type: "POST",
				url:"${basePath}/policy/delProcess",
				data:"policyProcessId="+policyProcessId+"&policyId="+policyId,
				async: false,
				error: function(request) {
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){
						$("select[name='policyProcessId#id#']").empty();
						$("select[name='policyProcessId#id#']").append("<option value='' selected disabled>请选择流程</option>");
						for(var i=0;i<data.processList.length;i++){
							$("select[name='policyProcessId#id#']").append("<option value='"+data.processList[i].processId+"'>"+data.processList[i].processName+"</option>");
						}
						var listCount=parseInt($("#materialListCount").val());
						if(listCount>0){
							for(var i=1;i<=listCount;i++){
								var temp=$("#policyProcessId"+i).val();
								$("#policyProcessId"+i).empty();
								$("#policyProcessId"+i).append("<option value='' disabled>请选择流程</option>");
								for(var j=0;j<data.processList.length;j++){
									$("#policyProcessId"+i).append("<option value='"+data.processList[j].processId+"'>"+data.processList[j].processName+"</option>");
								}
								$("#policyProcessId"+i).val(temp);
							}
						}
						alertify.alert("操作成功！");
						$('#processTemplete'+id).remove();
					}
					else{   
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}else{
			$('#processTemplete'+id).remove();
		}
	}
	function processSubmit(){
		if($("#policyId").val()==""){
			alertify.alert("请先保存政策基本信息！");
			return;
		}
		if($("#processCount").val()=="0"){
			alertify.alert("您还没有添加任何流程！");
			return;
		}
		if($('#processForm').parsley().validate()){
			$.ajax({
				cache: false,
				type: "POST",
				url:"${basePath}/policy/saveProcess",
				data:$('#processForm').serialize(),
				async: false,
				error: function(request) {
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){
						$("select[name='policyProcessId#id#']").empty();
						$("select[name='policyProcessId#id#']").append("<option value='' selected disabled>请选择流程</option>");
						for(var i=0;i<data.processList.length;i++){
							$("select[name='policyProcessId#id#']").append("<option value='"+data.processList[i].processId+"'>"+data.processList[i].processName+"</option>");
						}
						var listCount=parseInt($("#materialListCount").val());
						if(listCount>0){
							for(var i=1;i<=listCount;i++){
								var temp=$("#policyProcessId"+i).val();
								$("#policyProcessId"+i).empty();
								$("#policyProcessId"+i).append("<option value='' disabled>请选择流程</option>");
								for(var j=0;j<data.processList.length;j++){
									$("#policyProcessId"+i).append("<option value='"+data.processList[j].processId+"'>"+data.processList[j].processName+"</option>");
								}
								$("#policyProcessId"+i).val(temp);
							}
						}
						alertify.alert("操作成功！");
					}
					else{   
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}
	}
</script>
</#macro>