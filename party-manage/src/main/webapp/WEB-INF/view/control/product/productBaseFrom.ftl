<#macro productBaseFrom productModel currencyModels policyModels selectedPolicyModels countryModels>
<div class="panel-heading">产品基本信息</div>
<div class="panel-body">
	<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-2 control-label">产品名称</label>
				<div class="col-md-10">
					<input type="input" class="form-control input-sm"
					 data-parsley-required="true" data-parsley-required-message="产品名称不可为空" 
					 data-parsley-maxlength="50"
					 data-parsley-maxlength-message="字符最大长度不能超过50个字"
					 name="productName" placeholder="请输入产品名称" value="${(productModel.name)!}">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputPassword1" class="col-md-2 control-label">产品价格</label>
				<div class="col-md-3">
					<input type="input" class="form-control input-sm" data-parsley-required="true"  data-parsley-type="range" data-parsley-range="[100,99999999]" placeholder="产品的价格" name="productPrice" value="${(productModel.productPrice)!}">
				</div>
				<label for="exampleInputPassword1" class="col-md-2 control-label">价格货币</label>
				<div class="col-md-3">
					<@currencySelect.currencySelect currencyModelList=currencyModels controlName="productCurrency" selectedValue=(productModel.productCurrency)!"" required=true/>
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<div class="col-md-offset-2 col-md-10">
					<label class="label-checkbox" class="col-md-2 control-label">
						<input type="checkbox" name="isMigrate" value="true" <#if (productModel.isMigrate)?? && productModel.isMigrate> checked </#if>>
						<span class="custom-checkbox"></span>
						移民产品
					</label>
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label class="col-md-2 control-label">适用政策</label>
				<div class="col-md-10">
					<@policySelect.policySelect policyList=policyModels controlName="policyIds" selectedValue=(selectedPolicyModels)!""/>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-2 control-label">所属城市</label>
				<@citySelect.citySelect countryModelList=countryModelList selectedCityId=(productModel.cityId)!0 notNull=true/>
			</div><!-- /form-group -->
		</div>
		
		<div class="col-md-12">
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-1 control-label">产品优势</label>
				<div class="col-md-11">
					<textarea class="form-control" rows="2" name="advantageDesc" data-parsley-maxlength="250">${(productModel.advantageDesc)!}</textarea>
				</div>
			</div><!-- /form-group -->
		</div>
	</div><!-- /row -->
</div><!-- /panel body -->
</#macro>