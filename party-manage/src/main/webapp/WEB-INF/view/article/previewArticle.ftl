<#--<@macro previewArticle title summary contnet >-->

    <!doctype html>
    <html>
    <head>
        <meta charset="utf-8">
        <meta name="MobileOptimized" content="320" />
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title><#if article??>${article.title!}</#if></title>

        <link rel="stylesheet" href="https://webresource-yiminbang-com.alikunlun.com/static/web/v2/css/global.css?v=2015091705_1dc1df37">
        <link rel="stylesheet" type="text/css" href="https://webresource-yiminbang-com.alikunlun.com/static/web/v2/css/immigrate-s.css?v=2015091705_d8936323">
        <link rel="stylesheet" type="text/css" href="https://webresource-yiminbang-com.alikunlun.com/static/web/v2/css/yiminbang_icon.css?v=2015091705_28740886">

        <style>
            .mod_wrap{width: 1180px;margin: 0px auto;}
            .demo-panel-title{margin-bottom: 20px;padding-top: 20px;font-weight: bold;font-size: 24px;}
        </style>
    </head>
    <body>
    <div class="mod_header">
        <div class="mod_toolbar">
        </div>
    </div>
    <div class="mod_content">
        <div class="mod_main">
            <div class="article-detail">
                <div class="article-tits">
                    <h1 class="page-title"><#if article??>${article.title!}</#if></h1>
                    <p class="date"><#if article??>${article.publishTime?string("yyyy-MM-dd")}</#if></p>
                    <p class="tag">
                    <#if article?? && article.tagModels??>
                        <#list article.tagModels as tag>
                            <span><a class="tags-c" href="javascript:void(0)">${tag.tagName!}</a></span>
                        </#list>
                    </#if>

                    </p>
                    <p class="info-tips"><em><#if article??>${article.summary!}</#if></em></p>
                </div>
                <div class="aricle-show">
                <#if article??>${article.content!}</#if>
                </div>
            </div>
        </div>
    </div>

    <div class="mod_footer">
    </div>
    </body>
    </html>

<#--</@macro>-->