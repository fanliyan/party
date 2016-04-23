<#import "/master/master-frame.ftl" as master />

<@master.masterFrame showNotice=false >
<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>学习笔记</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="panel blog-container">
                    <div class="panel-body">
                        <h4>${(note.title)!}</h4>
                        <small class="text-muted">作者 <a href="#"><strong> ${(note.studentModel.name)!}</strong></a> |  发布于 ${(note.createTime?string('yyyy年MM月dd日'))!} | </small>
                        <div class="seperator"></div>
                        <div class="seperator"></div>
                        <p class="m-top-sm m-bottom-sm">
                            ${(note.content)!}
                        </p>

                    </div>
                </div>
            </div>
        </div><!-- /panel -->
    </div>
</div>
</@master.masterFrame>
<script>
    $(function()	{
        $('.animated-element').waypoint(function() {

            $(this).removeClass('no-animation');

        }, { offset: '70%' });

        $('.nav').localScroll({duration:800});
    });
</script>
