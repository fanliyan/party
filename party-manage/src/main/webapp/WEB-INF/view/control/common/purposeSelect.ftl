<#macro purposeSelect purposeList selectedValues controlName="" multiple="multiple" required="true">
<select ${multiple} class="form-control chzn-select" name="${controlName}" 
	data-placeholder="请选择移民目的"
	data-parsley-required="${required}" 
	data-parsley-required-message="移民目的不能为空"
	data-parsley-errors-container="#purposeError">
	<option value=""></option>
	<#if purposeList??>
	<#list purposeList as purpose>
		<option value="${purpose.purposeId}" ${checked(selectedValues purpose.purposeId)}>${purpose.purposeName}</option>
	</#list>
	</#if>
</select>
<div id="purposeError"></div>
</#macro>
<#function checked selectedValues purposeId>
	<#if selectedValues??>
		<#list selectedValues as id>
			<#if id == purposeId>
				<#return "selected='selected'">
			</#if>
		</#list>
	</#if>
	<#return "">   
</#function>