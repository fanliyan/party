<#macro houseTypeSelect houseTypeModelList selectedValue=0 controlName="">
<select class="form-control chzn-select" id="${controlName}" name="${controlName}" data-placeholder="房产类型"  data-parsley-required="true"  data-parsley-required-message="请选择房产类型" data-parsley-errors-container="#${controlName}_Error">
	<option value=""></option>
	<#if houseTypeModelList??>
	<#list houseTypeModelList as model>
		<option value="${model.houseTypeId}" <#if model.houseTypeId == selectedValue>selected</#if>>${model.houseTypeName}</option>
	</#list>
	</#if>
</select>
<div id="${controlName}_Error"></div>
</#macro>