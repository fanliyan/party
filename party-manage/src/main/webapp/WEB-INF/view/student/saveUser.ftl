<#import "/master/master-frame.ftl" as master />
<#import "/control/common/areaSelect.ftl" as areaSelect />
<#import "/control/common/nationSelect.ftl" as nationSelect />
<#import "/control/common/departmentSelect.ftl" as departmentSelect />
<#import "/control/common/branchSelect.ftl" as branchSelect />

<@master.masterFrame pageTitle=["学生管理","学生","编辑"]>

<#assign isTeacher=user.type==1>

<div class="padding-md col-md-10 col-md-offset-1">
	<div class="row">
		<div class="panel panel-default">
			<div class="panel-heading">基本资料</div>
			<form class="form-horizontal form-border" id="userForm" >
			<div class="panel-body">
                <div class="row">
                    <input type="hidden" name="id" value="${user.id}">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">姓名</label>
                            <div class="col-md-8 ">
                                <input name="name" type="text" class="form-control input-sm" id="" placeholder="必填,字符最大长度20"
                                       data-parsley-trigger="blur"
                                       data-parsley-required="true"
                                       data-parsley-required-message="姓名不可为空"
                                       value="${(user.name)!}"
                                />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">性别</label>
                            <div class="col-md-8">
                                <label class="label-radio inline">
                                    <input type="radio" name="gender" value="0" <#if (user.gender)??&&!user.gender>checked="checked"</#if>>
                                    <span class="custom-radio"></span>
                                    男
                                </label>
                                <label class="label-radio inline">
                                    <input type="radio" name="gender" value="1" <#if (user.gender)??&&user.gender>checked="checked"</#if>>
                                    <span class="custom-radio"></span>
                                    女
                                </label>
                            </div>
                        </div>
                    </div>


                    <#if !isTeacher>
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="control-label col-md-4">出生年月</label>
                            <div class="col-md-8">
                                <input type="text" class="form-control input-sm" data-parsley-pattern="\d{4}-\d{2}-\d{2}" data-parsley-pattern-message="生日必须是yyyy-MM-dd的格式"
                                       name="brithdayString" id="birthDay" placeholder="格式：yyyy-MM-dd"  value="${(user.birthday?string('yyyy-MM-dd'))!}">
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class=" control-label text-right">身份证</label>
                            <div class="">
                                <input name="idCard" type="text" class="form-control input-sm" value="${(user.idCard)!}"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <@nationSelect.nationSelect nationList=nationlist  nationControlName="nationId"
                        nationControlName="nationId" selectedNationId=(user.nationId)!0 ></@nationSelect.nationSelect>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class=" control-label text-right">手机</label>
                            <div class="">
                                <input type="text" name="phone" placeholder="telephone"
                                       class="form-control input-sm"
                                       data-parsley-pattern="/^[1][0-9]{10}$/"
                                       value="${(user.phone)!}"
                                >
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <@areaSelect.areaSelect provinceList=provincelist  provinceControlName="provinceId" cityControlName="cityId"
                        areaControlName="areaCode"
                        selectedProvinceId=""  selectedCityId="" selectedAreaId=user.areaCode!"" ></@areaSelect.areaSelect>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class=" control-label text-right">学号</label>
                            <div class="">
                                <input type="text" name="studentCode" placeholder="Student Code"
                                       class="form-control input-sm parsley-validated"
                                       data-parsley-required="true"
                                       data-parsley-required-message="学号不可为空"
                                       data-parsley-pattern="/^\d+$/"
                                       value="${(user.studentCode)!}"
                                >
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8 col-sm-8">
                        <@departmentSelect.departmentSelect departmentList=departmentlist departmentControlName="departmentId" xiControlName="xiId" classControlName="classId"
                        selectedDepartmentId=0  selectedXiId=0 selectedClassId=(user.classId)!0 ></@departmentSelect.departmentSelect>

                    </div>
                </div>
                </#if>
                <hr>
                    <div class="row">
                        <div class="col-md-8 col-sm-8">
                            <@branchSelect.branchSelect departmentList=departmentlist  departmentControlName="departmentId1" branchControlName="branchId"
                            selectedDepartmentId=0  selectedBranchId=(user.branchId)!0 ></@branchSelect.branchSelect>
                        </div>
                        <div class="col-md-4 col-sm-4">
                            <div class="form-group">
                                <label class=" control-label text-right">类型</label>
                                <div class="">
                                    <select class="form-control" name="type" >
                                        <option value="0" <#if user.type==0>selected</#if>>学生</option>
                                        <option value="1" <#if user.type==1>selected</#if>>老师</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                <hr>
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="control-label col-md-4">重点积极分子时间</label>
                            <div class="col-md-8">
                                <input type="text" class="form-control input-sm"
                                       data-parsley-pattern="\d{4}-\d{2}-\d{2}"
                                       data-parsley-pattern-message="必须是yyyy-MM-dd的格式"
                                       name="keyActiveMemberTimeString" id="keyActiveMemberTime" placeholder="格式：yyyy-MM-dd"
                                       value="${(user.keyActiveMemberTime?string('yyyy-MM-dd'))!}">
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="control-label col-md-4">预备党员时间</label>
                            <div class="col-md-8">
                                <input type="text" class="form-control input-sm"
                                       data-parsley-pattern="\d{4}-\d{2}-\d{2}"
                                       data-parsley-pattern-message="必须是yyyy-MM-dd的格式"
                                       name="probationaryMemberTimeString" id="probationaryMemberTime" placeholder="格式：yyyy-MM-dd"
                                       value="${(user.probationaryMemberTime?string('yyyy-MM-dd'))!}">
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="form-group">
                            <label class="control-label col-md-4">正式党员时间</label>
                            <div class="col-md-8">
                                <input type="text" class="form-control input-sm"
                                       data-parsley-pattern="\d{4}-\d{2}-\d{2}"
                                       data-parsley-pattern-message="必须是yyyy-MM-dd的格式"
                                       name="cardCarryingMemberTimeString" id="cardCarryingMemberTime" placeholder="格式：yyyy-MM-dd"
                                       value="${(user.cardCarryingMemberTime?string('yyyy-MM-dd'))!}">
                            </div><!-- /.col -->
                        </div><!-- /form-group -->
                    </div>
                </div>

			</div>
			<div class="panel-footer text-center">
				<button type="button" class="btn btn-success" onclick="submitr();">保存</button>
				<button type="button" class="btn btn-default" onclick="javascript:history.go(-1);">返回</button>
			</div>
			</form>
		</div>
	</div>
</div>
<script language="javascript">
    $(document).ready(function(){
        $("#birthDay,#keyActiveMemberTime,#probationaryMemberTime,#cardCarryingMemberTime").datepicker({
            dateFormat: 'yy-mm-dd',
            changeMonth: true,
            changeYear: true,
            yearRange:'-70:+70',
            maxDate:new Date()
        });
        <#if msg??>
            alertify.alert('${msg}');
        </#if>
    });
	function submitr(){
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/student/saveUser",
			data:$('#userForm').serialize(),
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					alertify.alert("操作成功！",function(e){location.reload();});
				}
				else{
					alertify.alert("错误:" + data.message);
				}   
			}
		});
	}
</script>
</@master.masterFrame>