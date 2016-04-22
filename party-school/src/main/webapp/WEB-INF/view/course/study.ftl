<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<link href="${basePath}/resources/css/video/video-js.css" rel="stylesheet">
<@master.masterFrame >
<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>视频课程</span>
        <hr class="right visible-lg">
    </div>
    <div class="container">
        <div class="panel panel-default table-responsive">
        <#--<div class="panel-body ">-->
            <div class="padding-md">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="panel blog-container">
                                    <div class="panel-body">
                                        <div class="image-wrapper">

                                            <video id="video" class="video-js"  preload="auto"
                                                   width="500em" height="400em"
                                                   poster="" data-setup="{}">
                                                <source src="${courseWare.url}" type='video/mp4'>
                                                <p class="vjs-no-js">
                                                    To view this video please enable JavaScript, and consider upgrading
                                                    to a web
                                                    browser that
                                                    <a href="http://videojs.com/html5-video-support/" target="_blank">supports
                                                        HTML5 video</a>
                                                </p>
                                            </video>

                                        </div>
                                        <!-- /image-wrapper -->

                                        <div class="seperator"></div>
                                        <#--<button class="btn btn-info">开始学习</button>-->
                                        <button class="btn">退出</button>

                                    </div>
                                </div>
                                <!-- /panel -->

                                <div class="col-md-12">
                                    <h4 class="headline">
                                        老师介绍
                                        <span class="line"></span>
                                    </h4>
                                    <div class="panel">
                                        <div class="panel-body">
                                            <div class="media">
                                            <#--<a class="pull-left" href="#">-->
                                            <#--<img src="img/user.jpg" alt="Author" class="img-rounded"-->
                                            <#--style="height:50px; width:50px;"></a>-->
                                                <div class="media-heading">
                                                ${(course.teacher)!}
                                                    <br>
                                                    <small class="text-muted">Web Designer</small>
                                                </div>
                                                <div class="media-body">
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam eros
                                                    nibh,
                                                    viverra a dui a, gravida varius velit. Nunc vel tempor nisi. Aenean id
                                                    pellentesque mi, non placerat mi.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /panel -->
                            </div>
                            <!-- /.col -->
                            <div class="col-md-4">
                                <h4 class="headline">
                                    课程名
                                    <span class="line"></span>
                                </h4>
                                <div class="media popular-post">
                                <#--<a class="pull-left" href="single_post.html">-->
                                <#--<img src="img/gallery1.jpg" alt="Popular Post"></a>-->
                                    <div class="media-body">${(course.courseName)!}</div>
                                </div>
                                <h4 class="headline">
                                    介绍
                                    <span class="line"></span>
                                </h4>
                                <p>
                                ${(course.description)!}
                                </p>
                                <h4 class="headline">
                                    <span class="line"></span>
                                </h4>
                                <ul class="category">
                                    <li>
                                        <a href="javascript:;"> <i class="fa fa-chevron-right"></i>
                                            时长：${(courseWare.time)!}
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;"> <i class="fa fa-chevron-right"></i>
                                            学分：${(course.score)!}
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
                <div class="panel-footer clearfix"></div>
            </div>
        </div>
    </div>
</div>
</@master.masterFrame>
<script>
    $(function () {
        $('.animated-element').waypoint(function () {

            $(this).removeClass('no-animation');

        }, {offset: '70%'});

        $('.nav').localScroll({duration: 800});
    });
</script>
<script>
    var videoConfig = {
        userId:${loginUserModel.id},
        courseId:${course.courseId},
        wareId:${courseWare.id},
        wsurl: "ws://localhost:8080/party-school/study/websocket",
        hashcode: "${hashcode!""}",
        returnUrl: "${basePath}/main/index",
        video: $("video")
    };
</script>
<script src="${basePath}/resources/js/video/video.js"></script>
<script src="${basePath}/resources/js/party/study.js"></script>