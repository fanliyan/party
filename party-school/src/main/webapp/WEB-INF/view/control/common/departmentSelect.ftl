<#macro departmentSelect departmentList departmentControlName="departmentId" branchControlName="branchId"
selectedDepartmentId=0  selectedBranchId=0 >
<div class="col-md-6">
    <label class="control-label">学院</label>
    <select class="form-control chzn-select" name="${departmentControlName}" data-placeholder="选择学院" id="${departmentControlName}"
        data-parsley-required="true" data-parsley-required-message="学院不可为空"  data-parsley-errors-container="#countryError">
        <option>请选择</option>
        <#list departmentList as model>
            <#if selectedDepartmentId gt 0 && model.id==selectedDepartmentId>
                <option value="${model.id}" selected>${model.name}</option>
            <#else>
                <option value="${model.id}">${model.name}</option>
            </#if>
        </#list>
    </select>
    <ul class="parsley-errors-list filled" id="countryError"><li class="parsley-required"></li></ul>
</div>
<div class="col-md-6">
    <label class="control-label">系</label>
    <select class="form-control chzn-select" name="${branchControlName}" data-placeholder="选择系" id="${branchControlName}"
            data-parsley-required="true" data-parsley-required-message="系不可为空"  data-parsley-errors-container="#cityError">
        <option>请选择</option>
    </select>
    <ul class="parsley-errors-list filled" id="cityError"><li class="parsley-required"></li></ul>
</div>
<script language="javascript">
        <#if selectedDepartmentId!=0>
        $(function(){
            $.ajax({
                cache: true,
                type: "GET",
                url:"${basePath}/common/getdepartment?id=${selectedDepartmentId}",
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        var option = [];
                        option.push('<option></option>');
                        $.each(data.citylist,function(index,item){
                            option.push('<option value="' + item.id + '">',item.name,'</option>');
                        });
                        $('#${cityControlName}').html(option.join(''));
                        $('#${cityControlName}').val(${selectedCityId});
                        $('#${cityControlName}').trigger('chosen:updated');

                        option = [];
                        option.push('<option></option>');
                        $.each(data.arealist,function(index,item){
                            option.push('<option value="' + item.code + '">',item.name,'</option>');
                        });
                        $('#${areaControlName}').html(option.join(''));

                        $('#${provinceControlName}').val(data.province.code);
                        $('#${provinceControlName}').trigger('chosen:updated');
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        });
        <#elseif selectedProvinceId!=0>
        $(function(){
            $.ajax({
                cache: true,
                type: "GET",
                url:"${basePath}/common/getcity?code=${selectedProvinceId}",
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        var option = [];
                        option.push('<option></option>');
                        $.each(data.citylist,function(index,item){
                            option.push('<option value="' + item.code + '">',item.name,'</option>');
                        });
                        $('#${cityControlName}').html(option.join(''));
                        <#--$('#${cityControlName}').val(data.city.);-->
                        <#--$('#${cityControlName}').trigger('chosen:updated');-->

                        $('#${provinceControlName}').trigger('chosen:updated');
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
                    option.push('<option></option>');
                    $.each(data.citylist,function(index,item){
                        option.push('<option value="' + item.code + '">',item.name,'</option>');
                    });
                    $('#${cityControlName}').html(option.join(''));
                    <#--$('#${cityControlName}').val(data.city.);-->
                    $('#${cityControlName}').trigger('chosen:updated');

                }
                else{
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    });

</script>
</#macro>