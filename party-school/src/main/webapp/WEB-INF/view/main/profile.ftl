<#import "/master/master-frame.ftl" as master />
<#import "/control/common/areaSelect.ftl" as areaSelect />
<#import "/control/common/nationSelect.ftl" as nationSelect />
<#import "/control/common/branchSelect.ftl" as branchSelect />
<#import "/control/common/departmentSelect.ftl" as departmentSelect />

<@master.masterFrame>

<#assign isTearcher=loginUser.type==1>

<br><br><br>

	<div class="col-md-10 col-md-offset-1">
		<div class="tab-content">
			<div class="tab-pane fade active in" id="edit">
				<div class="panel panel-default">
					<form class="form-horizontal form-border" name="editProfileFrom" id="editProfileFrom" method="post">
						<div class="panel-heading">
							基本信息
						</div>
						<div class="panel-body">
                            <input type="hidden" name="id" value="${loginUser.id}">
							<div class="form-group">
                                <div class="col-md-3 col-sm-3">
                                    <label class="control-label col-md-2">姓名</label>
                                    <div class="col-md-10">
                                        <input type="text" class="form-control input-sm" data-parsley-required="true"
                                               data-parsley-required-message="请输入真实姓名" data-parsley-length="[2,8]"
                                               data-parsley-length-message="真实姓名必须在2-8位之间" placeholder="此名称不会在网站中显示"
                                               value="${loginUser.name!}" name="name">
                                    </div><!-- /.col -->
                                </div>
                                <div class="col-md-3 col-sm-3">
                                    <label class="control-label col-md-2">性别</label>
                                    <div class="col-md-10">
                                        <label class="label-radio inline">
                                            <input type="radio" name="gender" value="0" <#if (loginUser.gender)?? && !loginUser.gender>checked="checked"</#if>>
                                            <span class="custom-radio"></span>
                                            男
                                        </label>
                                        <label class="label-radio inline">
                                            <input type="radio" name="gender" value="1" data-parsley-required="true" data-parsley-required-message="请选择性别"
                                                   <#if (loginUser.gender)?? && loginUser.gender>checked="checked"</#if>>
                                            <span class="custom-radio"></span>
                                            女
                                        </label>
                                    </div><!-- /.col -->
                                </div>

                                <#if !isTearcher>
                                <div class="col-md-3 col-sm-3">
                                    <label class="control-label col-md-2">出生年月</label>
                                    <div class="col-md-10">
                                        <input type="text" class="form-control input-sm" data-parsley-pattern="\d{4}-\d{2}-\d{2}"
                                               data-parsley-pattern-message="生日必须是yyyy-MM-dd的格式" name="birthday" id="birthDay"
                                               placeholder="格式：yyyy-MM-dd"  value="${(loginUser.birthday?string('yyyy-MM-dd'))!}">
                                    </div><!-- /.col -->
                                </div>
                                <div class="col-md-3 col-sm-3">
                                    <label class="control-label col-md-2">身份证</label>
                                    <div class="col-md-10">
                                        <input type="text" name="idCard" placeholder="ID-card" class="form-control input-sm parsley-validated"
                                           data-parsley-required="true"
                                           data-parsley-required-message="身份证不可为空"
                                           data-parsley-pattern="/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/"
                                           value="${(loginUser.idCard)!}"
                                        >
                                    </div>
                                </div>
                                </#if>
							</div><!-- /form-group -->

                            <#if !isTearcher>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <@departmentSelect.departmentSelect departmentList=departmentlist departmentControlName="departmentId" xiControlName="xiId" classControlName="classId"
                                    selectedDepartmentId=0  selectedXiId=0 selectedClassId=(loginUser.classId)!0 ></@departmentSelect.departmentSelect>

                                </div>
                            </div>
							<div class="form-group">
                                <div class="col-md-9 col-sm-9">
                                    <@areaSelect.areaSelect provinceList=provincelist  provinceControlName="provinceId" cityControlName="cityId"
                                    areaControlName="areaCode"
                                    selectedProvinceId=""  selectedCityId="" selectedAreaId=loginUser.areaId!"" ></@areaSelect.areaSelect>
                                </div>
                                <div class="col-md-3 col-sm-3">
                                    <@nationSelect.nationSelect nationList=nationlist  nationControlName="nationId"
                                    nationControlName="nationId" selectedNationId=(loginUser.nationId)!0></@nationSelect.nationSelect>
                                </div>
							</div><!-- /form-group -->
                            </#if>
                            <div class="form-group">
                                <div class="col-md-9 col-sm-9">
                                    <@branchSelect.branchSelect departmentList=departmentlist  departmentControlName="departmentId1" branchControlName="branchId"
                                    selectedDepartmentId=0  selectedBranchId=(loginUser.branchId)!0 ></@branchSelect.branchSelect>

                                </div>
                            </div><!-- /form-group -->
							<div class="form-group">

							</div><!-- /form-group -->
						</div>
						<div class="panel-footer">
							<div class="text-right">
								<button class="btn btn-sm btn-success" type="button" id="btnEditProfile">更新</button>
								<button class="btn btn-sm btn-success" type="reset">重置</button>
							</div>
						</div>
					</form>
				</div><!-- /panel -->
				
			</div><!-- /tab2 -->			
		</div><!-- /tab-content -->
	</div><!-- /.col -->

<script language="javascript">

$(document).ready(function(){
	$("#birthDay").datepicker({
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

$("#btnEditProfile").click(function(){
	if($('#editProfileFrom').parsley().validate()){
		$.ajax({
	        cache: true,
	        type: "POST",
	        url:"${basePath}/main/updateprofile",
	        data:$('#editProfileFrom').serialize(),
	        async: false,
	        error: function(request) {
	            alertify.error("错误：服务器异常！");
	        },
	        success: function(data) {
	        	if(data.success){   
	        		alertify.alert("资料修改成功！",function(e){location.href="${basePath}/main/index";});
		        }   
		        else{   
	            	alertify.alert("错误:" + data.message);
		        }   
	        }
	    });
	}
});
</script>

</@master.masterFrame>