<#import "/master/blank.ftl" as master />


<@master.masterBlank>

    <@master.header ></@master.header>
<link href="${basePath}/resources/css/dx-slider.css" type="text/css" rel="stylesheet" />

<div id="cont_index">
    <div class="left">
        <div class="lef">
            <div class="block1">
                <ul>
                    <#if banner?? && banner?size gt 0>
                        <#list banner as b>
                            <li><img class="img" src="${b.pic}" onclick="location.href='${b.url}'" /></li>
                        </#list>
                    </#if>
                </ul>
            </div>
            <ul class="but">
                <li><a href="${basePath}/list/16">党校概况</a></li>
                <li><a href="${basePath}/list/17">入党导航</a></li>
                <li><a href="${basePath}/list/18">教学计划</a></li>
                <li><a href="${basePath}/list/19">学习天地</a></li>
            </ul>
        </div>
        <div class="block2">
            <div class="blo">
                <div class="tit2">
                    <div class="title">党校新闻</div>
                    <a href="${basePath}/list/14">
                        <img src="${basePath}/resources/img/more.gif" alt="更多" class="fr" />
                    </a>
                </div>
                <ul class="cont">
                    <#if dxxw?? && dxxw?size gt 0>
                        <#list dxxw as a>
                            <li><a href="${basePath}/article/${a.articleId}"> ${a.title}</a><span>[${a.publishTime?string("yyyy-MM-dd")}]</span></li>
                        </#list>
                    </#if>
                </ul>
            </div>
        </div>

        <div class="block2">
            <div class="blo">
                <div class="tit2">
                    <div class="title">通知公告</div>
                    <a href="${basePath}/list/14">
                        <img src="${basePath}/resources/img/more.gif" alt="更多" class="fr" />
                    </a>
                </div>
                <ul class="cont">
                    <#if tzgg?? && tzgg?size gt 0>
                        <#list tzgg as a>
                            <li><a href="${basePath}/article/${a.articleId}"> ${a.title}</a><span>[${a.publishTime?string("yyyy-MM-dd")}]</span></li>
                        </#list>
                    </#if>
                </ul>
            </div>
        </div>

    </div>
    <div class="right">
        <#--<div class="right_1">-->
            <#--<div class="tit3">-->
                <#--<img src="${basePath}/resources/img/xuexitiandi.gif" alt="学习天地" class="r_fl" />-->
                <#--<img src="${basePath}/resources/img/more1.gif" alt="更多" class="fr" />-->
            <#--</div>-->
            <#--<ul class="right_cont">-->
                <#--<li><a href="#this">网络课程</a></li>-->
                <#--<li><a href="#this">网络课程</a></li>-->
                <#--<li class="libg1"><a href="#this">网络课程</a></li>-->
            <#--</ul>-->
        <#--</div>-->

        <div class="right_1">
            <div class="tit3">
                <img src="${basePath}/resources/img/guanlixitong.gif" alt="管理系统" class="r_fl" />
            </div>
            <ul class="right_cont">
                <li class="libg1"><a href="#this">管理系统</a></li>
            </ul>
        </div>
        <div class="right_2">
            <div class="tit4"><img src="${basePath}/resources/img/lianxiwomen.gif" alt="联系我们" /></div>
            <div class="phone">
                <div class="phone1"><img src="${basePath}/resources/img/phone.gif" alt="电话" /></div>
                <div class="num">
                    <span>电话传真：</span>
                    <p>0551-502223</p>
                </div>
            </div>
            <p class="text3">
                通信地址:省长春市卫星路6543号
            </p>
        </div>
        <div class="right_1">
            <div class="tit3">
                <img src="${basePath}/resources/img/youqinglianjie.gif" alt="学习天地" class="r_fl" />
                <img src="${basePath}/resources/img/more1.gif" alt="更多" class="fr" />
            </div>
            <ul class="right_cont">
                <li><a href="#this">网络课程</a></li>
                <li><a href="#this">网络课程</a></li>
            </ul>
        </div>
    </div>

</div>

    <@master.footer></@master.footer>

</@master.masterBlank>
<script>
    $(function() {
        $('.block1').unslider({
            autoplay: true,             //Automatic
//            animation: 'vertical',      //vertical or horizontal
//            animation: 'fade',
//            infinite: true,
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