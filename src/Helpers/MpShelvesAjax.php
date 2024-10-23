<?php
/**
 * 2017 mpSOFT
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
 *  @author    Massimiliano Palermo <info@mpsoft.it>
 *  @copyright 2019 Digital Solutions®
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of mpSOFT
 */

class MpShelvesAjax
{   
    public $module;

    public function __construct($module = null)
    {
        if ($module) {
            $this->module = $module;
        }
    }

    /**
     * Get selected Type Customization
     *
     * @return json Type attributes
     */
    public function ajaxProcessGetType()
    {
        $id = (int)Tools::getValue('id');
        $type = new MpCustomizationType($id);
        return Tools::jsonEncode(
            array(
                'id' => $type->id,
                'name' => $type->name,
                'active' => (int)$type->active,
            )
        );
    }

    /**
     * Get customization fields from product
     *
     * @return json Customization fields array
     */
    public function ajaxProcessGetAssociations()
    {
        $id_lang = (int)Context::getContext()->language->id;
        $id_product = (int)Tools::getValue('id_product');
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('a.id_customization_field as value')
            ->select('a.type')
            ->select('al.name')
            ->from('customization_field', 'a')
            ->innerJoin(
                'customization_field_lang',
                'al',
                'al.id_customization_field=a.id_customization_field and al.id_lang='.(int)$id_lang
            )->where('id_product='.(int)$id_product)
            ->orderBy('al.name');
        $res = $db->executeS($sql);
        if ($res) {
            return Tools::jsonEncode(array('options' => $res));
        }
        return Tools::jsonEncode(array('options' => array()));
    }

    /**
     * Get price from selected product quantity
     *
     * @return json product price based on quantity
     */
    public function ajaxProcessGetCustomizationPrice()
    {
        $id_customization_product = (int)Tools::getValue('id_product');
        $customization_product = new MpCustomizationProduct($id_customization_product);
        $id_product = (int)$customization_product->id_product;
        $quantity = (int)Tools::getValue('quantity');

        $product = new Product($id_product);
        $price = $product->getPrice(true, null, 6, null, false, true, $quantity);
        $price_display = Tools::displayPrice($price);
        $total_display = Tools::displayPrice($price * $quantity);

        if ($quantity == 0) {
            $price_display = Tools::displayPrice(0);
            $total_display = Tools::displayPrice(0);
        }

        die(
            Tools::jsonEncode(
                array(
                    'price' => $price_display,
                    'total' => $total_display,
                )
            )
        );
    }
    
    /**
     * Get Customization product from selected type
     *
     * @return void
     */
    public function ajaxProcessGetCustomizationProducts()
    {
        $id_type = (int)Tools::getValue('id_type');
        $res = MpCustomizationDatabase::getCustomizations($id_type);
        die (Tools::jsonEncode($res));
    }

    /**
     * Get Customization color from selected id
     *
     * @return void
     */
    public function ajaxProcessGetCustomizationColor()
    {
        $id = (int)Tools::getValue('id');
        $res = new MpCustomizationColor($id);
        die (Tools::jsonEncode($res));
    }

    /**
     * Get Customization position from selected id
     *
     * @return void
     */
    public function ajaxProcessGetCustomizationPosition()
    {
        $id = (int)Tools::getValue('id');
        $res = new MpCustomizationPosition($id);
        if ($res) {
            $folder = '/modules/mpcustomization/views/img/pos/';
            $res->filename = $folder.$res->filename;
        }
        die (Tools::jsonEncode($res));
    }

    /**
     * Get Customization font from selected id
     *
     * @return void
     */
    public function ajaxProcessGetCustomizationFont()
    {
        $id = (int)Tools::getValue('id');
        $res = new MpCustomizationFont($id);
        if ($res) {
            $folder = '/modules/mpcustomization/views/img/fonts/';
            $res->filename = $folder.$res->filename;
        }
        die (Tools::jsonEncode($res));
    }

    /**
     * Check if Customization product has logo
     *
     * @return json Has logo or not
     */
    public function ajaxProcessHasLogo()
    {
        $id_product = (int)Tools::getValue('id_product');
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('has_logo')
            ->from('mp_customization_product')
            ->where('id_mp_customization_product='.(int)$id_product);
        $res = (int)$db->getValue($sql);
        die (Tools::jsonEncode(array('hasLogo' => $res)));
    }

    public function ajaxProcessGetCustomizationProduct()
    {
        $id_customization_product = (int)Tools::getValue('id');
        $product = new MpCustomizationProduct($id_customization_product);
        die (Tools::jsonEncode($product));
    }
}
