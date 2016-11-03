<#import "/master/master-frame.ftl" as master />

<#include "/function.ftl">
<@master.masterFrame pageTitle=["学生管理","学生角色管理","学生角色列表"]>
<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
    <thead>
    <tr>
        <th>学生角色名</th>
        <th>创建时间</th>
        <th>最后修改时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
        <#list SRoleModel as srole>
        <tr>
            <td>${srole.name!}</td>
           <td>${srole.createTime?string('yyyy-MM-dd HH:mm:ss')}
            <td>${srole.lastModifyTime?string('yyyy-MM-dd HH:mm:ss')}</td>
            <td>
                <a class="btn btn-xs btn-success" href="${basePath}/srole/grantSRoleCourse?sroleId=${srole.roleId}"><i class="fa fa-wrench fa-lg"></i> 分配课程</a>
               <#-- <a class="btn btn-xs btn-success" href=""><i class="fa fa-wrench fa-lg"></i> 编辑</a>
                <a class="btn btn-xs btn-danger" href=""><i class="fa fa-trash-o fa-lg"></i> 删除</a>-->
            </td>
        </tr>
        </#list>
    </tbody>
</table>
</@master.masterFrame>