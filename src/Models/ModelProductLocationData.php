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

class ModelProductLocationData extends ModelTemplate
{
    public $type;
    public $name;

    /**
     * Object definitions
     */
    public static $definition = [
        'table' => 'product_location_data',
        'primary' => 'id_product_location_data',
        'fields' => [
            'type' => [
                'type' => self::TYPE_STRING,
                'validate' => 'isAnything',
                'size' => 255,
                'required' => true,
            ],
            'name' => [
                'type' => self::TYPE_STRING,
                'validate' => 'isAnything',
                'size' => 255,
                'required' => true,
            ],
        ],
    ];

    public static function getList($type = 'all', $orderBy = 'id')
    {
        $db = \Db::getInstance();
        $sql = new \DbQuery();
        $sql->select('id_product_location_data as `id`, name')
            ->from(self::$definition['table']);
        if ($orderBy == 'id') {
            $sql->orderBy('id_product_location_data');
        } else {
            $sql->orderBy('name');
        }

        if ($type != 'all') {
            $sql->where('type="' . pSQL($type) . '"');
        }

        $sql = $sql->build();
        $res = $db->executeS($sql);

        if ($res) {
            return $res;
        } else {
            return [];
        }
    }

    public function exists()
    {
        $db = \Db::getInstance();
        $sql = new \DbQuery();
        $sql->select('id_product_location_data')
            ->from(self::$definition['table'])
            ->where('type="' . pSQL($this->type) . '"')
            ->where('name="' . pSQL($this->name) . '"');

        return (int) $db->getValue($sql);
    }

    public function hasChildren()
    {
        $type = $this->type;
        $field = 'id_' . $type;
        $db = \Db::getInstance();
        $sql = new \DbQuery();
        $sql->select('count(*)')
            ->from(ModelProductLocation::$definition['table'])
            ->where($field . '=' . (int) $this->id);

        return (int) $db->getValue($sql);
    }
}
