<#macro processSelect processList selectedValue=0 controlName="">
<select class="form-control" name="${controlName}" 
	data-parsley-required="true" 
	data-parsley-required-message="国家不能为空"
	data-parsley-errors-container="#processError">
	<option value="" disabled>请选择流程</option>
	<#if processList??>
	<#list processList as process>
		<option value="${process.policyProcessId}" <#if selectedValue != 0 && selectedValue==process.policyProcessId>selected</#if>>${(process.processName)!}</option>
	</#list>
	</#if>
</select>
<div id="processError"></div>
</#macro>