		<table border="1">
			<thead>
				<tr>
					<th>序号</th>
                    <th>类型</th>
					<th>姓名</th>
					<th>性别</th>
					<th>出生年月</th>
					<th>身份证号</th>
					<th>民族</th>
					<th>电话</th>
					<th>省份</th>
					<th>城市</th>
					<th>地区</th>
					<th>学号</th>
                    <th>院</th>
                    <th>系</th>
                    <th>班级</th>
                    <th>系部</th>
                    <th>支部/支委</th>
                    <th>重点积极分子时间</th>
                    <th>预备党员时间</th>
                    <th>正式党员时间</th>
				</tr>
			</thead>
			<tbody>
				<#list listResponse.studentModelList as studnet>
				<tr>
					<td>${studnet_index+1}</td>
					<td><#if studnet.type==1>老师<#else>学生</#if></td>
					<td>${studnet.name}</td>
					<td><#if studnet.gender?? && studnet.gender>女<#else>男</#if></td>
					<td>${(studnet.birthday?string('yyyy-MM-dd'))!}</td>
					<td>${(studnet.idCard)!}</td>

                    <td>${(studnet.nationModel.name)!}</td>

                    <td>${(studnet.phone)!}</td>

                    <td>${(studnet.provinceModel.name)!}</td>
                    <td>${(studnet.cityModel.name)!}</td>
                    <td>${(studnet.areaModel.name)!}</td>

                    <td>${(studnet.studnetCode.name)!}</td>

                    <td>${(studnet.departmentModel.name)!}</td>
                    <td>${(studnet.xiModel.name)!}</td>
                    <td>${(studnet.classModel.name)!}</td>

                    <td>${(studnet.departmentModel.name)!}</td>
                    <td>${(studnet.branchModel.name)!}</td>

                    <td>${(studnet.keyActiveMemberTime?string('yyyy-MM-dd'))!}</td>
                    <td>${(studnet.probationaryMemberTime?string('yyyy-MM-dd'))!}</td>
                    <td>${(studnet.cardCarryingMemberTime?string('yyyy-MM-dd'))!}</td>

                </tr>
				</#list>
			</tbody>
		</table>