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
	.chosen-container.chosen-container-single {
		min-width: 300px !important; /* or any value that fits your needs */
	}
	#tbl_shelf
	{
		width: 100%;
	}
	#tbl_shelf tbody tr td:nth-child(1)
	{
		width: 32px;
		text-align: right;
		padding-right: 6px;
	}
	#tbl_shelf tbody tr td:nth-child(2)
	{
		width: 40%;
		padding-right: 6px;
	}
	#tbl_shelf tbody tr td:nth-child(3)
	{
		width: auto;
		padding-right: 6px;
	}
	#tbl_shelf tbody tr td:nth-child(4)
	{
		width: 128px;
		padding-right: 6px;
	}
	#tbl_shelf tbody tr td:nth-child(5)
	{
		width: 128px;
		padding-right: 6px;
	}
	#tbl_shelf tbody tr td:nth-child(6)
	{
		width: 128px;
		padding-right: 6px;
	}
	#tbl_shelf tbody tr td:nth-child(7)
	{
		width: 128px;
		padding-right: 6px;
	}
	#tbl_shelf select
	{
		width: 100%;
	}
</style>

{if isset($errors) && $errors}
	<div class="alert alert-danger">
		{assign var=tot_err value=$errors|@count}
		<p>{if $tot_err > 1}{l s='There are %d errors:'  mod='mpcustomization' sprintf=$tot_err}{else}{l s='There is %d error'  mod='mpcustomization' sprintf=$tot_err}{/if}</p>
		<ol>
		{foreach from=$errors key=k item=error}
			<li>{$error}</li>
		{/foreach}
		</ol>
	</div>
{/if}

{if isset($confirmations) && $confirmations}
	<div class="alert alert-success">
		{assign var=tot_msg value=$confirmations|@count}
		{if  $tot_msg > 1}<p>{l s='There are %d messages'  mod='mpcustomization' sprintf= $tot_msg}</p>{/if}
		<ol>
		{foreach from=$confirmations key=k item=confirmation}
			<li>{$confirmation}</li>
		{/foreach}
		</ol>
	</div>
{/if}

<form method='post' enctype="multipart/form-data" id="form_config_warehouses" novalidate>
	<div class="panel">
		<div class="panel-heading">
			<i class="icon icon-tag"></i>&nbsp;Catalogazione prodotti
		</div>
		<div class="panel-body">
			<form id="form_sizes" method="post">
			{foreach $sizes as $s name=item_size}
				<div class="row" style="border-bottom: 1px solid #bcbcbc; margin-bottom: 8px; padding-bottom: 8px;">
					<div class="col-md-1 col-xs-2 id_mpshelves_product">
						<label>id</label>
						<input type="text" class="form-control" value="{$s.id_product_shelves}" readonly>
					</div>
					<div class="col-md-1 col-xs-2 id_size">
						<label>Taglia</label>
						<input type="text" class="form-control" id="{$s.id_product_attribute}" value="{$s.size}" readonly>
					</div>
					<div class="col-md-2 col-xs-3 id_warehouse">
						<label>Magazzino</label>
						<select class="form-control" name="id_warehouse">
							<option value="0">--</option>
							{foreach $warehouses as $w}
								<option value="{$w.id}" {if $w.id == $s.id_warehouse}selected{/if}>{$w.name}</option>
							{/foreach}
						</select>
					</div>
					<div class="col-md-2 col-xs-3 id_shelf">
						<label>Scaffale</label>
						<select class="form-control" name="id_shelf">
							<option value="0">--</option>
							{foreach $shelves as $w}
								<option value="{$w.id}" {if $w.id == $s.id_shelf}selected{/if}>{$w.name}</option>
							{/foreach}
						</select>
					</div>
					<div class="col-md-2 col-xs-3 id_column">
						<label>Colonna</label>
						<select class="form-control" name="id_column">
							<option value="0">--</option>
							{foreach $columns as $w}
								<option value="{$w.id}" {if $w.id == $s.id_column}selected{/if}>{$w.name}</option>
							{/foreach}
						</select>
					</div>
					<div class="col-md-2 col-xs-3 id_level">
						<label>Livello</label>
						<select class="form-control" name="id_level">
							<option value="0">--</option>
							{foreach $levels as $w}
								<option value="{$w.id}" {if $w.id == $s.id_level}selected{/if}>{$w.name}</option>
							{/foreach}
						</select>
					</div>
					<div class="col-md-2 col-xs-3">
						<label>--</label><br>
						<button type="button" class="save-size btn btn-default" onclick="javascript:saveSize(this);">
							<i class="icon icon-save"></i>
						</button>
						&nbsp;
						<button type="button" class="save-size btn btn-default" onclick="javascript:removeSize(this);">
							<i class="icon icon-trash text-danger"></i>
						</button>
						{if $smarty.foreach.item_size.first}
							&nbsp;
							<button type="button" class="save-size btn btn-default" onclick="javascript:setAll(this);">
								<i class="icon icon-download text-danger"></i>
							</button>
						{/if}
						&nbsp;
						<button type="button" class="save-size btn btn-default" onclick="javascript:copyClip(this);">
							<i class="icon icon-copy text-danger"></i>
						</button>
					</div>
				</div>
			{/foreach}
			</form>
		</div>
		<div class="panel-footer"></div>
	</div>
</form>

<script type="text/javascript">
	function getOptionTextValue(row, index)
	{
		//console.log('getOptionTextValue', row, index);
		var children = $(row).find('div');
		if (children.length >= index) {
			var select = $(children[index-1]).find('select');
		} else {
			var select = false;
		}
		//console.log('getOptionTextValue->select', select);
		if (select) {
			var option = getSelectedOptionText(select);
		} else {
			var option = false;
		}
		
		return option;
	}
	function getSelectedOptionText(select)
	{
		return $(select).find('option:selected').text();
	}
	function getSelectedOptionId(select)
	{
		return $(select).find('option:selected').val();
	}
	function copyToClipboard(text) {
		var sampleTextarea = document.createElement("textarea");
		document.body.appendChild(sampleTextarea);
		sampleTextarea.value = text; //save main text in it
		sampleTextarea.select(); //select textarea contenrs
		document.execCommand("copy");
		document.body.removeChild(sampleTextarea);
		alert("Valore copiato nella Clipboard!");
	}
	function copyClip(button)
	{
		var tr = $(button).closest('.row');
		console.log('copyClip', button, tr);
		var mag = getOptionTextValue(tr, 3);
		var scf = getOptionTextValue(tr, 4);
		var col = getOptionTextValue(tr, 5);
		var lev = getOptionTextValue(tr, 6);
		var value = mag+"#"+scf+"#"+col+"#"+lev;
		//console.log('copyClip:value', value);
		copyToClipboard(value);
	}
	function refreshSelect(select, data)
	{
		$(select).html('');
		$(select).append(
			$('<option></option>')
				.attr('id', '0')
				.text('--')
			);
		$(data).each(function(){
			$(select).append(
				$('<option></option>')
					.val(this.id)
					.text(this.name)
			);
		});
		$(select).trigger('chosen:updated');
	}

	function setAll(button)
	{
		var row = $(button).closest('div.row');
		$('select[name="id_warehouse"]').val($(row).find('select[name="id_warehouse"]').val());
		$('select[name="id_shelf"]').val($(row).find('select[name="id_shelf"]').val());
		$('select[name="id_column"]').val($(row).find('select[name="id_column"]').val());
		$('select[name="id_level"]').val($(row).find('select[name="id_level"]').val());
	}

	function saveSize(button)
	{
		if (!confirm("{l s='Update position?' mod='mpshelf'}")) {
			return false;
		}
		var row = $(button).closest('div.row');
		var id_row = $(row).find('div.id_mpshelves_product input');
		
		var obj_size = {
			'id' : Number($(row).find('div.id_mpshelves_product input').val()),
			'id_warehouse' : Number($(row).find('div.id_warehouse select').val()),
			'id_shelf' : Number($(row).find('div.id_shelf select').val()),
			'id_column' : Number($(row).find('div.id_column select').val()),
			'id_level' : Number($(row).find('div.id_level select').val()),
			'id_product' : Number($('input[name="id_product"]').val()),
			'id_product_attribute' : Number($(row).find('div.id_size input').attr('id')),
		};

		$.ajax({
			type: 'post',
			dataType: 'json',
			data:
			{
				action: 'updateShelfPosition',
				ajax: true,
				object: JSON.stringify(obj_size)
			},
			success: function(response)
			{
				$.growl.notice({
					title: 'Aggiornamento posizione',
					message: 'Operazione eseguita.'
				});
				$(id_row).val(response.id);
			},
			error: function(response)
			{
				$.growl.error({
					title: 'ERRORE',
					message: response.responseText
				});
			}
		});
	}

	function removeSize(button) {
		if (!confirm("{l s='Remove position?' mod='mpshelf'}")) {
			return false;
		}

		var row = $(button).closest('div.row');
		var id_row = $(row).find('div.id_mpshelves_product input').val();
		
		$.ajax({
			type: 'post',
			dataType: 'json',
			data:
			{
				action: 'removeShelfPosition',
				ajax: true,
				id: id_row
			},
			success: function(response)
			{
				$.growl.notice({
					title: 'Rimozione posizione',
					message: 'Operazione eseguita.'
				});
				
				$(row).find('div.id_warehouse select').val('0');
				$(row).find('div.id_shelf select').val('0');
				$(row).find('div.id_column select').val('0');
				$(row).find('div.id_level select').val('0');
			},
			error: function(response)
			{
				$.growl.error({
					title: 'ERRORE',
					message: response.responseText
				});
			}
		});
	}
	
	function copyPosition(button) {
		
		var row = $(button).closest('div.row');
		var id_row = $(row).find('div.id_mpshelves_product input').val();
		var warehouse = $(row).find('select[name="id_warehouse"] option:selected').text();
		var shelf = $(row).find('select[name="id_shelf"] option:selected').text();
		var column = $(row).find('select[name="id_column"] option:selected').text();
		var level = $(row).find('select[name="id_level"] option:selected').text();
		var position = warehouse + "#" + shelf + "#" + column + "#" + level;
		jAlert('<input type="text" value="'+position+'">');
	}
	
	$(document).ready(function(){
		$("#form_config_warehouses").validate();
	});
</script>