<#macro immigrationPriceFrom currencyModels productImmigrationPriceModels>
	<div class="panel-heading">移民相关费用<div class="pull-right"><a class="btn btn-xs btn-info" onclick="$.addImmigrationPriceRow();"><i class="fa fa-plus"> 增加费用</i></a></div></div>
	<div class="panel-body" id="immigrationPricePanel">
		<div class="row" id="immigrationPriceRowTemplete" style="display:none">
			<div class="col-md-3">
				<div class="form-group">
					<label for="exampleInputEmail1" class="col-md-4 control-label">费用名称</label>
					<div class="col-md-8">
						<input type="input" class="form-control input-sm" placeholder="移民费用名称" name="immigrationPriceName#id#" {parsleyTrue} 
						 data-parsley-maxlength="25"
						 data-parsley-maxlength-message="字符最大长度不能超过25个字">
					</div>
				</div><!-- /form-group -->
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<label for="exampleInputEmail1" class="col-md-4 control-label">费用</label>
					<div class="col-md-8">
						<input type="input" class="form-control input-sm" placeholder="可精确到两位小数" name="immigrationPrice#id#" {parsleyTrue}  data-parsley-type="range" data-parsley-range="[0,999999]">
					</div>
				</div><!-- /form-group -->
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<label for="exampleInputEmail1" class="col-md-4 control-label">货币种类</label>
					<div class="col-md-8">
						<@currencySelect.currencySelect currencyModelList=currencyModels controlName="immigrationPriceCurrency#id#" controlAttrValue="{parsleyTrue}"/>
					</div>
				</div>
			</div>
			<div class="col-md-1">
				<a class="btn btn-xs btn-danger" onclick="$('#immigrationPriceRow#id#').remove();"><i class="fa fa-trash-o"></i></a>
			</div>
		</div><!-- /row -->
		
		<#assign tempFlag=0>
		<#if (productImmigrationPriceModels)?? && productImmigrationPriceModels?size gt 0>
			<#list productImmigrationPriceModels as m>
			<#assign tempFlag=tempFlag+1>
			<div class="row" id="immigrationPriceRow${tempFlag}">
				<div class="col-md-3">
					<div class="form-group">
						<label for="exampleInputEmail1" class="col-md-4 control-label">费用名称</label>
						<div class="col-md-8">
							<input type="input" class="form-control input-sm" placeholder="移民费用名称" name="immigrationPriceName${tempFlag}" data-parsley-required="true"
							 data-parsley-maxlength="25"
							 data-parsley-maxlength-message="字符最大长度不能超过25个字" value="${(m.priceName)!}">
						</div>
					</div><!-- /form-group -->
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label for="exampleInputEmail1" class="col-md-4 control-label">费用</label>
						<div class="col-md-8">
							<input type="input" class="form-control input-sm" placeholder="可精确到两位小数" name="immigrationPrice${tempFlag}"  data-parsley-required="true"  data-parsley-type="range" data-parsley-range="[0,999999]" value="${(m.price)!}">
						</div>
					</div><!-- /form-group -->
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label for="exampleInputEmail1" class="col-md-4 control-label">货币种类</label>
						<div class="col-md-8">
							<@currencySelect.currencySelect currencyModelList=currencyModels controlName="immigrationPriceCurrency${tempFlag}" selectedValue=(m.currency)!/>
						</div>
					</div>
				</div>
				<div class="col-md-1">
					<a class="btn btn-xs btn-danger" onclick="$('#immigrationPriceRow${tempFlag}').remove();"><i class="fa fa-trash-o"></i></a>
				</div>
			</div><!-- /row -->
			</#list>
		</#if>
		
		<input type="hidden" id="immigrationPriceCount" name="immigrationPriceCount" value="${tempFlag}" >
	</div><!-- /panel body -->

	<script language="javascript">
	$.addImmigrationPriceRow = function(){
		var idCount = parseInt($("#immigrationPriceCount").val());
		idCount++;
		$("#immigrationPriceCurrency_id__chosen").remove();
		$("#immigrationPricePanel").append('<div class="row" id="immigrationPriceRow' + idCount + '">' + $("#immigrationPriceRowTemplete").html()
			.replace(new RegExp(/#id#/g),idCount)
			.replace(new RegExp(/{parsleytrue}/g),"data-parsley-required=\"true\"")
			 + '</div>');
		$("#immigrationPriceCurrency"+idCount).chosen("destroy");
		$("#immigrationPriceCount").val(idCount);
	}
	</script>
</#macro>