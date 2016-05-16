<#macro nationSelect nationList nationControlName="nationId" selectedNationId=0 >
<div class="col-md-12">
    <label class="control-label">民族</label>
    <select class="form-control chzn-select" name="${nationControlName}" data-placeholder="选择民族" id="${nationControlName}"
        data-parsley-required="true" data-parsley-required-message="民族不可为空"  data-parsley-errors-container="#countryError">
        <option>请选择</option>
        <#list nationList as model>
            <#if selectedNationId gt 0 && model.id==selectedNationId>
                <option value="${model.id}" selected>${model.nation}</option>
            <#else>
                <option value="${model.id}">${model.nation}</option>
            </#if>
        </#list>
    </select>
    <ul class="parsley-errors-list filled" id="countryError"><li class="parsley-required"></li></ul>
</div>
</#macro>