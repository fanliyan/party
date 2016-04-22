<#include "/function.ftl"> 

<#macro policySelect policyList selectedValue="" controlName="">
<select multiple class="form-control chzn-select" name="${controlName}" 
	data-placeholder="可适用的政策"   
	data-parsley-required="true" 
	data-parsley-required-message="请至少选择一个适用政策"
	data-parsley-errors-container="#policyError">
	<option value=""></option>
	<#if policyList??>
	<#list policyList as model>
		<option value="${model.policyId}" <#if hasItem(selectedValue,model.policyId)>selected</#if>>${model.policyName}</option>
	</#list>
	</#if>
</select>
<div id="policyError"></div>
</#macro>
