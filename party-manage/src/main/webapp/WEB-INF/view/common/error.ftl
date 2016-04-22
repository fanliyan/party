<#assign basePath=springMacroRequestContext.contextPath>
<#import "/master/master-blank.ftl" as master />
<@master.masterBlank bodyClass="">
<div id="wrapper">
	<div class="padding-md" style="margin-top:50px;">
		<div class="row">
			<div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 text-center">
				<h4 class="text-danger"><i class="fa fa-warning"></i> 出错了</h4>
				<br /><br />
				<p class="font-14">${message!""}</p>
				<br /><br />
				
				<#if showBackButton?? && showBackButton>
				<a class="btn btn-success m-bottom-sm" href="${basePath}"><i class="fa fa-chevron-left"></i> 后退</a>
				<#else>
				<a class="btn btn-success m-bottom-sm" href="${basePath}/main/index"><i class="fa fa-home"></i> 回首页</a>

				</#if>
				<a class="btn btn-success m-bottom-sm" href="mailto:liwei@htke.com"><i class="fa fa-envelope"></i> 联系技术部</a>
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.padding-md -->
</div><!-- /wrapper -->
</@master.masterBlank>