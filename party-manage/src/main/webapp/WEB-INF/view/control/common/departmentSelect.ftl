<#macro departmentSelect departmentList
departmentControlName="departmentId" xiControlName="xiId" classControlName="classId"
selectedDepartmentId=0  selectedXiId=0 selectedClassId=0 >
<div class="col-md-4">
    <label class="control-label">学院</label>
    <select class="form-control chzn-select" name="${departmentControlName}" data-placeholder="选择学院" id="${departmentControlName}"
        data-parsley-required="true" data-parsley-required-message="学院不可为空"  data-parsley-errors-container="#departmentError">
        <option value="">请选择</option>
        <#list departmentList as model>
            <#if selectedDepartmentId gt 0 && model.id==selectedDepartmentId>
                <option value="${model.id}" selected>${model.name}</option>
            <#else>
                <option value="${model.id}">${model.name}</option>
            </#if>
        </#list>
    </select>
    <ul class="parsley-errors-list filled" id="departmentError"><li class="parsley-required"></li></ul>
</div>
<div class="col-md-4">
    <label class="control-label">系</label>
    <select class="form-control chzn-select" name="${xiControlName}" data-placeholder="选择系" id="${xiControlName}"
            data-parsley-required="true" data-parsley-required-message="系不可为空"  data-parsley-errors-container="#xiError">
        <option value="">请选择</option>
    </select>
    <ul class="parsley-errors-list filled" id="xiError"><li class="parsley-required"></li></ul>
</div>
<div class="col-md-4">
    <label class="control-label">班</label>
    <select class="form-control chzn-select" name="${classControlName}" data-placeholder="选择班" id="${classControlName}"
            data-parsley-required="true" data-parsley-required-message="系不可为空"  data-parsley-errors-container="#classError">
        <option value="">请选择</option>
    </select>
    <ul class="parsley-errors-list filled" id="classError"><li class="parsley-required"></li></ul>
</div>
<script language="javascript">
        <#if selectedClassId!=0>
        $(function(){
            $.ajax({
                cache: true,
                type: "GET",
                url:"${basePath}/common/getxiandclass?id=${selectedClassId}",
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        var option = [];
                        option.push('<option value=\"\"></option>');
                        $.each(data.xilist,function(index,item){
                            option.push('<option value="' + item.id + '">',item.name,'</option>');
                        });
                        $('#${xiControlName}').html(option.join(''));
                        $('#${xiControlName}').val(data.xi.id);
                        $('#${xiControlName}').trigger('chosen:updated');


                        option = [];
                        option.push('<option value=\"\"></option>');
                        $.each(data.classlist,function(index,item){
                            option.push('<option value="' + item.id + '">',item.name,'</option>');
                        });
                        $('#${classControlName}').html(option.join(''));
                        $('#${classControlName}').val(${selectedClassId});
                        $('#${classControlName}').trigger('chosen:updated');

                        $('#${departmentControlName}').val(data.xi.departmentId);
                        $('#${departmentControlName}').trigger('chosen:updated');
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        });
        <#elseif selectedXiId!=0>
        $(function(){
            $.ajax({
                cache: true,
                type: "GET",
                url:"${basePath}/common/getclassbyxi?id=${selectedXiId}",
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        var option = [];
                        option.push('<option value=\"\"></option>');
                        $.each(data.xilist,function(index,item){
                            option.push('<option value="' + item.id + '">',item.name,'</option>');
                        });
                        $('#${xiControlName}').html(option.join(''));
                        $('#${xiControlName}').val(data.xi.id);
                        $('#${xiControlName}').trigger('chosen:updated');


                        option = [];
                        option.push('<option value=\"\"></option>');
                        $.each(data.classlist,function(index,item){
                            option.push('<option value="' + item.id + '">',item.name,'</option>');
                        });
                        $('#${classControlName}').html(option.join(''));
                        <#--$('#${classControlName}').val(${selectedClassId});-->
                        $('#${classControlName}').trigger('chosen:updated');

                        $('#${departmentControlName}').val(data.xi.departmentId);
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
                url:"${basePath}/common/getclassbydepartment?id=${selectedDepartmentId}",
                async: false,
                error: function(request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        var option = [];
                        option.push('<option value=\"\"></option>');
                        $.each(data.xilist,function(index,item){
                            option.push('<option value="' + item.id + '">',item.name,'</option>');
                        });
                        $('#${xiControlName}').html(option.join(''));
                        $('#${xiControlName}').trigger('chosen:updated');

                        $('#${departmentControlName}').val(${selectedDepartmentId});
                        $('#${departmentControlName}').trigger('chosen:updated');
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
            url:"${basePath}/common/xilistbydepartment?id=" + provinceCode,
            async: false,
            error: function(request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function(data) {
                if(data.success){
                    var option = [];
                    option.push('<option value=\"\"></option>');
                    $.each(data.xilist,function(index,item){
                        option.push('<option value="' + item.id + '">',item.name,'</option>');
                    });
                    $('#${xiControlName}').html(option.join(''));
                    $('#${xiControlName}').trigger('chosen:updated');

                }
                else{
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    });
    $('#${xiControlName}').change(function(){
        var provinceCode = $(this).val();

        $.ajax({
            cache: true,
            type: "GET",
            url:"${basePath}/common/classlistbyxi?id=" + provinceCode,
            async: false,
            error: function(request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function(data) {
                if(data.success){
                    var option = [];
                    option.push('<option value=\"\"></option>');
                    $.each(data.classlist,function(index,item){
                        option.push('<option value="' + item.id + '">',item.name,'</option>');
                    });
                    $('#${classControlName}').html(option.join(''));
                    $('#${classControlName}').trigger('chosen:updated');

                }
                else{
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    });

</script>
</#macro>