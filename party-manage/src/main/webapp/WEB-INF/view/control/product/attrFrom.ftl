<#include "/function.ftl"> 

<#macro attrFrom attrMap attributeValueModels>
<#if attrMap?exists>
	<#list attrMap?keys as key>
	<div class="panel-heading">${key}</div>
	<div class="panel-body">
		<div class="row">
			<#assign models = attrMap[key] />
			<#list models as attrModel>
				<div class="col-md-3">
					<div class="form-group">
						<label for="exampleInputEmail1" class="col-md-4 control-label">${attrModel.attrName}</label>
						<div class="col-md-8">
							<input type="input" class="form-control input-sm" name="attr${attrModel.attrId}" placeholder="文本描述" value="${getAttrValue(attributeValueModels,(attrModel.attrId)!)}">
						</div>
					</div><!-- /form-group -->
				</div>
			</#list>
		</div><!-- /row -->
	</div><!-- /panel-body -->
	</#list>
</#if>
</#macro>