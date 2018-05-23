<?php
/**
* 2007-2018 PrestaShop
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
*  @copyright 2018 Digital Solutions®
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

class MpGdprAccountModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();

        $this->addJqueryPlugin('growl');

        $processpage = Tools::getValue('processpage', '');
        if ($processpage) {
            $processpage = 'processPage'.$processpage;
            $this->$processpage();
        }
        if (Tools::isSubmit('ajax')) {
            $action = 'ajaxProcess'.Tools::ucFirst(Tools::getValue('action', 'default'));
            $result = $this->$action();
            print Tools::jsonEncode(array('result' => $result));
            exit();
        }
    }

    private function ajaxProcessOblivion()
    {
        $id_customer = (int)Tools::getValue('id_customer', 0);
        $db = Db::getInstance();
        $db->execute("delete from "._DB_PREFIX_."mp_customer_gdpr where id_customer=".(int)$id_customer);
        $customer = new customer($id_customer);
        $shop = new ShopCore(Context::getContext()->shop->id);

        /** SEND MAIL TO ADVICE CUSTOMER **/
        $to = $customer->email;
        $subject = $this->module->l('Customer account deleted');
        $txt = $this->module->l('As you requested on your account page, all data concerning your account has been deleted.');
        $headers = "From: info@dalavoro.com" . "\r\n" . "CC: info@mpsoft.com";
        $customer->logout();
        $result = $customer->delete();
        if ($result) {
            mail($to,$subject,$txt,$headers);    
        }

        return array(
            'result' => $result,
            'redirect' => $shop->getBaseURI(),
        );
    }

    private function ajaxProcessRemovePreference()
    {
        $id = (int)Tools::getValue('id', 0);
        $pref = new MpGdprObjectModelCustomerGdpr($id);
        if ($pref->name == 'job area') {
            $id_ref = (int)$pref->choice_value;
            $job_area = new MpGdprObjectModelCustomerJobArea($id_ref);
            $job_area->delete();
        } elseif ($pref->name == 'job name') {
            $id_ref = (int)$pref->choice_value;
            $job_name = new MpGdprObjectModelCustomerJobName($id_ref);
            $job_name->delete();
        } elseif ($pref->name == 'newsletter') {
            $id_customer = (int)Context::getContext()->customer->id;
            $customer = new Customer($id_customer);
            $customer->newsletter = 0;
            $customer->save();
        }
        return $pref->delete();
    }

    private function ajaxProcessUnsubscribe()
    {
        $id_customer = (int)Tools::getValue('id_customer', 0);
        $customer = new Customer($id_customer);
        $customer->newsletter = 0;
        return $customer->save();
    }

    private function processPageEraseData()
    {
        $shop = new ShopCore(Context::getContext()->shop->id);
        $id_lang = (int)Context::getContext()->language->id; 
        $url = $shop->getBaseURI().'modules/mpgdpr/vendor/bootstrap4';
        $smarty = Context::getContext()->smarty;
        $customer = new Customer((int)Context::getContext()->customer->id);
        $customer->date_add = Tools::displayDate($customer->date_add);
        $orders = $this->getCustomerOrders($customer->id);
        $pref = $this->getPreferences($customer->id);
        foreach ($orders as &$order) {
            $order['date'] = Tools::displayDate($order['date_add']);
            $order['total'] = Tools::displayPrice($order['total_paid']);
            $order['status'] = $this->getStatus($order['id_order'], $id_lang);
        }

        $smarty->assign(
            array(
                'customer' => $customer,
                'orders' => $orders,
                'bootstrap4' => $url,
                'preferences' => $pref,
            )
        );
        $this->setTemplate('erase_data.tpl');
    }

    private function processPageExportData()
    {
        header("Content-type: text/plain");
        header("Content-Disposition: attachment; filename=customer.csv");

        $id_shop = (int)Context::getContext()->shop->id;
        $id_lang = (int)Context::getContext()->language->id;
        $db = Db::getInstance();

        $customer = new Customer(Context::getContext()->customer->id);
        $header_customer = array(
            'id_customer',
            'firstname',
            'lastname',
            'email',
            'newsletter',
            'ip_newsletter',
            'newsletter_date',
            'website',
            'active',
            'date_add',
        );
        $content_customer = array(
            $customer->id,
            $customer->firstname,
            $customer->lastname,
            $customer->email,
            $customer->newsletter,
            $customer->ip_registration_newsletter,
            Tools::displayDate($customer->newsletter_date_add),
            $customer->website,
            $customer->active,
            Tools::displayDate($customer->date_add),
        );
        /** PRINT CUSTOMER **/
        print "CUSTOMER ACCOUNT";
        print PHP_EOL;
        print implode("\t",$header_customer);
        print PHP_EOL;
        print implode("\t",$content_customer);
        

        $header_address = array(
            'id_address',
            'country',
            'state',
            'alias',
            'company',
            'lastname',
            'firstname',
            'address1',
            'address2',
            'postcode',
            'city',
            'phone',
            'phone_mobile',
            'vat_number',
            'dni',
            'date_add',
            'active',
            'deleted',
        );
        $sql= "select * from "._DB_PREFIX_."address where id_customer=".(int)$customer->id." order by date_add";
        $result = $db->executeS($sql);
        $content_address = array();
        if ($result) {
            foreach($result as $row) {
                $country = new Country($row['id_country']);
                $state = new State($row['id_state']);
                $addr = array(
                    $row['id_address'],
                    $country->name[$id_lang],
                    $state->name[$id_lang],
                    $row['alias'],
                    $row['company'],
                    $row['lastname'],
                    $row['firstname'],
                    $row['address1'],
                    $row['address2'],
                    $row['postcode'],
                    $row['city'],
                    $row['phone'],
                    $row['phone_mobile'],
                    $row['vat_number'],
                    $row['dni'],
                    Tools::displayDate($row['date_add']),
                    $row['active'],
                    $row['deleted'],
                );
                $content_address[] = $addr;
            }
            print PHP_EOL.PHP_EOL;
            print "ADDRESSES";
            print PHP_EOL;
            print implode("\t", $header_address);
            print PHP_EOL;
            foreach ($content_address as $address) {
                print implode("\t", $address);
                print PHP_EOL;
            }
        }


        $header_orders = array(
            'id_order',
            'reference',
            'carrier',
            'id_cart',
            'id_address_delivery',
            'id_address_invoice',
            'payment',
            'total_paid',
            'date_add',
        );

        $content_orders = array();

        
        $sql = "select * from "._DB_PREFIX_."orders where id_shop = ".(int)$id_shop." and id_customer=".(int)$customer->id." order by date_add";
        $result = $db->executeS($sql);
        if ($result) {
            foreach($result as $row)
            {
                $carrier = new Carrier($row['id_carrier']);
                $order = array(
                    $row['id_order'],
                    $row['reference'],
                    $carrier->name,
                    $row['id_cart'],
                    $row['id_address_delivery'],
                    $row['id_address_invoice'],
                    $row['payment'],
                    Tools::displayPrice($row['total_paid']),
                    Tools::displayDate($row['date_add']),
                );
                $content_orders[] = $order;
            }

            print PHP_EOL.PHP_EOL;
            print "ORDERS";
            print PHP_EOL;
            print implode("\t", $header_orders);
            print PHP_EOL;
            foreach ($content_orders as $order) {
                print implode("\t", $order);
                print PHP_EOL;
            }
        }

        exit();
    }

    private function getPreferences($id_customer)
    {
        $db = Db::getInstance();
        $sql = new DbQueryCore();
        $sql->select('*')
            ->from('mp_customer_gdpr')
            ->where('id_customer='.(int)$id_customer)
            ->orderBy('date_sign');
        $result = $db->executeS($sql);
        if ($result) {
            foreach ($result as &$row)
            {
                $row['id'] = $row['id_mp_customer_gdpr'];
                $row['date'] = Tools::displayDate($row['date_sign']);
            }
            return $result;
        }
        return array();
    }

    private function getCustomerOrders($id_customer)
    {
        $id_shop = (int)Context::getContext()->shop->id;
        $db = Db::getInstance();
        $sql = "select * from "._DB_PREFIX_."orders where id_shop=".(int)$id_shop." and id_customer=".(int)$id_customer." order by date_add";
        $result = $db->executeS($sql);
        if (!$result) {
            return array();
        } else {
            return $result;
        }
    }

    private function getStatus($id_order, $id_lang)
    {
        $order = new Order($id_order);
        return $order->getCurrentStateFull($id_lang);
    }
}
