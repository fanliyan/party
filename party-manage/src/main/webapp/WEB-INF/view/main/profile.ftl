<#import "/master/master-frame.ftl" as master />
<#import "/control/common/branchSelect.ftl" as branchSelect />

<@master.masterFrame>
<div class="row">
	<div class="col-md-12 col-sm-12">

    <div class="panel panel-default">
	</div><!-- /.col -->
	<div class="col-md-12 col-sm-12">
		<div class="tab-content">
			<div class="tab-pane fade active in" id="edit">
				<div class="panel panel-default">
					<form class="form-horizontal form-border" name="editProfileFrom" id="editProfileFrom" method="post">
						<div class="panel-heading">
							基本信息
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="control-label col-md-2">姓名</label>
								<div class="col-md-10">
									<input type="text" class="form-control input-sm" data-parsley-required="true" data-parsley-required-message="请输入真实姓名" data-parsley-length="[2,8]" data-parsley-length-message="真实姓名必须在2-8位之间" placeholder="请输入真实姓名" value="${loginUser.name!}" name="userName">
								</div><!-- /.col -->
							</div><!-- /form-group -->
							<div class="form-group">
								<label class="control-label col-md-2">生日</label>
								<div class="col-md-10">
									<input type="text" class="form-control input-sm" data-parsley-pattern="\d{4}-\d{2}-\d{2}" data-parsley-pattern-message="生日必须是yyyy-MM-dd的格式" name="birthDay" id="birthDay" placeholder="格式：yyyy-MM-dd"  value="<#if loginUser.birthday??>${loginUser.birthday}</#if>">
								</div><!-- /.col -->
							</div><!-- /form-group -->
							<div class="form-group">
								<label class="control-label col-md-2">性别</label>
								<div class="col-md-10">
									<label class="label-radio inline">
										<input type="radio" name="gender" value="M" <#if (loginUser.gender)?? && loginUser.gender == "M">checked="checked"</#if>>
										<span class="custom-radio"></span>
										男
									</label>
									<label class="label-radio inline">
										<input type="radio" name="gender" value="F" data-parsley-required="true" data-parsley-required-message="请选择性别" <#if (loginUser.gender)?? && loginUser.gender == "F">checked="checked"</#if>>
										<span class="custom-radio"></span>
										女
									</label>
								</div><!-- /.col -->
							</div><!-- /form-group -->

                            <div class="form-group">
                                <div class="col-md-2"></div>
                                <div class="col-md-10">
                                    <@branchSelect.branchSelect departmentList=departmentlist  departmentControlName="departmentId" branchControlName="branchId"
                                    selectedDepartmentId=(loginUser.departmentId)!0  selectedBranchId=(loginUser.branchId)!0 ></@branchSelect.branchSelect>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2">教师级别</label>
                                <div class="col-md-10">
                                    <select class="form-control col-md-10" name="departmentType">
                                        <option value="">请选择</option>
                                        <option value="0" <#if loginUser.departmentType==0>selected</#if>>系</option>
                                        <option value="1" <#if loginUser.departmentType==1>selected</#if>>院</option>
                                        <option value="2" <#if loginUser.departmentType==2>selected</#if>>校</option>
                                        <option value="3" <#if loginUser.departmentType==3>selected</#if>>机关</option>

                                    </select>
                                </div>
                            </div>

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
</div><!-- /.row -->	
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