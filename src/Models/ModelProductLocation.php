<?php
/*
* Copyright since 2007 PrestaShop SA and Contributors
* PrestaShop is an International Registered Trademark & Property of PrestaShop SA
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
*  @author    Massimiliano Palermo <maxx.palermo@gmail.com>
*  @copyright Since 2016 Massimiliano Palermo
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

namespace MpSoft\MpLocation\Models;

class ModelProductLocation extends ModelTemplate
{
    public $id_product;
    public $id_product_attribute;
    public $id_warehouse;
    public $id_shelf;
    public $id_column;
    public $id_level;
    public $location;

    /**
     * Object definitions
     */
    public static $definition = [
        'table' => 'product_location',
        'primary' => 'id_product_location',
        'fields' => [
            'id_product' => [
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => true,
            ],
            'id_product_attribute' => [
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => true,
            ],
            'id_warehouse' => [
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => true,
            ],
            'id_shelf' => [
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => true,
            ],
            'id_column' => [
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => true,
            ],
            'id_level' => [
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => true,
            ],
            'location' => [
                'type' => self::TYPE_STRING,
                'validate' => 'isAnything',
                'required' => true,
                'size' => 255,
            ],
        ],
    ];

    public static function getLocations($id_product, $full = false)
    {
        if ($full) {
            $tbl_location = ModelProductLocationData::$definition['table'];
            $tbl_product = self::$definition['table'];

            $sql = new \DbQuery();
            $sql->select('a.*, b.name as `warehouse`, c.name as `shelf`, d.name as `column`, e.name as `level`')
                ->from($tbl_product, 'a')
                ->leftJoin($tbl_location, 'b', 'a.id_warehouse=b.id_product_location_data and b.type=\'warehouse\'')
                ->leftJoin($tbl_location, 'c', 'a.id_shelf=c.id_product_location_data and c.type=\'shelf\'')
                ->leftJoin($tbl_location, 'd', 'a.id_column=d.id_product_location_data and d.type=\'column\'')
                ->leftJoin($tbl_location, 'e', 'a.id_level=e.id_product_location_data and e.type=\'level\'')
                ->where('id_product=' . (int) $id_product)
                ->orderBy('id_product_attribute ASC');
            $res = \Db::getInstance()->executeS($sql);
            if ($res) {
                return $res;
            } else {
                return [];
            }
        } else {
            $sql = new \DbQuery();
            $sql->select('*')
                ->from(self::$definition['table'])
                ->where('id_product=' . (int) $id_product)
                ->orderBy('id_product_attribute ASC');
            $res = \Db::getInstance()->executeS($sql);
            if ($res) {
                return array_column($res, 'id_product_attribute');
            } else {
                return [];
            }
        }
    }

    public static function getLocation($id_product, $id_product_attribute = 0)
    {
        $db = \Db::getInstance();
        $sql = new \DbQuery();
        $sql->select('*')
            ->from(self::$definition['table'])
            ->where('id_product = ' . (int) $id_product)
            ->where('id_product_attribute = ' . (int) $id_product_attribute)
            ->orderBy('id_product_attribute ASC');
        $location = $db->getRow($sql);

        if (!$location) {
            return [
                'id_product_location' => 0,
                'id_product' => $id_product,
                'id_attribute' => 0,
                'attribute_name' => '',
                'id_product_attribute' => $id_product_attribute,
                'id_warehouse' => 0,
                'id_shelf' => 0,
                'id_column' => 0,
                'id_level' => 0,
                'location' => '',
            ];
        }

        return $location;
    }
}
