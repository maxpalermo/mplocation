{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License version 3.0
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    Massimiliano Palermo <maxx.palermo@gmail.com>
 * @copyright Since 2016 Massimiliano Palermo
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License version 3.0
 *}

<form method="post" enctype="multipart/form-data" id="form_config_warehouses" novalidate="novalidate">
    <div class="panel">
        <div class="panel-heading">
            <i class="icon icon-tag"></i>{l s='Catalogazione prodotti' mod='mplocation'}
        </div>
        <div class="panel-body">
            {foreach $locations as $location}
                <div class="row" style="border-bottom: 1px solid var(--edition-lightblue-300); margin-bottom: 8px; padding-bottom: 8px;">
                    <div class="col-md-1 col-xs-2 id_mpshelves_product">
                        <label>id</label>
                        <input type="text" data-id_product="{$location.id_product}" data-id_product_attribute="{$location.id_product_attribute}" class="form-control" value="{$location.id_product_location}" name="id_product_location" readonly="">
                    </div>
                    <div class="col-md-1 col-xs-2 id_size">
                        <label>Taglia</label>
                        <input type="text" class="form-control" id="0" value="{$location.attribute_name}" name="attribute_name" readonly="">
                    </div>
                    <div class="col-md-2 col-xs-3 id_warehouse">
                        <label>Magazzino</label>
                        <select class="form-control" name="id_warehouse">
                            <option value="0">{l s='Seleziona' mod='mplocation'}</option>
                            {foreach $warehouses as $warehouse}
                                <option value="{$warehouse.id}" {if $location.id_warehouse == $warehouse.id}selected{/if}>{$warehouse.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col-md-2 col-xs-3 id_shelf">
                        <label>Scaffale</label>
                        <select class="form-control" name="id_shelf">
                            <option value="0">{l s='Seleziona' mod='mplocation'}</option>
                            {foreach $shelves as $shelf}
                                <option value="{$shelf.id}" {if $location.id_shelf == $shelf.id}selected{/if}>{$shelf.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col-md-2 col-xs-3 id_column">
                        <label>Colonna</label>
                        <select class="form-control" name="id_column">
                            <option value="0">{l s='Seleziona' mod='mplocation'}</option>
                            {foreach $columns as $column}
                                <option value="{$column.id}" {if $location.id_column == $column.id}selected{/if}>{$column.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col-md-2 col-xs-3 id_level">
                        <label>Livello</label>
                        <select class="form-control" name="id_level">
                            <option value="0">{l s='Seleziona' mod='mplocation'}</option>
                            {foreach $levels as $level}
                                <option value="{$level.id}" {if $location.id_level == $level.id}selected{/if}>{$level.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col-md-2 col-xs-3">
                        <label>{l s='Azioni' mod='mplocation'}</label><br>
                        <div class="btn-group" role="group" aria-label="Actions">
                            <button type="button" class="save-size btn btn-default" title="{l s='Salva la posizione' mod='mplocation'}" onclick="javascript:saveSize(this, {$location.id_product_attribute});">
                                <span class="material-icons">save</span>
                            </button>
                            <button type="button" class="save-size btn btn-danger" title="{l s='Rimuovi la posizione' mod='mplocation'}" onclick="javascript:removeSize(this, {$location.id_product_attribute});">
                                <span class="material-icons ">close</span>
                            </button>
                            <button type="button" class="save-size btn btn-default" title="{l s='Copia la posizione nella clipboard' mod='mplocation'}" onclick="javascript:copyClip(this, {$location.id_product_attribute});">
                                <span class="material-icons">content_copy</span>
                            </button>
                            <button type="button" class="save-size btn btn-warning" title="{l s='Imposta a tutti' mod='mplocation'}" onclick="javascript:setAll(this, {$location.id_product_attribute});">
                                <span class="material-icons">copy_all</span>
                            </button>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
        <div class="panel-footer"></div>
    </div>
</form>

<script type="text/javascript">
    function getOptionTextValue(row, index) {
        var children = $(row).find('div');
        if (children.length >= index) {
            var select = $(children[index - 1]).find('select');
        } else {
            var select = false;
        }
        if (select) {
            var option = getSelectedOptionText(select);
        } else {
            var option = false;
        }

        return option;
    }

    function getSelectedOptionText(select) {
        return $(select).find('option:selected').text();
    }

    function getSelectedOptionId(select) {
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

    function copyClip(button, id_product_attribute) {
        let row = $(button).closest('.row');
        let value = createLocationString(row);

        console.log("Clipboard: " + value);

        copyToClipboard(value);
    }

    function setAll(button) {
        var row = $(button).closest('.row');
        let select = $(row).find('select');
        $('select[name="id_warehouse"]').val($(row).find('select[name="id_warehouse"]').val());
        $('select[name="id_shelf"]').val($(row).find('select[name="id_shelf"]').val());
        $('select[name="id_column"]').val($(row).find('select[name="id_column"]').val());
        $('select[name="id_level"]').val($(row).find('select[name="id_level"]').val());
    }

    function createLocationString(row) {
        let select = $(row).find('select');
        let warehouse = $(select[0]).find('option:selected').text();
        let shelf = $(select[1]).find('option:selected').text();
        let column = $(select[2]).find('option:selected').text();
        let level = $(select[3]).find('option:selected').text();
        let value = warehouse + "#" + shelf + "#" + column + "#" + level;

        return value;
    }

    function saveSize(button) {
        if (!confirm("{l s='Aggiornare la posizione?' mod='mpshelf'}")) 
        {
            return false;
        }
        let row = $(button).closest('.row');
        let id_row = $(row).find('input[name="id_product_location"]');
        let id_product_location = $(row).find('input[name="id_product_location"]').val();
        let id_product = $(row).find('input[name="id_product_location"]').data('id_product');
        let id_product_attribute = $(row).find('input[name="id_product_location"]').data('id_product_attribute');
        let id_warehouse = $(row).find('select[name="id_warehouse"]').val();
        let id_shelf = $(row).find('select[name="id_shelf"]').val();
        let id_column = $(row).find('select[name="id_column"]').val();
        let id_level = $(row).find('select[name="id_level"]').val();
        let location = createLocationString(row);

        var obj_size = {
            id_product_location: id_product_location,
            id_product: id_product,
            id_product_attribute: id_product_attribute,
            id_warehouse: id_warehouse,
            id_shelf: id_shelf,
            id_column: id_column,
            id_level: id_level,
            location: location
        };

        $.ajax({
            url: '{$frontControllerAjax|escape:'html':'UTF-8'}',
            type: 'post',
            dataType: 'json',
            data: {
                action: 'updateShelfPosition',
                ajax: true,
                object: JSON.stringify(obj_size)
            },
            success: function(response) {
                if (response.result) {
                    $.growl.notice({
                        title: 'Aggiornamento posizione',
                        message: response.message
                    });
                    $(id_row).val(response.id);
                } else {
                    $.growl.error({
                        title: 'ERRORE',
                        message: response.message
                    });
                }
            },
            error: function(response) {
                $.growl.error({
                    title: 'ERRORE',
                    message: response.responseText
                });
                return false;
            }
        });
    }

    function removeSize(button) {
        if (!confirm("{l s='Rimuovere la posizione?' mod='mpshelf'}")) 
        {
            return false;
        }
        let row = $(button).closest('.row');
        let id_row = $(row).find('input[name="id_product_location"]');
        let id_product_location = $(row).find('input[name="id_product_location"]').val();

        $.ajax({
            url: '{$frontControllerAjax|escape:'html':'UTF-8'}',
            type: 'post',
            dataType: 'json',
            data: {
                action: 'removeShelfPosition',
                ajax: true,
                id: id_product_location
            },
            success: function(response) {
                if (response.result) {
                    $.growl.notice({
                        title: 'Rimozione posizione',
                        message: response.message
                    });

                    $(id_row).val("0");
                    $(row).find('div.id_warehouse select').val('0');
                    $(row).find('div.id_shelf select').val('0');
                    $(row).find('div.id_column select').val('0');
                    $(row).find('div.id_level select').val('0');
                } else {
                    $.growl.error({
                        title: 'ERRORE',
                        message: response.message
                    });
                }
            },
            error: function(response) {
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
        jAlert('<input type="text" value="' + position + '">');
    }

    $(document).ready(function() {
        // nothing to do
    });
</script>