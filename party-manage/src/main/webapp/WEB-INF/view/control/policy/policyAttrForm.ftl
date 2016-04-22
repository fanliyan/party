<#macro policyAttr policyGroupList isShow=false>
<#if policyGroupList ??>
	<#list policyGroupList as group>
		<div class="panel-heading">${group.attrGroupName}</div>
		<div class="panel-body">
			<div class="row">
				<#if group.attributes??>
					<#list group.attributes as attr >
						<div class="col-md-12">
							<div class="form-group">
								<label for="exampleInputEmail1" class="col-md-1 control-label">${attr.attrName}</label>
								<div class="col-md-11">
									<input type="hidden" name="attrId" value="${attr.attrId}"/>
									<input type="input" class="form-control input-sm" name="attrValue${attr.attrId}" 
									 placeholder="请输入${attr.attrName}内容,最大长度300" value="${(attr.attributeValue.attrValue)!}"
									 data-parsley-maxlength="300"
									 data-parsley-maxlength-message="内容不能超过300字"
									/>
								</div>
							</div><!-- /form-group -->
						</div>
					</#list>
				</#if>
			</div><!-- /row -->
		</div><!-- /panel body -->
	</#list>
</#if>
</#macro>