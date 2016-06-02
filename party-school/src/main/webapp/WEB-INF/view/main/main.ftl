<#import "/master/master-frame.ftl" as master />
<@master.masterFrame showNotice=false >
<!-- <div id="main-slider" class="carousel slide bg-dark" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#main-slider" data-slide-to="0" class="active"></li>
                <li data-target="#main-slider" data-slide-to="1"></li>
                <li data-target="#main-slider" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">

                <div class="item active">
                    <img src="img/gallery14.jpg" alt="" class="img-background">
                    <div class="row text-center">
                        <h2 class="m-top-lg text-warning fadeInDownLarge animation-delay3">Powerful Template with Clean Design</h2>
                        <p class="text-white fadeInUpLarge animation-delay6 hidden-xs">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. <br/>
                            Vestibulum auctor suscipit lobortis.
                        </p>
                        <a href="https://wrapbootstrap.com/theme/endless-responsive-admin-template-WB00J6977" class="btn btn-default btn-lg fadeInLeftLarge animation-delay8">Get It Now</a>
                        <a href="index-2.html" class="btn btn-danger btn-lg fadeInRightLarge animation-delay8">Find Out More</a>
                    </div>
                </div>
            </div> -->
<!-- <a class="left carousel-control" href="#main-slider" data-slide="prev">
    <span class="fa fa-chevron-left"></span>
</a>
<a class="right carousel-control" href="#main-slider" data-slide="next">
    <span class="fa fa-chevron-right"></span>
</a> -->
<!-- </div> -->

<!-- <div class="bg-white content-padding text-center font-lg">
    <div class="container">
        <span class="m-right-sm">ENDLESS ADMIN IS A BEAUTIFUL, POWERFUL TEMPLATE WITH CLEAN DESIGN</span>
        <div class="inline-block m-top-sm">
            <a href="https://wrapbootstrap.com/theme/endless-responsive-admin-template-WB00J6977" class="btn btn-success btn-lg m-bottom-sm"><i class="fa fa-tag"></i> PURCHASE NOW</a>
            <a href="index-2.html" class="btn btn-danger btn-lg m-bottom-sm fadeInRightLarge animation-delay2">LIVE PREVIEW <i class="fa fa-arrow-right"></i></a>
        </div>
    </div>
</div> -->

<div class="bg-light padding-md" id="feature">
    <div class="container">
        <div class="row">
            <div class="col-sm-3 content-padding">
                <div class="feature-icon text-center" onclick="location.href='${basePath}/task/mytask'">
                    <i class="fa fa-tasks fa-4x"></i>
                </div>
                <div class="text-center font-lg">
                    <h3>年度要求</h3>
                </div>
                <p></p>
            </div><!-- /.col -->
            <div class="col-sm-3 content-padding">
                <div class="feature-icon text-center" onclick="location.href='${basePath}/course/mycourselist'">
                    <i class="fa fa-book fa-4x"></i>
                </div>
                <div class="text-center font-lg">
                    <h3>在学课程</h3>
                </div>
                <p></p>
            </div><!-- /.col -->
            <div class="col-sm-3 content-padding">
                <div class="feature-icon text-center" onclick="location.href='${basePath}/note/list'">
                    <i class="fa fa-pencil fa-4x"></i>
                </div>
                <div class="text-center font-lg">
                    <h3>学习笔记</h3>
                </div>
                <p></p>
            </div><!-- /.col -->
            <div class="col-sm-3 content-padding">
                <div class="feature-icon text-center"  onclick="location.href='${basePath}/statistic'">
                    <i class="fa fa-bars fa-4x"></i>
                </div>
                <div class="text-center font-lg">
                    <h3>排行榜</h3>
                </div>
                <p></p>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div>
</div>

<div class="padding-md">
    <div class="container">
        <div class="row">
            <div class="col-sm-3 content-padding">
                <div class="feature-icon text-center" onclick="location.href='${basePath}/question/list'">
                    <i class="fa fa-folder-open-o fa-4x"></i>
                </div>
                <div class="text-center font-lg">
                    <h3>题库学习</h3>
                </div>
                <p></p>
            </div><!-- /.col -->
            <div class="col-sm-3 content-padding">
                <div class="feature-icon text-center" onclick="location.href='${basePath}/exam/list'">
                    <i class="fa fa-star-o fa-4x"></i>
                </div>
                <div class="text-center font-lg">
                    <h3>在线考试</h3>
                </div>
                <p></p>
            </div><!-- /.col -->
            <div class="col-sm-3 content-padding">
                <div class="feature-icon text-center" onclick="location.href='${basePath}/profile/list'">
                    <i class="fa fa-folder fa-4x"></i>
                </div>
                <div class="text-center font-lg">
                    <h3>学习档案</h3>
                </div>
                <p></p>
            </div><!-- /.col -->
            <div class="col-sm-3 content-padding">
                <div class="feature-icon text-center" onclick="location.href='${basePath}/faq/list'">
                    <i class="fa fa-comments-o fa-4x"></i>
                </div>
                <div class="text-center font-lg">
                    <h3>问题解答</h3>
                </div>
                <p></p>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div>
</div>
<div class="bg-white text-center content-padding">
    <div class="container">
        <#--<h3>The Perfect Canvas For Your Design</h3>-->
        <#--<h5 class="text-muted">Super Powerful & Easy to Use Theme</h5>-->
        <#--<div class="seperator"></div>-->
        <#--<div class="seperator"></div>-->
        ${(notify.content)!}
        ${(notify.extraContent)!}
        <#--<a href="https://wrapbootstrap.com/theme/endless-responsive-admin-template-WB00J6977" class="btn btn-lg btn-success animated-element fadeInUp no-animation">PURCHASE NOW</a>-->
    </div>
</div>

<#--<div class="bg-white">-->
    <#--<div class="text-center content-padding" id="contact">-->
        <#--<div class="container">-->
            <#--<h3>NEWSLETTER SIGNUP</h3>-->
            <#--<p class="m-bottom-md">Subscribing to our newsletter you will always be update with the latest news from us.</p>-->

            <#--<form class="form-inline content-padding">-->
                <#--<div class="form-group">-->
                    <#--<label class="sr-only">Email address</label>-->
                    <#--<input type="text" class="form-control input-lg" placeholder="Email Address" id="newsletter">-->
                <#--</div>-->
                <#--<a href="#" class="btn btn-lg btn-info">Subscribe</a>-->
            <#--</form>-->
        <#--</div>-->
    <#--</div>-->
<#--</div>-->



<#--<div class="content-padding bg-light">-->
    <#--<div class="container">-->
        <#--<div class="panel">-->
            <#--<div class="panel-body content-padding">-->
                <#--<div class="pull-left">-->
                    <#--<p class="font-lg">Endless Admin is a fully responsive admin template</p>-->
                    <#--<p class="text-muted">built with Bootstrap 3.0 Framework, modern web technology HTML5 and CSS3.</p>-->
                <#--</div>-->
                <#--<a href="https://wrapbootstrap.com/theme/endless-responsive-admin-template-WB00J6977" class="btn btn-lg btn-danger pull-right m-top-xs fadeInLeftLarge no-animation animated-element animation-delay1">PURCHASE NOW</a>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
<#--</div>-->
</@master.masterFrame>
<script>
    $(function()	{
        $('.animated-element').waypoint(function() {

            $(this).removeClass('no-animation');

        }, { offset: '70%' });

        $('.nav').localScroll({duration:800});
    });
</script>