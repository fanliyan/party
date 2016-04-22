<#macro productTypeSelect productTypeModelList selectedValue=0 controlName="productTypeId" showAll=true notNull=false>
	<select class="form-control chzn-select" data-placeholder="产品类型" id="${controlName}" name="${controlName}" <#if notNull> data-parsley-required="true" data-parsley-required-message="产品类型不可为空"  data-parsley-errors-container="#${controlName}_Error"</#if>>
		<#if showAll>
			<option>全部</option>
		<#else>
			<option></option>
		</#if>
		<#if productTypeModelList??>
		<#list productTypeModelList as model>
			<option value="${model.productTypeId}" <#if model.productTypeId == selectedValue>selected</#if>>${model.productTypeName}</option>
		</#list>
		</#if>
	</select>
	
	<div id="${controlName}_Error"></div>
</#macro>