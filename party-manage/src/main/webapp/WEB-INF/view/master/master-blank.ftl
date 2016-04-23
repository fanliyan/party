<#global basePath=springMacroRequestContext.contextPath>
<#global defaultAvatar=basePath+"/resources/img/default_avatar.png">

<#macro masterBlank bodyClass="overflow-hidden">
<!DOCTYPE html>
<html lang="zh-cn">
  
<head>
    <meta charset="utf-8">
    <title>计算机党校 云平台</title>
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

    <!-- timepicker -->
    <link href="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.css" rel="stylesheet" type="text/css"/>

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
  	
	<!-- yiminbang -->	
	<script src="${basePath}/resources/js/ymb.common.js"></script>
	<script src="${basePath}/resources/js/ymb.menu.js"></script>
	<script src="${basePath}/resources/js/ymb.ueditor.insertossimage.js"></script>
	<script src="${basePath}/resources/js/ymb.selectAndUploadFile.js"></script>

    <!-- timepicker -->
    <script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.js" type="text/javascript"></script>
    <script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>


  </body>
</html>
</#macro>

