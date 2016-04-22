<#macro currencySelect currencyModelList selectedValue="" controlName="" controlAttrValue="" required=false>
<select class="form-control chzn-select" id="${controlName}" name="${controlName}" data-placeholder="选择货币" 
 ${controlAttrValue} <#if required>data-parsley-required="true"</#if> data-parsley-required-message="请选择一个货币类型" 
 data-parsley-errors-container="#${controlName}_Error">
	<option value=""></option>
		<#if currencyModelList??>
		<#list currencyModelList as model>
			<option value="${model.currency}" <#if model.currency == selectedValue>selected</#if>>${model.currencyName}</option>
		</#list>
		</#if>
</select>
<div id="${controlName}_Error"></div>
</#macro>