<#function hasItem ids id>
	<#if ids??>
		<#list ids?split(",") as s>
			<#if id?string == s?trim>
				<#return true>
			</#if>
		</#list>
	</#if>
	<#return false>   
</#function>

<#function getPolicyIds policyModels>
<#local ids="">
<#if policyModels?size gt 0>
	<#list policyModels as m>
		<#if ids != "">
			<#local ids = ids + "," >
		</#if>
		<#local ids = ids + m.policyId>
	</#list>
</#if>
<#return ids>
</#function>

<#function getAttrValue attributeValueModels attrId>
<#if attributeValueModels?size gt 0>
	<#list attributeValueModels as m>
		<#if m.attrId == attrId>
			<#return m.attrValue>
		</#if>
	</#list>
</#if>
<#return "">
</#function>

<#function getProductEditUrl productTypeId,productId>
	<#if productTypeId??>
		<#if productTypeId == 1>
			<#return basePath+"/producthouse/edit?productId="+productId>
		</#if>
	</#if>
</#function>
