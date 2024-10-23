<?php
/**
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
 */

namespace MpSoft\MpLocation\Helpers;
use MpSoft\MpLocation\Models\ModelProductLocation;
use MpSoft\MpLocation\Models\ModelProductLocationData;

class MpLocationProductExtra
{
    protected $id_product;
    protected $locations;
    protected $id_lang;

    public function __construct($id_product)
    {
        $this->id_product = $id_product;
        $this->id_lang = (int) \Context::getContext()->language->id;
        $this->locations = $this->getLocations();
    }

    public function getLocations()
    {
        $product = new \Product($this->id_product, false, $this->id_lang);
        if (!\Validate::isLoadedObject($product)) {
            return [];
        }
        $combinations = $product->getAttributeCombinations($this->id_lang);
        $locations = [];

        $location = $this->getLocation(0);
        $location['id_attribute'] = 0;
        $location['attribute_name'] = '--';
        $locations[0] = $location;

        foreach ($combinations as $combination) {
            if ($combination['id_attribute_group'] != 13) {
                continue;
            }
            $id_product_attribute = (int) $combination['id_product_attribute'];
            $location = $this->getLocation($id_product_attribute);
            if (!$location) {
                $location = [
                    'id_product_location' => 0,
                    'id_product' => $this->id_product,
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
            $location['id_attribute'] = $combination['id_attribute'];
            $location['attribute_name'] = \Tools::strtoupper($combination['attribute_name']);
            $locations[$id_product_attribute] = $location;
        }

        return $locations;
    }

    protected function getLocation($id_product_attribute)
    {
        return ModelProductLocation::getLocation($this->id_product, $id_product_attribute);
    }

    public function display()
    {
        $tpl = \Context::getContext()->smarty->createTemplate(
            _PS_MODULE_DIR_ . 'mplocation/views/templates/hook/hookDisplayAdminProductExtra.tpl'
        );
        $data = [
            'locations' => $this->locations,
            'id_product' => $this->id_product,
            'warehouses' => ModelProductLocationData::getList('warehouse'),
            'shelves' => ModelProductLocationData::getList('shelf'),
            'columns' => ModelProductLocationData::getList('column'),
            'levels' => ModelProductLocationData::getLIst('level'),
            'frontControllerAjax' => \Context::getContext()->link->getModuleLink('mplocation', 'Ajax', [], \Configuration::get('PS_SSL_ENABLED')),
        ];

        $tpl->assign($data);

        return $tpl->fetch();
    }
}
