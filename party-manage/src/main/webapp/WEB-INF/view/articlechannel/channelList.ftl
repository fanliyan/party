<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />

<@master.masterFrame pageTitle=["文章频道管理","频道","频道列表"]>

<div class="panel panel-default table-responsive">

    <div class="panel-heading"></div>
    <div class="panel-body">

        <div class="panel-body ">
            <a class="btn btn-xs btn-info" href="${basePath}/articlechannel/add"><i class="fa fa-plus fa-lg"></i> 新增</a>
        </div>
    </div>
    <div class="padding-md clearfix">

            <div class="col-sm-6">

                <table class="table table-condensed table-hover table-striped" id="dataTable">
                    <thead>
                    <tr>
                        <th>频道ID</th>
                        <th>频道名称</th>
                        <#--<th>标签类别</th>-->
                        <th>父节点</th>
                        <th>权重</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                        <#if channelList?? && channelList?size gt 0>
                            <#list channelList as channel>
                            <tr>
                                <td>${channel.channelId!}</td>
                                <td>${channel.name!}</td>
                                <td>${channel.parentId!}</td>
                                <td>${channel.weight!}</td>
                                <td>${channel.createTime?string('yyyy-MM-dd HH:mm:ss')}</td>
                                <td>
                                    <a class="btn btn-xs btn-warning" href="${basePath}/articlechannel/edit?id=${channel.channelId}"><i
                                            class="fa  fa-edit  fa-lg"></i> 编辑</a>
                                    <a class="btn btn-xs btn-danger" href="javascript:$.del(${channel.channelId});"><i
                                            class="fa  fa-times  fa-lg"></i> 删除</a>
                                </td>
                            </tr>
                            </#list>
                        <#else>
                        <tr>
                            <td colspan=7 class="text-center">没有数据</td>
                        </tr>
                        </#if>
                    </tbody>
                </table>

            </div>
            <div class="col-sm-6">

                <div id="nestable" class="dd" >

                    ${nestable}

                </div>

            </div>


    </div><!-- /.padding-md -->
</div><!-- /panel -->

<script src="${basePath}/resources/js/jquery.nestable.min.js"></script>
<script >
    $(function(){
        var nestable = $('.dd').nestable({
            maxDepth:20,
//            group:1,
        });

        //改变排序之后的数据
        var old_value = JSON.stringify($('.dd').nestable('serialize'));

        nestable.on('change', function(){
            var nestable_obj = $('.dd').nestable('serialize');
            var nestable_str = JSON.stringify(nestable_obj);

            if(nestable_str!=old_value){
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/articlechannel/dynamicChange",
                    data: {data:nestable_str},
                    async: false,
                    error: function (request) {
                        alertify.alert("错误：服务器异常！");
                    },
                    success: function (data) {
                        if (data.success) {
                            location.reload();
                        } else {
                            alertify.alert("错误:" + data.message);
                        }
                    }
                });
            }
        });
    });
</script>
<script language="javascript">
    $.del = function (id) {
        alertify.confirm("注意，一经删除，无法恢复！是否继续？", function (e) {
            if (e) {
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${basePath}/articlechannel/del",
                    data: {"id": id},
                    async: false,
                    error: function (request) {
                        alertify.alert("错误：服务器异常！");
                    },
                    success: function (data) {
                        if (data.success) {
                            location.reload();
                        }
                        else {
                            alertify.alert("错误:" + data.message);
                        }
                    }
                });
            }
        });
    };
</script>
</@master.masterFrame>