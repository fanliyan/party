/**
 * Created by ky on 2016/4/23.
 */
!function(){
    $(function () {
        $("#ask").on("click",function(){
            $("#question").val("");
            $("#question-modal").modal();
        });
        $("#success-modal").on("click",function(){
            var question = $("#question").val();
            if(!(question&&question!="")){
                alertify.alert("问题不能为空");
                return;
            }
            if(question.length>200){
                alertify.alert("问题不能超过200字");
            }
            $.ajax({
                cache: true,
                type: "POST",
                url: $.basePath+"/faq/askquestion/",
                data:{question:question},
                async: false,
                error: function (request) {
                    alertify.alert("错误：服务器异常！");
                },
                success: function (data) {
                    if (data.success) {
                        alertify.alert("问题已提交~");
                        $("#question-modal").modal("hide");
                    }
                    else {
                        alertify.alert("错误:" + data.message);
                    }
                }
            });
        });
    });
}();