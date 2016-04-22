<#macro splitPage pageCount pageNo formId recordCount>
<#assign startPageNo=1>
<#assign pageSize=5>
<#if pageNo-(pageSize/2)<1 >
	<#assign startPageNo = 1>
<#else>
	<#assign startPageNo = pageNo-(pageSize/2) + 1>
</#if>

<#if startPageNo + pageSize gt pageCount >
	<#assign endPageNo=pageCount >
	<#if pageCount-pageSize lt 1 >
		<#assign startPageNo = 1>
	</#if>
<#else>
	<#assign endPageNo=startPageNo + pageSize - 1>
</#if>

<div class="panel-footer clearfix">
	<span class="label label-info pull-left">当前第 ${pageNo} 页  共 ${pageCount} 页  共 ${recordCount} 条记录</span>
	<#if pageCount gt 0>
        <ul class="pagination pagination-split pagination-xs m-top-none pull-right">
            <li><a href="javascript:$.GoPage(1);">首页</a></li>
			<#if pageNo==1>
                <li class="disabled"><a href="javascript:void(0);">上页</a></li>
			<#else>
                <li><a href="javascript:$.GoPage(${pageNo-1});">上页</a></li>
			</#if>
			<#if startPageNo != 1>
                <li class="disabled"><a>..</a></li>
			</#if>
			<#list startPageNo..endPageNo as t>
                <li <#if pageNo ==t >class="active"</#if>><a href="javascript:$.GoPage(${t});">${t}</a></li>
			</#list>

			<#if endPageNo != pageCount>
                <li class="disabled"><a>..</a></li>
			</#if>
			<#if pageNo == pageCount>
                <li class="disabled"><a href="javascript:void(0);" onclick="">下页</a></li>
			<#else >
                <li><a href="javascript:$.GoPage(${pageNo+1});" onclick="">下页</a></li>
			</#if>
            <li><a href="javascript:$.GoPage(${pageCount});">尾页</a></li>
        </ul>
	</#if>
</div>

<script language="javascript">
$.GoPage = function(pageNo){
	$("input[name=pageNo]").remove();
	$("#${formId}").append("<input type='hidden' id='${formId}_pageNo' name='pageNo' value='" + pageNo + "' />");
	$("#${formId}").submit();
}
</script>


</#macro>