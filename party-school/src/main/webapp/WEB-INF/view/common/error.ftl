<#assign basePath=springMacroRequestContext.contextPath>
<#import "/master/master-blank.ftl" as master />
<@master.masterBlank bodyClass="">
<div id="wrapper">
    <div class="padding-md" style="margin-top:50px;">
        <div class="row">
            <div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 text-center">
                <h4 class="text-danger"><i class="fa fa-warning"></i> 出错了</h4>
                <#--<h1 class="m-top-none error-heading">${message}</h1>-->
                <div>${message!}</div>
                <#--<div class="m-bottom-md">Try searching for the page here</div>-->
                <#--<div class="input-group m-bottom-md">-->
                    <#--<input type="text" class="form-control input-sm" placeholder="search here...">-->
						<#--<span class="input-group-btn">-->
							<#--<button class="btn btn-default btn-sm" type="button"><i class="fa fa-search"></i></button>-->
						<#--</span>-->
                <#--</div><!-- /input-group &ndash;&gt;-->
                <#if showBackButton??&&showBackButton></#if>
                    <a class="btn btn-success m-bottom-sm" href="${basePath}/main/index"><i class="fa fa-home"></i> 返回</a>

                <#--<a class="btn btn-success m-bottom-sm" href="contact.html"><i class="fa fa-envelope"></i> Contact Us</a>-->
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.padding-md -->
</div><!-- /wrapper -->
</@master.masterBlank>