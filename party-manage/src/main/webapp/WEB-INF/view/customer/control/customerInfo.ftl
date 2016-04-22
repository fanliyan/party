<#macro customerInfo >
	<div class="modal fade" id="customerInfoModal" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="width:700px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4>客户详情</h4>
				</div>
				<div class="modal-body">
					<table class="table">
						<tr>
							<td align="right">
								<label class="control-label">客户编码</label>
								<input type="hidden" id="grantCustomerId" name="customerId" />
							</td>
							<td id="customerId_info">
							</td>
							<td align="right">
								<label class="control-label">录入日期</label>
							</td>
							<td id="createTime_info">
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">客户姓名</label>
							</td>
							<td id="name_info">
							</td>
							<td align="right">
								<label class="control-label">性别</label>
							</td>
							<td id="gender_info">
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">电话</label>
							</td>
							<td id="phone_info">
							</td>
							<td align="right">
								<label class="control-label">电话2</label>
							</td>
							<td id="phone2_info">
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">微信</label>
							</td>
							<td id="wechat_info">
							</td>
							<td align="right">
								<label class="control-label">QQ</label>
							</td>
							<td id="qq_info">
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">邮箱</label>
							</td>
							<td id="email_info">
							</td>
							<td align="right">
								<label class="control-label">所在地</label>
							</td>
							<td id="city_info">
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">客户来源</label>
							</td>
							<td id="source_info">
							</td>
							<td align="right">
								<label class="control-label">来源备注</label>
							</td>
							<td id="sourceRemark_info">
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">咨询方式</label>
							</td>
							<td id="consultType_info">
							</td>
							<td align="right">
								<label class="control-label">咨询时间</label>
							</td>
							<td id="consultTime_info">
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">客户状态</label>
							</td>
							<td id="status_info">
								
							</td>
							<td align="right">
								<label class="control-label">跟进机构</label>
							</td>
							<td id="company_info">
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">业务类型</label>
							</td>
							<td colspan="3" id="businessType_info">
								
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">意向国家</label>
							</td>
							<td colspan="3" id="country_info">
								
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">移民目的</label>
							</td>
							<td colspan="3" id="purpose_info">
								
							</td>
						</tr>
						
						<tr>
							<td align="right">
								<label class="control-label">移民方式</label>
							</td>
							<td colspan="3" id="immigrantType_info">
								
							</td>
						</tr>
						<tr>
							<td align="right">
								<label class="control-label">备注</label>
							</td>
							<td colspan="3" id="remark_info">
								
							</td>
						</tr>
						<tr>
							<td colspan="4" align="left"><label class="control-label">跟进记录</label></td>
						</tr>
						<tr>
							<td colspan="4">
								<table id="followLog_info" class="table table-bordered" style="border-collapse: collapse;">
									<thead>
									<tr>
										<th>跟进人</th>
										<th>跟进方式</th>
										<th>跟进时间</th>
										<th>跟进状态</th>
										<th width="20%">跟进内容</th>
										<th>后续跟进时间</th>
										<th>操作</th>
									</tr>
									</thead>
									<tbody id="tbody">
									</tbody>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script language="javascript">
		function getCustomer(customerId){
			$.ajax({
				cache: false,
				type: "POST",
				url:"${basePath}/customer/grantAdvisor",
				data:"customerId="+customerId,
				async: false,
				error: function(request) {
					$('#customerInfoModal').modal('hide');
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){
						$("#advisorUseridtd").val("");
						var customer=data.customer;
						$("#customerId_info").text(customer.customerId);
						$("#grantCustomerId").val(customer.customerId);
						$("#createTime_info").text(customer.createTimeStr);
						$("#name_info").text(customer.name);
						$("#gender_info").text(customer.gender=='M'?'男':'女');
						$("#phone_info").text(customer.phone==null?'':customer.phone);
						$("#phone2_info").text(customer.phone2==null?'':customer.phone2);
						$("#email_info").text(customer.email==null ?'':customer.email);
						$("#wechat_info").text(customer.wechat==null?'':customer.wechat);
						$("#qq_info").text(customer.qq==null?'':customer.qq);
						var province=customer.province;
						var city=customer.city;
						var address="";
						if(province!=null){
							address=province.provinceName;
						}
						if(city!=null){
							if(address!=""){
								address=address+"-"+city.cityName
							}else{
								address=city.cityName;
							}
						}
						$("#city_info").text(address);
						$("#source_info").text(customer.sourceName==null?'':customer.sourceName);
						$("#sourceRemark_info").text(customer.sourceRemark==null?'':customer.sourceRemark);
						$("#consultType_info").text(customer.consultType == null?'':customer.consultType);
						$("#consultTime_info").text(customer.consultTimeStr == null?'':customer.consultTimeStr);
						$("#status_info").text(customer.statusName == null?'':customer.statusName);
						$("#companyCode_info").text(customer.company == null?'':customer.company.companyName);
						$("#remark_info").text(customer.remark == null?'':customer.remark);
						var countryList=customer.intentionCountry;
						if(countryList!=null){
							var country="";
							$.each(countryList,function(){
								country+=this.countryName+" "
							});
							$("#country_info").text(country);
						}
						var purposeList=customer.purpose;
						if(purposeList!=null){
							var purpose="";
							$.each(purposeList,function(){
								purpose=purpose+this.purposeName+" ";
							});
							$("#purpose_info").text(purpose);
						}
						
						var businessTypeList=customer.businessTypeList;
						if(businessTypeList!=null){
							var businessType="";
							$.each(businessTypeList,function(){
								if(this.businessTypeId==1){
									if(customer.adviserUser!=null){
									businessType=businessType+"移民  跟进顾问:"+customer.adviserUser.userName+"<br/>";
									}
								}else{
									businessType=businessType+this.businessTypeName+"  "+this.businessRemark+"<br/>";
								}
							});
							$("#businessType_info").html(businessType);
						}
						
						var immigrantType=customer.immigrantType;
						if(immigrantType!=null && immigrantType!=''){
							var types=immigrantType.split(',');
							var type="";
							$.each(types,function(i,n){
								$("#grantForm [name='immigrantType'][value='"+n+"']").prop("checked",true);
								if(n==1){
									type=type+" 投资移民";
								}else if(n==2){
									type=type+"企业家移民";
								}else if(n==3){
									type=type+"创业移民/自雇";
								}else if(n==4){
									type=type+"技术移民";
								}else if(n==5){
									type=type+"亲属移民";
								}
							});
							$("#immigrantType_info").text(type);
						}
						if(data.hasViewFollowLog){
							var followLogList=customer.followLog;
							$("#tbody").html("");
							if(followLogList!=null){
								$.each(followLogList,function(){
									var nextFollowDate=this.nextFollowDate;
									if(nextFollowDate==null){
										nextFollowDate='';
									}
									var status='';
									if(this.followStatus){
										status="已跟进";
									}else{
										status="未跟进";
									}
									$("#tbody").append("<tr><td>"+this.followUserName+"</td><td>"+this.followName+"</td><td>"
									+this.followDate+"</td><td>"+status+"</td><td>"+this.followDesc+"</td><td>"+nextFollowDate+"</td><td>"
									+"<a class=\"btn btn-xs btn-primary\" href=\"#followFormModal\" data-toggle=\"modal\" "
									+"onclick=\"openFollowpanel('','','"+this.followLogId+"')\"><i class=\"fa fa-info-circle fa-lg\"></i> 修改</a></td></tr>");
								});
							}else{
								$("#tbody").append("<tr><td colspan='7'>没有数据</td></tr>");
							}
						}else{
							$("#tbody").html("");
							$("#tbody").append("<tr><td colspan='7'>您没有权限查看跟进日志</td></tr>");
						}
					}
					else{
						$('#customerInfoModal').modal('hide');
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}
	</script>
</#macro>