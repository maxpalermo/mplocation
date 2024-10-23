<?php
use MpSoft\MpLocation\Helpers\MpLocationProductExtra;

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
if (!defined('_PS_VERSION_')) {
    exit;
}

use MpSoft\MpLocation\Models\ModelProductLocationData;

require_once dirname(__FILE__) . '/vendor/autoload.php';
require_once dirname(__FILE__) . '/src/Models/autoload.php';

use MpSoft\MpLocation\Module\ModuleTemplate;
use PrestaShop\PrestaShop\Core\Module\WidgetInterface;

class MpLocation extends ModuleTemplate implements WidgetInterface
{
    public $active_panel;

    public function __construct()
    {
        $this->name = 'mplocation';
        $this->tab = 'front_office_features';
        $this->version = '2.0.1';
        $this->author = 'Massimiliano Palermo';
        $this->need_instance = 0;
        $this->module_key = '';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('MP Catalogazione Prodotti');
        $this->description = $this->l('Questo modulo cataloga i prodotti in base alla loro posizione.');
        $this->confirmUninstall = $this->l('Are you sure you want uninstall this module?');
        $this->ps_versions_compliancy = ['min' => '8.0', 'max' => _PS_VERSION_];
    }

    public function getWidgetVariables($hookName, array $configuration)
    {
        return "<h2>Widget rendered on {$hookName}</h2>";
    }

    public function renderWidget($hookName, array $configuration)
    {
        return $this->getWidgetVariables($hookName, $configuration);
    }

    /**
     * Don't forget to create update methods if needed:
     * http://doc.prestashop.com/display/PS16/Enabling+the+Auto-Update
     */
    public function install()
    {
        $hooks = [
            'displayAdminProductsExtra',
            'actionAdminControllerSetMedia',
            'actionFrontControllerSetMedia',
        ];

        return parent::install()
            && $this->registerHook($hooks)
            && $this->installModuleTab(
                $this->l('MP Catalogazione Prodotti'),
                $this->name,
                'AdminCatalog',
                'AdminMpLocation',
                'fa-cogs'
            );
    }

    public function hookActionAdminControllerSetMedia($params)
    {
        $controller = Tools::getValue('controller');
        if (Tools::strtolower($controller) === 'adminmodules' && Tools::getValue('configure') === $this->name) {
            $this->context->controller->addCSS($this->_path . 'views/css/bootstrap.min.css');
            $this->context->controller->addJS($this->_path . 'views/js/bootstrap.bundle.min.js');
            $this->context->controller->addJqueryPlugin('growl');
        }
    }

    public function hookActionFrontControllerSetMedia($params)
    {
        // nothing, dummy function for ajax calls.
    }

    public function hookDisplayAdminProductsExtra($params)
    {
        $location = new MpLocationProductExtra((int) $params['id_product']);

        return $location->display();
    }

    public function getSizes($id_product)
    {
        $id_lang = (int) Context::getContext()->language->id;
        $attr_size = 13;
        $db = Db::getInstance();
        $sql = new DbQuery();
        $sql->select('id_product_attribute')
            ->from('product_attribute')
            ->where('id_product=' . (int) $id_product);
        $attr = $db->executeS($sql);
        $sizes = [];
        if ($attr) {
            foreach ($attr as $a) {
                $sql = new DbQuery();
                $sql->select('al.name')
                    ->from('attribute_lang', 'al')
                    ->innerJoin(
                        'attribute',
                        'a',
                        'a.id_attribute=al.id_attribute'
                        . ' and id_lang=' . (int) $id_lang
                        . ' and a.id_attribute_group=' . (int) $attr_size
                    )
                    ->innerJoin(
                        'product_attribute_combination',
                        'pac',
                        'pac.id_attribute=a.id_attribute'
                        . ' and pac.id_product_attribute=' . (int) $a['id_product_attribute']
                    );
                $size = $db->getValue($sql);
                $sizes[] = [
                    'size' => $size,
                    'id_product_shelves' => 0,
                    'id_product' => $id_product,
                    'id_product_attribute' => $a['id_product_attribute'],
                    'id_warehouse' => 0,
                    'id_shelf' => 0,
                    'id_column' => 0,
                    'id_level' => 0,
                ];
            }
        }
        array_unshift(
            $sizes,
            [
                'size' => '--',
                'id_product_shelves' => 0,
                'id_product' => $id_product,
                'id_product_attribute' => 0,
                'id_warehouse' => 0,
                'id_shelf' => 0,
                'id_column' => 0,
                'id_level' => 0,
            ]
        );

        foreach ($sizes as &$size) {
            $sql = new DbQuery();
            $sql->select('*')
                ->from('product_shelves')
                ->where('id_product=' . (int) $size['id_product'])
                ->where('id_product_attribute=' . (int) $size['id_product_attribute']);
            $row = $db->getRow($sql);
            if ($row) {
                $size['id_product_shelves'] = (int) $row['id_product_shelves'];
                $size['id_warehouse'] = (int) $row['id_warehouse'];
                $size['id_shelf'] = (int) $row['id_shelf'];
                $size['id_column'] = (int) $row['id_column'];
                $size['id_level'] = (int) $row['id_level'];
            }
        }

        return $sizes;
    }

    public function getContent()
    {
        $this->postProcess();

        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            [
                'errors' => $this->_errors,
                'confirmations' => $this->_confirmations,
            ]
        );
        $file = $this->local_path . 'views/templates/admin/getContent.tpl';
        $tpl = $smarty->createTemplate($file, $smarty);
        $tpl->assign(
            [
                'module_dir' => $this->_path,
                'module_name' => $this->name,
                'module_version' => $this->version,
                'module_author' => $this->author,
                'module_displayName' => $this->displayName,
                'module_description' => $this->description,
                'warehouses' => ModelProductLocationData::getList('warehouse', 'name'),
                'shelves' => ModelProductLocationData::getList('shelf', 'name'),
                'columns' => ModelProductLocationData::getList('column', 'name'),
                'levels' => ModelProductLocationData::getList('level', 'name'),
                'link' => Context::getContext()->link,
            ]
        );

        return $tpl->fetch($file);
    }

    public function postProcess()
    {
    }

    public function addError($error)
    {
        if (!in_array($error, $this->_errors)) {
            $this->_errors[] = $error;
        }
    }

    public function addConfirmation($confirmation)
    {
        if (!in_array($confirmation, $this->_confirmations)) {
            $this->_confirmations[] = $confirmation;
        }
    }

    public function getErrorsCount()
    {
        return count($this->_errors);
    }
}
