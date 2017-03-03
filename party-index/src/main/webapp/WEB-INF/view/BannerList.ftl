<#import "/master/blank.ftl" as master />
<#import "/master/splitPage.ftl" as splitPage />

<@master.masterBlank title="计算机科学技术学院党建网-头条新闻" >

    <@master.header list=list></@master.header>

<div id="cont_tongzhigonggao" class="clear">
    <div class="t_conts clear">
    <#--<div class="t_left">-->
    <#--<div class="t_tit">${channel!}</div>-->
    <#--<ul class="t_list">-->
    <#--<#if left?? && left?size gt 0>-->
    <#--<#list left as c>-->
    <#--<li><a href="${basePath}/list/${c.channelId}">${c.name}</a></li>-->
    <#--</#list>-->
    <#--</#if>-->
    <#--</ul>-->
    <#--</div>-->
        <div id="getDiv">
            <a href="javascript:history.back()" id="getBack">后退</a>
            <a href="javascript:history.forward()">前进</a>
        </div>
        <div class="t_right">
            <div class="t_cont_r">
                <div class="title">
                    <div class="t">头条新闻</div>
                </div>
                <ul class="list">
                    <#if banner?? && banner?size gt 0>
                        <#list banner as b>
                            <#--<#if article.status == 0 || article.status == 1>-->
                                <li>
                                    <a href="${b.url}">
                                         <#if b.name?? && b.name?length gt 60>
                                            ${b.name?substring(0, 60)}...
                                             <#else>
                                               ${b.name}
                                         </#if>
                                 </a>

                                    <span
                                        class="date">${b.lastModifyTime?string('yyyy-MM-dd')}
                                    </span>
                                </li>
                            <#--</#if>-->
                        </#list>
                    <#else>
                        暂无头条新闻
                    </#if>
                </ul>

                <#--<#if response.articleModelList?? && response.articleModelList?size gt 0>-->
                    <#--<form id="searchForm" action="${basePath}/list/${id}" method="post"></form>-->
                    <#--<@splitPage.splitPage pageCount=(response.splitPage.pageCount)!1 pageNo=(response.splitPage.pageNo)!1 formId="searchForm" recordCount=(response.splitPage.recordCount)!0 />-->
                <#--</#if>-->
            </div>
        </div>
    </div>
</div>

    <@master.footer></@master.footer>

</@master.masterBlank>
