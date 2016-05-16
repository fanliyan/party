<#macro areaSelect provinceList provinceControlName="provinceId" cityControlName="cityId" areaControlName="areaId"  selectedProvinceId=0  selectedCityId=0 selectedAreaId=0>
<div class="col-md-4">
    <label class="control-label">省份</label>
    <select class="form-control chzn-select" name="${provinceControlName}" data-placeholder="选择省份" id="${provinceControlName}"
        data-parsley-required="true" data-parsley-required-message="省份不可为空"  data-parsley-errors-container="#countryError">
        <option>请选择</option>
        <#list provinceList as model>
            <#if selectedProvinceId gt 0 && model.id==selectedProvinceId>
                <option value="${model.code}" selected>${model.name}</option>
            <#else>
                <option value="${model.code}">${model.name}</option>
            </#if>
        </#list>
    </select>
    <ul class="parsley-errors-list filled" id="countryError"><li class="parsley-required"></li></ul>
</div>
<div class="col-md-4">
    <label class="control-label">城市</label>
    <select class="form-control chzn-select" name="${cityControlName}" data-placeholder="选择城市" id="${cityControlName}"
            data-parsley-required="true" data-parsley-required-message="城市不可为空"  data-parsley-errors-container="#cityError">
        <option>请选择</option>
    </select>
    <ul class="parsley-errors-list filled" id="cityError"><li class="parsley-required"></li></ul>
</div>
<div class="col-md-4">
    <label class="control-label">地区</label>
    <select class="form-control chzn-select" name="${areaControlName}" data-placeholder="选择地区" id="${areaControlName}"
        data-parsley-required="true" data-parsley-required-message="地区不可为空"  data-parsley-errors-container="#areaError">
        <option>请选择</option>
    </select>
    <ul class="parsley-errors-list filled" id="areaError"><li class="parsley-required"></li></ul>
</div>
<script language="javascript">
        <#if selectedAreaId != 0>
        $(function(){
            $.ajax({
                cache: true,
                type: "GET",
                url:"${basePath}/common/getcityandprovince?code=${selectedAreaId}",
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
                        $('#${cityControlName}').val(data.city.code);
                        $('#${cityControlName}').trigger('chosen:updated');

                        option = [];
                        option.push('<option></option>');
                        $.each(data.arealist,function(index,item){
                            option.push('<option value="' + item.code + '">',item.name,'</option>');
                        });
                        $('#${areaControlName}').html(option.join(''));
                        $('#${areaControlName}').val(${selectedAreaId});
                        $('#${areaControlName}').trigger('chosen:updated');

                        $('#${provinceControlName}').val(data.province.code);
                        $('#${provinceControlName}').trigger('chosen:updated');
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        });
        <#elseif selectedCityId!=0>
        $(function(){
            $.ajax({
                cache: true,
                type: "GET",
                url:"${basePath}/common/getprovince?code=${selectedProvinceId}",
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

    $('#${provinceControlName}').change(function(){
        var provinceCode = $(this).val();

        $.ajax({
            cache: true,
            type: "GET",
            url:"${basePath}/common/citylistbyprovince?code=" + provinceCode,
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

    $('#${cityControlName}').change(function(){
        var cityCode = $(this).val();

        $.ajax({
            cache: true,
            type: "GET",
            url:"${basePath}/common/arealistbycity?code=" + cityCode,
            async: false,
            error: function(request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function(data) {
                if(data.success){
                    var option = [];
                    option.push('<option></option>');
                    $.each(data.arealist,function(index,item){
                        option.push('<option value="' + item.code + '">',item.name,'</option>');
                    });
                    $('#${areaControlName}').html(option.join(''));
                <#--$('#${cityControlName}').val(data.city.);-->
                    $('#${areaControlName}').trigger('chosen:updated');
                }
                else{
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    });

</script>
</#macro>