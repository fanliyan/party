<#macro houseFacilityFrom productFacilityModels facilityTypeModels>
	<div class="panel-heading">周边配套设施<div class="pull-right"><a class="btn btn-xs btn-info" onclick="$.addFacilityRow();"><i class="fa fa-plus"> 增加周边设施</i></a></div></div>
	<div class="panel-body" id="facilityPanel">
		<div class="row" style="display:none" id="facilityRowTemplete">
			<div class="col-md-12 ">
				<div class="form-group">
					<div class="col-md-2">
						<@productFacilitySelect.productFacilitySelect facilityTypeModels=facilityTypeModels controlName="facilityTypeId#id#" controlAttrValue="{parsleyTrue}"/>
					</div>
					
					<label for="exampleInputEmail1" class="col-md-1 control-label">名称</label>
					<div class="col-md-3">
						<input type="input" class="form-control input-sm" placeholder="配套设施名称" name="facilityName#id#" {parsleyTrue} data-parsley-maxlength="60"
					 data-parsley-maxlength-message="字符最大长度不能超过60个字">
					</div>
					
					<label for="exampleInputEmail1" class="col-md-1 control-label">距离(公里)</label>
					<div class="col-md-1">
						<input type="input" class="form-control input-sm" placeholder="" name="facilityDistance#id#" {parsleyTrue} data-parsley-pattern="^\d{1,3}(\.\d{1,2})?$">
					</div>
					
					<div class="col-md-1">
						<a class="btn btn-xs btn-danger" onclick="$('#facilityRow#id#').remove();"><i class="fa fa-trash-o"></i></a>
					</div>
				</div><!-- /form-group -->				
			</div>
		</div><!-- /row -->
		<#assign tempFlag=0>
		<#if (productFacilityModels)?? && productFacilityModels?size gt 0>
			<#list productFacilityModels as m>
			<#assign tempFlag=tempFlag+1>
				<div class="row" id="facilityRow${tempFlag}">
					<div class="col-md-12 ">
						<div class="form-group">
							<div class="col-md-2">
								<@productFacilitySelect.productFacilitySelect facilityTypeModels=facilityTypeModels controlName="facilityTypeId${tempFlag}" selectedValue=(m.facilityTypeId)!0/>
							</div>
							
							<label for="exampleInputEmail1" class="col-md-1 control-label">名称</label>
							<div class="col-md-3">
								<input type="input" class="form-control input-sm" placeholder="配套设施名称" name="facilityName${tempFlag}" value="${(m.facilityName)!}" data-parsley-required="true" data-parsley-maxlength="60"
								 data-parsley-maxlength-message="字符最大长度不能超过60个字">
							</div>
							
							<label for="exampleInputEmail1" class="col-md-1 control-label">距离(公里)</label>
							<div class="col-md-1">
								<input type="input" class="form-control input-sm" placeholder="" name="facilityDistance${tempFlag}" value="${(m.facilityDistance)!}" data-parsley-pattern="^\d{1,8}(\.\d{1,2})?$" data-parsley-required="true">
							</div>
							
							<div class="col-md-1">
								<a class="btn btn-xs btn-danger" onclick="$('#facilityRow${tempFlag}').remove();"><i class="fa fa-trash-o"></i></a>
							</div>
						</div><!-- /form-group -->				
					</div>
				</div><!-- /row -->
			</#list>
		</#if>
		<input type="hidden" id="facilityCount" name="facilityCount" value="${tempFlag}" >
	</div><!-- /panel-body -->
	
	<script language="javascript">
	$.addFacilityRow = function(){
		var idCount = parseInt($("#facilityCount").val());
		idCount++;
		$("#facilityTypeId_id__chosen").remove();
		$("#facilityPanel").append('<div class="row" id="facilityRow' + idCount + '">' + $("#facilityRowTemplete").html()
			.replace(new RegExp(/#id#/g),idCount)
			.replace(new RegExp(/{parsleytrue}/g),"data-parsley-required=\"true\"") + '</div>');
		
		$("#facilityTypeId"+idCount).chosen("destroy");
		$("#facilityCount").val(idCount);
	}
	</script>
</#macro>