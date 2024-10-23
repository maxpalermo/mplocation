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
    #customization-color li, #customization-position li
    {
        width: 32px;
        height: 32px;
        display: inline-block;
        background-color: transparent;
        border: 1px solid #969696;
        margin-right: 4px;
        margin-bottom: 4px;
    }

    #customization-color li.selected, #customization-position li.selected
    {
        border-color: #BB6050;
        border-width: 2px;
    }

    #customization-position li a>img
    {
        width: 100%;
        height: 100%;
    }

    #customization-color li a
    {
        display: block;
        width: 100%;
        height: 100%;
    }

    #img-logo:hover
    {
        cursor: pointer;
    }

    .title.customization
    {
        color: #232323;
        text-align: center;
        text-shadow: 2px 2px 2px #cecece;
    }

    .title.customization:hover
    {
        cursor: pointer;
        color: #3030f0;
        text-shadow: 2px 2px 4px #909090;
    }
    .customization_btn
    {
        padding: 8px;
        font-size: 1.5em;
        font-weight: bold;
        border: 1px solid #54b558;
        border-radius: 5px;
        color: #fcfcfc !important;
        width: 100%;
        height: 64px;
        text-align: center;
        background-color: #74d578;
    }
    .customization_btn:hover
    {
        background-color: #94f598;
        text-shadow: 1px 1px 2px #54b558;
    }
    .customization_btn span
    {
        color: #fcfcfc !important;
        text-shadow: 1px 1px 2px #353535 !important;
    }
    .customselect
    {
        border: 1px solid #969696;
        background-color: #fcfcfc;
        padding: 4px;
        color: #565656;
        text-shadow: 1px 1px 2px #cdcdcd;
    }
    .button-border
    {
        border: 2px solid #17a325;
        padding: 1px;
        margin: 0 auto;
        background; #fefefe;
        border-radius: 4px;
    }
    .button-border:hover
    {
        border-color: #91f29c;
    }

    .customization_type, .customization_type_btn
    {
        border: 1px solid;
        border-color: #91f29c #2e5733 #2e5733 #91f29c;
        background-color: #17a325;
        color: white;
        text-shadow: 1px 1px 2px #2e5733;
        text-align: center;
        display: block;
        border-radius: 4px;
        padding: 8px;
        font-size: 1.2em;
        margin: 0 auto;
    }
    .customization_type:hover, .customization_type_btn:hover
    {
        border-color: #ccedd0;
        text-shadow: 1px 1px 2px #1e2703;
    }
    .customization_type.selected
    {
        border-color: #903030;
        background-color: #903030;
        color: ##fcfcfc;
        text-shadow: 2px 2px 3px #232323;
    }

    li.position-box, li.color-box
    {
        width: 48px !important;
        height: 48px !important;
        border: 1px solid: #909090;
        padding: 1px;
        display: inline-block !important;
        margin-right: 4px;
        margin-bottom: 4px; 
    }
    li.position-box a, li.color-position a
    {
        margin: 0 auto;
    }
    .box-selected
    {
        border: 2px solid #903030 !important;
    }
    .badge-info
    {
        background-color: #17a325;
    }
    .badge-2x
    {
        font-size: 1.5em;
    }
    .box
    {
        margin: 8px auto;
        padding: 4px;
        border: 1px solid #17a325;
        font-size: 1.5em;
        text-align: justify;
        font-weight: bold;
    }
</style>

<form enctype="multipart/form-data" method="post" id="customization-form">
{include file="./errors.tpl"}
<div style="padding: 8px !important;" id="product-customization">
    <button type="button" class="customization_btn">
        <span class="title customization">{l s='Personalizzazione' mod='mpcustomization'}</span>
    </button>
    <!--<h3 class="title customization">{l s='Personalizzazione' mod='mpcustomization'}</h3>-->
    <hr>
    <div id="customization-container" style="display: none; border: none;">
        <!-- TYPE -->
        <div class="form-group customization-type">
            <label>{l s='Customization type' mod='mpcustomization'}</label>
            <br>
             <div class="box">
                <p>{$warnings}</p>
            </div>
            <br>
            <table class="responsive_table">
                <tbody>
                    <tr>
                    {foreach $cust_types as $t}
                        <td>
                            <div class="button-border">
                            <button type="button" class="customization_type" value="{$t.id}">
                                <span>{$t.name}</span>
                            </button>
                            </div>
                        </td>
                    {/foreach}
                    </tr>
                </tbody>
            </table>
        </div>
        <!-- CUSTOMIZATIONS -->
        <div class="form-group customization-product" style="display: none;">
            <label>{l s='Customization product' mod='mpcustomization'}</label>
            <table id="customization_products" class="responsive_table">
                <tbody>
                    <tr>
                    
                    </tr>
                </tbody>
            </table>
            <input type="hidden" name="select_product_cust" value="0">
            <br>
        </div>
        <!-- POSITIONS -->
        <div class="form-group customization-position" style="display: none;">
            <label for="customization-position">{l s='Position' mod='mpcustomization'}:&nbsp;<span id='position-span'></span></label>
            <ul class="clearfix">
                {foreach $cust_positions as $p}
                <li class="position-box" style="border: 1px solid #909090; padding: 1px; display: inline-block; width: 48px; height: 48px;">
                    <a href="javascript:void(0);" title="{$p.name}" class="position-content">
                        <img src="{$p.filename}" title="{$p.name}" style="width: 42px; height: 42px; margin: 0 auto;">
                    </a>
                </li>
                {/foreach}
            </ul>
            <input type="hidden" name="position-box" value="">
        </div>
        <!-- COLORS -->
        <div class="form-group customization-color" style="display: none;">
            <label for="customization-color">{l s='Color' mod='mpcustomization'}:&nbsp;<span id='color-span'></span></label>
            <ul class="clearfix">
                {foreach $cust_colors as $c}
                <li class="color-box" style="border: 1px solid #909090; padding: 1px; display: inline-block; width: 48px; height: 48px;">
                    <a href="javascript:void(0);" title="{$c.name}" class="color-content">
                        <div title="{$c.name}" style="width: 42px; height: 42px; margin: 0 auto; background-color: {$c.color};"></div>
                    </a>
                </li>
                {/foreach}
            </ul>
            <input type="hidden" name="color-box" value="">
        </div>
        <!-- TEXT -->
        <div class="customization-rows" style="display: none;">
            <div class="form-group">
                <label for="input-text-1">{l s='Embroidery text (first row)'  mod='mpcustomization'}</label>
                <input type="text" name="input-text-1" id="input-text-1" class="form-control" value="" maxlength="15">
            </div>
            <div class="form-group">
                <label for="input-text-2">{l s='Embroidery text (second row)' mod='mpcustomization'}</label>
                <input type="text" name="input-text-2" id="input-text-2" class="form-control" value="" maxlength="15">
            </div>
        </div>
        <!-- FONT -->
        <div class="form-group customization-font" style="display: none;">
            <label for="select-font">{l s='Font' mod='mpcustomization'}</label>
            <select name="select-font" id="select-font" class="customselect" style="width: 100%;">
                <option value="0" data-type="0" data-img="http://lightwidget.com/widgets/empty-photo.jpg">{l s='Please select' mod='mpcustomization'}</option>
                {foreach $cust_fonts as $f}
                    <option value="{$f.name}" data-img="{$f.filename}">{$f.name}</option>
                {/foreach}
            </select>
            <img id="preview-font" style="width: 240px; display:none; margin-top: 12px;" src="">
        </div>
        <!-- LOGO -->
        <div class="form-group customization-logo" style="display: none;">
            <label for="input-select-image">{l s='Logo' mod='mpcustomization'}</label>
            <input type="file" onchange="readURL(this);" name="image_logo" id="input-select-image" style="width: 100%; display: none;">
            <div class="logo-canvas" style="text-align: center;" onclick="$('#input-select-image').click();">
                <img id="img-logo" style="width: 240px; margin: 8px auto; border: 1px solid #ababab;" src="{$click_here}" alt="image preview" />
            </div>
        </div>
        <!-- CART PRODUCTS -->
        <div class="form-group cart-products" style="display: none;">
            <label for="cart-product">{l s='Select product to apply customization' mod='mpcustomization'}</label>
            <table class="responsive_table">
                <thead>
                    <tr>
                        <th>--</th>
                        <th>{l s='Name product' mod='mpcustomization'}</th>
                        <th>{l s='Qty in cart' mod='mpcustomization'}</th>
                        <th>{l s='Customized qty' mod='mpcustomization'}</th>
                        <th>{l s='Price' mod='mpcustomization'}</th>
                        <th>{l s='Total' mod='mpcustomization'}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $cart_products as $p}
                    <tr>
                        <td><input type="checkbox" name="chk_select_cart_product[]" value="{$p.id_product}.{$p.id_product_attribute}" class="chk-prod"></td>
                        <td>{$p.name}</td>
                        <td style="text-align: center;"><span class="badge badge-info badge-2x">{$p.quantity}</span></td>
                        <td>
                            <input type="hidden" name="cust_id_product[]" value="{$p.id_product}" class="cust_id_product">
                            <input type="hidden" name="cust_id_product_attribute[]" value="{$p.id_product_attribute}" class="cust_id_product_attribute">
                            <input type="number" name="cust_qty[]" value="0" style="text-align: right; padding: 4px; width: 96px;" class="cust-qty">
                        </td>
                        <td style="align: center;"><span class="badge badge-info badge-2x cust-price">{displayPrice price=0}</span></td>
                        <td style="align: center;"><span class="badge badge-info badge-2x cust-total">{displayPrice price=0}</span></td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        <!-- FOOTER -->
        <div class="form-group customization-footer" style="display: none; height: 64px;">
            <div class="button-border pull-right">
                <button type="submit" class="customization_type_btn" name="submitCustomization">
                    <i class="icon icon-save icon-2x"></i>
                    <span>{l s='Save' mod='mpcustomization'}</span>
                </button>
            </div>
        </div>
        <hr>
    </div>
</div>
</form>

<script>
    var input_file_data;

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#img-logo').attr('src', e.target.result);
                input_file_data = e.target;
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    function bootstrap_check(check, checked)
    {
        if (checked) {
            $(check).parents('span').addClass("checked").end().attr("checked", true).change();
        } else {
            $(check).parents('span').removeClass("checked").end().removeAttr("checked").change();
        }
    }

    $(document).ready(function(){
        /**
         * POSITION BUTTON
         **/
        $('#cart_summary').before($('#customization-form').detach());

        /**
         * SELECTED TYPE CUSTOMIZATION
         **/
        $('.customization_type').on('click', function(){
            var id_type = $(this).val();
            var item = $(this);
            var customizations = $('#customization_product');

            $('.customization_type').closest('tr').find('.customization_type').removeClass('selected');
            $(this).addClass('selected');

            if (id_type==0) {
                $('.customization-product').fadeOut();
                $('.customization-position').fadeOut();
                $('.customization-font').fadeOut();
                $('.customization-rows').fadeOut();
                $('.customization-logo').fadeOut();
                $('.customization-footer').fadeOut();
                $('.cart-products').fadeOut();
                return false;
            }

            $('#customization_products tbody tr').html("");

            $.ajax({
                type: 'post',
                dataType: 'json',
                data:
                {
                    ajax: true,
                    action: 'getCustomizationProducts',
                    id_type: id_type
                },
                success: function(response)
                {
                    $(response).each(function(){
                        var but = this;
                        var button = $('<div></div>')
                            .addClass('button-border')
                            .html(
                                $('<button></button>')
                                    .attr('type', 'button')
                                    .addClass('customization_type')
                                    .addClass('customselect')
                                    .attr('name', 'but_customization')
                                    .val(but.id)
                                    .html(
                                        $('<span></span>')
                                            .text(but.name)
                                    )
                            );
                        $('#customization_products tbody tr').append(
                            $('<td></td>')
                                .html(button)
                        );
                    });
                    $('.customization-product').fadeIn();
                },
                error: function(response)
                {
                    console.log("ERROR:", response.responseText);
                }
            });
        });

        /**
         * SELECT CUSTOMIZATION
         */
        $(document).on('click', '.customselect', function(){
            
            console.log("button clicked: ", $(this).val());
            $(this).closest("table").next().val($(this).val());

            $('.customselect').closest('tr').find('.customselect').removeClass('selected');
            $(this).addClass('selected');
            
            var id_product = $(this).val();
            if (id_product == 0) {
                $('.customization-position').fadeOut();
                $('.customization-color').fadeOut();
                $('.customization-rows').fadeOut();
                $('.customization-font').fadeOut();
                $('.customization-logo').fadeOut();
                $('.customization-footer').fadeOut();
                $('.cart-products').fadeOut();
                return;
            }
            $.ajax({
                type: 'post',
                dataType: 'json',
                data:
                {
                    ajax: true,
                    action: 'hasLogo',
                    id_product: id_product
                },
                success: function(response)
                {
                    console.log("has logo: ", response.hasLogo);
                    if (response.hasLogo == 1) {
                        $('.customization-position').fadeIn();
                        $('.customization-color').fadeOut();
                        $('.customization-rows').fadeOut();
                        $('.customization-font').fadeOut();
                        $('.customization-logo').fadeIn();
                        $('.customization-footer').fadeIn();
                        $('.cart-products').fadeIn();
                    } else {
                        $('.customization-position').fadeIn();
                        $('.customization-color').fadeIn();
                        $('.customization-rows').fadeIn();
                        $('.customization-font').fadeIn();
                        $('.customization-logo').fadeOut();
                        $('.customization-footer').fadeIn();
                        $('.cart-products').fadeIn();
                    }
                },
                error: function(response)
                {
                    console.log("ERROR:", response.responseText);
                }
            });
        });


        /**
         * SELECT POSITION
         */
        $('.position-content').on('click', function(){
            console.log('Position content clicked');
            console.log('title', $(this).attr('title'));
            $('.position-content').closest('li').removeClass('box-selected');
            $(this).closest('li').addClass('box-selected');
            $('#position-span').html($(this).attr('title'));
            $('input[name="position-box"]').val($(this).attr('title'));
        });

        /**
         * SELECT COLOR
         */
        $('.color-content').on('click', function(){
            console.log('Color content clicked');
            console.log('color', $(this).attr('color'));
            $('.color-content').closest('li').removeClass('box-selected');
            $(this).closest('li').addClass('box-selected');
            $('#color-span').html($(this).attr('title'));
            $('input[name="color-box"]').val($(this).attr('title'));
        });

        /**
         * SELECT FONT
         */
        $('#select-font').on('click', function(){
            var id = $('#select-font').val();
            $('#select-font option').each(function(){
                if ($(this).attr('value') == id) {
                    item = this;
                    var filename = $(item).attr('data-img');
                    $('#preview-font').attr('src', filename).fadeIn();
                    return true;
                }
            });
        });
        
        /**
         * SELECT QUANTITY
         */
        $('.cust-qty').on('change', function(){
            var item = this;
            var id_product = $('input[name="select_product_cust"]').val();
            var chk = $(item).closest('tr').find('.chk-prod');
            var price = $(item).closest('tr').find('.cust-price');
            var total = $(item).closest('tr').find('.cust-total');

            if (item.value<0) {
                item.value=0;
            }
            if (item.value == 0) {
                $(chk).prop('checked', false);
                bootstrap_check(chk, false);
                $(price).html("{displayPrice price=0}");
            } else {
                $(chk).prop('checked', true);
                bootstrap_check(chk, true);
            }

            if (item.value > 0) {
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    data:
                    {
                        ajax: true,
                        action: 'getCustomizationPrice',
                        id_product: id_product,
                        quantity: item.value,
                    },
                    success: function(response)
                    {
                        $(price).html(response.price);
                        $(total).html(response.total);
                    },
                    error: function(response)
                    {
                        console.log(response.responseText);
                    }
                });
            }
        });

        /**
         * CHECK PRODUCT
         */
        $('.chk-prod').on('click', function(){
            var chk = this;
            var qty = $(chk).closest('tr').find('.cust-qty');
            var price = $(chk).closest('tr').find('.cust-price');
            if ($(chk).prop('checked') == false) {
                $(qty).val("0");
                $(price).html("{displayPrice price=0}");
            } 
        });

        $('.customization_btn').on('click', function(){
            $('#customization-container').toggle('fold');
        });
    });
</script>
