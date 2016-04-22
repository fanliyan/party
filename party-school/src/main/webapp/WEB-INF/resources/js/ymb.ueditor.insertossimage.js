 $(function(){
		var contentImageDropzone = null;
		var contentImgArray = new Array();
		var thisEditor = null;

		$.insertContentImage = function(){
			if($("#localimagepanel").hasClass("active")){
				if(contentImageDropzone != null && typeof contentImageDropzone.getUploadingFiles() != 'undefined' && contentImageDropzone.getUploadingFiles().length != 0){
					alertify.alert("还有图片在上传中，请等待图片全部上传完成再插入！");
				}
				else{
					thisEditor.execCommand("insertimage",contentImgArray);
					$("#ueditorImageModal").modal('hide');
				}
			}
			else{
				if($('#insertImageModalUrlFrom').parsley().validate()){
					if($("#imageurl").val() != ""){
						url = $("#imageurl").val();
						if(url.toLowerCase().indexOf("http") != 0){
							url = "http://" + url;
							thisEditor.execCommand("insertimage",{src:url,width:$("#imagewidth").val(),height:$("#imageheight").val()});
						}
						
						$("#ueditorImageModal").modal('hide');
					}
				}
			}
			
		}
		
    	// 编辑器图片上传的插入框
		modalHtml = '<div class="modal fade" id="ueditorImageModal" aria-hidden="true" style="display: none;">'+
					'	<div class="modal-dialog">'+
					'		<div class="modal-content">'+
					'			<div class="modal-header">'+
					'				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>'+
					'				<h4>插入图片</h4>'+
					'			</div>'+
					'			<div class="panel panel-default">'+
					'				<div class="panel-tab clearfix">'+
					'					<ul class="tab-bar">'+
					'						<li class="active"><a href="#localimagepanel" data-toggle="tab"><i class="fa fa-upload"></i> 上传本地图片</a></li>'+
					'						<li><a href="#imageurlpanel" data-toggle="tab"><i class="fa fa-picture-o"></i> 插入网络图片</a></li>'+
					'					</ul>'+
					'				</div>'+
					'				<div class="panel-body">'+
					'					<div class="tab-content">'+
					'						<div class="tab-pane fade in active" id="localimagepanel">'+
					'							<div class="modal-body" id="ueditorImageModalFormPanel"></div>'+
					'						</div>'+
					'						<div class="tab-pane fade" id="imageurlpanel">'+
					'							<form class="form-horizontal" id="insertImageModalUrlFrom">'+
					'								<div class="form-group">'+
					'									<label class="col-lg-2 control-label">图片网址</label>'+
					'									<div class="col-lg-10">'+
					'										<input type="text" class="form-control input-sm" id="imageurl" placeholder="URL地址" data-parsley-type="url">'+
					'									</div><!-- /.col -->'+
					'								</div>'+
					'								<div class="form-group">'+
					'									<label class="col-lg-2 control-label">高度</label>'+
					'									<div class="col-lg-2">'+
					'										<input type="text" class="form-control input-sm" id="imageheight" placeholder="图像高度" >'+
					'									</div><!-- /.col -->'+
					'									<label class="col-lg-2 control-label">宽度</label>'+
					'									<div class="col-lg-2">'+
					'										<input type="text" class="form-control input-sm" id="imagewidth" placeholder="图像宽度" >'+
					'									</div><!-- /.col -->'+
					'								</div>'+
					'							</form>'+
					'						</div>'+
					'					</div>'+
					'				</div>'+
					'			</div>'+
					'			<div class="modal-footer">'+
					'				<button class="btn btn-sm btn-success" data-dismiss="modal" aria-hidden="true">取消</button>'+
					'				<a href="javascript:$.insertContentImage();" class="btn btn-danger btn-sm" id="btnBindAccountEmail" >插入图片</a>'+
					'		    </div>'+
					'		</div><!-- /.modal-content -->'+
					'	</div><!-- /.modal-dialog -->';
		
		if($("#ueditorImageModal").length<=0){
			$("body").append(modalHtml);
			
			// 增加form
			$("#ueditorImageModalFormPanel").html('<form action="" class="dropzone" style="overflow-y:scroll;height:260px" id="ueditorImageModalForm">' +
						'	  <div class="fallback">' +
						'		<input name="file" type="file" />' +
						'	  </div>' +
						'</form>');
						
			$("#ueditorImageModalForm").dropzone({
				  url: $.basePath + "/main/imgupload",
				  paramName: "file", // The name that will be used to transfer the file
				  acceptedFiles: ".jpg,.jpeg,.png,.gif,.bmp",
				  maxFilesize: 10, // MB
				  init: function() {
				  	this.on("addedfile",function(file){
				    	contentImageDropzone = this;
				  	});
				  	
				    this.on("success", function(file,data) {
				        if(data.success){
				        	contentImgArray.push({src:data.imageUrl});
				        }
				    });
				  }
			});
		}
		
	    UE.registerUI('insertOSSImage',function(editor,uiName){
			//注册按钮执行时的command命令,用uiName作为command名字，使用命令默认就会带有回退操作
		    editor.registerCommand(uiName,{
		        execCommand:function(cmdName,value){
		            alert(value);
		        },
		        queryCommandValue:function(){
		            alert(value);
		        }
		     
    		});
		        
		    //参考addCustomizeButton.js
		    var btn = new UE.ui.Button({
		        name:'dialogbutton' + uiName,
		        title:'插入图片',
		        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
		        cssRules :'background-position: -725px 41px;',
		        onclick:function () {
		        	thisEditor = editor;
		        	if(contentImageDropzone != null){
						contentImageDropzone.removeAllFiles();
					}
					$("#imageurl").val("");
					$("#imagewidth").val("");
					$("#imageheight").val("");
					contentImgArray = new Array();
					
					$("#ueditorImageModal").modal('show');
		        }
		    },2);
		
		    return btn;
		}/*index 指定添加到工具栏上的那个位置，默认时追加到最后,editorId 指定这个UI是那个编辑器实例上的，默认是页面上所有的编辑器都会添加这个按钮*/);
	    
});