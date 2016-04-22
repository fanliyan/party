<#macro countrySelect countryList selectedValue=0 controlName="" multiple="">
<select ${multiple} class="form-control chzn-select" name="${controlName}" 
	data-placeholder="请选择国家"   
	data-parsley-required="true" 
	data-parsley-required-message="国家不能为空"
	data-parsley-errors-container="#countryError">
	<option value=""></option>
	<#if countryList??>
	<#list countryList as country>
		<option value="${country.countryId}" <#if selectedValue != 0 && selectedValue==country.countryId>selected</#if>>${country.countryName}</option>
	</#list>
	</#if>
</select>
<div id="countryError"></div>
</#macro>