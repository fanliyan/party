<#import "/master/master-frame.ftl" as master />
<@master.masterFrame pageTitle=["系统管理","国家管理","编辑国家"]>
<div class="panel panel-default">
	<form class="form-horizontal no-margin" id="companyForm" >
		<div class="panel-heading">
			国家基本信息
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-2">国家名称</label>
						<div class="col-md-10">
							<p class="form-control-static">${country.countryName}</p>
						</div><!-- /.col -->
					</div>
					
					<div class="form-group">
						<label class="control-label col-md-2">英文名称</label>
						<div class="col-md-10">
							<p class="form-control-static">${country.eName!}</p>
						</div><!-- /.col -->
					</div>
					<div class="form-group">
						<div class="col-md-2"></div>
						<div class="col-md-10">
							<p class="form-control-static"><#if country.isMigrant>移民国家<#else>暂时不是移民国家</#if></p>
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
				</div>
			</div><!-- /.row -->
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-1 control-label">特点</label>
					<div class="col-md-11">
						<p class="form-control-static">${(country.countryInfo.characteristic)!}</p>
					</div><!-- /.col -->
				</div>
			</div><!-- /row -->
			<div class="row">
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">热度</label>
						<div class="col-md-8">
							<p class="form-control-static">${(country.countryInfo.scoreHot)!} 分</p>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">环境</label>
						<div class="col-md-8">
							<p class="form-control-static">${(country.countryInfo.scoreEnvironment)!} 分</p>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">福利</label>
						<div class="col-md-8">
							<p class="form-control-static">${(country.countryInfo.scoreWelfare)!} 分</p>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">教育</label>
						<div class="col-md-8">
							<p class="form-control-static">${(country.countryInfo.scoreEducation)!} 分</p>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">投资</label>
						<div class="col-md-8">
							<p class="form-control-static">${(country.countryInfo.scoreInvestment)!} 分</p>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">就业</label>
						<div class="col-md-8">
							<p class="form-control-static">${(country.countryInfo.scoreJob)!} 分</p>
						</div><!-- /.col -->
					</div>
				</div><!-- /.col -->
			</div>
			<div class="row">
				<div class="col-md-12 form-group ">
					<label class="control-label col-md-1">分娩补贴</label>
					<div class="col-md-11">
						<p class="form-control-static">${(country.countryInfo.fertilitySubsidy)!}</p>
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
					<div class="col-md-12 border-bottom">
						<p class="form-control-static">${(attr.valueModel.attrValue)!}</p>
					</div><!-- /.col -->
				</div><!-- /form-group -->
				
				<#if attr.childAttrModels??>
				<#list attr.childAttrModels as childAttr>
				<div class="form-group">
					<label class="col-md-2 control-label">
						${childAttr.attrName}
					</label>
					<div class="col-md-10">
						<p class="form-control-static">${(childAttr.valueModel.attrValue)!}</p>
					</div><!-- /.col -->
				</div><!-- /form-group -->
				</#list>
				</#if>
			</div>
			</#list>
		</#if>
		<div class="panel-footer text-center">
			<button class="btn btn-default" type="button" onclick="javascript:history.go(-1);">返回</button>
		</div>
	</form>
</div>
</@master.masterFrame>