 $(function(){
		var contentFileDropzone = null;
		var contentFileArray = new Array();
		var thisEditor = null;

		$.insertContentFile = function(){
			if($("#localfilepanel").hasClass("active")){
				if(contentFileDropzone != null && typeof contentFileDropzone.getUploadingFiles() != 'undefined' && contentFileDropzone.getUploadingFiles().length != 0){
					alertify.alert("还有文件在上传中，请等待图片全部上传完成再插入！");
				}
				else{
                    for(i in contentFileArray){
                        thisEditor.execCommand("inserthtml","<a href=\""
                            +contentFileArray[i].url+"\" title=\""+contentFileArray[i].title
                            +"\" target=\"_blank\">"+contentFileArray[i].title+"</a>");
                    }
					$("#ueditorFileModal").modal('hide');
				}
			}
		};
		
    	// 编辑器图片上传的插入框
		modalHtml = '<div class="modal fade" id="ueditorFileModal" aria-hidden="true" style="display: none;">'+
					'   <div class="modal-dialog">'+
					'		<div class="modal-content">'+
					'			<div class="modal-header">'+
					'				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>'+
					'				<h4>插入图片</h4>'+
					'			</div>'+
					'			<div class="panel panel-default">'+
					'				<div class="panel-tab clearfix">'+
					'					<ul class="tab-bar">'+
					'						<li class="active"><a href="#localfilepanel" data-toggle="tab"><i class="fa fa-upload"></i> 上传本地文件</a></li>'+
					// '						<li><a href="#fileurlpanel" data-toggle="tab"><i class="fa fa-picture-o"></i> 插入网络图片</a></li>'+
					'					</ul>'+
					'				</div>'+
					'				<div class="panel-body">'+
					'					<div class="tab-content">'+
					'						<div class="tab-pane fade in active" id="localfilepanel">'+
					'							<div class="modal-body" id="ueditorFileModalFormPanel"></div>'+
					'						</div>'+
					'					</div>'+
					'				</div>'+
					'			</div>'+
					'			<div class="modal-footer">'+
					'				<button class="btn btn-sm btn-success" data-dismiss="modal" aria-hidden="true">取消</button>'+
					'				<a href="javascript:$.insertContentFile();" class="btn btn-danger btn-sm" id="btnBindAccountEmail" >插入文件</a>'+
					'		    </div>'+
					'		</div><!-- /.modal-content -->'+
					'	</div><!-- /.modal-dialog -->';
		
		if($("#ueditorFileModal").length<=0){
			$("body").append(modalHtml);
			
			// 增加form
			$("#ueditorFileModalFormPanel").html('<form action="" class="dropzone" style="overflow-y:scroll;height:260px" id="ueditorFileModalForm">' +
						'	  <div class="fallback">' +
						'		<input name="file" type="file" />' +
						'	  </div>' +
						'</form>');
						
			$("#ueditorFileModalForm").dropzone({
				  url: $.basePath + "/main/fileupload",
				  paramName: "file", // The name that will be used to transfer the file
				  acceptedFiles: ".pdf,.zip,.txt,.rar,.ppt,.pptx,.xls,.xlsx,.doc,.docx",
				  maxFilesize: 20, // MB
				  init: function() {
				  	this.on("addedfile",function(file){
				    	contentFileDropzone = this;
				  	});
				  	
				    this.on("success", function(file,data) {
				        if(data.success){
                            contentFileArray.push({url:data.imageUrl,title:file.name});
				        }
				    });
				  }
			});
		}
		
	    UE.registerUI('insertOSSFile',function(editor,uiName){
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
		        title:'插入文件',
		        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
		        cssRules :'background-position: -650px 41px;',
		        onclick:function () {
		        	thisEditor = editor;
		        	if(contentFileDropzone != null){
                        contentFileDropzone.removeAllFiles();
					}
					$("#fileurl").val("");
					contentFileArray = new Array();
					
					$("#ueditorFileModal").modal('show');
		        }
		    },3);
		
		    return btn;
		}/*index 指定添加到工具栏上的那个位置，默认时追加到最后,editorId 指定这个UI是那个编辑器实例上的，默认是页面上所有的编辑器都会添加这个按钮*/);
	    
});