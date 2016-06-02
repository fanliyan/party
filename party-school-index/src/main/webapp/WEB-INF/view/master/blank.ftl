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


<#macro header >

<div id="header">
    <h1 onclick="location.href='/party-school-index/'"><img src="${basePath}/resources/img/dx.png" alt="" /> </h1>
    <#--<h2><img src="${basePath}/resources/img/dj/h2.gif" alt="" /></h2>-->

    <div class="menu1">
        <ul class="link1">
            <li class="left1"></li>
            <li class="right1">
                <form action="${basePath}/search" method="post">
                    <input class="sousuo" name="w" placeholder="站内搜索" style="overflow:hidden;"></input>
                    <button type="submit" class="right2"></button>
                <#--<a href="#this"><img class="right2" src="${basePath}/resources/img/dj/coin.gif" alt=""/></a>-->
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