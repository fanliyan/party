<#import "/master/blank.ftl" as master />


<@master.masterBlank title="党建首页" >

    <@master.header list=list></@master.header>
<link href="${basePath}/resources/css/dj-slider.css" type="text/css" rel="stylesheet" />

<div id="contents">
        <div class="left">
            <div class="left2">
                <div class="tit">
                    <img src="${basePath}/resources/img/dj/titbg1.gif" alt="" /><span>先进典型</span>
                    <a href="${basePath}/list/12"><img class="flr" src="${basePath}/resources/img/dj/gengduo.gif" alt="" /></a>
                </div>
                <ul class="cot">
                    <#if xjdx?? && xjdx?size gt 0>
                        <#list xjdx as a>
                            <li><a href="${basePath}/article/${a.articleId}">${a.title}</a></li>
                        </#list>
                    </#if>
                </ul>

            </div>
            <div class="left2">
                <div class="tit">
                    <img src="${basePath}/resources/img/dj/titbg1.gif" alt="" /><span>专题教育</span>
                    <a href="${basePath}/list/10"><img class="flr" src="${basePath}/resources/img/dj/gengduo.gif" alt="" /></a>
                </div>
                <ul class="cot">
                    <#if ztjy?? && ztjy?size gt 0>
                        <#list ztjy as a>
                            <li><a href="${basePath}/article/${a.articleId}">${a.title}</a></li>
                        </#list>
                    </#if>
                </ul>

            </div>
        </div>
        <div class="center">
            <div class="top">
                <div class="tit5">
                    <img class="ml9" src="${basePath}/resources/img/dj/tit5.gif" alt="" />
                    <a href="#this"><img class="fr" src="${basePath}/resources/img/dj/gengduo.gif" alt="" /></a>
                </div>
                <div class="con">
                    <div class="unslider">
                        <ul>
                            <#if banner?? && banner?size gt 0>
                                <#list banner as b>
                                    <li><img src="${b.pic}">
                                        <div class="banner-content">
                                            <span class="title">${b.name}</span>
                                            <p>
                                                <#if b.description?? && b.description?length gt 180>
                                                ${b.description?substring(0,180)}...
                                                <#else>
                                                ${b.description}
                                                </#if>
                                                <a href="${b.url}"><span>【详细】</span></a>
                                            </p>
                                        </div>
                                    </li>
                                </#list>
                            </#if>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="bot">
                <div class="tit6">
                    <img class="ml9" src="${basePath}/resources/img/dj/tit6.gif" alt="" />
                    <a href="${basePath}/list/11"><img class="fr" src="${basePath}/resources/img/dj/gengduo.gif" alt="" /></a>
                </div>
                <ul class="cont">
                    <#if djxx?? && djxx?size gt 0>
                        <#list djxx as a>
                            <li><a href="${basePath}/article/${a.articleId}">${a.title}</a><span>${a.publishTime?string("yyyy-MM-dd")}</span></li>
                        </#list>
                    </#if>
                </ul>
            </div>
        </div>
        <div class="left">
            <div class="left2">
                <div class="tit">
                    <img src="${basePath}/resources/img/dj/titbg1.gif" alt="" /><span>网上党校</span>
                    <a href="#this"><img class="flr" src="${basePath}/resources/img/dj/gengduo.gif" alt="" /></a>
                </div>
                <ol class="cot">
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                </ol>

            </div>
            <div class="left2">
                <div class="tit">
                    <img src="${basePath}/resources/img/dj/titbg1.gif" alt="" /><span>常用链接</span>
                    <a href="#this"><img class="flr" src="${basePath}/resources/img/dj/gengduo.gif" alt="" /></a>
                </div>
                <ol class="cot">
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                    <li><a href="#this">习近平总书记对开展”两学一做“··</a></li>
                </ol>

            </div>
        </div>

    </div>

    <@master.footer></@master.footer>

</@master.masterBlank>
<script>
    $(function() {
        $('.unslider').unslider({
            autoplay: true,             //Automatic
            animation: 'vertical',      //vertical or horizontal
//            animation: 'fade',
            infinite: true,
            speed: 500,               //  The speed to animate each slide (in milliseconds)
            delay: 3000,              //  The delay between slide animations (in milliseconds)
            complete: function() {},  //  A function that gets called after every slide animation
//            arrows: true,
            keys: true,               //  Enable keyboard (left, right) arrow shortcuts
            dots: true,               //  Display dot navigation
            fluid: true              //  Support responsive design. May break non-responsive designs
        });
    });
</script>
