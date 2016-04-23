<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame showNotice=false >
<div id="portfolio" class="bg-light">
    <div class="section-header">
        <hr class="left visible-lg">
        <span>问题解答</span>
        <hr class="right visible-lg"></div>
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-body">
                <h4 class="headline">
                    问题列表
                    <button class="btn btn-success pull-right" id="ask" >提问</button>
                    <span class="line"></span>
                </h4>
                <ul class="media-list comment-list">

                    <#if response.faqModelList??&&response.faqModelList?size gt 0>
                        <#list response.faqModelList as faq>
                            <li class="media">
                                <a class="pull-left" href="#">
                                    <span class="label label-info"> 问</span>
                                </a>
                                <div class="media-body">
                                    <div class="media-heading">
                                        <a href="#">${(faq.studentModel.name)!}</a>
                                        <small class="text-muted">
                                          ${("于 "+faq.createTime?string('yyyy年MM月dd日 hh:mm:ss'))!}
                                        </small>
                                    </div>
                                    <p>${(faq.question)!}</p>
                                    <!-- Nested media object -->
                                    <div class="media">
                                        <a class="pull-left" href="#">
                                            <span class="label label-warning"> 答</span>
                                        </a>
                                        <div class="media-body">
                                            <div class="media-heading">
                                                <a href="#">${(faq.userModel.name)!}</a>
                                                <small class="text-muted">
                                                     ${("于 "+faq.answerTime?string('yyyy年MM月dd日 hh:mm:ss'))!}
                                                </small>
                                            </div>
                                            ${(faq.answer)!}
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </#list>
                    <#else >
                        暂无问题
                    </#if>

                </ul><!-- /media-list -->
                <form id="searchForm" action="${basePath}/faq/list"></form>
                <#if response.faqModelList?? && response.faqModelList?size gt 0>
                    <@splitPage1.splitPage pageCount=(response.splitPageResponse.pageCount)!1 pageNo=(response.splitPageResponse.pageNo)!1 formId="searchForm" recordCount=(response.splitPageResponse.recordCount)!0 />
                </#if>
            </div>
        </div><!-- /panel -->
    </div>
</div>
<div  id="question-modal" class="modal fade" style="display: none;width: 50%;left: 25%" aria-hidden="true">
    <div class="modal-content">
        <div class="modal-header">
            <a class="close" data-dismiss="modal">×</a>
            <h3 id="modal-title">提问</h3>
        </div>
        <div class="modal-body" id="modal-content">
            <textarea id="question" class="form-control" placeholder="FAQ"></textarea>
        </div>
        <div class="modal-footer">
            <a href="javascript:;" class="btn btn-success" id="success-modal">提交</a>
        </div>
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
<script src="${basePath}/resources/js/party/ask.js"></script>