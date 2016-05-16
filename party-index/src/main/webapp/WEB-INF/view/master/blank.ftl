<#global basePath=springMacroRequestContext.contextPath>
<#global icon=basePath+"/resources/img/favicon.ico">

<#macro masterBlank title="党校首页" description="">
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${title}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${description}">
    <meta name="author" content="">

    <link rel="shortcut icon" href="${icon}" type="image/x-icon">
    <link rel=icon href="${icon}" type="image/x-icon">

    <link href="${basePath}/resources/css/main.css" type="text/css" rel="stylesheet" />

    <link href="${basePath}/resources/css/unslider.css" type="text/css" rel="stylesheet" />
    <link href="${basePath}/resources/css/unslider-dots.css" type="text/css" rel="stylesheet" />

    <script src="${basePath}/resources/js/jquery-1.10.2.min.js"></script>
    <script language="javascript">
        $.basePath = "${basePath}";
    </script>
</head>
<body>
    <div id="wrap">
    <#nested>
    </div>
</body>
</html>

<script src="${basePath}/resources/js/unslider-min.js"></script>
<script src="${basePath}/resources/js/common.js"></script>

</#macro>


<#macro header>
<#--<div id="head">-->
    <#--<div class="top">-->
        <#--<div class="tit"><img src="${basePath}/resources/img/dx/tit.png" alt="计算机科学技术学院" /></div>-->
        <#--<div class="tit1"><img src="${basePath}/resources/img/dx/tit1.png" alt="网上党校" /></div>-->
    <#--</div>-->
    <#--<div class="next">-->
        <#--<ul class="nav">-->
            <#--<li><a href="#this">党校首页</a></li>-->
            <#--<li><a href="#this">通知公告</a></li>-->
            <#--<li><a href="#this">党校概况</a></li>-->
            <#--<li><a href="#this">入党导航</a></li>-->
            <#--<li><a href="#this">教学计划</a></li>-->
            <#--<li class="libg"><a href="#this">学习天地</a></li>-->
        <#--</ul>-->
    <#--</div>-->
<#--</div>-->
<div id="header">
    <h1><img src="${basePath}/resources/img/dj/h1.jpg" alt="" /> </h1>
    <h2><img src="${basePath}/resources/img/dj/h2.gif" alt="" /></h2>
    <div class="menu">
        <ul>
            <li><a href="#this">首 页</a></li>
            <li><a href="#this">机构设置</a>
                <ul>
                    <li><a href="#">HTML</a></li>
                    <li><a href="#">CSS</a></li>
                </ul>
            </li>
            <li><a href="#this">党法党规</a>
                <ul>
                    <li><a href="#">Photoshop</a></li>
                    <li><a href="#">Illustrator</a></li>
                    <li><a href="#">Web Design</a>
                        <ul>
                            <li><a href="#">HTML</a></li>
                            <li><a href="#">CSS</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
            <li><a href="#this">文件通知</a></li>
            <li><a href="#this">党建研究</a></li>
            <li class="no"><a href="#this">组织发展</a></li>

        </ul>
    </div>
    <div class="menu1">
        <ul class="link1">
            <li class="left1"></li>
            <li class="right1">
                <a href="#this"><img  class="right2" src="${basePath}/resources/img/dj/coin.gif" alt="" /></a>
                <form>
                    <input class="sousuo" placeholder="站内搜索" style="overflow:hidden;"></input>
                </form>
            </li>
        </ul>
    </div>
</div>
</#macro>

<#macro footer>
<div id="footer">
    <p>长春大学科学技术学院 地点：吉林省长春市南关区卫星广场6543号</p>
    <p>邮编：130022 吉ICP备05001994号</p>
</div>
</#macro>