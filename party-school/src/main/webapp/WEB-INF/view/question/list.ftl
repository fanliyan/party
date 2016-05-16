<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >

<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>题库学习</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default table-responsive">
            <div class="panel-heading">
                <span class="label label-info pull-right">${(response.questionModelList?size)!"0"} 题</span>
            </div>
            <form id="searchForm">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-4 col-sm-4">
                            <#--<a class="btn btn-warning btn-sm" href="${basePath}/note/add">添加笔记</a>-->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
            </form>
            <table class="table table-striped" id="responsiveTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>标题</th>
                    <th>创建日期</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#if response.questionModelList??&&response.questionModelList?size gt 0>
                        <#list response.questionModelList as question>
                        <tr>
                            <td>${question.id!}</td>
                            <td>${question.name}</td>
                            <td>${question.createTime?string('yyyy-MM-dd')}</td>
                            <td>
                                <button class="btn btn-info" onclick="$.watch(${question.id},1);">查看</button>
                            </td>
                        </tr>
                        </#list>
                    <#else>
                    <tr><td colspan="5">暂无题目</td></tr>
                    </#if>
                </tbody>
            </table>
            <form id="searchForm" action="${basePath}/question/list"></form>
            <#if response.questionModelList?? && response.questionModelList?size gt 0>
                <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
            </#if>
        </div>
    </div>
</div>


<div class="content-padding bg-white">
    <div class="container">
        <div class="panel">
            <div class="panel-body content-padding">
                <div class="pull-left">
                    <p class="font-lg">向他人学习</p>
                    <p class="text-muted">了解更多党校知识</p>
                </div>
                <a href="${basePath}/exam/list"
                   class="btn btn-lg btn-danger pull-right m-top-xs no-animation animated-element">立即考试</a>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="formModal" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <#--<div class="modal-header">-->
                <#--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>-->
                <#--<h4>题目</h4>-->
            <#--</div>-->
            <div class="modal-body">
                <div class="form-group">
                    <div class="panel-body relative">
                        <div class="form-group" id="modal-body">
                        </div>
                    </div>
                </div>
                <div class="form-group text-right">
                    <a href="#" data-dismiss="modal" class="btn btn-default">关闭</a>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
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
<script>
    $.watch = function (id) {
        $.ajax({
            cache: true,
            type: "POST",
            url: "${basePath}/question/watch/"+id,
            data:null,
            async: false,
            error: function (request) {
                alertify.alert("错误：服务器异常！");
            },
            success: function (data) {
                if (data.success) {
                    var choiceString="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                    var type;
                    var rightAnswer=new Array();
                    switch (data.question.type){
                        case 1:
                            type="单选题";
                            rightAnswer.push(data.question.rightAnswerList[0]);
                            break;
                        case 2:
                            type="多选题";
                            for(i in data.question.rightAnswerList){
                                rightAnswer.push(data.question.rightAnswerList[i]);
                            }
                            break;
                        case 3:
                            type="判断题";
                            rightAnswer.push(data.question.rightAnswerList[0]);
                            break;
                    }
                    var choice=new Array();
                    var html="";
                    var rightIndex=new Array();
                    for(i in data.question.choiceModelList){
                        //String[] rightAnswer
                        if($.inArray(data.question.choiceModelList[i].value+"",rightAnswer)>=0){
                            rightIndex.push(i);
                        }
                        html+="<span class=\"label col-xs-1\"> "+choiceString.charAt(i)+"：</span><div class=\"col-xs-11\">"+data.question.choiceModelList[i].name+"</div>";
                    }
                    var rightString="";
                    for(i in rightIndex){
                        rightString+=choiceString.charAt(rightIndex[i])+" ";
                    }

                    $("#modal-body").html(
                            "<div class='col-xs-12'>" +
                            "<h4><span class='label label-info'>题目：</span></h4>"+
                            "<p>"+data.question.question+"</p>"+
                            "</div>"+
                            "<div class='col-xs-12'>" +
                            "<span class='label label-info'>题型：</span>"+
                            "<span class='label label-default'> "+type+" </span>"+
                            "</div>"+
                            "<div class='col-xs-12'>" +
                            "<span class='label label-info'>选项：</span><div class='separator'></div>"+html+
                            "</div>"+
                            "<div class='col-xs-12'>" +
                            "<span class='label label-info'>正确答案：</span>"+
                            "<span class='label label-default'> "+rightString+" </span>"+
                            "</div>"

                    );


                    $("#formModal").modal();
                }else {
                    alertify.alert("错误:" + data.message);
                }
            }
        });
    };
</script>