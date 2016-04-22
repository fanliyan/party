/*
 * 移民帮文件选择和上传插件
 * create by liwei 
 * Version 1.0
 * 
 * 2015-07-10
 */
(function($){ 
	Dropzone.autoDiscover = false;
	var ymbFileDropzone = null;
	var ymbFileSelectMobalPanel = '<div class="modal fade" id="ymbFileSelectMobalPanel" aria-hidden="true" style="display: none;">'+
				'	<div class="modal-dialog">'+
				'		<div class="modal-content">'+
				'			<div class="modal-header">'+
				'				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>'+
				'				<h4>选择文件</h4>'+
				'			</div>'+
				'			<div class="panel panel-default">'+
				'				<div class="panel-tab clearfix">'+
				'					<ul class="tab-bar">'+
				'						<li class="active"><a href="#localFilePanel" data-toggle="tab"><i class="fa fa-upload"></i> 上传本地文件</a></li>'+
				'						<li><a href="#urlFilePanel" data-toggle="tab"><i class="fa fa-picture-o"></i> 插入网络文件</a></li>'+
				'					</ul>'+
				'				</div>'+
				'				<div class="panel-body">'+
				'					<div class="tab-content">'+
				'						<div class="tab-pane fade in active" id="localFilePanel">'+
				'							<div class="modal-body" id="localFileFormPanel"></div>'+
				'						</div>'+
				'						<div class="tab-pane fade" id="urlFilePanel">'+
				'							<form class="form-horizontal" id="urlFileForm">'+
				'								<div class="form-group">'+
				'									<label class="col-lg-2 control-label">文件地址</label>'+
				'									<div class="col-lg-10">'+
				'										<input type="text" class="form-control input-sm" id="fileUrl" placeholder="文件地址" data-parsley-type="url">'+
				'									</div><!-- /.col -->'+
				'								</div>'+
				'							</form>'+
				'						</div>'+
				'					</div>'+
				'				</div>'+
				'			</div>'+
				'			<div class="modal-footer">'+
				'				<button class="btn btn-sm btn-success" data-dismiss="modal" aria-hidden="true">取消</button>'+
				'				<a class="btn btn-danger btn-sm" id="btnInsertFile" >插入</a>'+
				'		    </div>'+
				'		</div><!-- /.modal-content -->'+
				'	</div><!-- /.modal-dialog -->';
	var ymbUploadFiles = new Array();
	
	$.fn.selectFile = function(callback){ 
		if($("#ymbFileSelectMobalPanel").length<=0){
			$("body").append(ymbFileSelectMobalPanel);
			
		}
		
		return this.each(function() {
    		$(this).click(function(){
    			var maxFile = $(this).attr("maxFile");
    			var acceptedFile = $(this).attr("acceptedFile");
				if(!acceptedFile)
    				acceptedFile=".jpg,.jpeg,.png,.gif,.bmp";
    			
    			if(maxFile == ""){
    				maxFile = 1;
    			}
    			//if(acceptedFile != ""){
    			//	acceptedFile = acceptedFile + "," + $(this).attr("acceptedFile");
    			//}
    			
    			var formId = "uploadForm" + Math.ceil(Math.random()*35000);
				// 增加form
				$("#localFileFormPanel").html('<form id="' + formId + '" class="dropzone">' +
						'	  <div class="fallback">' +
						'		<input name="file" type="file" />' +
						'	  </div>' +
						'</form>');
				var action="imgupload";
				var max = 10;//图片最大10M
				if(acceptedFile.indexOf('.mp3')>=0){
					action ='fileupload';
					max=30;
				}
    			$("#"+formId).dropzone({
					  url: $.basePath + "/main/"+action,
					  paramName: "file", // The name that will be used to transfer the file
					  acceptedFiles: acceptedFile,
					  maxFilesize: max, // MB
					  maxFiles:parseInt(maxFile),
					  dictMaxFilesExceeded:"最多只能上传 " + maxFile + " 个文件",
					  autoProcessQueue: true,//自动上传
					  init: function() {
					  	this.on("addedfile",function(file){
					  		ymbFileDropzone = this;
					  	});
					  	
					  	this.on("maxfilesexceeded", function(file) { 
					  		alertify.alert("最多只能上传 " + maxFile + " 个文件");
					  		this.removeFile(file); 
					  	});
					  	
					    this.on("success", function(file,data) {
					        if(data.success){
					    		ymbUploadFiles.push(data.imageUrl);
					        }
					    });
					 }
				});
	    		
	    		clickbutton = $(this);
	    		$("#btnInsertFile").off("click");
	    		$("#btnInsertFile").on("click",function(){
					if(ymbFileDropzone != null && typeof ymbFileDropzone.getUploadingFiles() != 'undefined' && ymbFileDropzone.getUploadingFiles().length != 0){
						alertify.alert("还有图片在上传中，请等待图片全部上传完成再插入！");
					}else{
						if($("#urlFilePanel").hasClass("active")){
							if($('#urlFileForm').parsley().validate()){
								if($("#fileUrl").val() != ""){
									url = $("#fileUrl").val();
									if(url.toLowerCase().indexOf("http") != 0){
										url = "http://" + url;
									}
									ymbUploadFiles = new Array();
									ymbUploadFiles.push(url);
								}
							}
						}
						$("#ymbFileSelectMobalPanel").modal('hide');
						callback(clickbutton,ymbUploadFiles);
						$("#"+formId).remove();
						if(ymbFileDropzone != null){
							ymbFileDropzone.removeAllFiles();
							ymbUploadFiles = new Array();
						}
					}

                    //if($("#urlFilePanel").hasClass("active")){
	    				//if($('#urlFileForm').parsley().validate()){
	    				//	if($("#fileUrl").val() != ""){
	    				//		url = $("#fileUrl").val();
	    				//		if(url.toLowerCase().indexOf("http") != 0){
	    				//			url = "http://" + url;
	    				//		}
	    				//		ymbUploadFiles = new Array();
	    				//		ymbUploadFiles.push(url);
	    				//	}
	    				//}
                    //}
                    //else if(ymbFileDropzone != null && typeof ymbFileDropzone.getUploadingFiles() != 'undefined' && ymbFileDropzone.getUploadingFiles().length != 0){
						//alertify.alert("还有图片在上传中，请等待图片全部上传完成再插入！");
                    //}
                    //else{
		    			//$("#ymbFileSelectMobalPanel").modal('hide');
						//callback(clickbutton,ymbUploadFiles);
						//$("#"+formId).remove();
		    			//if(ymbFileDropzone != null){
		    	    //		ymbFileDropzone.removeAllFiles();
		    	    //		ymbUploadFiles = new Array();
		    	    //	}
		    	    //}
	    		});
    	
    			$("#ymbFileSelectMobalPanel").modal('show');
    		});
    	});
	};
})(jQuery); 