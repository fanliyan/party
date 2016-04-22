<#macro productImageFrom imageModels >
<div class="panel-heading">产品图片<div class="pull-right"><a class="btn btn-xs btn-info" id="insertImg" maxFile="10" selectIndex="0"><i class="fa fa-plus"> 增加产品图片</i></a></div></div>
<div class="panel-body" id="housePricePanel">
	<div class="row">
		<div class="col-md-12" id="productImagesPanel">
			<#assign productImages = "">
			<#if imageModels?exists>
				<#list imageModels as m>
					<#assign productImages = productImages + "|" + m.imageUrl >
					<div class="thumbnail relative pull-left" id='${m.imageUrl?replace("[^\\w]+","","ir")}'>
						<img src="${m.imageUrl}@80h_80w_1e_1c"/>
						<label class="label-radio text-center">
							<input type="radio" name="isCover" value="${m.imageUrl}" <#if m.isCover>checked</#if> data-parsley-required="true" data-parsley-required-message="必须选择一个封面">
							<span class="custom-radio"></span>
							封面
					   &nbsp;&nbsp;<a class="btn btn-xs btn-danger" onclick="removeProductImages('${m.imageUrl}')"><i class="fa fa-trash-o"></i></a>
						</label>
					</div>
					<div style="width:10px" class="pull-left">&nbsp;</div>
				</#list>
			</#if>
		</div>
	</div><!-- /row -->
	<input type="hidden" name="productImages" id="productImages" value="${productImages}" />
</div>



<script language="javascript">
function removeProductImages(imageUrl){
	$("#productImages").val($("#productImages").val().replace("|"+imageUrl,""));
	$("#"+getImageId(imageUrl)).remove();
}

function getImageId(imageUrl){
	return imageUrl.replace(/[^\w]+/g,"");
}

$(function(){
	$("#insertImg").selectFile(function(clickbutton,uploadFiles){
		if(uploadFiles.length > 0){
			for (var i = 0; i < uploadFiles.length; i++) {
	    	$("#productImagesPanel").append('<div class="thumbnail relative pull-left" id="' + getImageId(uploadFiles[i]) + '">' +
									'	<img src="' + uploadFiles[i] + '@80h_80w_1e_1c"/>' +
									'	<label class="label-radio text-center">' +
									'		<input type="radio" name="isCover" value="' + uploadFiles[i] + '"  data-parsley-required="true" data-parsley-required-message="必须选择一个封面"> ' +
									'		<span class="custom-radio"></span>' +
									'		封面' +
									'   &nbsp;&nbsp;<a class="btn btn-xs btn-danger" onclick="removeProductImages(\'' + uploadFiles[i] + '\');"><i class="fa fa-trash-o"></i></a>' +
									'	</label>' +
									'</div><div style="width:10px" class="pull-left">&nbsp;</div>');
	 		$("#productImages").val($("#productImages").val()+"|"+uploadFiles[i]);
	 	}
		}
	});
});
</script>

</#macro>