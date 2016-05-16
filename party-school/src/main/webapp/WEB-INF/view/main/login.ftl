<#import "/master/master-blank.ftl" as master />

<@master.masterBlank title="网上党校-登录">

<div class="login-wrapper">
    <div class="text-center">
        <h2 class="fadeInUp animation-delay8" style="font-weight:bold">
            <span class="text-success">计算机学院</span>
            <span style="color:#ccc; text-shadow:0 1px #fff">网上党校</span>
        </h2>
    </div>
    <div class="login-widget animation-delay1">
        <div class="panel panel-default">
            <div class="panel-heading clearfix">
                <div class="pull-left">
                    <i class="fa fa-lock fa-lg"></i> 登录
                </div>

                <div class="pull-right">
                    <span style="font-size:11px;">暂无账号?</span>
                    <a class="btn btn-default btn-xs login-link" href="${basePath}/main/register" style="margin-top:-2px;"><i class="fa fa-plus-circle"></i> 注册</a>
                </div>
            </div>
            <div class="panel-body">
                <form class="form-login">
                    <div class="form-group">
                        <label>账号</label>
                        <input type="text" name="username" placeholder="Username" class="form-control input-sm bounceIn animation-delay2" >
                    </div>
                    <div class="form-group">
                        <label>密码</label>
                        <input type="password" name="password" placeholder="Password" class="form-control input-sm bounceIn animation-delay4">
                    </div>
                    <div class="form-group">
                        <label class="label-checkbox inline">
                            <input type="checkbox" name="rememberUserid" <#if userId??>checked="checked"</#if> class="regular-checkbox chk-delete" />
                            <span class="custom-checkbox info bounceIn animation-delay4"></span>
                        </label>
                        记住我
                    </div>

                    <div class="seperator"></div>
                    <div class="form-group">
                        忘记了密码？<br/>
                        单击 <a href="#">此处</a> 重置密码
                    </div>

                    <hr/>

                    <a class="btn btn-success btn-sm bounceIn animation-delay5 pull-right" id="submitButton" href="javascript:;">
                        <i class="fa fa-sign-in"></i> 登录</a>
                </form>
            </div>
        </div><!-- /panel -->
    </div><!-- /login-widget -->
</div><!-- /login-wrapper -->


    <@master.js >
    <script language="javascript">
        $("#submitButton").click(function(){
            if($('form').parsley().validate()){
                $.ajax({
                    cache: true,
                    type: "POST",
                    url:"${basePath}/main/checklogin",
                    data:$('form').serialize(),
                    async: false,
                    error: function(request) {
                        alertify.alert("错误：服务器异常！");
                    },
                    success: function(data) {
                        if(data.success){
                            <#if backurl??>
                                location.href="${backurl!}";
                            <#else>
                                location.href="${basePath}/main/index";
                            </#if>
                        }
                        else{
                            alertify.alert("错误:" + data.message);
                        }
                    }
                });
            }
        });

        $(document).ready(function(){
            if($("input[name='username']").val()!=''){
                $("input[name='password']")[0].focus();
            }
        })

        document.onkeydown = function(e){
            var ev = document.all ? window.event : e;
            if(ev.keyCode==13) {
                $('#submitButton').click();
            }
        }
    </script>
    </@master.js>

</@master.masterBlank>