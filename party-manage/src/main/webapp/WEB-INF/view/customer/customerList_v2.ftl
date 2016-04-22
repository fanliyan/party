<#import "/master/master-frame.ftl" as master />
<#import "/control/common/splitPage.ftl" as splitPage1 />
<#import "/control/common/citySelect.ftl" as citySelect>
<#import "/customer/control/customerInfo.ftl" as customerInfo>
<@master.masterFrame pageTitle=["系统管理","客户","移民帮客户列表"]>
	<div class="panel-body">
		<a href="#formModal" class="btn btn-info btn-xs" data-toggle="modal"><i class="fa fa-plus fa-lg"></i> 新增客户</a>
	</div>
	<div class="panel panel-default table-responsive">
		<div class="panel-heading">条件搜索</div>
		<div class="panel-body">
			<form id="searchForm" class="form-inline no-margin" action="" method="post">
				<input type='hidden' id="pageNo" name='pageNo' value='${(response.splitPage.pageNo)!}' />
				<input type="hidden" id="orderBy" name="orderBy" value="${orderBy!}"/>
				<div class="row">
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label">客户编码</label>
							<div>
								<input name="customerId" type="text" class="form-control input-sm" value="${(customer.customerId)! }"/>
							</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label">客户姓名</label>
							<div>
								<input name="name" type="text" class="form-control input-sm" value="${(customer.name)! }"/>
							</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label">手机</label>
							<div>
								<input name="phone" type="text" class="form-control input-sm" value="${(customer.phone)! }"/>
							</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label">客户来源</label>
							<div class="col-md-12 nav">
								<select class="form-control chzn-select" name="sourceId" data-placeholder="请选客户来源">
									<option value="">全部</option>
									<#if sourceList?? && sourceList?size gt 0>
										<#list sourceList as source>
											<#if (customer.sourceId)?? && customer.sourceId==source.sourceId>
												<option value="${source.sourceId}" selected>${source.source}</option>
											<#else>
												<option value="${source.sourceId}">${source.source}</option>
											</#if>
										</#list>
									</#if>
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label">所在地区</label>
							<div>
								<input name="cityName" type="text" class="form-control input-sm" value="${(customer.cityName)! }"/>
							</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label">跟进顾问</label>
							<div>
								<input name="adviserName" type="text" class="form-control input-sm" value="${(customer.adviserName)! }"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label">意向国家</label>
							<div>
								<input name="countryName" type="text" class="form-control input-sm" value="${(customer.countryName)! }"/>
							</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label">客户状态</label>
							<div class="col-md-12 nav">
								<select class="form-control chzn-select" name="statusId" >
									<option value="">全部</option>
									<#if statusList?? && statusList?size gt 0>
										<#list statusList as status>
											<#if (customer.statusId)?? && customer.statusId==status.statusId>
												<option value="${status.statusId}" selected>${status.status}</option>
											<#else>
												<option value="${status.statusId}">${status.status}</option>
											</#if>
										</#list>
									</#if>
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label">跟进状态</label>
							<div class="col-md-12 nav">
								<select class="form-control chzn-select" name="followStatus" >
									<option value="">全部</option>
									<option value="1" <#if (customer.followStatus)?? && customer.followStatus==1>selected</#if>>已跟进</option>
									<option value="0" <#if (customer.followStatus)?? && customer.followStatus==0>selected</#if>>未跟进</option>
									
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-2">
					 	<div class="form-group">
							<label class="control-label">开始时间</label>
							<div>
								<input id="starttime" name="startTime" class="form-control input-sm"  type="text" value="${(customer.startTime)!}"/>
							</div>
						</div>
					</div>
					<div class="col-md-2">
					 	<div class="form-group">
							<label class="control-label">结束时间</label>
							<div >
								<input id="endtime" name="endTime" class="form-control input-sm" type="text" value="${(customer.endTime)!}"/>
							</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label class="control-label"></label>
							<div>
								<button type="button" class="btn btn-sm btn-success" onclick="search();"><i class="fa fa-search" style="font-size:16px;"></i></button>
								<#if hasDownload?? && hasDownload>
								<button type="button" class="btn btn-sm btn-success" onclick="download();"><i class="fa fa-search" style="font-size:16px;"></i>导出跟进客户</button>
								</#if>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<table class="table table-bordered table-condensed table-hover table-striped" id="responsiveTable">
			<thead>
				<tr>
					<th>客户编码</th>
					<th>姓名</th>
					<th>电话</th>
					<th>居住城市</th>
					<th>客户来源</th>
					<th>来源说明</th>
					<th>
						<div style="cursor:pointer;" onclick="createTimeOrder();">
							<div style="width:90%;float:left;">录入日期</div>
							<div style="10%;float:right;">
								<#if orderBy?? && orderBy=='createTimeDown'>
									<i class="fa fa-sort-down fa-sm"></i>
								<#elseif orderBy?? && orderBy=='createTimeUp'>
									<i class="fa fa-sort-up fa-sm"></i>
								<#else>
									<i class="fa fa-sort fa-sm"></i>
								</#if>
							</div>
						</div>
					</th>
					<th>跟进顾问</th>
					<th>最新进度</th>
					<th>
						<div style="cursor:pointer;" onclick="followTimeOrder();">
							<div style="width:90%;float:left;">最新跟进日期</div>
							<div style="10%;float:right;">
								<#if orderBy?? && orderBy=='followTimeDown'>
									<i class="fa fa-sort-down fa-sm"></i>
								<#elseif orderBy?? && orderBy=='followTimeUp'>
									<i class="fa fa-sort-up fa-sm"></i>
								<#else>
									<i class="fa fa-sort fa-sm"></i>
								</#if>
							</div>
						</div>
					</th>
					<th>客户状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<#list response.customerList as customer>
				<tr>
					<td>${customer.customerId}</td>
					<td><a href="#customerInfoModal" data-toggle="modal" onclick="getCustomer('${customer.customerId}');" data-toggle="tooltip" data-placement="left" title="点击查看详情">${customer.name}</a></td>
					<td>${customer.phone!}</td>
					<td>${(customer.province.provinceName)!}<#if (customer.province.provinceName)??&&(customer.city.cityName)??>-</#if>${(customer.city.cityName)!}</td>
					<td>${customer.sourceName!}</td>
					<td>${customer.sourceRemark!}</td>
					<td>${customer.createTime?string('yyyy-MM-dd')}</td>
					<td>${(customer.adviserUser.userName)!}</td>
					<td>
						<#if (customer.followLog)?? && customer.followLog?size gt 0>
							<span class="label label-success">已跟进</span>
						<#else>
							<span class="label label-warning">未跟进</span>
						</#if>
					</td>
					<td>
						<#if (customer.followLog)?? && customer.followLog?size gt 0>
							<#list customer.followLog as followLog>
								<#if followLog_index == 0>
									${followLog.followTime?string('yyyy-MM-dd')}
								</#if>
							</#list>
						</#if>
					</td>
					<td>${(customer.statusName)!}</td>
					<td>
						<#if ((customer.adviserUserid)?? && customer.adviserUserid==userid) || (hasEdit?? && hasEdit)>
							<a class="btn btn-xs btn-success" href="#formModal" data-toggle="modal" onclick="editCust('${customer.customerId}');"><i class="fa fa-wrench fa-lg"></i> 编辑</a>
						</#if>
						<#if hasGrantAdvisor?? && hasGrantAdvisor>
							<a class="btn btn-xs btn-warning" href="#grantAdvisor" data-toggle="modal" onclick="grantAdvisor('${customer.customerId}')"><i class="fa fa-info-circle fa-lg"></i> 分配顾问</a>
						</#if>
						<#if ((customer.adviserUserid)?? && customer.adviserUserid==userid) || (hasAddFollowlog?? && hasAddFollowlog)>
							<a class="btn btn-xs btn-primary" href="#followFormModal" data-toggle="modal" onclick="openFollowpanel('${customer.customerId}','${customer.name}','','${customer.statusId!}')"><i class="fa fa-info-circle fa-lg"></i> 增加跟进</a>
						</#if>
							<a class="btn btn-xs btn-info" href="#customerInfoModal" data-toggle="modal" onclick="getCustomer('${customer.customerId}');"><i class="fa fa-info fa-lg"></i> 详情</a>
					</td>
				</tr>
				</#list>
			</tbody>
		</table>
		<@splitPage1.splitPage pageCount=response.splitPage.pageCount pageNo=response.splitPage.pageNo formId="searchForm" recordCount=response.splitPage.recordCount />
	</div><!-- /panel -->
	<div class="modal fade" id="formModal" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4>编辑客户信息</h4>
				</div>
				<div class="modal-body">
					<form id="customerForm" class="form-horizontal" method="post">
						<table class="table">
							<tr>
								<td align="right">
									<label class="control-label"><span class="text-danger">*</span>客户姓名</label>
								</td>
								<td>
									<input name="name" type="text" class="form-control input-sm" id="name" placeholder="字符最大长度20"
									 data-parsley-trigger="blur"
									 data-parsley-required="true"
									 data-parsley-maxlength="20"
									 data-parsley-maxlength-message="名字最大不能超过20个字"
									 data-parsley-required-message="客户姓名不可为空"/>
									 <input type="hidden" name="customerId" id="customerId" />
								</td>
								<td align="right">
									<label class="control-label"><span class="text-danger">*</span>性别</label>
								</td>
								<td>
									<label class="label-radio inline">
										<input type="radio" name="gender" value="M" checked="checked">
										<span class="custom-radio"></span>
										男
									</label>
									<label class="label-radio inline">
										<input type="radio" name="gender" value="F" >
										<span class="custom-radio"></span>
										女
									</label>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">电话</label>
								</td>
								<td>
									<input type="text" name="phone" class="form-control input-sm" id="phone" placeholder="请输入客户手机"
									 data-parsley-trigger="blur"
									 data-parsley-required-message="客户手机不可为空"
									 data-parsley-mobilePhone
									 data-parsley-mobilePhone-message="请填写正确的手机号"
									/>
								</td>
								<td align="right">
									<label class="control-label">电话2</label>
								</td>
								<td>
									<input type="text" name="phone2" class="form-control input-sm" id="phone2" placeholder="请输入客户电话"
										 data-parsley-maxlength="50"
										 data-parsley-maxlength-message="邮箱长度不能超过50个字符"
										/>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">邮箱</label>
								</td>
								<td>
									<input type="email" name="email" class="form-control input-sm" id="email" placeholder="请输入客户邮箱"
										 data-parsley-maxlength="50"
										 data-parsley-maxlength-message="邮箱长度不能超过50个字符"
										/>
								</td>
								<td align="right">
									<label class="control-label"><span class="text-danger">*</span>跟进机构</label>
								</td>
								<td>
									<select class="form-control chzn-select" id="companyCode" name="companyCode" data-placeholder="请选择跟进机构" required data-parsley-required-message="跟进机构不可为空" data-parsley-errors-container="#companyError">
										<option ></option>
										<#if companyList?? && companyList?size gt 0>
											<#list companyList as company>
												<option value="${company.companyCode!}">${company.companyName!}</option>
											</#list>
										</#if>
									</select>
									<span id="companyError"></span>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">微信</label>
								</td>
								<td>
									<input type="text" name="wechat" class="form-control input-sm" id="wechat" placeholder="请输入微信号"
									 data-parsley-trigger="blur"
									 data-parsley-maxlength="50"
									 data-parsley-maxlength-message="长度不能超过50个字符"
									/>
								</td>
								<td align="right">
									<label class="control-label">QQ</label>
								</td>
								<td>
									<input type="text" name="qq" class="form-control input-sm" id="qq" placeholder="请输入QQ号码"
										 data-parsley-trigger="blur"
										 data-parsley-maxlength="11"
										 data-parsley-maxlength-message="长度不能超过11个字符"
										/>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">所在地</label>
								</td>
								<td colspan="3">
									<@citySelect.citySelect countryModelList=countryModelList selectedCityId=(customerModel.cityId)!0 notNull=false/>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label"><span class="text-danger">*</span>客户来源</label>
								</td>
								<td>
									<select class="form-control chzn-select" id="sourceId" name="sourceId" data-placeholder="请选客户来源" required data-parsley-required-message="客户来源不可为空" data-parsley-errors-container="#sourceError">
										<option ></option>
										<#if sourceList?? && sourceList?size gt 0>
											<#list sourceList as source>
												<option value="${source.sourceId}">${source.source}</option>
											</#list>
										</#if>
									</select>
									<span id="sourceError"></span>
								</td>
								<td align="right">
									<label class="control-label">来源备注</label>
								</td>
								<td>
									<input type="text" id="sourceRemark" name="sourceRemark" class="form-control input-sm" placeholder="请输入来源备注"
										 data-parsley-maxlength="50"
										 data-parsley-maxlength-message="长度不能超过50个字符"
										/>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">咨询方式</label>
								</td>
								<td>
									<select class="form-control chzn-select" id="consultTypeId" name="consultTypeId" data-placeholder="请选择咨询方式" >
										<option ></option>
										<#if consultList?? && consultList?size gt 0>
											<#list consultList as consult>
												<option value="${consult.consultTypeId}">${consult.consultType}</option>
											</#list>
										</#if>
									</select>
								</td>
								<td align="right">
									<label class="control-label">咨询时间</label>
								</td>
								<td>
									<input type="text" id="consultTime" name="consultTimeStr" class="form-control input-sm" placeholder="请选择咨询日期"/>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">客户状态</label>
								</td>
								<td>
									<select class="form-control chzn-select" id="statusIdEdit" name="statusId" data-placeholder="请选择客户状态">
										<option ></option>
										<#if statusList?? && statusList?size gt 0>
											<#list statusList as status>
												<option value="${status.statusId}">${status.status}</option>
											</#list>
										</#if>
									</select>
								</td>
								<td align="right">
								</td>
								<td>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">备注</label>
								</td>
								<td colspan="3">
									<textarea id="remark" name="remark" class="form-control" rows="2"></textarea>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">业务类型</label>
								</td>
								<td colspan="3">
									<table width="100%" style="border-collapse: separate;">
										<tr>
											<td>
												<span >
													<input type="checkbox" id="businessTypeIds1" name="businessTypeIds" value="1">
													<span class="custom-checkbox"></span>
													移民
												</span>
											</td>
											<td>
												<#if hasGrantAdvisor?? && hasGrantAdvisor>
													<select class="form-control chzn-select" id="grantAdvisorid" name="adviserUserid" data-placeholder="请选择顾问" data-parsley-errors-container="#adviso_Error">
														<option ></option>
														<#if advisorUsers?? && advisorUsers?size gt 0>
															<#list advisorUsers as advisor>
																<option value="${advisor.userid}">${advisor.userName!}</option>
															</#list>
														</#if>
													</select>
													<span id="adviso_Error"></span>
												<#else>
													&nbsp;
												</#if>
											</td>
										</tr>
										<tr>
											<td>
												<span >
													<input type="checkbox" name="businessTypeIds" value="2">
													<span class="custom-checkbox"></span>
													咨询留学
												</span>
											</td>
											<td>
												<input type="text" id="businessRemark2" name="businessRemark2" class="form-control input-sm" placeholder="请输入备注"
												 data-parsley-maxlength="50"
												 data-parsley-maxlength-message="长度不能超过50个字符"
												/>
											</td>
										</tr>
										<tr>
											<td>
												<span >
													<input type="checkbox" name="businessTypeIds" value="3">
													<span class="custom-checkbox"></span>
													海外金融资产配置
												</span>
											</td>
											<td>
												<input type="text" id="businessRemark3" name="businessRemark3" class="form-control input-sm" placeholder="请输入备注"
												 data-parsley-maxlength="50"
												 data-parsley-maxlength-message="长度不能超过50个字符"
												/>
											</td>
										</tr>
										<tr>
											<td>
												<span >
													<input type="checkbox" name="businessTypeIds" value="4">
													<span class="custom-checkbox"></span>
													海外置业
												</span>
											</td>
											<td>
												<input type="text" id="businessRemark4" name="businessRemark4" class="form-control input-sm" placeholder="请输入备注"
												 data-parsley-maxlength="50"
												 data-parsley-maxlength-message="长度不能超过50个字符"
												/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">意向国家</label>
								</td>
								<td colspan="3">
									<#if countryList?? && countryList?size gt 0>
										<#if countryList?size gt 4>
											<#assign countryMore=true>
										</#if>
									<table width="100%" style="border-collapse: separate;">
										<tr>
											<#list countryList as country>
												<#if country_index lt 4>
												<td>
													<span >
														<input type="checkbox" name="intCountrys" value="${country.countryId}">
														<span class="custom-checkbox"></span>
														${country.countryName!}
													</span>
												</td>
												</#if>
											</#list>
											<#if countryMore?? && countryMore>
												<td align="right"><a href="#countryMore" data-toggle="collapse">更多 <i class="fa fa-arrows-v"></i> </a></td>
											</#if>
										</tr>
										<#if countryMore?? && countryMore>
										<tr>
											<td colspan="4">
												<div class="panel-body no-padding collapse" id="countryMore">
												<table width="100%" style="border-collapse: separate;">
													<#assign i=1>
													<#list countryList as country>
														<#if country_index gt 3 && i%4==1>
															<tr>
														</#if>
														<#if country_index gt 3>
															<td>
																<span>
																	<input type="checkbox" name="intCountrys" value="${country.countryId}">
																	<span class="custom-checkbox"></span>
																	${country.countryName!}
																</span>
															</td>
														</#if>
														<#if country_index gt 3 && i%4==0>
															</tr>
														</#if>
														<#assign i=i+1>
													</#list>
												</table>
												</div>
											</td>
										</tr>
										</#if>
									</table>
									</#if>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">移民目的</label>
								</td>
								<td colspan="3">
									<#if purposeList?? && purposeList?size gt 0>
										<#if purposeList?size gt 3>
											<#assign purposeMore=true>
										</#if>
									<table width="100%" style="border-collapse: separate;">
										<tr>
											<#list purposeList as purpose>
												<#if purpose_index lt 3>
												<td>
													<span >
														<input type="checkbox" name="purposeId" value="${purpose.purposeId}">
														<span class="custom-checkbox"></span>
														${purpose.purposeName!}
													</span>
												</td>
												</#if>
											</#list>
											<#if purposeMore?? && purposeMore>
												<td align="right"><a href="#purposeMore" data-toggle="collapse">更多 <i class="fa fa-arrows-v"></i> </a></td>
											</#if>
										</tr>
										<#if purposeMore?? && purposeMore>
										<tr>
											<td colspan="4">
												<div class="panel-body no-padding collapse" id="purposeMore">
												<table width="100%" style="border-collapse: separate;">
													<#assign i=1>
													<#list purposeList as purpose>
														<#if purpose_index gt 2 && i%3==1>
															<tr>
														</#if>
														<#if purpose_index gt 2>
															<td>
																<span>
																	<input type="checkbox" name="purposeId" value="${purpose.purposeId}">
																	<span class="custom-checkbox"></span>
																	${purpose.purposeName!}
																</span>
															</td>
														</#if>
														<#if purpose_index gt 2 && i%3==0>
															</tr>
														</#if>
														<#assign i=i+1>
													</#list>
												</table>
												</div>
											</td>
										</tr>
										</#if>
									</table>
									</#if>
								</td>
							</tr>
							
							<tr>
								<td align="right">
									<label class="control-label">移民方式</label>
								</td>
								<td colspan="3">
									<table width="100%" style="border-collapse: separate;">
										<tr>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="1">
													<span class="custom-checkbox"></span>
													投资移民
												</span>
											</td>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="2">
													<span class="custom-checkbox"></span>
													企业家移民
												</span>
											</td>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="3">
													<span class="custom-checkbox"></span>
													创业移民/自雇
												</span>
											</td>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="4">
													<span class="custom-checkbox"></span>
													技术移民
												</span>
											</td>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="5">
													<span class="custom-checkbox"></span>
													亲属移民
												</span>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							
							<tr>
								<td colspan="4" align="center">
									<button type="button" class="btn btn-success" id="submitButton">保存</button>
									<button type="button" class="btn btn-success" data-dismiss="modal" aria-hidden="true">取消</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="grantAdvisor" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" style="width:700px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4>分配顾问</h4>
				</div>
				<div class="modal-body">
					<form id="grantForm" class="form-horizontal" method="post">
						<table class="table">
							<tr>
								<td align="right">
									<label class="control-label">客户编码</label>
									<input type="hidden" id="grantCustomerId" name="customerId" />
									<input type="hidden" name="flag" value="grantAdvisor" />
								</td>
								<td id="customerIdtd">
								</td>
								<td align="right">
									<label class="control-label">录入日期</label>
								</td>
								<td id="createTimetd">
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">客户姓名</label>
								</td>
								<td id="nametd">
								</td>
								<td align="right">
									<label class="control-label">性别</label>
								</td>
								<td id="gendertd">
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">电话</label>
								</td>
								<td id="phonetd">
								</td>
								<td align="right">
									<label class="control-label">电话2</label>
								</td>
								<td id="phone2td">
								</td>
							<tr>
								<td align="right">
									<label class="control-label">微信</label>
								</td>
								<td id="wechattd">
								</td>
								<td align="right">
									<label class="control-label">QQ</label>
								</td>
								<td id="qqtd">
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">邮箱</label>
								</td>
								<td id="emailtd">
								<td align="right">
									<label class="control-label">所在地</label>
								</td>
								<td id="citytd">
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">客户来源</label>
								</td>
								<td id="sourcetd">
								</td>
								<td align="right">
									<label class="control-label">来源备注</label>
								</td>
								<td id="sourceRemarktd">
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">咨询方式</label>
								</td>
								<td id="consultTypetd">
								</td>
								<td align="right">
									<label class="control-label">咨询时间</label>
								</td>
								<td id="consultTimetd">
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">备注</label>
								</td>
								<td colspan="3" id="remarktd">
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">客户状态</label>
								</td>
								<td>
									<select class="form-control chzn-select" id="statusId" name="statusId" data-placeholder="请选择客户状态" data-parsley-required-message="客户状态不可为空" data-parsley-errors-container="#statusError">
										<option ></option>
										<#if statusList?? && statusList?size gt 0>
											<#list statusList as status>
												<option value="${status.statusId}">${status.status}</option>
											</#list>
										</#if>
									</select>
									<span id="statusError"></span>
								</td>
								<td align="right">
									<label class="control-label">跟进机构</label>
								</td>
								<td>
									<select class="form-control chzn-select" id="companyCodetd" name="companyCode" data-placeholder="请选择跟进机构" required data-parsley-required-message="跟进机构不可为空" data-parsley-errors-container="#companytdError">
										<option ></option>
										<#if companyList?? && companyList?size gt 0>
											<#list companyList as company>
												<option value="${company.companyCode!}">${company.companyName!}</option>
											</#list>
										</#if>
									</select>
									<span id="companytdError"></span>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">业务类型</label>
								</td>
								<td colspan="3">
									<table width="100%" style="border-collapse: separate;">
										<tr>
											<td>
												<span >
													<input type="checkbox" id="businessTypetd1" name="businessTypeIds" value="1">
													<span class="custom-checkbox"></span>
													移民
												</span>
											</td>
											<td>
												<select class="form-control chzn-select" id="advisorUseridtd" name="adviserUserid" data-placeholder="请选择顾问" data-parsley-errors-container="#advisor_Error">
													<option ></option>
													<#if advisorUsers?? && advisorUsers?size gt 0>
														<#list advisorUsers as advisor>
															<option value="${advisor.userid}">${advisor.userName!}</option>
														</#list>
													</#if>
												</select>
												<span id="advisor_Error"></span>
											</td>
										</tr>
										<tr>
											<td>
												<span >
													<input type="checkbox" id="businessTypetd2" name="businessTypeIds" value="2">
													<span class="custom-checkbox"></span>
													咨询留学
												</span>
											</td>
											<td>
												<input type="text" id="businessRemarktd2" name="businessRemark2" class="form-control input-sm" placeholder="请输入来源备注"
												 data-parsley-maxlength="50"
												 data-parsley-maxlength-message="长度不能超过50个字符"
												/>
											</td>
										</tr>
										<tr>
											<td>
												<span >
													<input type="checkbox" id="businessTypetd3" name="businessTypeIds" value="3">
													<span class="custom-checkbox"></span>
													海外金融资产配置
												</span>
											</td>
											<td>
												<input type="text" id="businessRemarktd3" name="businessRemark3" class="form-control input-sm" placeholder="请输入来源备注"
												 data-parsley-maxlength="50"
												 data-parsley-maxlength-message="长度不能超过50个字符"
												/>
											</td>
										</tr>
										<tr>
											<td>
												<span >
													<input type="checkbox" id="businessTypetd4" name="businessTypeIds" value="4">
													<span class="custom-checkbox"></span>
													海外置业
												</span>
											</td>
											<td>
												<input type="text" id="businessRemarktd4" name="businessRemark4" class="form-control input-sm" placeholder="请输入来源备注"
												 data-parsley-maxlength="50"
												 data-parsley-maxlength-message="长度不能超过50个字符"
												/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">意向国家</label>
								</td>
								<td colspan="3">
									<#if countryList?? && countryList?size gt 0>
										<#if countryList?size gt 4>
											<#assign countryMore=true>
										</#if>
									<table width="100%" style="border-collapse: separate;">
										<tr>
											<#list countryList as country>
												<#if country_index lt 4>
												<td>
													<span >
														<input type="checkbox" name="intCountrys" value="${country.countryId}">
														<span class="custom-checkbox"></span>
														${country.countryName!}
													</span>
												</td>
												</#if>
											</#list>
											<#if countryMore?? && countryMore>
												<td align="right"><a href="#grantCountryMore" data-toggle="collapse">更多 <i class="fa fa-arrows-v"></i> </a></td>
											</#if>
										</tr>
										<#if countryMore?? && countryMore>
										<tr>
											<td colspan="4">
												<div class="panel-body no-padding collapse" id="grantCountryMore">
												<table width="100%" style="border-collapse: separate;">
													<#assign i=1>
													<#list countryList as country>
														<#if country_index gt 3 && i%4==1>
															<tr>
														</#if>
														<#if country_index gt 3>
															<td>
																<span>
																	<input type="checkbox" name="intCountrys" value="${country.countryId}">
																	<span class="custom-checkbox"></span>
																	${country.countryName!}
																</span>
															</td>
														</#if>
														<#if country_index gt 3 && i%4==0>
															</tr>
														</#if>
														<#assign i=i+1>
													</#list>
												</table>
												</div>
											</td>
										</tr>
										</#if>
									</table>
									</#if>
								</td>
							</tr>
							<tr>
								<td align="right">
									<label class="control-label">移民目的</label>
								</td>
								<td colspan="3">
									<#if purposeList?? && purposeList?size gt 0>
										<#if purposeList?size gt 3>
											<#assign purposeMore=true>
										</#if>
									<table width="100%" style="border-collapse: separate;">
										<tr>
											<#list purposeList as purpose>
												<#if purpose_index lt 3>
												<td>
													<span >
														<input type="checkbox" name="purposeId" value="${purpose.purposeId}">
														<span class="custom-checkbox"></span>
														${purpose.purposeName!}
													</span>
												</td>
												</#if>
											</#list>
											<#if purposeMore?? && purposeMore>
												<td align="right"><a href="#grantPurposeMore" data-toggle="collapse">更多 <i class="fa fa-arrows-v"></i> </a></td>
											</#if>
										</tr>
										<#if purposeMore?? && purposeMore>
										<tr>
											<td colspan="4">
												<div class="panel-body no-padding collapse" id="grantPurposeMore">
												<table width="100%" style="border-collapse: separate;">
													<#assign i=1>
													<#list purposeList as purpose>
														<#if purpose_index gt 2 && i%3==1>
															<tr>
														</#if>
														<#if purpose_index gt 2>
															<td>
																<span>
																	<input type="checkbox" name="purposeId" value="${purpose.purposeId}">
																	<span class="custom-checkbox"></span>
																	${purpose.purposeName!}
																</span>
															</td>
														</#if>
														<#if purpose_index gt 2 && i%3==0>
															</tr>
														</#if>
														<#assign i=i+1>
													</#list>
												</table>
												</div>
											</td>
										</tr>
										</#if>
									</table>
									</#if>
								</td>
							</tr>
							
							<tr>
								<td align="right">
									<label class="control-label">移民方式</label>
								</td>
								<td colspan="3">
									<table width="100%" style="border-collapse: separate;">
										<tr>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="1">
													<span class="custom-checkbox"></span>
													投资移民
												</span>
											</td>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="2">
													<span class="custom-checkbox"></span>
													企业家移民
												</span>
											</td>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="3">
													<span class="custom-checkbox"></span>
													创业移民/自雇
												</span>
											</td>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="4">
													<span class="custom-checkbox"></span>
													技术移民
												</span>
											</td>
											<td>
												<span >
													<input type="checkbox" name="immigrantType" value="5">
													<span class="custom-checkbox"></span>
													亲属移民
												</span>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							
							<tr>
								<td colspan="4">
									<table id="followLog" class="table table-bordered" style="border-collapse: collapse;">
										<tr>
											<th>跟进人</th>
											<th>跟进方式</th>
											<th>跟进时间</th>
											<th>跟进状态</th>
											<th>跟进内容</th>
											<th>后续跟进时间</th>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<button type="button" class="btn btn-success" id="submitButton1">保存</button>
									<button type="button" class="btn btn-success" data-dismiss="modal" aria-hidden="true">取消</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<@customerInfo.customerInfo/>
	<div class="modal fade" id="followFormModal" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4>编辑跟进</h4>
				</div>
				<div class="modal-body">
					<div class="panel panel-default">
						<div class="panel-body">
							<form id="adForm" class="form-horizontal form-border">
								<input type="hidden" name="customerId" id="followCustomerId" value=""/>
								<input type="hidden" name="followLogId" id="followLogId" value=""/>
								<div class="form-group">
									<label class="col-md-3 control-label">客户姓名</label>
									<div class="col-md-8">
										<p class="form-control-static" id="customerName"></p>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">客户状态</label>
									<div class="col-md-8">
										<select class="form-control chzn-select" id="flgCustomerStatusId" name="customerStatus" data-placeholder="请选择客户状态" required data-parsley-required-message="客户状态不可为空" data-parsley-errors-container="#statusError">
											<option ></option>
											<#if statusList?? && statusList?size gt 0>
												<#list statusList as status>
													<option value="${status.statusId}">${status.status}</option>
												</#list>
											</#if>
										</select>
										<span id="statusError"></span>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">跟进方式</label>
									<div class="col-md-8">
										<select class="form-control chzn-select" id="flgFollowType" name="followType" data-placeholder="请选择跟进方式" required data-parsley-required-message="跟进方式不可为空">
											<option value=""></option>
											<#if followTypeModels ??>
												<#list followTypeModels as type>
													<option value="${type.followType}">${type.followTypeName}</option>
												</#list>
											</#if>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">跟进状态</label>
									<div class="col-md-8">
										<select class="form-control chzn-select" id="flgFollowStatus" name="followStatus" data-placeholder="请选择跟进状态" required data-parsley-required-message="跟进状态不可为空">
											<option value="1">已跟进</option>
											<option value="0">未跟进</option>
										</select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label">跟进时间</label>
									<div class="col-md-8">
										<div class="input-group">
											<input id="time" name="followDate" placeholder="请点击选择跟进时间" class="form-control input-sm"
											 readonly type="text" value=""  required data-parsley-required-message="跟进时间不可为空"
											 data-parsley-errors-container="#timeError"
											 />
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
										<ul class="parsley-errors-list filled" id="timeError"><li class="parsley-required"></li></ul>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label">跟进内容</label>
									<div class="col-md-8">
										<textarea id="followDesc" name="followDesc" class="form-control" rows="5" placeholder="请输入跟进内容" data-parsley-required="true"
										 data-parsley-required-message="跟进内容不可为空"
										 data-parsley-maxlength="500"
										 data-parsley-maxlength-message="内容长度不能超过500"
										 ></textarea>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label">后续跟进时间</label>
									<div class="col-md-8">
										<div class="input-group">
											<input id="nexttime" name="nextFollowDate" placeholder="请点击选择跟进时间" class="form-control input-sm" 
											 readonly type="text" value=""/>
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
										<ul class="parsley-errors-list filled" id="nameError"><li class="parsley-required"></li></ul>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1" class="col-md-3 control-label">上传图片</label>
									<div class="col-md-8">
										<input type="hidden" name="materialDemo#id#" id="materialDemo#id#">
										<a class="btn btn-sm btn-primary insertFile" maxFile="10"><i class="fa fa-book"></i> 选择文件</a>
									</div>
								</div>
								<div class="form-group" id="imagesDiv">
									
								</div>
								<div class="form-group text-center">
									<button type="button" class="btn btn-success" onclick="saveFollowlog();">保存</button>
									<button type="button" class="btn btn-success" data-dismiss="modal" aria-hidden="true">取消</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
	
<link href="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.css" rel="stylesheet" type="text/css" />
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-addon.min.js" type="text/javascript"></script>
<script src="${basePath}/resources/js/timepicker/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>
	<script language="javascript">
	window.ParsleyConfig = {
		validators: {
			mobilePhone: {
				fn: function (value) {
					var reg = /^1[3|4|5|7|8][0-9]\d{8}$/;  
					return reg.test(value);
				},
				priority: 32
			}
		} 
	};
	function search(){
		$("#pageNo").val("1");
		$("#searchForm").attr("action","${basePath}/customer/list");
		$("#searchForm").submit();
	}
	$(document).ready(function(){
		$("#consultTime").datetimepicker({
			hour: 12,
			minute: 30,
			timeFormat: "HH:mm",
			dateFormat: "yy-mm-dd",
			minDate: new Date(2015, 0, 01, 00, 00),
			maxDate: new Date()
		});
		
		$('#time').datetimepicker({
			hour: 12,
			minute: 30,
			timeFormat: "HH:mm",
			dateFormat: "yy-mm-dd",
			minDate: new Date(2015, 0, 01, 00, 00),
			maxDate: new Date()
		});
		$('#nexttime').datetimepicker({
			hour: 12,
			minute: 30,
			timeFormat: "HH:mm",
			dateFormat: "yy-mm-dd",
			minDate: new Date(),
			yearRange:'-1:+1',
			changeMonth: true,
			changeYear: true
		});
		$('#starttime').datepicker({
			dateFormat: "yy-mm-dd",
			maxDate: new Date(),
			yearRange:'-2:+2',
			changeMonth: true,
			changeYear: true, 
			onSelect:function(dateText,inst){
				$("#endtime").datepicker("option","minDate",dateText);
			}
		});
		$('#endtime').datepicker({
			dateFormat: "yy-mm-dd",
			maxDate: new Date(),
			yearRange:'-2:+2',
			changeMonth: true,
			changeYear: true,
			onSelect:function(dateText,inst){
				$("#starttime").datepicker("option","maxDate",dateText);
			}
		});
		
		$(".insertFile").selectFile(function(clickbutton,uploadFiles){
			if(uploadFiles.length > 0){
				var imgHtml="";
				for(var i=0;i<uploadFiles.length;i++){
					imgHtml+="<img style='width:80px;height:80px;' src='"+uploadFiles[i]+"' class='img-thumbnail'>";
					imgHtml+="<input type='hidden' name='imgs' value='"+uploadFiles[i]+"'>";
				}
				$("#imagesDiv").html(imgHtml);
			}
		});
	});
	function editCust(customerId){
		$.ajax({
			cache: false,
			type: "POST",
			url:"${basePath}/customer/grantAdvisor",
			data:"customerId="+customerId,
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					var customer=data.customer;
					$("#customerId").val(customerId);
					$("#name").val(customer.name);
					$("#gender").text(customer.gender=='M'?'男':'女');
					$("input[type='radio'][value='"+customer.gender+"']").attr("checked","checked");
					$("#phone").val(customer.phone==null?'':customer.phone);
					$("#phone2").val(customer.phone2==null?'':customer.phone2);
					$("#email").val(customer.email==null ?'':customer.email);
					$("#wechat").val(customer.wechat==null?'':customer.wechat);
					$("#qq").val(customer.qq==null?'':customer.qq);
					$("#remark").val(customer.remark==null?'':customer.remark);
					var provinceId=0;
					var cityId=0;
					if(customer.provinceId != null){
						provinceId=customer.provinceId;
					}
					if(customer.cityId != null){
						cityId=customer.cityId;
					}
					initProvenceAndCountry(cityId,provinceId);
					$("#sourceId").val(customer.sourceId==null?'':customer.sourceId);
					$('#sourceId').trigger('chosen:updated');
					$("#sourceRemark").val(customer.sourceRemark==null?'':customer.sourceRemark);
					$("#consultTypeId").val(customer.consultTypeId == null?'':customer.consultTypeId);
					$("#consultTypeId").trigger('chosen:updated');
					$("#statusIdEdit").val(customer.statusId == null?'':customer.statusId);
					$("#statusIdEdit").trigger('chosen:updated');
					$("#grantAdvisorid").val(customer.adviserUserid == null?'':customer.adviserUserid);
					$("#grantAdvisorid").trigger('chosen:updated');
					$("#companyCode").val(customer.companyCode == null?'':customer.companyCode);
					$("#companyCode").trigger('chosen:updated');
					$("#consultTime").val(customer.consultTimeStr == null?'':customer.consultTimeStr);
					var countryList=customer.intentionCountry;
					if(countryList!=null){
						$.each(countryList,function(){
							$("#customerForm [name='intCountrys'][value='"+this.countryId+"']").prop("checked",true);
						});
					}
					var purposeList=customer.purpose;
					if(purposeList!=null){
						$.each(purposeList,function(){
							$("#customerForm [name='purposeId'][value='"+this.purposeId+"']").prop("checked",true);
						});
					}
					
					var businessTypeList=customer.businessTypeList;
					if(businessTypeList!=null){
						$.each(businessTypeList,function(){
							if(this.businessTypeId==1){
							}else{
								$("#businessRemark"+this.businessTypeId).val(this.businessRemark);
								$("#businessRemark"+this.businessTypeId).attr("data-parsley-required",true);
							}
							$("#customerForm [name='businessTypeIds'][value='"+this.businessTypeId+"']").prop("checked",true);
						});
					}
					
					var immigrantType=customer.immigrantType;
					if(immigrantType!=null && immigrantType!=''){
						var types=immigrantType.split(',');
						$.each(types,function(i,n){
							$("#customerForm [name='immigrantType'][value='"+n+"']").prop("checked",true);
						});
					}
				}
				else{
					$('#formModal').modal('hide');
					alertify.alert("错误:" + data.message);
				}
			}
		});
	}
	function grantAdvisor(customerId){
		$.ajax({
			cache: false,
			type: "POST",
			url:"${basePath}/customer/grantAdvisor",
			data:"customerId="+customerId,
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					$("#advisorUseridtd").val("");
					var customer=data.customer;
					$("#customerIdtd").text(customer.customerId);
					$("#grantCustomerId").val(customer.customerId);
					$("#createTimetd").text(customer.createTimeStr);
					$("#nametd").text(customer.name);
					$("#gendertd").text(customer.gender=='M'?'男':'女');
					$("#phonetd").text(customer.phone==null?'':customer.phone);
					$("#phone2td").text(customer.phone2==null?'':customer.phone2);
					$("#emailtd").text(customer.email==null ?'':customer.email);
					$("#wechattd").text(customer.wechat==null?'':customer.wechat);
					$("#qqtd").text(customer.qq==null?'':customer.qq);
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
					$("#citytd").text(address);
					$("#sourcetd").text(customer.sourceName==null?'':customer.sourceName);
					$("#sourceRemarktd").text(customer.sourceRemark==null?'':customer.sourceRemark);
					$("#consultTypetd").text(customer.consultType == null?'':customer.consultType);
					$("#consultTimetd").text(customer.consultTimeStr == null?'':customer.consultTimeStr);
					$("#statusId").val(customer.statusId == null?'':customer.statusId);
					$("#statusId").trigger('chosen:updated');
					$("#companyCodetd").val(customer.companyCode == null?'':customer.companyCode);
					$("#remarktd").text(customer.remark==null?'':customer.remark);
					$("#companyCodetd").trigger('chosen:updated');
					var countryList=customer.intentionCountry;
					if(countryList!=null){
						$.each(countryList,function(){
							$("#grantForm [name='intCountrys'][value='"+this.countryId+"']").prop("checked",true);
						});
					}
					var purposeList=customer.purpose;
					if(purposeList!=null){
						$.each(purposeList,function(){
							$("#grantForm [name='purposeId'][value='"+this.purposeId+"']").prop("checked",true);
						});
					}
					
					var businessTypeList=customer.businessTypeList;
					if(businessTypeList!=null){
						$.each(businessTypeList,function(){
							if(this.businessTypeId==1){
								$("#advisorUseridtd").val(customer.adviserUserid);
								$("#advisorUseridtd").trigger('chosen:updated');
								$("#advisorUseridtd").attr("data-parsley-required",true);
							}else{
								$("#businessRemarktd"+this.businessTypeId).val(this.businessRemark);
								$("#businessRemarktd"+this.businessTypeId).attr("data-parsley-required",true);
							}
							$("#grantForm [name='businessTypeIds'][value='"+this.businessTypeId+"']").prop("checked",true);
						});
					}
					
					var immigrantType=customer.immigrantType;
					if(immigrantType!=null && immigrantType!=''){
						var types=immigrantType.split(',');
						$.each(types,function(i,n){
							$("#grantForm [name='immigrantType'][value='"+n+"']").prop("checked",true);
						});
					}
					$("#followLog").html('');
					if(data.hasViewFollowLog){
						
						var followLogList=customer.followLog;
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
								$("#followLog").append("<tr><td>"+this.followUserName+"</td><td>"+this.followName+"</td><td>"+this.followDate+"</td><td>"+status+"</td><td>"+this.followDesc+"</td><td>"+nextFollowDate+"</td></tr>");
							});
						}
					}else{
						$("#followLog").append("<tr><td colspan='6'>您没有权限查看跟进日志</td></tr>");
					}
				}
				else{
					$('#grantAdvisor').modal('hide');
					alertify.alert("错误:" + data.message);
				}
			}
		});
	};
	$("#submitButton").click(function(){
		if($('#customerForm').parsley().validate()){
			$.ajax({
				cache: false,
				type: "POST",
				url:"${basePath}/customer/saveCustomer",
				data:$('#customerForm').serialize(),
				async: false,
				error: function(request) {
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){
						msgAlert();
						$("#searchForm").attr("action","${basePath}/customer/list");
						$("#searchForm").submit();
					}
					else{
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}
	});
	$("#grantAdvisorid").change(function(){
		$("#businessTypeIds1").prop("checked",true);
	});
	$("#submitButton1").click(function(){
		if($('#grantForm').parsley().validate()){
			$.ajax({
				cache: false,
				type: "POST",
				url:"${basePath}/customer/saveCustomer",
				data:$('#grantForm').serialize(),
				async: false,
				error: function(request) {
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){
						msgAlert();
						$("#searchForm").attr("action","${basePath}/customer/list");
						$("#searchForm").submit();
					}
					else{
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}
	});
	function openFollowpanel(customerId,customerName,followLogId,statusId){
		if(followLogId==""){
			$("#followCustomerId").val(customerId);
			$("#customerName").text(customerName);
			$("#flgCustomerStatusId").val(statusId);
			$("#flgCustomerStatusId").trigger('chosen:updated');
		}else{
			$("#followLogId").val(followLogId);
			$.ajax({
				cache: false,
				type: "POST",
				url:"${basePath}/customer/followLogInfo",
				data:"followLogId="+followLogId,
				async: false,
				error: function(request) {
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){
						var follow=data.followLog;
						$("#followCustomerId").val(follow.customer.customerId);
						$("#flgCustomerStatusId").val(follow.customer.statusId);
						$("#flgCustomerStatusId").trigger('chosen:updated');
						$("#customerName").text(follow.customer.name);
						$("#flgFollowType").val(follow.followType);
						$("#flgFollowType").trigger('chosen:updated');
						$("#time").val(follow.followDate);
						$("#nexttime").val(follow.nextFollowDate);
						$("#followDesc").val(follow.followDesc);
					}
					else{
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}
	}
	function saveFollowlog(){
		if($('#adForm').parsley().validate()){
			$.ajax({
				cache: false,
				type: "POST",
				url:"${basePath}/customer/saveFollow",
				data:$('#adForm').serialize(),
				async: false,
				error: function(request) {
					alertify.alert("错误：服务器异常！");
				},
				success: function(data) {
					if(data.success){
						msgAlert();
						$("#searchForm").attr("action","${basePath}/customer/list");
						$("#searchForm").submit();
					}
					else{
						alertify.alert("错误:" + data.message);
					}
				}
			});
		}
	}
	function initProvenceAndCountry(cityId,provinceId){
		if(cityId==0 && provinceId==0){
			return;
		}
		var url="${basePath}/common/";
		if(cityId==0){
			url+="getprovince?provinceId="+provinceId;
		}else{
			url+="getprovinceandcountry?cityId="+cityId;
		}
		$.ajax({
			cache: true,
			type: "GET",
			url:url,
			async: false,
			error: function(request) {
				alertify.alert("错误：服务器异常！");
			},
			success: function(data) {
				if(data.success){
					$("#countryId").val(data.countryId);
					$('#countryId').trigger('chosen:updated');
					var option = [];
					option.push('<option></option>');
					$.each(data.provinceData,function(index,item){
						option.push('<option value="' + item.provinceId + '">',item.provinceName,'</option>');
					});
					$('#provinceId').html(option.join(''));
					$('#provinceId').val(data.province);
					$('#provinceId').val(data.provinceId);
					$('#provinceId').trigger('chosen:updated');
					if(cityId==0){
						return ;
					}
					option = [];
					option.push('<option></option>');
					$.each(data.cityData,function(index,item){
						option.push('<option value="' + item.cityId + '">',item.cityName,'</option>');
					});
					$('#cityId').html(option.join(''));
					$('#cityId').val(cityId);
					$('#cityId').trigger('chosen:updated');
				}
				else{
					alertify.alert("错误:" + data.message);
				}
			}
		});
	}
	function msgAlert(){
		$.gritter.add({
			title: '<i class="fa fa-check-circle"></i>提示',
			text: '操作成功',
			sticky: false,
			time: '3000',
			class_name: 'gritter-success',
			position: 'bottom-left'
		});
		return false;
	}
	function createTimeOrder(){
		var orderBy=$("#orderBy").val();
		if(orderBy=="followTimeUp" || orderBy=="followTimeDown"){
			$("#orderBy").val("createTimeDown");
		}else if(orderBy=="createTimeUp"){
			$("#orderBy").val("createTimeDown");
		}else{
			$("#orderBy").val("createTimeUp");
		}
		$("#searchForm").attr("action","${basePath}/customer/list");
		$("#searchForm").submit();
	}
	function download(){
		$("#searchForm").attr("action","${basePath}/customer/list?isDownload=true");
		$("#searchForm").submit();
	}
	function followTimeOrder(){
		var orderBy=$("#orderBy").val();
		if(orderBy=="createTimeDown" || orderBy=="createTimeUp"){
			$("#orderBy").val("followTimeDown");
		}else if(orderBy=="followTimeUp"){
			$("#orderBy").val("followTimeDown");
		}else{
			$("#orderBy").val("followTimeUp");
		}
		$("#searchForm").attr("action","${basePath}/customer/list");
		$("#searchForm").submit();
	}
</script>
</@master.masterFrame>