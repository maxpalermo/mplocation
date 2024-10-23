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
<div class="panel">
	<div class="panel-heading">
		<i class="icon-map-marker"></i> {l s='Location Data' mod='mplocation'}
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-md-3">
				<div class="form-group">
					<label for="warehouses">{l s='Gestione Magazzini'}</label>
					<div class="mb-4">
						<button type="button" class="btn btn-primary" onclick="addElement('warehouse', this);">
							{l s='Aggiungi Magazzino'} <i class="icon icon-plus ml-4"></i>
						</button>
					</div>
					<div class="container" style="height: 600px; overflow-y: auto; width: 100%;">
						<ul class="list-group" id="warehouse-list">
							{foreach from=$warehouses item=warehouse}
								<li class="list-group-item d-flex justify-content-between align-items-center">
									{$warehouse.name}
									<div class="btn-group" role="group" aria-label="Button group">
										<button title="{l s='Modifica' mod='mplocation'}" type="button" class="btn btn-warning btn-sm" onclick="editElement('warehouse', {$warehouse.id}, '{$warehouse.name}', this);">
											<i class="icon icon-pencil"></i>
										</button>
										<button title="{l s='Elimina' mod='mplocation'}" type="button" class="btn btn-danger btn-sm" onclick="removeElement('warehouse', {$warehouse.id}, this);">
											<i class="icon icon-trash"></i>
										</button>
									</div>
								</li>
							{/foreach}
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<label for="warehouses">{l s='Gestione Scaffali'}</label>
					<div class="mb-4">
						<button type="button" class="btn btn-primary" onclick="addElement('shelf', this);">
							{l s='Aggiungi Scaffale'} <i class="icon icon-plus ml-4"></i>
						</button>
					</div>
					<div class="container" style="height: 600px; overflow-y: auto; width: 100%;">
						<ul class="list-group" id="shelf-list">
							{foreach from=$shelves item=shelf}
								<li class="list-group-item d-flex justify-content-between">
									<span>{$shelf.name}</span>
									<div class="btn-group" role="group" aria-label="Button group">
										<button title="{l s='Modifica' mod='mplocation'}" type="button" class="btn btn-warning btn-sm" onclick="editElement('shelf', {$shelf.id}, '{$shelf.name}', this);">
											<i class="icon icon-pencil"></i>
										</button>
										<button title="{l s='Elimina' mod='mplocation'}" type="button" class="btn btn-danger btn-sm" onclick="removeElement('shelf', {$shelf.id});">
											<i class="icon icon-trash"></i>
										</button>
									</div>
								</li>
							{/foreach}
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<label for="warehouses">{l s='Gestione Colonne'}</label>
					<div class="mb-4">
						<button type="button" class="btn btn-primary" onclick="addElement('column', this);">
							{l s='Aggiungi Colonna'} <i class="icon icon-plus ml-4"></i>
						</button>
					</div>
					<div class="container" style="height: 600px; overflow-y: auto; width: 100%;">
						<ul class="list-group" id="column-list">
							{foreach from=$columns item=column}
								<li class="list-group-item d-flex justify-content-between align-items-center">
									{$column.name}
									<div class="btn-group" role="group" aria-label="Button group">
										<button title="{l s='Modifica' mod='mplocation'}" type="button" class="btn btn-warning btn-sm" onclick="editElement('column', {$column.id}, '{$column.name}', this);">
											<i class="icon icon-pencil"></i>
										</button>
										<button title="{l s='Elimina' mod='mplocation'}" type="button" class="btn btn-danger btn-sm" onclick="removeElement('column', {$column.id}, this);">
											<i class="icon icon-trash"></i>
										</button>
										<div class="btn-group" role="group" aria-label="Button group">
								</li>
							{/foreach}
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<label for="warehouses">{l s='Gestione Livelli'}</label>
					<div class="mb-4">
						<button type="button" class="btn btn-primary" onclick="addElement('level', this);">
							{l s='Aggiungi Livello'} <i class="icon icon-plus ml-4"></i>
						</button>
					</div>
					<div class="container" style="height: 600px; overflow-y: auto; width: 100%;">
						<ul class="list-group" id="level-list">
							{foreach from=$levels item=level}
								<li class="list-group-item d-flex justify-content-between align-items-center">
									{$level.name}
									<div class="btn-group" role="group" aria-label="Button group">
										<button title="{l s='Modifica' mod='mplocation'}" type="button" class="btn btn-warning btn-sm" onclick="editElement('level', {$level.id}, '{$level.name}', this);">
											<i class="icon icon-pencil"></i>
										</button>
										<button title="{l s='Elimina' mod='mplocation'}" type="button" class="btn btn-danger btn-sm" onclick="removeElement('level', {$level.id}, this);">
											<i class="icon icon-trash"></i>
										</button>
										<div class="btn-group" role="group" aria-label="Button group">
								</li>
							{/foreach}
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="panel-footer">
	<!-- NOTHING -->
</div>

<script type="text/javascript">
	function addElement(type, button) {
		var name = prompt('Inserisci il nome del nuovo elemento');
		if (name) {
			$.ajax({
				url: '{$link->getModuleLink('mplocation', 'Ajax')}',
				type: 'POST',
				data: {
					ajax: 1,
					action: 'addElement',
					type: type,
					name: name
				},
				success: function(response) {
					if (response.success) {
						$.growl.notice({ title: 'Successo', message: response.message });
						var list = document.getElementById(type + '-list');
						var li = document.createElement('li');
						li.className = 'list-group-item d-flex justify-content-between align-items-center';
						li.innerHTML = name + '<button type="button" class="btn btn-danger btn-sm" onclick="removeElement(\'' + type + '\', ' + response.id + ', this);"><i class="icon icon-trash"></i></button>';
						list.appendChild(li);
					} else {
						$.growl.error({ title: 'Errore', message: response.message });
					}
				}
			});
		}
	}

	function removeElement(type, id, button) {
		if (confirm('Sei sicuro di voler eliminare questo elemento?')) {
			$.ajax({
				url: '{$link->getModuleLink('mplocation', 'Ajax')}',
				type: 'POST',
				data: {
					ajax: 1,
					action: 'removeElement',
					type: type,
					id: id
				},
				success: function(response) {
					if (response.success) {
						$.growl.notice({ title: 'Successo', message: response.message });
						button.parentNode.parentNode.remove();
					} else {
						$.growl.error({ title: 'Errore', message: response.message });
					}
				}
			});
		}
	}

	function editElement(type, id, name, button) {
		var newName = prompt('Modifica il nome dell\'elemento', name);
		if (newName) {
			$.ajax({
				url: '{$link->getModuleLink('mplocation', 'Ajax')}',
				type: 'POST',
				data: {
					ajax: 1,
					action: 'editElement',
					type: type,
					id: id,
					name: newName
				},
				success: function(response) {
					if (response.success) {
						$.growl.notice({ title: 'Successo', message: response.message });
						button.parentNode.firstChild.nodeValue = newName;
					} else {
						$.growl.error({ title: 'Errore', message: response.message });
					}
				}
			});
		}
	}
</script>