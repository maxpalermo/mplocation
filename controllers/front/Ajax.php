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

use MpSoft\MpLocation\Models\ModelProductLocation;
use MpSoft\MpLocation\Models\ModelProductLocationData;

class MpLocationAjaxModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();
        $this->ajax = true;
    }

    protected function response($params)
    {
        header('Content-Type: application/json; charset=utf-8');
        exit(json_encode($params));
    }

    public function displayAjax()
    {
        $action = Tools::getValue('action');
        if (!$action) {
            $this->response(['error' => $this->trans('Azione non valida.')]);
        }
        $action = 'ajax' . Tools::ucfirst($action);
        if (!method_exists($this, $action)) {
            $this->response(['error' => 'Invalid action']);
        }
        $this->response($this->{$action}());
    }

    public function ajaxRemoveShelfPosition()
    {
        $id = (int) Tools::getValue('id');
        if (!$id) {
            $this->response(['error' => 'Dati non validi']);
        }
        $model = new ModelProductLocation($id);

        try {
            $result = $model->delete();
            if (!$result) {
                $message = \Db::getInstance()->getMsgError();
            } else {
                $db = \Db::getInstance();
                $db->update(
                    'product',
                    ['location' => ''],
                    'id_product=' . (int) $model->id_product
                );
                $db->update(
                    'stock_available',
                    ['location' => ''],
                    'id_product=' . (int) $model->id_product . ' and id_product_attribute=0'
                );
                $message = $this->trans('Posizione rimossa con successo.');
            }
        } catch (Exception $e) {
            $message = $e->getMessage();
            $result = false;
        }

        $this->response(['result' => $result, 'message' => $message]);
    }

    public function ajaxUpdateShelfPosition()
    {
        /*
        object: {
            "id_product_location":1179,
            "id_product":9999,
            "id_product_attribute":1234
            "id_warehouse":1,
            "id_shelf":108,
            "id_column":219,
            "id_level":301,
            "location":"1-108-219-301"
        }
        */
        $object = json_decode(Tools::getValue('object'), true);
        if (!$object) {
            $this->response(['error' => 'Dati non validi', 'object' => $object]);
        }
        $object['id'] = (int) $object['id_product_location'];
        unset($object['id_product_location']);

        $model = new ModelProductLocation($object['id']);
        $model->hydrate($object);

        try {
            $result = $model->save();
            if (!$result) {
                $this->response(['result' => false, 'message' => \Db::getInstance()->getMsgError()]);
            } else {
                $db = \Db::getInstance();
                if ($model->id_product_attribute == 0) {
                    $db->update(
                        'product',
                        ['location' => $model->location],
                        'id_product=' . (int) $model->id_product
                    );
                    $db->update(
                        'stock_available',
                        ['location' => $model->location],
                        'id_product=' . (int) $model->id_product . ' and id_product_attribute=0'
                    );
                } else {
                    $db->update(
                        'stock_available',
                        ['location' => $model->location],
                        'id_product=' . (int) $model->id_product . ' and id_product_attribute=' . (int) $model->id_product_attribute
                    );
                }
            }
        } catch (Exception $e) {
            $this->response(['result' => false, 'message' => $e->getMessage()]);
            $result = false;
        }

        $this->response(
            [
                'result' => $result,
                'message' => $this->trans('Posizione aggiornata con successo.'),
                'id' => $model->id,
            ]
        );
    }

    public function ajaxAddElement()
    {
        $type = Tools::getValue('type');
        $name = Tools::getValue('name');

        if (!$type || !$name) {
            $this->response(['error' => 'Dati non validi']);
        }

        $model = new ModelProductLocationData();
        $model->type = $type;
        $model->name = $name;

        if (!$model->exists()) {
            $result = $model->add();
            if (!$result) {
                $message = \Db::getInstance()->getMsgError();
            } else {
                $message = $this->trans('Elemento aggiunto con successo.');
            }
        } else {
            $result = false;
            $message = $this->trans('Elemento già esistente.');
        }

        $this->response(['success' => $result, 'message' => $message]);
    }

    public function ajaxEditElement()
    {
        $id = (int) Tools::getValue('id');
        $type = Tools::getValue('type');
        $name = Tools::getValue('name');

        if (!$type || !$name) {
            $this->response(['error' => 'Dati non validi']);
        }

        $model = new ModelProductLocationData($id);
        $model->type = $type;
        $model->name = $name;

        if (\Validate::isLoadedObject($model)) {
            $result = $model->update();
            if (!$result) {
                $message = \Db::getInstance()->getMsgError();
            } else {
                $message = $this->trans('Elemento modificato con successo.');
            }
        } else {
            $result = false;
            $message = $this->trans('Elemento non esistente.');
        }

        $this->response(['success' => $result, 'message' => $message]);
    }

    public function ajaxRemoveElement()
    {
        $id = (int) Tools::getValue('id');

        if (!$id) {
            $this->response(['error' => 'Dati non validi']);
        }

        $model = new ModelProductLocationData($id);

        $children = $model->hasChildren();
        if ($children == 0) {
            $result = $model->delete();
            if (!$result) {
                $message = \Db::getInstance()->getMsgError();
            } else {
                $message = $this->trans('Elemento eliminato con successo.');
            }
        } else {
            $result = false;
            $message = $this->trans(
                sprintf('L\'elemento è associato a %d prodotti. Non è possibile rimuoverlo.', $children)
            );
        }

        $this->response(['success' => $result, 'message' => $message]);
    }
}
