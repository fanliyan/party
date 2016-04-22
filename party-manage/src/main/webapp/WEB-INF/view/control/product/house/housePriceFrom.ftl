<#macro housePriceFrom currencyModels productHousePriceModels>
	<div class="panel-heading">购房相关费用<div class="pull-right"><a class="btn btn-xs btn-info" onclick="$.addHousePriceRow();"><i class="fa fa-plus"> 增加费用</i></a></div></div>
	<div class="panel-body" id="housePricePanel">
		<div class="row" id="housePriceRowTemplete" style="display:none">
			<div class="col-md-3">
				<div class="form-group">
					<label for="exampleInputEmail1" class="col-md-4 control-label">税/费名称</label>
					<div class="col-md-8">
						<input type="input" class="form-control input-sm" placeholder="税费名称" name="housePriceName#id#"  {parsleyTrue}  data-parsley-maxlength="15"
					 data-parsley-maxlength-message="字符最大长度不能超过15个字">
					</div>
				</div><!-- /form-group -->
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<label for="exampleInputEmail1" class="col-md-6 control-label">税率(百分比)</label>
					<div class="col-md-6">
						<input type="input" class="form-control input-sm" placeholder="税请填此项" name="rate#id#" data-parsley-type="range" data-parsley-range="[0,100]">
					</div>
				</div><!-- /form-group -->
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<label for="exampleInputEmail1" class="col-md-6 control-label">税/费金额</label>
					<div class="col-md-6">
						<input type="input" class="form-control input-sm" placeholder="金额" name="price#id#" {parsleyTrue}  data-parsley-type="range" data-parsley-range="[0,999999]">
					</div>
				</div><!-- /form-group -->
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<label for="exampleInputEmail1" class="col-md-4 control-label">货币类型</label>
					<div class="col-md-8">
						<@currencySelect.currencySelect currencyModelList=currencyModels controlName="housePriceCurreny#id#" controlAttrValue="{parsleyTrue}"/>
					</div>
				</div><!-- /form-group -->
			</div>
			<div class="col-md-1">
				<a class="btn btn-xs btn-danger" onclick="$('#housePriceRow#id#').remove();"><i class="fa fa-trash-o"></i></a>
			</div>
		</div><!-- /row -->
		<#assign tempFlag=0>
		<#if (productHousePriceModels)?? && productHousePriceModels?size gt 0>
			<#list productHousePriceModels as m>
			<#assign tempFlag=tempFlag+1>
			<div class="row" id="housePriceRow${tempFlag}">
				<div class="col-md-3">
					<div class="form-group">
						<label for="exampleInputEmail1" class="col-md-4 control-label">税/费名称</label>
						<div class="col-md-8">
							<input type="input" class="form-control input-sm" placeholder="税费名称" name="housePriceName${tempFlag}"  data-parsley-required="true" data-parsley-maxlength="15"
							 data-parsley-maxlength-message="字符最大长度不能超过15个字" value="${(m.housePriceName)!}">
						</div>
					</div><!-- /form-group -->
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label for="exampleInputEmail1" class="col-md-6 control-label">税率(百分比)</label>
						<div class="col-md-6">
							<input type="input" class="form-control input-sm" placeholder="税请填此项" name="rate${tempFlag}"  data-parsley-type="range" data-parsley-range="[0,100]" value="${(m.rate)!}">
						</div>
					</div><!-- /form-group -->
				</div>
				<div class="col-md-2">
					<div class="form-group">
						<label for="exampleInputEmail1" class="col-md-6 control-label">税/费金额</label>
						<div class="col-md-6">
							<input type="input" class="form-control input-sm" placeholder="金额" name="price${tempFlag}"  data-parsley-type="range" data-parsley-range="[0,999999]" data-parsley-required="true" value="${(m.price)!}">
						</div>
					</div><!-- /form-group -->
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label for="exampleInputEmail1" class="col-md-4 control-label">货币类型</label>
						<div class="col-md-8">
							<@currencySelect.currencySelect currencyModelList=currencyModels controlName="housePriceCurreny${tempFlag}" selectedValue=(m.currency)!/>
						</div>
					</div><!-- /form-group -->
				</div>
				<div class="col-md-1">
					<a class="btn btn-xs btn-danger" onclick="$('#housePriceRow${tempFlag}').remove();"><i class="fa fa-trash-o"></i></a>
				</div>
			</div><!-- /row -->
			</#list>
		</#if>
		<input type="hidden" id="housePriceCount" name="housePriceCount" value="${tempFlag}" >
	</div><!-- /panel body -->
	<script language="javascript">
	$.addHousePriceRow = function(){
		var idCount = parseInt($("#housePriceCount").val());
		idCount++;
		$("#housePriceCurreny_id__chosen").remove();
		$("#housePricePanel").append('<div class="row" id="housePriceRow' + idCount + '">' + $("#housePriceRowTemplete").html().replace(new RegExp(/#id#/g),idCount).replace(new RegExp(/{parsleytrue}/g),"data-parsley-required=\"true\"") + '</div>');
		$("#housePriceCurreny"+idCount).chosen("destroy");
		$("#housePriceCount").val(idCount);
	}
	</script>
</#macro>