<#macro housePropertySelect housePropertyModelList selectedValue=0 controlName="">
<select class="form-control chzn-select" name="${controlName}" id="${controlName}" data-placeholder="房产性质" data-parsley-required="true"  data-parsley-required-message="请选择房产性质" data-parsley-errors-container="#${controlName}_Error">
	<option value=""></option>
	<#if housePropertyModelList??>
	<#list housePropertyModelList as model>
		<option value="${model.housePropertyId}" <#if model.housePropertyId == selectedValue>selected</#if>>${model.housePropertyName}</option>
	</#list>
	</#if>
</select>
<div id="${controlName}_Error"></div>
</#macro>