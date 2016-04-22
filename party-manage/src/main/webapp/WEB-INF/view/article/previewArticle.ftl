<macro previewArticle title summary contnet >

    <!doctype html>
    <html>
    <head>
        <meta charset="utf-8">
        <meta name="MobileOptimized" content="320" />
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title><#if article??>${article.title!}</#if> - 精华文章 - 移民帮</title>

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
            <div class="toolbar">
                <h1 class="logo"><a href="#" target="_blank" title="移民帮">移民帮</a></h1>
                <div class="main-nav">
                    <a href="#" target="_blank" title="我要移民" class=" current">我要移民<span class="hot">HOT</span></a>
                    <a href="#" target="_blank" title="移民目的地">移民目的地</a>
                    <a href="#" target="_blank" title="移民评估">移民评估</a>
                </div>
                <div class="sub-nav"><a href="##">精华</a><a href="##">圈子</a><a href="##">问答</a></div>
                <div class="mod_tb_loginbar"><a href="##" class="button-inline button-primary">登录</a><a href="##" class="button-inline button-light">注册</a></div>
                <#--<div class="mod_tb_loginbar logined"><span class="pic"><img src="images/photos_39.png" alt=""></span>-->
                    <#--<div class="user-name"><a href="/member/" class="link"><span class="txt">wleatu</span><i class="icon icon_drop"></i></a>-->
                        <#--<div class="show-menu">-->
                            <#--<p><a href="/member/">我的主页</a></p>-->
                            <#--<p><a href="/member/me_publish">我发布的</a></p>-->
                            <#--<p><a href="/member/collect">收藏夹</a></p>-->
                            <#--<div class="action"><a href="/setting/index" class="btn-s button-light">设置</a><a href="javascript:void(0);" onclick="window.toLogout(this);return false;" class="btn-s button-primary">退出</a></div>-->
                            <#--<i class="triangle-up"><b></b></i>-->
                        <#--</div>-->
                    <#--</div>-->
                    <#--<a href="#" class="message_numb">10<i class="ico_arr"></i>-->
                    <#--</a>-->
                <#--</div>-->
            </div>
        </div>
    </div>
    <div class="mod_content">
        <div class="crumbs">
            <a href="javascrip:void(0)">移民帮</a><span class="gt">/</span><a href="javascrip:void(0)">精华文章</a><span class="gt">/</span><span class="current"><#if article??>${article.title!}</#if></span>
        </div>
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
                    <div class="focus"><a href="##" class="btn-s"><i class="yiminbang-icon">&#xe646;</i>2</a></div>
                    <p class="info-tips"><em><#if article??>${article.summary!}</#if></em></p>
                </div>
                <div class="aricle-show">
                <#if article??>${article.content!}</#if>
                </div>
            </div>
        </div>
        <div class="mod_aside">
            <div class="baidu_share">
                <div class="baidu_share_txt">分享给好友：</div>

            </div>
            <div class="action-tool">
                <button type="submit" class="button-block button-primary">文本收藏</button>
            </div>
            <!--相关文章-->
            <div class="asid-mod relevant-mod">
                <div class="asid-hd">
                    <h2>相关文章<i class="icon icon_line"></i></h2>
                </div>
                <div class="bd">
                    <ul class="new-list">
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-239.html">中国土豪们喜欢的海外哪些国家置业？</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-641.html">澳大利亚将通过调整申请费控制移民数量</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-642.html">澳洲移民新政，投资方向受限制，188C将更具风险性</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-643.html">澳大利亚政府调整技术移民政策</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-644.html">澳洲投资移民新政7月执行 住宅地产或不被认可</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-645.html">澳洲移民申请最常见的误区有哪些？</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-646.html">2015年澳大利亚移民新政策有哪些</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-648.html">澳将调整技术移民政策 加强对雇主监管防止滥用</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-649.html">澳洲技术移民评分中的职业年加分是什么?</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-1238.html">澳洲塔州商讨签证发放比例 欢迎中国商业技术移民</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-1267.html">澳洲移民新政锁定全球投资客(图)</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-1424.html">澳洲移民部:临时毕业生工作签证将改变雅思要求</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-1425.html">澳洲今年将发放超500万个签证 移民数量或破纪录</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-1437.html">澳洲457签证英语语言测试改革更灵活 吸引高技能移民</a></li>-->
                        <#--<li><a target="_blank" href="http://www.yiminbang.com/article-detail/11-1452.html">澳洲188A新政让人喜让人忧</a></li>-->
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="mod_footer">
        <div class="footer clearfix">
            <div class="mod_guide">
                <dl class="guide_item item_aboutus">
                    <dt>关于我们</dt>
                    <dd><a href="#" target="_blank" title="移民帮介绍">移民帮介绍</a></dd>
                    <dd><a href="#" target="_blank" title="联系我们">联系我们</a></dd>
                </dl>
                <dl class="guide_item item_joinus">
                    <dt>加入移民帮</dt>
                    <dd><a href="#" target="_blank" title="招聘职位">招聘职位</a></dd>
                    <dd><a href="#" target="_blank" title="全球专家招募">全球专家招募</a></dd>
                </dl>
                <dl class="guide_item item_declare">
                    <dt>网站条款</dt>
                    <dd><a href="#" target="_blank" title="网站条款">网站条款</a></dd>
                    <dd><a href="#" target="_blank" title="免责声明">免责声明</a></dd>
                    <dd><a href="#" target="_blank" title="版权声明">版权声明</a></dd>
                </dl>
                <dl class="guide_item item_map">
                    <dt>网站导航</dt>
                    <dd><a href="#" target="_blank" title="网站地图">网站地图</a></dd>
                </dl>
                <dl class="guide_item item_service">
                    <dt>咨询电话</dt>
                    <dd>400 960 1116</dd>
                    <dd><a href="#" target="_blank" title="关注我们">关注我们</a></dd>
                    <dd><a href="#" class="icon icon_weibo"></a><a href="#" class="icon icon_email"></a></dd>
                </dl>
                <dl class="guide_item item_other">
                    <dt>微信公众号</dt>
                    <dd><img src="images/code_weixin.png" alt=""></dd>
                </dl>
            </div>
            <p class="copyright">&copy;2014-2015 移民帮, All Rights Reserved.</p>
        </div>
    </div>
    </body>
    </html>

</macro>