<#macro houseAttrFrom housePropertyModels houseTypeModels houseModel>
<div class="panel-heading">房产类产品属性</div>
<div class="panel-body">
	<div class="row">
		<div class="col-md-3">
			<div class="form-group">
				<label for="exampleInputPassword1" class="col-md-4 control-label">房产性质</label>
				<div class="col-md-8">
					<@housePropertySelect.housePropertySelect housePropertyModelList=housePropertyList controlName="housePropertyId" selectedValue=(houseModel.housePropertyId)!0 />
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputPassword1" class="col-md-4 control-label">房产类型</label>
				<div class="col-md-8">
					<@houseTypeSelect.houseTypeSelect houseTypeModelList=houseTypeList controlName="houseTypeId" selectedValue=(houseModel.houseTypeId)!0/>
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">开发商</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="开发商名称" name="developers" value="${(houseModel.developers)!}" data-parsley-maxlength="50"
					 data-parsley-maxlength-message="字符最大长度不能超过50个字">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">建造时间</label>
				<div class="col-md-8">
					<input type="input" id="constructionTime" class="form-control input-sm" data-parsley-pattern="\d{4}-\d{2}-\d{2}" data-parsley-pattern-message="日期必须是yyyy-MM-dd的格式" placeholder="格式：yyyy-mm-dd" name="constructionTime"  value="${(houseModel.constructionTime?string('yyyy-MM-dd'))!}">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">交付时间</label>
				<div class="col-md-8">
					<input type="input" id="deliveryTime" class="form-control input-sm" data-parsley-pattern="\d{4}-\d{2}-\d{2}" data-parsley-pattern-message="日期必须是yyyy-MM-dd的格式" placeholder="格式：yyyy-mm-dd" name="deliveryTime" value="${(houseModel.deliveryTime?string('yyyy-MM-dd'))!}">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">产权</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="示例：永久" name="propertyRight" value="${(houseModel.propertyRight)!}">
				</div>
			</div><!-- /form-group -->
		</div>
		
		<div class="col-md-3">
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">占地面积</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="占地面积（单位：平方）" name="coveredAcreage" value="${(houseModel.coveredAcreage)!}" data-parsley-pattern="^\d{1,8}(\.\d{1,2})?$" data-parsley-pattern-message="必须为数字，支持两位小数">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">建筑面积</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="建筑面积（单位：平方）" name="buildAcreage" value="${(houseModel.buildAcreage)!}" data-parsley-pattern="^\d{1,8}(\.\d{1,2})?$" data-parsley-pattern-message="必须为数字，支持两位小数">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">每平米单价</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="示例：1000元" name="unitPrice" value="${(houseModel.unitPrice)!}">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<div class="col-md-offset-4 col-md-10">
					<label class="label-checkbox" class="col-md-8 control-label">
						<input type="checkbox" name="isGuaranteeLease" value="true" <#if (houseModel.isGuaranteeLease)?? && houseModel.isGuaranteeLease> checked</#if>>
						<span class="custom-checkbox"></span>
						包租
					</label>
				</div>
			</div><!-- /form-group -->
			
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">租金价格</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="示例：1000元/月" name="leasePrice" value="${(houseModel.leasePrice)!}">
				</div>
			</div><!-- /form-group -->
			
		</div>
		
		<div class="col-md-3">
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">房间数</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，单位：间" name="roomQuantity" value="${(houseModel.roomQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">客厅数</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，单位：间" name="parlourQuantity" value="${(houseModel.parlourQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">卧室数</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，单位：间" name="bedroomQuantity" value="${(houseModel.bedroomQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
			
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">餐厅数</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，单位：间" name="restaurantQuantity" value="${(houseModel.restaurantQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">厨房数</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，单位：间" name="cookroomQuantity" value="${(houseModel.cookroomQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
			
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">卫生间数</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，单位：间" name="toiletQuantity" value="${(houseModel.toiletQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
			
		</div>
		
		<div class="col-md-3">
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">花园数量</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，不填代表无花园" name="gardenQuantity" value="${(houseModel.gardenQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">花园面积</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字" name="gardenAcreage" value="${(houseModel.gardenAcreage)!}" data-parsley-pattern="^\d{1,8}(\.\d{1,2})?$" data-parsley-pattern-message="必须为数字，支持两位小数">
				</div>
			</div><!-- /form-group -->
			
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">车库数</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，单位：间" name="garageQuantity" value="${(houseModel.garageQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
			
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">停车位数</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，单位：间" name="parkingSpaceQuantity" value="${(houseModel.parkingSpaceQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
			
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-4 control-label">泳池数</label>
				<div class="col-md-8">
					<input type="input" class="form-control input-sm" placeholder="数字，单位：个" name="swimmingPoolQuantity" value="${(houseModel.swimmingPoolQuantity)!}" data-parsley-pattern="^\d{1,2}$" data-parsley-pattern-message="必须为1-99之间的整数">
				</div>
			</div><!-- /form-group -->
		</div>
		
		<div class="col-md-12">
			<div class="form-group">
				<label for="exampleInputEmail1" class="col-md-1 control-label">房产描述</label>
				<div class="col-md-11">
					<textarea class="form-control" rows="3" name="houseDesc"  data-parsley-maxlength="250">${(houseModel.houseDesc)!}</textarea>
				</div>
			</div><!-- /form-group -->
		</div>
	</div><!-- /row -->
	
	
</div><!-- /panel body -->
<script>
	$(document).ready(function(){
		$("#constructionTime").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			yearRange:'-70:+70',
			maxDate:new Date()
		});
		
		$("#deliveryTime").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			yearRange:'-70:+70',
			maxDate:new Date()
		});
	});
</script>
</#macro>