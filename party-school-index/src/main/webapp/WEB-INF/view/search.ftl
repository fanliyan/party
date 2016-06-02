<#import "/master/blank.ftl" as master />
<#import "/master/splitPage.ftl" as splitPage />

<@master.masterBlank title="搜索页："+w >

    <@master.header ></@master.header>

<div id="cont_tongzhigonggao">
    <div class="t_conts">
        <div class="t_left">
            <div class="t_tit">${channel!}</div>
            <ul class="t_list">
            </ul>
        </div>
        <div class="t_right">
            <div class="t_cont_r">
                <div class="title">
                    <div class="t">${channel!}</div>
                </div>
                <ul class="list">
                    <#if response.articleModelList?? && response.articleModelList?size gt 0>
                        <#list response.articleModelList as article>
                            <li><a href="${basePath}/article/${article.articleId}">${article.title}</a><span class="date">${article.publishTime?string('yyyy-MM-dd')}</span></li>
                        </#list>
                    <#else>
                        没有：${w} 相关文章
                    </#if>
                </ul>

                 <#if response.articleModelList?? && response.articleModelList?size gt 0>
                    <@splitPage.splitPage pageCount=(response.splitPage.pageCount)!1 pageNo=(response.splitPage.pageNo)!1 formId="searchForm" recordCount=(response.splitPage.recordCount)!0 />
                 </#if>
            </div>
        </div>
    </div>
</div>

    <@master.footer></@master.footer>

</@master.masterBlank>
