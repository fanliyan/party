<#global basePath=springMacroRequestContext.contextPath>
<#global defaultAvatar=basePath+"/resources/img/default_avatar.png">

<#macro masterBlank title="网上党校" bodyClass="" >
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>${title}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="shortcut icon" href="${basePath}/resources/img/favicon.ico?v=f6d031" type="image/x-icon">
    <link rel=icon href="${basePath}/resources/img/favicon.ico?v=f6d031" type="image/x-icon">


    <!-- Bootstrap core CSS -->
    <link href="${basePath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">

    <!-- Pace -->
    <link href="${basePath}/resources/css/pace.css" rel="stylesheet">

    <!-- Endless -->
    <link href="${basePath}/resources/css/endless.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/endless-landing.min.css" rel="stylesheet">

    <!-- Parsley -->
    <link href="${basePath}/resources/css/parsley/parsley.css" rel="stylesheet">

    <!-- alertify -->
    <link href="${basePath}/resources/css/alertify/alertify.core.css" rel="stylesheet">
    <link href="${basePath}/resources/css/alertify/alertify.bootstrap.css" rel="stylesheet">



    <!-- Jquery -->
    <script src="${basePath}/resources/js/jquery-1.10.2.min.js"></script>

</head>
<body  class="${bodyClass}">

<#nested >

</body>

</html>


</#macro>

<#macro js>
<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->


<!-- Bootstrap -->
<script src="${basePath}/resources/bootstrap/js/bootstrap.min.js"></script>

<!-- Waypoint -->
<script src='${basePath}/resources/js/waypoints.min.js'></script>

<!-- LocalScroll -->
<script src='${basePath}/resources/js/jquery.localscroll.min.js'></script>

<!-- ScrollTo -->
<script src='${basePath}/resources/js/jquery.scrollTo.min.js'></script>

<!-- Modernizr -->
<script src='${basePath}/resources/js/modernizr.min.js'></script>

<!-- Pace -->
<script src='${basePath}/resources/js/pace.min.js'></script>

<!-- Popup Overlay -->
<script src='${basePath}/resources/js/jquery.popupoverlay.min.js'></script>

<!-- Slimscroll -->
<script src='${basePath}/resources/js/jquery.slimscroll.min.js'></script>

<!-- Cookie -->
<script src='${basePath}/resources/js/jquery.cookie.min.js'></script>

<!-- Endless -->
<script src="${basePath}/resources/js/endless/endless.js"></script>

<!-- Parsley -->
<script src="${basePath}/resources/js/parsley.min.js"></script>

<!-- alertify -->
<script src="${basePath}/resources/js/alertify/alertify.min.js"></script>

<!-- common -->
<script src="${basePath}/resources/js/party/common.js"></script>

    <#nested >
</#macro>


<#macro header>
<header class="navbar navbar-fixed-top bg-white">
    <div class="container">
        <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="${basePath}/main/index" class="navbar-brand"><span class="text-danger">计算机学院</span> 网上党校</a>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="javascript:;" class="top-link">${(loginUserModel.name)!}[${(loginUserModel.sRoleModel.name)!}]</a>
                </li>
                <li>
                    <a href="${basePath}/main/profile" class="top-link">修改个人信息</a>
                </li>
                <li>
                    <a href="${basePath}/main/changepwd" class="top-link">修改密码</a>
                </li>
                <li>
                    <a href="${basePath}/main/logout" class="top-link">退出</a>
                </li>
            </ul>
        </nav>
    </div>
</header>
</#macro>


<#macro footer>
<footer>
    <div class="container">
        <div class="row">
            <div class="col-sm-3 padding-md">
                <p class="font-lg">关于我们</p>
                <p><small>长春大学 计算机学院 在线党校</small></p>
            </div><!-- /.col -->
            <div class="col-sm-3 padding-md">
                <p class="font-lg">相关链接</p>
                <ul class="list-unstyled useful-link">
                    <li>
                        <a href="#">
                            <small><i class="fa fa-chevron-right"></i> 长春大学</small>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <small><i class="fa fa-chevron-right"></i> 长春大学计算机科学技术学院</small>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <small><i class="fa fa-chevron-right"></i> 计算机学党建网站</small>
                        </a>
                    </li>
                </ul>
            </div><!-- /.col -->
            <!-- <div class="col-sm-3 padding-md">
                <p class="font-lg">联系我们</p>
                <a href="#" class="social-connect tooltip-test facebook-hover pull-left m-right-xs" data-toggle="tooltip" data-original-title="Facebook"><i class="fa fa-facebook"></i></a>
                <a href="#" class="social-connect tooltip-test twitter-hover pull-left m-right-xs" data-toggle="tooltip" data-original-title="Twitter"><i class="fa fa-twitter"></i></a>
                <a href="#" class="social-connect tooltip-test google-plus-hover pull-left m-right-xs" data-toggle="tooltip" data-original-title="Google Plus"><i class="fa fa-google-plus"></i></a>
                <a href="#" class="social-connect tooltip-test rss-hover pull-left m-right-xs" data-toggle="tooltip" data-original-title="Rss feed"><i class="fa fa-rss"></i></a>
                <a href="#" class="social-connect tooltip-test tumblr-hover pull-left m-right-xs" data-toggle="tooltip" data-original-title="Tumblr"><i class="fa fa-tumblr"></i></a>
                <a href="#" class="social-connect tooltip-test dribbble-hover pull-left m-right-xs" data-toggle="tooltip" data-original-title="Dribbble"><i class="fa fa-dribbble"></i></a>
                <a href="#" class="social-connect tooltip-test linkedin-hover pull-left m-right-xs" data-toggle="tooltip" data-original-title="Linkedin"><i class="fa fa-linkedin"></i></a>
                <a href="#" class="social-connect tooltip-test pinterest-hover pull-left" data-toggle="tooltip" data-original-title="Pinterest"><i class="fa fa-pinterest"></i></a>
            </div> -->
            <!-- /.col -->
            <div class="col-sm-3 padding-md">
                <p class="font-lg">联系我们</p>
                Email : endless.themes@gmail.com
                <div class="seperator"></div>
                <a class="btn btn-info" href="mailto:"><i class="fa fa-envelope"></i> 投诉建议</a>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div>
</footer>
</#macro>




<#macro masterBlank123 >
<!DOCTYPE html>
<html lang="zh-cn">
  
<head>
    <meta charset="utf-8">
    <title>计算机科学技术学院党建网 云平台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <link rel="shortcut icon" href="${basePath}/resources/img/favicon.ico?v=f6d031" type="image/x-icon">
    <link rel=icon href="${basePath}/resources/img/favicon.ico?v=f6d031" type="image/x-icon">
    <meta name="author" content="">

    <!-- Bootstrap core CSS -->
    <link href="${basePath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Font Awesome -->
	<link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">

	<!-- Pace -->
	<link href="${basePath}/resources/css/pace.css" rel="stylesheet">	

	<link href="${basePath}/resources/css/ymb_common.css" rel="stylesheet">
	
	<!-- Datatable 
	<link href="${basePath}/resources/css/jquery.dataTables_themeroller.css" rel="stylesheet">	
	-->
	<!-- alertify -->
	<link href="${basePath}/resources/css/alertify/alertify.core.css" rel="stylesheet">
	<link href="${basePath}/resources/css/alertify/alertify.bootstrap.css" rel="stylesheet">
	

	<!-- Parsley -->
	<link href="${basePath}/resources/css/parsley/parsley.css" rel="stylesheet">
	
	<!-- Chosen -->
	<link href="${basePath}/resources/css/chosen/chosen.min.css" rel="stylesheet"/>
	
	
	<!-- Endless -->
	<link href="${basePath}/resources/css/endless.min.css" rel="stylesheet">
	<link href="${basePath}/resources/css/endless-skin.css" rel="stylesheet">
	
	<!-- jquer ui -->
	<link href="${basePath}/resources/css/jqueryui/flick/jquery-ui.min.css" rel="stylesheet"/>
	<link href="${basePath}/resources/css/jqueryui/flick/jquery.ui.theme.css" rel="stylesheet"/>
	
	<!-- Dropzone -->
	<link href='${basePath}/resources/css/dropzone/dropzone.css' rel="stylesheet"/>
	
	<!-- Gritter -->
	<link href="${basePath}/resources/css/gritter/jquery.gritter.css" rel="stylesheet">
	<!-- Morris -->
	<link href="${basePath}/resources/css/morris.css" rel="stylesheet"/>	
	<!-- Jquery -->
	<script src="${basePath}/resources/js/jquery-1.10.2.min.js"></script>
	
	<!-- Dropzone -->
	<script src='${basePath}/resources/js/dropzone.js'></script>
	
	<!-- jquery ui -->
	<script src="${basePath}/resources/js/i18n/jquery-ui-i18n.js"></script>	
	<script src="${basePath}/resources/js/jquery.ui.core.js"></script>	
	<script src="${basePath}/resources/js/jquery.ui.datepicker.min.js"></script>
	
	<!-- Gritter -->
	<script src="${basePath}/resources/js/jquery.gritter.min.js"></script>
	
	<script language="javascript">
		$.basePath = "${basePath}";
	</script>
  </head>

  <body class="${bodyClass}">
	<#nested>
	
	<!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	
	<!-- Bootstrap -->
    <script src="${basePath}/resources/bootstrap/js/bootstrap.min.js"></script>
   
	<!-- Modernizr -->
	<script src='${basePath}/resources/js/modernizr.min.js'></script>
   
    <!-- Pace -->
	<script src='${basePath}/resources/js/pace.min.js'></script>
	
	<!-- Popup Overlay -->
	<script src='${basePath}/resources/js/jquery.popupoverlay.min.js'></script>
   
    <!-- Slimscroll -->
	<script src='${basePath}/resources/js/jquery.slimscroll.min.js'></script>
    
	<!-- Cookie -->
	<script src='${basePath}/resources/js/jquery.cookie.min.js'></script>

	<!-- Endless -->
	<script src="${basePath}/resources/js/endless/endless.js"></script>
	
	<!-- Parsley -->
	<script src="${basePath}/resources/js/parsley.min.js"></script>

	<!-- alertify -->
	<script src="${basePath}/resources/js/alertify/alertify.min.js"></script>
	
	<!-- Chosen -->
	<script src='${basePath}/resources/js/chosen.jquery.min.js'></script>	
	
	<!-- Datatable 
	<script src='${basePath}/resources/js/jquery.dataTables.min.js'></script>	
	-->
	
	<!-- ueditor -->
    <script type="text/javascript" charset="utf-8" src="${basePath}/resources/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${basePath}/resources/js/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${basePath}/resources/js/ueditor/lang/zh-cn/zh-cn.js"></script>
  	

  </body>

</html>
</#macro>

