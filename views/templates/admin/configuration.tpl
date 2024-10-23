{*
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2017 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<style>
	.fixed-width-50
	{
		width: 50% !important;
	}
</style>

<form method='post' enctype="multipart/form-data" id="form_config_warehouses">
	<div class="panel">
		<div class="panel-heading">
			<i class="icon icon-home"></i>&nbsp;&nbsp;Magazzini
		</div>
		<div class="panel-body">
			<div class="form-group">
				<label>Id</label>
				<input type="text" class="id form-control fixed-width-xs text-right" value="{Tools::getValue('warehouse_id', 0)}" name="warehouse_id">
			</div>
			<div class="form-group">
				<label>Nome Magazzino</label>
				<input type="text" class="form-control fixed-width-50" value="{Tools::getValue('warehouse_name')}" name="warehouse_name">
			</div>
			<div class="form-group">
				<label>Locazione</label>
				<input type="text" class="form-control fixed-width-50" value="{Tools::getValue('warehouse_location')}" name="warehouse_location">
			</div>
			<div class="form-group" style="overflow: hidden;">
				<button type="submit" class="btn btn-default pull-right" name="submitSaveWarehouse">
					<i class="process-icon-save"></i>Salva
				</button>
				<button type="button" class="btn btn-default pull-right submitNewValue" id="submitNewWarehouse" style="margin-right: 12px;">
					<i class="process-icon-new"></i>Nuovo
				</button>
			</div>
			<hr>
			{$table_warehouses}
		</div>
	</div>
</form>

<form method='post' enctype="multipart/form-data" id="form_config_shelves">
	<div class="panel">
		<div class="panel-heading">
			<i class="icon icon-th-large"></i>&nbsp;&nbsp;Scaffali
		</div>
		<div class="panel-body">
			<div class="form-group">
				<label>Id</label>
				<input type="text" class="id form-control fixed-width-xs text-right" value="{Tools::getValue('shelf_id', 0)}" name="shelf_id">
			</div>
			<div class="form-group">
				<label>Magazzino</label>
				<br>
				<select class="form-control chosen-select fixed-width-50" name="shelf_warehouse">
					<option value="0">--</option>
					{foreach $warehouses as $w}
						<option value="{$w.id}">{$w.name}</option>
					{/foreach}
				</select>
			</div>
			<div class="form-group">
				<label>Scaffale</label>
				<input type="text" class="form-control fixed-width-50" value="{Tools::getValue('shelf_name')}" name="shelf_name">
			</div>
			<div class="form-group" style="overflow: hidden;">
				<button type="submit" class="btn btn-default pull-right" name="submitSaveShelf">
					<i class="process-icon-save"></i>Salva
				</button>
				<button type="button" class="btn btn-default pull-right submitNewValue" id="submitNewShelf" style="margin-right: 12px;">
					<i class="process-icon-new"></i>Nuovo
				</button>
			</div>
			<hr>
			{$table_shelves}
		</div>
	</div>
</form>

<form method='post' enctype="multipart/form-data" id="form_config_columns">
	<div class="panel">
		<div class="panel-heading">
			<i class="icon icon-th-list"></i>&nbsp;&nbsp;Colonne
		</div>
		<div class="panel-body">
			<div class="form-group">
				<label>Id</label>
				<input type="text" class="id form-control fixed-width-xs text-right" value="{Tools::getValue('column_id', 0)}" name="column_id">
			</div>
			<div class="form-group">
				<label>Magazzino</label>
				<br>
				<select class="form-control chosen-select chosen-warehouse fixed-width-50" name="column_warehouse">
					<option value="0">--</option>
					{foreach $warehouses as $w}
						<option value="{$w.id}">{$w.name}</option>
					{/foreach}
				</select>
			</div>
			<div class="form-group">
				<label>Scaffale</label>
				<br>
				<select class="form-control chosen-select chosen-shelf fixed-width-50" name="column_shelf">
					<option value="0">--</option>
					{foreach $shelves as $w}
						<option value="{$w.id}">{$w.name}</option>
					{/foreach}
				</select>
			</div>
			<div class="form-group">
				<label>Colonna</label>
				<input type="text" class="form-control fixed-width-50" value="{Tools::getValue('column_name')}" name="column_name">
			</div>
			<div class="form-group" style="overflow: hidden;">
				<button type="submit" class="btn btn-default pull-right" name="submitSaveColumn">
					<i class="process-icon-save"></i>Salva
				</button>
				<button type="button" class="btn btn-default pull-right submitNewValue" id="submitNewColumn" style="margin-right: 12px;">
					<i class="process-icon-new"></i>Nuovo
				</button>
			</div>
			<hr>
			{$table_columns}
		</div>
	</div>
</form>
<form method='post' enctype="multipart/form-data" id="form_config_levels">
	<div class="panel">
		<div class="panel-heading">
			<i class="icon icon-list-alt"></i>&nbsp;&nbsp;Livelli
		</div>
		<div class="panel-body">
			<div class="form-group">
				<label>Id</label>
				<input type="text" class="id form-control fixed-width-xs text-right" value="{Tools::getValue('level_id', 0)}" name="level_id">
			</div>
			<div class="form-group">
				<label>Magazzino</label>
				<br>
				<select class="form-control chosen-select chosen-warehouse fixed-width-50" name="level_warehouse">
					<option value="0">--</option>
					{foreach $warehouses as $w}
						<option value="{$w.id}">{$w.name}</option>
					{/foreach}
				</select>
			</div>
			<div class="form-group">
				<label>Scaffale</label>
				<br>
				<select class="form-control chosen-select chosen-shelf fixed-width-50" name="level_shelf">
					<option value="0">--</option>
					{foreach $shelves as $w}
						<option value="{$w.id}">{$w.name}</option>
					{/foreach}
				</select>
			</div>
			<div class="form-group">
				<label>Colonna</label>
				<br>
				<select class="form-control chosen-select chosen-column fixed-width-50" name="level_column">
					<option value="0">--</option>
					{foreach $columns as $c}
						<option value="{$c.id}">{$c.name}</option>
					{/foreach}
				</select>
			</div>
			<div class="form-group">
				<label>Livello</label>
				<input type="text" class="form-control fixed-width-50" value="{Tools::getValue('level_name')}" name="level_name">
			</div>
			<div class="form-group" style="overflow: hidden;">
				<button type="submit" class="btn btn-default pull-right" name="submitSaveLevel">
					<i class="process-icon-save"></i>Salva
				</button>
				<button type="button" class="btn btn-default pull-right submitNewValue" id="submitNewLevel" style="margin-right: 12px;">
					<i class="process-icon-new"></i>Nuovo
				</button>
			</div>
			<hr>
			{$table_levels}
		</div>
	</div>
</form>
<style>
	.container_flex {
		width: 100%;
		height: 100%;
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: rgba(100,100,100,.5);
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 9999999999;
	}
</style>
<div class="container_flex hidden">
	<div class="panel col-md-6">
		<div class="panel-heading">
			<i class="icon icon-cogs"></i>
			<span style="margin-left: 8px;">{l s='Edit panel' mod='mpshelves'}</span>
		</div>
		<div class="panel-body">
			<fieldset>
				<legend>{l s ='Tipo' mod='mpshelves'}</legend>
				<div class="form-group">
					<label>Seleziona</label>
					<select id="type_list" class="form-control">
						<option value="warehouse">Magazzino</option>
						<option value="shelf">Scaffale</option>
						<option value="column">Colonna</option>
						<option value="level">Livello</option>
					</select>
				</div>
			</fieldset>
			<fieldset>
				<legend>{l s='Valore' mod='mpshelves'}</legend>
				<div class="form-group">
					<label>Inserisci il valore</label>
					<input id="value_record" class="form-control">
				</div>
			</fieldset>
		</div>
		<div class="panel-footer">
			<button type="button" class="btn btn-primary pull-right submitSaveValue">
				<i class="process-icon-save"></i>
				{l s='SALVA' mod='mpshelves'}
			</button>
			<button type="button" class="btn btn-warning pull-left submitClosePanel">
				<i class="process-icon-back"></i>
				{l s='CHIUDI' mod='mpshelves'}
			</button>
		</div>
	</div>
</div>
<script type="text/javascript">
	function deleteItem(id, action)
	{
		$.ajax({
			type: 'post',
			dataType: 'json',
			data:
			{
				action: action,
				ajax: true,
				id: id
			},
			success: function(response)
			{
				switch (response.result) {
					case "notice":
						$.growl.notice({
							title: response.title,
							message: response.message
						});
						break;
					case "warning":
						$.growl.warning({
							title: response.title,
							message: response.message
						});
						break;
					case "error":
						$.growl.error({
							title: response.title,
							message: response.message
						});
						break;
				}
			},
			error: function(response)
			{
				$.growl.error({
					title: '{l s='ERROR' mod='mpshelves'}',
					message: response.responseText
				});
			}
		});
	}
	$(document).ready(function(){
		$('.submitSaveValue').on('click', function(){
			$.ajax({
				type: 'post',
				dataType: 'json',
				data:
				{
					ajax: true,
					action: 'addNewValue',
					type: $('#type_list').val(),
					value: $('#value_record').val()
				},
				success: function(response)
				{
					if (response.error == false) {
						$.growl.notice({
							title: '{l s='NUOVO VALORE' mod='mpshelves'}',
							message: response.message
						});
					} else {
						$.growl.error({
							title: '{l s='AJAX ERROR' mod='mpshelves'}',
							message: response.message
						});
					}
					
					$('.submitClosePanel').click();
				},
				error: function(response)
				{
					$.growl.error({
						title: '{l s='AJAX ERROR' mod='mpshelves'}',
						message: response.responseText
					});
					$('.submitClosePanel').click();
				}
			});
		});

		$('.submitClosePanel').on('click', function(){
			$('.container_flex').addClass('hidden').hide();
		});
		
		$('.submitNewValue').on('click', function(){
			$('.id').val('0');
			$('.container_flex').removeClass('hidden').show();
			$('.container_flex select').focus();
		});

		$('.chosen-select').chosen({
			allow_single_deselect: true,
			no_results_text: "{l s='No result found.' mod='mpshelves'}",

		});

		$('.edit-btn').on('click', function(){
			var row = $(this).closest('tr');
			var table = $(this).attr('table');

			switch (table) {
				case 'warehouse':
					var id = $(row).find('.col-id').text().trim();
					var name = $(row).find('.col-name').text().trim();
					var location = $(row).find('.col-location').text().trim();

					$('input[name="warehouse_id"]').val(id);
					$('input[name="warehouse_name"]').val(name);
					$('input[name="warehouse_location"]').val(location);
					break;
				case 'shelf':
					var id = $(row).find('.col-id').text().trim();
					$.ajax({
						type: 'post',
						dataType: 'json',
						data:
						{
							action: 'getShelf',
							ajax: true,
							id: id
						},
						success: function(response)
						{
							$('input[name="shelf_id"]').val(response.id);
							$('select[name="shelf_warehouse"]').val(response.warehouse).trigger('chosen:updated');
							$('input[name="shelf_name"]').val(response.name);
						},
						error: function(response)
						{
							$.growl.error({
								title: '{l s='ERROR' mod='mpshelves'}',
								message: '{l s='Error retrieving record.' mod='mpshelves'}'
							});
						}
					});
					break;
				case 'column':
					var id = $(row).find('.col-id').text().trim();
					$.ajax({
						type: 'post',
						dataType: 'json',
						data:
						{
							action: 'getColumn',
							ajax: true,
							id: id
						},
						success: function(response)
						{
							$('input[name="column_id"]').val(response.id);
							$('select[name="column_warehouse"]').val(response.warehouse).trigger('chosen:updated');
							$('select[name="column_shelf"]').val(response.shelf).trigger('chosen:updated');
							$('input[name="column_name"]').val(response.name);
						},
						error: function(response)
						{
							$.growl.error({
								title: '{l s='ERROR' mod='mpshelves'}',
								message: '{l s='Error retrieving record.' mod='mpshelves'}'
							});
						}
					});
				case 'level':
					var id = $(row).find('.col-id').text().trim();
					$.ajax({
						type: 'post',
						dataType: 'json',
						data:
						{
							action: 'getLevel',
							ajax: true,
							id: id
						},
						success: function(response)
						{
							$('input[name="level_id"]').val(response.id);
							$('select[name="level_warehouse"]').val(response.warehouse).trigger('chosen:updated');
							$('select[name="level_shelf"]').val(response.shelf).trigger('chosen:updated');
							$('select[name="level_column"]').val(response.shelf).trigger('chosen:updated');
							$('input[name="level_name"]').val(response.name);
						},
						error: function(response)
						{
							$.growl.error({
								title: '{l s='ERROR' mod='mpshelves'}',
								message: '{l s='Error retrieving record.' mod='mpshelves'}'
							});
						}
					});
			}
		});

		$('.delete-btn').on('click', function(){
			if (!confirm("{l s='Delete selected item?' mod='mpshelves'}")) {
				return false;
			}
			var row = $(this).closest('tr');
			var table = $(this).attr('table');

			switch (table) {
				case "warehouse":
					var id = $(row).find('.col-id').text().trim();
					var action = "deleteWarehouse";
					deleteItem(id, action);
					break;
				case "shelf":
					break;
				case "column":
					break;
				case "level":
					break;
			}
		});

		$('#submitNewWarehouse').on('click', function(){
			$('input[name="warehouse_id"]').val('0');
			$('input[name="warehouse_name"]').val('');
			$('input[name="warehouse_location"]').val('');
		});
		$('#submitNewShelf').on('click', function(){
			$('input[name="shelf_id"]').val('0');
			$('input[name="shelf_warehouse"]').val('0').change().trigger('chosen:updated');
			$('input[name="shelf_name"]').val('');
		});
		$('#submitNewColumn').on('click', function(){
			$('input[name="column_id"]').val('0');
			$('input[name="column_warehouse"]').val('0').change().trigger('chosen:updated');
			$('input[name="column_shelf"]').val('0').change().trigger('chosen:updated');
			$('input[name="column_name"]').val('');
		});
		$('#submitNewLevel').on('click', function(){
			$('input[name="level_id"]').val('0');
			$('input[name="level_warehouse"]').val('0').change().trigger('chosen:updated');
			$('input[name="level_shelf"]').val('0').change().trigger('chosen:updated');
			$('input[name="level_column"]').val('0').change().trigger('chosen:updated');
			$('input[name="level_name"]').val('');
		});
	});
</script>