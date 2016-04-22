<#macro isDeleteSelect selectedValue>
	<select class="form-control chzn-select" data-placeholder="是否删除">
		<option value=""></option>
		<option value="true" <#if selectedValue>selected</#if>>已删除</option>
		<option value="true" <#if !selectedValue>selected</#if>>正常</option>
	</select>
</#macro>