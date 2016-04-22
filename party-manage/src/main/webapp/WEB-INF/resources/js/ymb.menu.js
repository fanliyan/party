$(".moduleGroupMenu"+$.getCookie("activeGroupMenu")).addClass("active");
$(".moduleMenu"+$.getCookie("activeMenu")).addClass("active");

$("#wrapper").removeClass("sidebar-hide");
$("#wrapper").removeClass("sidebar-mini");
$("#wrapper").addClass($.cookie("wrapperClass"));

$("#menuToggle").click(function(){
	$.removeCookie("wrapperClass",{path:"/"});
	if(!$("#wrapper").hasClass("sidebar-hide")){
		$.cookie("wrapperClass","sidebar-hide",{expires:30,path:"/"});
	}
});

$("#sizeToggle").click(function(){

	$.removeCookie("wrapperClass",{path:"/"});
	if(!$("#wrapper").hasClass("sidebar-mini")){
		$.cookie("wrapperClass","sidebar-mini",{expires:30,path:"/"});
	}
});
