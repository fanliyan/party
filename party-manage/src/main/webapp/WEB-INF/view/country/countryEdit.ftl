<#import "/master/master-frame.ftl" as master />
<#import "/control/common/purposeSelect.ftl" as purposeSelect>
<@master.masterFrame pageTitle=["系统管理","国家管理","编辑国家"]>
<div class="panel panel-default">
	<form class="form-horizontal no-margin " id="companyForm" >
		<div class="panel-heading">
			国家基本信息
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-2">国家名称</label>
						<div class="col-md-10">
							<input name="countryName" class="form-control" type="text" placeholder="请输入国家名称"
							 data-parsley-trigger="blur"
							 data-parsley-required="true"
							 data-parsley-required-message="国家名称不可为空"
							 value="${country.countryName}"
							/>
							<input type="hidden" name="countryId" value="${country.countryId}"/>
						</div><!-- /.col -->
					</div>
					
					<div class="form-group">
						<label class="control-label col-md-2">英文名称</label>
						<div class="col-md-10">
							<input name="eName" class="form-control" type="text" placeholder="可空,必须全英文,字符长度3-100"
							 data-parsley-pattern="^(?!\\s)[a-zA-Z\\s]{3,100}$"
							 data-parsley-pattern-message="必须全为英文,长度3-100"
							 value="${country.eName!}"/>
						</div><!-- /.col -->
					</div>
					<div class="form-group">
						<label class="control-label col-md-2">所属洲</label>
						<div class="col-md-10">
							<select class="form-control chzn-select" name="continentId" id="" placeholder="请选择所属洲">
								<option value="">全部</option>
								<#if continentModels??>
								<#list continentModels as continentModel>
									<option value="${continentModel.continentId}" <#if country.continentId ?? && country.continentId==continentModel.continentId>selected="selected"</#if>>${continentModel.continentName}</option>
								</#list>
								</#if>
							</select>
						</div><!-- /.col -->
					</div>
					<div class="form-group">
						<div class="col-md-2"></div>
						<div class="col-md-10">
							<label class="label-checkbox pull-left">
								<input type="checkbox" name="isMigrant" <#if country.isMigrant>checked="checked"</#if>>
								<span class="custom-checkbox"></span>
								是否移民国家 (勾选后，会在网站的移民目的选项中展示)
							</label>
						</div>
					</div><!-- /form-group -->
				</div><!-- /.col -->
				<div class="col-md-6">
					<label class="control-label col-md-2">国旗</label>
					<div class="col-md-4">
						<div id="flagPicDiv" class="col-md-8">
						<#if country.countryInfo?? && country.countryInfo.flagPic ?? && country.countryInfo.flagPic!="">
							<img src="${(country.countryInfo.flagPic)!}@90h_160w_1e_1c" alt="国旗" class="img-thumbnail"/>
						<#else>
							暂无国旗图片
						</#if>
						</div>
					</div><!-- /.col -->
						<div class="col-md-4">
							<a href="#formModal" class="btn btn-success" data-toggle="modal">上传国旗图片</a>
							<input name="flagPic" id="flagPic" type="hidden" value="${(country.countryInfo.flagPic)!}"/>
						</div>
				</div>
			</div><!-- /.row -->
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-1 control-label">移民目的</label>
					<div class="col-md-11">
						<@purposeSelect.purposeSelect purposeList=purposeList selectedValues=country.purposeIds controlName="purposeIds"/>
					</div><!-- /.col -->
				</div>
			</div><!-- /row -->
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-1 control-label">特点</label>
					<div class="col-md-11">
						<textarea id="characteristic" name="characteristic"  class="wysihtml5">${(country.countryInfo.characteristic)!}</textarea>
					</div><!-- /.col -->
				</div>
			</div><!-- /row -->
			<div class="row">
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">热度</label>
						<div class="col-md-8">
							<input name="scoreHot" class="form-control" type="text" placeholder="必填,不大于5,支持一位小数"
							 data-parsley-trigger="blur"
							 data-parsley-required="true"
							 data-parsley-pattern="^[0-5]{1}(\.[0-9]{1})?$"
							 data-parsley-pattern-message="分数不大于5,支持一位小数"
							 data-parsley-required-message="热度分数不可为空"
							 value="${(country.countryInfo.scoreHot)!}"
							/>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">环境</label>
						<div class="col-md-8">
							<input name="scoreEnvironment" class="form-control" type="text" placeholder="必填,不大于5,支持一位小数"
							 data-parsley-trigger="blur"
							 data-parsley-required="true"
							 data-parsley-pattern="^[0-5]{1}(\.[0-9]{1})?$"
							 data-parsley-pattern-message="分数不大于5,支持一位小数"
							 data-parsley-required-message="环境分数不可为空"
							 value="${(country.countryInfo.scoreEnvironment)!}"
							/>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">福利</label>
						<div class="col-md-8">
							<input name="scoreWelfare" class="form-control" type="text" placeholder="必填,不大于5,支持一位小数"
							 data-parsley-trigger="blur"
							 data-parsley-required="true"
							 data-parsley-pattern="^[0-5]{1}(\.[0-9]{1})?$"
							 data-parsley-pattern-message="分数不大于5,支持一位小数"
							 data-parsley-required-message="福利分数不可为空"
							 value="${(country.countryInfo.scoreWelfare)!}"
							/>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">教育</label>
						<div class="col-md-8">
							<input name="scoreEducation" class="form-control" type="text" placeholder="必填,不大于5,支持一位小数"
							 data-parsley-trigger="blur"
							 data-parsley-required="true"
							 data-parsley-pattern="^[0-5]{1}(\.[0-9]{1})?$"
							 data-parsley-pattern-message="分数不大于5,支持一位小数"
							 data-parsley-required-message="教育分数不可为空"
							 value="${(country.countryInfo.scoreEducation)!}"
							/>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">投资</label>
						<div class="col-md-8">
							<input name="scoreInvestment" class="form-control" type="text" placeholder="必填,不大于5,支持一位小数"
							 data-parsley-trigger="blur"
							 data-parsley-required="true"
							 data-parsley-pattern="^[0-5]{1}(\.[0-9]{1})?$"
							 data-parsley-pattern-message="分数不大于5,支持一位小数"
							 data-parsley-required-message="投资分数不可为空"
							 value="${(country.countryInfo.scoreInvestment)!}"
							/>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">就业</label>
						<div class="col-md-8">
							<input name="scoreJob" class="form-control" type="text" placeholder="必填,不大于5,支持一位小数"
							 data-parsley-trigger="blur"
							 data-parsley-required="true"
							 data-parsley-pattern="^[0-5]{1}(\.[0-9]{1})?$"
							 data-parsley-pattern-message="分数不大于5,支持一位小数"
							 data-parsley-required-message="就业分数不可为空"
							 value="${(country.countryInfo.scoreJob)!}"
							/>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
			</div>
			<div class="row">
				<div class="col-md-12 form-group">
					<label class="control-label col-md-1">分娩补贴</label>
					<div class="col-md-11">
						<input name="fertilitySubsidy" class="form-control" type="text" placeholder="请输入分娩补贴"
						 value="${(country.countryInfo.fertilitySubsidy)!}"
						/>
					</div><!-- /.col -->
				</div>
			</div>
		</div>
		<#if country.attrModels??>
			<#list country.attrModels as attr>
			<div class="panel-heading">
				${attr.attrName}
			</div>
			<div class="panel-body">
				<div class="form-group">
					<div class="col-md-12">
						<input type="hidden" name="attrId" value="${attr.attrId}"/>
						<textarea id="attrValue${attr.attrId}" name="attrValue${attr.attrId}" rows=5 class="wysihtml5" placeholder="请输入${attr.attrName}描述">${(attr.valueModel.attrValue)!}</textarea>
					</div><!-- /.col -->
				</div><!-- /form-group -->
				
				<#if attr.childAttrModels??>
				<#list attr.childAttrModels as childAttr>
				<div class="form-group">
					<label class="col-md-2 control-label">
						<input type="hidden" name="attrId" value="${childAttr.attrId}"/>
						${childAttr.attrName}
					</label>
					<div class="col-md-10">
						<textarea id="attrValue${childAttr.attrId}" name="attrValue${childAttr.attrId}" class="wysihtml5" rows="3" placeholder="请输入${childAttr.attrName}描述">${(childAttr.valueModel.attrValue)!}</textarea>
					</div><!-- /.col -->
				</div><!-- /form-group -->
				</#list>
				</#if>
			</div>
			</#list>
		</#if>
		<div class="panel-footer text-center">
			<button class="btn btn-success" type="button" id="submitButton">保存</button>
			<button class="btn btn-default" type="button" onclick="javascript:history.go(-1);">返回</button>
		</div>
	</form>
	<div class="modal fade" id="formModal" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4>上传国旗图片</h4>
				</div>
				<div class="modal-body">
					<div class="panel panel-default">
						<div class="panel-body">
							<form class="form-horizontal form-border">
								<div class="form-group">
									<div class="col-lg-12">
										<div class="upload-file">
											<input type="file" name="file" id="imgUpload" class="upload-demo"/>
											<label data-title="选择图片" for="imgUpload">
												<span data-title="未选择图片"></span>
											</label>
										</div>
									</div><!-- /.col -->
								</div><!-- /form-group -->
								<div class="form-group text-right">
									<a href="javascript:ajaxFileUpload();" class="btn btn-success">上传</a>
									<a href="javascript:cancelBtn();" class="btn btn-success">取消</a>
								</div><!-- /form-group -->
							</form>			
						</div>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
</div>

<script src='${basePath}/resources/js/ajaxfileupload.js'></script>
<script language="javascript">
$(function(){
	$('.wysihtml5').each(function(){
		UE.getEditor($(this).attr("id"),{
		    toolbars: [edittoolbars],
		    elementPathEnabled:false,
		    autoHeightEnabled:false,
		    initialFrameHeight:100,
		    initialFrameWidth:"100%",
		    minFrameWidth:100
		});
	});
});

$("#submitButton").click(function(){
	if($('#companyForm').parsley().validate()){
		$.submitCompany();
	}
});

$.submitCompany = function(){
	$.ajax({
        cache: false,
        type: "POST",
        url:"${basePath}/country/save",
        data:$('#companyForm').serialize(),
        async: false,
        error: function(request) {
            alertify.alert("错误：服务器异常！");
        },
        success: function(data) {
        	if(data.success){   
            	alertify.alert("操作成功！",function(e){location.href="${basePath}/country/list";});
	        }   
	        else{   
            	alertify.alert("错误:" + data.message);
	        }   
        }
    });
}

function cancelBtn(){
	$("#imgUpload").val("");
	$('#formModal').modal('hide');
}
function ajaxFileUpload() {
	var img=$("#imgUpload").val();
	if(img != ''){
		img=img.substring(img.lastIndexOf(".")+1).toLowerCase();
		if(img!='jpg' && img != 'jpeg' && img != 'png'){
			alertify.alert("图片格式不符合要求!只能选择jpg,png格式的图片");
			return;
		}
	}else{
		return;
	}
	$.ajaxFileUpload({
		url: '${basePath}/main/imgupload',
		type: 'post',
		secureuri: false, //一般设置为false
		fileElementId: 'imgUpload', // 上传文件的id、name属性名
		dataType: 'json', //返回值类型，一般设置为json、application/json
		success: function(data, status){
			if(data.success){
				$("#imgUpload").val("");
				$('#formModal').modal('hide');
				$("#flagPic").val(data.imageUrl);
				var htm="<img src='"+data.imageUrl+"@90h_160w_1e_1c' alt='国旗' class='img-thumbnail'/>";
				$("#flagPicDiv").html(htm);
			}else{
				alertify.alert("图片上传出错了");
			}
		},
		error: function(data, status, e){ 
			alertify.alert("图片上传出错了");
		}
	});
}
</script>
</@master.masterFrame>