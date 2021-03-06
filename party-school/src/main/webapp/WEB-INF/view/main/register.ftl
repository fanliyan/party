<#import "/master/master-blank.ftl" as master />
<#import "/control/common/areaSelect.ftl" as areaSelect />
<#import "/control/common/nationSelect.ftl" as nationSelect />
<#import "/control/common/branchSelect.ftl" as branchSelect />
<#import "/control/common/departmentSelect.ftl" as departmentSelect />

<@master.masterBlank title="网上党校-注册">

<div class="login-wrapper">
    <div class="text-center">
        <h2 class="fadeInUp animation-delay10" style="font-weight:bold">
            <span class="text-success">计算机学院</span> <span style="color:#ccc; text-shadow:0 1px #fff">网上党校</span>
        </h2>
    </div>
    <div class="login-widget animation-delay1">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-plus-circle fa-lg"></i> 注册
            </div>
            <div class="panel-tab clearfix">
                <ul class="tab-bar">
                    <li class="active"><a href="#studnet" data-toggle="tab"><i class="fa fa-home"></i> 学生注册</a></li>
                    <li class=""><a href="#teacher" data-toggle="tab"><i class="fa fa-pencil"></i> 老师注册</a></li>
                </ul>
            </div>
            <div class="panel-body">
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="studnet">
                        <form class="form-login-studnet">
                            <div class="form-group">
                                <label>账号</label>
                                <input type="text" name="account" placeholder="Username" class="form-control input-sm bounceIn animation-delay2 parsley-validated"
                                       data-parsley-trigger="focusout"
                                       data-parsley-required="true"
                                       data-parsley-required-message="用户名不可为空"
                                >
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label>密码</label>
                                <input type="password" name="password" placeholder="Password" class="form-control input-sm bounceIn animation-delay3 parsley-validated"
                                       data-parsley-required="true"
                                       data-parsley-trigger="focusout"
                                       data-parsley-required-message="密码不可为空"
                                       data-parsley-minlength="6"
                                       data-parsley-minlength-message="密码位数不可少于6位"
                                >
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <div class="col-md-6">
                                    <label>姓名</label>
                                    <input type="text" name="name" placeholder="Name" class="form-control input-sm bounceIn animation-delay4  parsley-validated"
                                           data-parsley-required="true"
                                           data-parsley-required-message="姓名不可为空"
                                    >
                                </div>
                                <div class="col-md-6">
                                    <label>身份证</label>
                                    <input type="text" name="idCard" placeholder="ID-card" class="form-control input-sm bounceIn animation-delay4  parsley-validated"
                                           data-parsley-required="true"
                                           data-parsley-required-message="身份证不可为空"
                                           data-parsley-pattern="/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/"
                                    >
                                </div>
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <div class="col-md-6">
                                    <label>学号</label>
                                    <input type="text" name="studentCode" placeholder="Student Code" class="form-control input-sm bounceIn animation-delay5  parsley-validated"
                                           data-parsley-required="true"
                                           data-parsley-required-message="学号不可为空"
                                           data-parsley-pattern="/^\d+$/"
                                    >
                                </div>
                                <div class="col-md-6">
                                    <label>手机</label>
                                    <input type="text" name="phone" placeholder="telephone"
                                           class="form-control input-sm bounceIn animation-delay5  parsley-validated"
                                           data-parsley-pattern="/^[1][0-9]{10}$/"
                                    >
                                </div>
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2">性别</label>
                                    <div class="col-md-10">
                                        <label class="label-radio inline">
                                            <input type="radio" name="gender" value="0" >
                                            <span class="custom-radio"></span>
                                            男
                                        </label>
                                        <label class="label-radio inline">
                                            <input type="radio" name="gender" value="1"
                                                   data-parsley-required="true" data-parsley-required-message="请选择性别">
                                            <span class="custom-radio"></span>
                                            女
                                        </label>
                                    </div><!-- /.col -->
                                </div>
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2">生日</label>
                                    <div class="col-md-10">
                                        <input type="text" class="form-control input-sm"
                                               data-parsley-pattern="\d{4}-\d{2}-\d{2}"
                                               data-parsley-pattern-message="生日必须是yyyy-MM-dd的格式"
                                               name="birthdayString" id="birthday" placeholder="格式：yyyy-MM-dd"
                                        >
                                    </div><!-- /.col -->
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <@departmentSelect.departmentSelect departmentList=departmentlist departmentControlName="departmentId" xiControlName="xiId" classControlName="classId"
                                    selectedDepartmentId=0  selectedXiId=0 selectedClassId=0 ></@departmentSelect.departmentSelect>

                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <@branchSelect.branchSelect departmentList=departmentlist  departmentControlName="departmentId" branchControlName="branchId"
                                    selectedDepartmentId=0  selectedBranchId=0 ></@branchSelect.branchSelect>

                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <@nationSelect.nationSelect nationList=nationlist  nationControlName="nationId"
                                    nationControlName="nationId" selectedNationId=0></@nationSelect.nationSelect>

                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <@areaSelect.areaSelect provinceList=provincelist  provinceControlName="provinceId" cityControlName="cityId"
                                    areaControlName="areaCode"
                                    selectedProvinceId=""  selectedCityId="" selectedAreaId=""></@areaSelect.areaSelect>

                                </div>
                            </div>

                            <#--<div class="form-group">-->
                                <#--<label class="label-checkbox">-->
                                    <#--<input type="checkbox" class=" parsley-validated"-->
                                           <#--data-parsley-required="true"-->
                                           <#--data-parsley-required-message="倾"-->
                                    <#--/>-->
                                    <#--<span class="custom-checkbox info bounceIn animation-delay6"></span>-->
                                    <#--我同意服务使用协议。-->
                                <#--</label>-->
                            <#--</div><!-- /form-group &ndash;&gt;-->

                            <div class="form-group">
                                <div class="col-md-12">
                                    <div class="controls">
                                        已有账号？ <a href="${basePath}/main/login" class="primary-font login-link">登录</a>
                                    </div>
                                    <div class="controls text-right">
                                        <a class="btn btn-success btn-sm bounceIn animation-delay7 "
                                           id="submitButton_student" href="javascript:;">
                                            <i class="fa fa-plus-circle"></i> 注册</a>
                                    </div>
                                </div>
                            </div><!-- /form-group -->
                        </form>
                    </div>

                    <div class="tab-pane fade" id="teacher">
                        <form class="form-login-studnet">
                            <div class="form-group">
                                <label>账号</label>
                                <input type="text" name="account" placeholder="Username" class="form-control input-sm bounceIn animation-delay2 parsley-validated"
                                       data-parsley-trigger="focusout"
                                       data-parsley-required="true"
                                       data-parsley-required-message="用户名不可为空"
                                >
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label>密码</label>
                                <input type="password" name="password" placeholder="Password" class="form-control input-sm bounceIn animation-delay3 parsley-validated"
                                       data-parsley-required="true"
                                       data-parsley-trigger="focusout"
                                       data-parsley-required-message="密码不可为空"
                                       data-parsley-minlength="6"
                                       data-parsley-minlength-message="密码位数不可少于6位"
                                >
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <div class="col-md-6">
                                    <label>姓名</label>
                                    <input type="text" name="name" placeholder="Name" class="form-control input-sm bounceIn animation-delay4  parsley-validated"
                                           data-parsley-required="true"
                                           data-parsley-required-message="姓名不可为空"
                                    >
                                </div>
                                <div class="col-md-6">
                                    <label>手机</label>
                                    <input type="text" name="phone" placeholder="telephone"
                                           class="form-control input-sm bounceIn animation-delay5  parsley-validated"
                                           data-parsley-pattern="/^[1][0-9]{10}$/"
                                    >
                                </div>
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2">性别</label>
                                    <div class="col-md-10">
                                        <label class="label-radio inline">
                                            <input type="radio" name="gender" value="0" >
                                            <span class="custom-radio"></span>
                                            男
                                        </label>
                                        <label class="label-radio inline">
                                            <input type="radio" name="gender" value="1"
                                                   data-parsley-required="true" data-parsley-required-message="请选择性别">
                                            <span class="custom-radio"></span>
                                            女
                                        </label>
                                    </div><!-- /.col -->
                                </div>
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <div class="col-md-12">
                                    <@branchSelect.branchSelect departmentList=departmentlist  departmentControlName="departmentId1" branchControlName="branchId1"
                                    selectedDepartmentId=0  selectedBranchId=0 ></@branchSelect.branchSelect>

                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-12">
                                    <div class="controls">
                                        已有账号？ <a href="${basePath}/main/login" class="primary-font login-link">登录</a>
                                    </div>
                                    <div class="controls text-right">
                                        <a class="btn btn-success btn-sm bounceIn animation-delay7 "
                                           id="submitButton_teacher" href="javascript:;">
                                            <i class="fa fa-plus-circle"></i> 注册</a>
                                    </div>
                                </div>
                            </div><!-- /form-group -->
                        </form>
                    </div>
                </div>
            </div>
        </div><!-- /panel -->
    </div><!-- /login-widget -->
</div><!-- /login-wrapper -->

<@master.js>

<script language="javascript">
    $("#birthday").datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        yearRange:'-70:+70',
        maxDate:new Date()
    });
    $("#submitButton_studnet").click(function(){

        if($('#studnet form').parsley().validate()){
            $.ajax({
                cache: true,
                type: "POST",
                url:"${basePath}/main/register",
                data:$('#studnet form').serialize()+"&type=0",
                async: false,
                error: function(data) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        alertify.alert("注册成功.注意：学生注册后需要审核审核后即可登录",function () {
                            location.reload();
                        });
                    <#--<#if backurl??>-->
                    <#--location.href="${backurl!}";-->
                    <#--<#else>-->
                    <#--location.href="${basePath}/main/index";-->
                    <#--</#if>-->
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        }
    });
    $("#submitButton_teacher").click(function(){

        if($('#teacher form').parsley().validate()){
            $.ajax({
                cache: true,
                type: "POST",
                url:"${basePath}/main/register",
                data:$('#teacher form').serialize()+"&type=1",
                async: false,
                error: function(data) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function(data) {
                    if(data.success){
                        alertify.alert("注册成功.注意：教师注册后需要审核审核后即可登录",function () {
                            location.reload();
                        });
                    <#--<#if backurl??>-->
                    <#--location.href="${backurl!}";-->
                    <#--<#else>-->
                    <#--location.href="${basePath}/main/index";-->
                    <#--</#if>-->
                    }
                    else{
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        }
    });
</script>
</@master.js>

</@master.masterBlank>