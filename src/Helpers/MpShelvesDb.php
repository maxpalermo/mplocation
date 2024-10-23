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

class MpShelvesDb
{   
    /**
     * Returns array with customization types
     *
     * @return array Customization type
     */
    public static function getTypes()
    {
        $db = Db::getInstance();
        $ctx = self::getContextValues();
        $sql = new DbQuery();
        $sql->select('id_mp_customization_type as id')
            ->select('name')
            ->from('mp_customization_type')
            ->where('id_lang='.(int)$ctx['id_lang'])
            ->where('active=1')
            ->orderBy('name');
        $res = $db->executeS($sql);
        if ($res) {
            return $res;
        }
        return array();
    }


    /**
     * Returns array of Curstomization products 
     * of selected type
     *
     * @param int $id_type
     * @return array Customization products
     */
    public static function getCustomizations($id_type)
    {
        $db = Db::getInstance();
        $ctx = self::getContextValues();
        $sql = new DbQuery();
        $sql->select('cp.id_mp_customization_product as id')
            ->select('cpl.name')
            ->from('mp_customization_product', 'cp')
            ->innerJoin(
                'mp_customization_product_lang',
                'cpl',
                'cpl.id_mp_customization_product=cp.id_mp_customization_product and cpl.id_lang='.(int)$ctx['id_lang']
            )
            ->where('id_mp_customization_type='.(int)$id_type)
            ->where('active=1');
        $res = $db->executeS($sql);
        if ($res) {
            return $res;
        }
        return array();
    }
    
    /**
     * Returns array of id_product
     *
     * @return array id_product
     */
    public static function getProducts()
    {
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('id_product')
            ->from('mp_customization_product')
            ->where('id_shop='.(int)Context::getContext()->shop->id);
        $res = $db->executeS($sql);
        $output = array();
        if ($res) {
            foreach ($res as $item) {
                $output[] = $item['id_product'];
            }
        }
        return $output;
    }

    /**
     * Get products that have customization fields
     *
     * @return array products
     */
    public static function getProductForCustomization()
    {
        $id_lang = (int)Context::getContext()->language->id;
        $id_shop = (int)Context::getContext()->shop->id;
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('distinct p.id_product as id')
            ->select('pl.name')
            ->from('product', 'p')
            ->innerJoin(
                'product_lang',
                'pl',
                'pl.id_product=p.id_product '
                .'and pl.id_lang='.(int)$id_lang
                .' and pl.id_shop='.(int)$id_shop
            )->innerJoin(
                'customization_field',
                'cf',
                'cf.id_product=p.id_product'
            )
            ->where('p.active=1')
            ->orderBy('pl.name');
        $res = $db->executeS($sql);
        if ($res) {
            return $res;
        }
        return array();
    }

    /**
     * Returns array of active product
     *
     * @return array products
     */
    public static function getActiveProducts()
    {
        $id_lang = (int)Context::getContext()->language->id;
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('p.id_product as id')
            ->select('pl.name')
            ->from('product', 'p')
            ->innerJoin('product_lang', 'pl', 'pl.id_product=p.id_product and pl.id_lang='.(int)$id_lang)
            ->where('p.active=1')
            ->where('id_shop='.(int)Context::getContext()->shop->id)
            ->orderBy('pl.name');
        $res = $db->executeS($sql);
        return $res;
    }

    /**
     * Get customization field association from customized product
     *
     * @param int $id_customization
     * @return void
     */
    public static function getCustomizationFields($id_customization)
    {
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('id_mp_customization_product_associations')
            ->from('mp_customization_product_associations')
            ->where('id_mp_customization_product='.(int)$id_customization);
        return (int)$db->getValue($sql);
    }

    /**
     * Return array with customization field list
     * for selected product
     *
     * @param int $id_product
     * @return array Customization fields
     */
    public static function getProductCustomizationFields($id_product)
    {
        $id_lang = Context::getContext()->language->id;
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('cf.id_customization_field')
            ->select('cf.type')
            ->select('cfl.name')
            ->from('customization_field', 'cf')
            ->innerJoin(
                'customization_field_lang',
                'cfl',
                'cfl.id_customization_field=cf.id_customization_field and cfl.id_lang='.(int)$id_lang
            )
            ->where('cf.id_product='.(int)$id_product)
            ->orderBy('cf.id_customization_field');
        $res = $db->executeS($sql);
        if ($res) {
            return $res;
        }
        return array();
    }

    /**
     * Returns array with Colors
     *
     * @return array Colors
     */
    public static function getColors()
    {
        $id_lang = (int)COntext::getContext()->language->id;
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('c.id_mp_customization_color as id')
            ->select('c.color')
            ->select('cl.name')
            ->from('mp_customization_color', 'c')
            ->innerJoin(
                'mp_customization_color_lang',
                'cl',
                'cl.id_mp_customization_color=c.id_mp_customization_color and cl.id_lang='.(int)$id_lang
            )
            ->orderBy('c.id_mp_customization_color');
        $colors = $db->executeS($sql);
        $output = array();
        if ($colors) {
            foreach ($colors as $c) {
                $output[] = array(
                    'id' => $c['id'],
                    'name' => $c['name'],
                    'color' => $c['color'],
                );
            }
        }
        return $output;
    }

    /**
     * Returns array with positions
     *
     * @param string $folder base folder for position images
     * @return array Positions
     */
    public static function getPositions($folder)
    {
        $id_lang = (int)Context::getContext()->language->id;
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('p.id_mp_customization_position as id')
            ->select('p.filename')
            ->select('pl.name')
            ->from('mp_customization_position', 'p')
            ->innerJoin(
                'mp_customization_position_lang',
                'pl',
                'pl.id_mp_customization_position=p.id_mp_customization_position and pl.id_lang='.(int)$id_lang
            )
            ->orderBy('p.id_mp_customization_position');
        $positions = $db->executeS($sql);
        $folder .= 'views/img/pos/';
        $output = array();
        if ($positions) {
            foreach ($positions as $p) {
                $output[] = array(
                    'id' => $p['id'],
                    'name' => $p['name'],
                    'filename' => $folder.$p['filename'],
                );
            }
        }
        return $output;
    }

    /**
     * Returns array with Fonts 
     *
     * @param string $folder base folder for font images
     * @return array Fonts
     */
    public static function getFonts($folder)
    {
        $id_lang = (int)Context::getContext()->language->id;
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('p.id_mp_customization_font as id')
            ->select('p.filename')
            ->select('pl.name')
            ->from('mp_customization_font', 'p')
            ->innerJoin(
                'mp_customization_font_lang',
                'pl',
                'pl.id_mp_customization_font=p.id_mp_customization_font and pl.id_lang='.(int)$id_lang
            )
            ->orderBy('p.id_mp_customization_font');
        $fonts = $db->executeS($sql);
        $folder .= 'views/img/fonts/';
        $output = array();
        if ($fonts) {
            foreach ($fonts as $p) {
                $output[] = array(
                    'id' => $p['id'],
                    'name' => $p['name'],
                    'filename' => $folder.$p['filename'],
                );
            }
        }
        return $output;
    }


    /**
     * Returns list of cart product 
     * without customization products
     *
     * @return array Products in cart
     */
    public static function getCartProducts()
    {
        $id_lang = (int)Context::getContext()->language->id;
        $cart = Context::getContext()->cart;
        $products = $cart->getProducts();
        $hidden = self::getProducts();
        $output = array();
        if ($products) {
            foreach ($products as $p) {
                if (!in_array($p['id_product'], $hidden)) {
                    $name = Product::getProductName($p['id_product'], $p['id_product_attribute'], $id_lang);
                    $output[] = array(
                        'id_product' => (int)$p['id_product'],
                        'id_product_attribute' => (int)$p['id_product_attribute'],
                        'name' => $name,
                        'quantity' => (int)$p['quantity'],
                    );
                }
            }
        }
        return $output;
    }

    /**
     * Get language and shop
     *
     * @return array values
     */
    public static function getContextValues()
    {
        return array(
            'id_lang' => (int)Context::getContext()->language->id,
            'id_shop' => (int)Context::getContext()->shop->id,
        );
    }
}
