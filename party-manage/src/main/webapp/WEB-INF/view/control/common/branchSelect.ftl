<#macro branchSelect departmentList departmentControlName="departmentId" branchControlName="branchId"
selectedDepartmentId=0  selectedBranchId=0 >
<div class="col-md-6">
    <label class="control-label">学院</label>
    <select class="form-control chzn-select" name="${departmentControlName}" data-placeholder="选择学院" id="${departmentControlName}"
        data-parsley-required="true" data-parsley-required-message="学院不可为空"  data-parsley-errors-container="#department1Error">
        <option value="">请选择</option>
        <#list departmentList as model>
            <#if selectedDepartmentId gt 0 && model.id==selectedDepartmentId>
                <option value="${model.id}" selected>${model.name}</option>
            <#else>
                <option value="${model.id}">${model.name}</option>
            </#if>
        </#list>
    </select>
    <ul class="parsley-errors-list filled" id="department1Error"><li class="parsley-required"></li></ul>
</div>
<div class="col-md-6">
    <label class="control-label">支部/支委</label>
    <select class="form-control chzn-select" name="${branchControlName}" data-placeholder="选择支部/支委" id="${branchControlName}"
            data-parsley-required="true" data-parsley-required-message="支部/支委不可为空"  data-parsley-errors-container="#branchError">
        <option value="">请选择</option>
    </select>
    <ul class="parsley-errors-list filled" id="branchError"><li class="parsley-required"></li></ul>
</div>
<script language="javascript">
        <#if selectedBranchId!=0>
        $(function(){
            $.ajax({
                cache: true,
                type: "GET",
                url:"${basePath}/common/getbranch?id=${selectedBranchId}",
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        var option = [];
                        option.push('<option value=\"\"></option>');
                        $.each(data.branchlist,function(index,item){
                            option.push('<option value="' + item.id + '">',item.name,'</option>');
                        });
                        $('#${branchControlName}').html(option.join(''));
                        $('#${branchControlName}').val(${selectedBranchId});
                        $('#${branchControlName}').trigger('chosen:updated');

                        $('#${departmentControlName}').val(data.branch.departmentId);
                        $('#${departmentControlName}').trigger('chosen:updated');
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        });
        <#elseif selectedDepartmentId!=0>
        $(function(){
            $.ajax({
                cache: true,
                type: "GET",
                url:"${basePath}/common/getbranchbydepartment?id=${selectedDepartmentId}",
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        var option = [];
                        option.push('<option value=\"\"></option>');
                        $.each(data.branchlist,function(index,item){
                            option.push('<option value="' + item.id + '">',item.name,'</option>');
                        });
                        $('#${branchControlName}').html(option.join(''));

                        $('#${branchControlName}').trigger('chosen:updated');
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        });
        </#if>

    $('#${departmentControlName}').change(function(){
        var provinceCode = $(this).val();

        $.ajax({
            cache: true,
            type: "GET",
            url:"${basePath}/common/branchlistbydepartment?id=" + provinceCode,
            async: false,
            error: function(request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function(data) {
                if(data.success){
                    var option = [];
                    option.push('<option value=\"\"></option>');
                    $.each(data.branchlist,function(index,item){
                        option.push('<option value="' + item.id + '">',item.name,'</option>');
                    });
                    $('#${branchControlName}').html(option.join(''));
                    <#--$('#${cityControlName}').val(data.city.);-->
                    $('#${branchControlName}').trigger('chosen:updated');

                }
                else{
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    });

</script>
</#macro>