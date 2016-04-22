<#import "/master/master-frame.ftl" as master />
<#if roleModel??>
	<#assign title=["系统管理","角色管理","更新角色"]>
<#else>
	<#assign title=["系统管理","角色管理","新增角色"]>
</#if>
<@master.masterFrame pageTitle=title>
<div class="tab-pane fade" id="edit">
								
		<div class="row">
			<div class="panel panel-info pull-right">
				<div class="panel-body">
					Last Update on 12 Oct,2013
				</div>
			</div><!-- /panel -->
		</div><!-- /.row -->
		
		<div class="panel panel-default">
			<form class="form-horizontal form-border">
				<div class="panel-heading">
					Basic Information
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label class="control-label col-md-2">Username</label>
						<div class="col-md-10">
							<input type="text" class="form-control input-sm" placeholder="Username" value="John Doe">
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="control-label col-md-2">Password</label>
						<div class="col-md-10">
							<input type="password" class="form-control input-sm" value="Password">
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="control-label col-md-2">Email</label>
						<div class="col-md-10">
							<input type="text" class="form-control input-sm" value="john_doe@email.com">
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="control-label col-md-2">Gender</label>
						<div class="col-md-10">
							<label class="label-radio inline">
								<input type="radio" name="inline-radio" checked>
								<span class="custom-radio"></span>
								Male
							</label>
							<label class="label-radio inline">
								<input type="radio" name="inline-radio">
								<span class="custom-radio"></span>
								Female
							</label>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="control-label col-md-2">Address</label>
						<div class="col-md-10">
							<textarea class="form-control" rows="3"></textarea>
						</div><!-- /.col -->
					</div><!-- /form-group -->
					<div class="form-group">
						<label class="control-label col-md-2">Phone</label>
						<div class="col-md-10">
							<input type="text" class="form-control input-sm">
						</div><!-- /.col -->
					</div><!-- /form-group -->
				</div>
				<div class="panel-footer">
					<div class="text-right">
						<button class="btn btn-sm btn-success">Update</button>
						<button class="btn btn-sm btn-success" type="reset">Reset</button>
					</div>
				</div>
			</form>
		</div><!-- /panel -->
	
		<div class="panel panel-default">
			<div class="panel-body padding-xs">
				<textarea class="form-control no-border no-shadow" rows="2" placeholder="What's on your mind?"></textarea>
			</div>
			<div class="panel-footer clearfix">
				<a class="btn btn-xs btn-success pull-right">Post</a>
			</div>
		</div><!-- /panel -->
		<div class="panel panel-default">
			<div class="panel-heading">
				About Me
			</div>
			<div class="panel-body padding-xs">
				<textarea class="form-control no-border no-shadow" rows="5" placeholder="Who are you?"></textarea>
			</div>
			<div class="panel-footer clearfix">
				<a class="btn btn-xs btn-success pull-right">Save</a>
			</div>
		</div><!-- /panel -->
			
		<div class="panel panel-default">
			<div class="panel-heading">
				Products
			</div>
			<table class="table table-bordered table-condensed table-hover table-striped table-vertical-center">
				<thead>
					<tr>
						<th></th>
						<th class="text-center">Name</th>
						<th class="text-center">Price</th>
						<th class="text-center">Total Sales</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="text-center hidden-xs">
							<img data-src="holder.js/60x60" alt="Product Image" src=".html">
						</td>
						<td class="text-center">
							Leather Bag
						</td>
						<td class="text-center">
							$50
						</td>
						<td class="text-center">
							102
						</td>
						<td class="text-center">
							<a class="btn btn-sm btn-success">Edit</a>
						</td>
					</tr>
					<tr>
						<td class="text-center hidden-xs">
							<img data-src="holder.js/60x60" alt="Product Image" src=".html">
						</td>
						<td class="text-center">
							Brown Sunglasses
						</td>
						<td class="text-center">
							$80
						</td>
						<td class="text-center">
							310
						</td>
						<td class="text-center">
							<a class="btn btn-sm btn-success">Edit</a>
						</td>
					</tr>
					<tr>
						<td class="text-center hidden-xs">
							<img data-src="holder.js/60x60" alt="Product Image" src=".html">
						</td>
						<td class="text-center">
							Summer Dress
						</td>
						<td class="text-center">
							$35
						</td>
						<td class="text-center">
							89
						</td>
						<td class="text-center">
							<a class="btn btn-sm btn-success">Edit</a>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="panel-footer text-right">
				<a class="btn btn-sm btn-success"><i class="fa fa-plus"></i> Add Product</a>
				<a class="btn btn-sm btn-danger"><i class="fa fa-trash-o"></i> Delete</a>
			</div>
		</div><!-- panel -->
	</div><!-- /tab2 -->
</@master.masterFrame>