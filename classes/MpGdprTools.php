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
*  @copyright 2007-2018 Digital Solutions®
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

require_once _PS_MODULE_DIR_.'mpgdpr/mpgdpr.php';

Class MpGdprTools
{
    const TYPE_BUTTON = 'button';
    const TYPE_TEXT = 'text';
    const TYPE_PRICE = 'price';
    const TYPE_INT = 'int';
    const TYPE_DATE = 'date';
    const TYPE_PERCENTAGE = 'percentage';
    const TYPE_IMAGE = 'image';
    const TYPE_HTML = 'html';
    const OBJECT_FIT_FILL = 'fill';
    const OBJECT_FIT_CONTAIN = 'contain';
    const OBJECT_FIT_COVER = 'cover';
    const OBJECT_FIT_NONE = 'none';
    const OBJECT_FIT_SCALE_DOWN = 'scale-down';

    /**
     * Get the default Template Path
     * @param  string templatePath
     * @return string templatePath, if empty returns the default path
     */
    public static function getDefaultTemplatePath($templatePath)
    {
        /** Get Template path if not set **/
        if (empty($templatePath)) {
            return _PS_MODULE_DIR_.'mpgdpr/views/templates/admin/';
        } else {
            return $templatePath;
        }
    }

    /**
     * Get Locale float values
     * @return array Array of decimal locale values ['decimal_point', 'thousands_sep']
     */
    public static function getLocaleInfo()
    {
        if (Context::getContext()->language->iso_code == 'it') {
            return array(
                'decimal_point' => ',',
                'thousands_sep' => '.'
            );
        } else {
            return array(
                'decimal_point' => '.',
                'thousands_sep' => ','
            );
        }
    }

    public static function ajax()
    {
        $functions = array(
            'getComboStates',
            'getComboTowns',
            'autocompleteItem',
            'checkEmail',
            'getComboJobName',
        );

        if (!Tools::isSubmit('ajax')) {
            return false;
        }

        $function = Tools::getValue('action', '');
        if (in_array($function, $functions)) {
            $callback = 'ajaxProcess'.Tools::ucFirst($function);
            print Tools::jsonEncode(
                array(
                    'result' => self::$callback(),
                )
            );
            return true;
        }
        return false;
    }

    public static function ajaxProcessGetComboJobArea()
    {
        $job_area_list = MpGdprObjectModelCustomerJobArea::getList();
        return $job_area_list;
    }

    public static function ajaxProcessGetComboJobName()
    {
        $id_area = (int)Tools::getValue('id_job_area', 0);
        $job_name_list = MpGdprObjectModelCustomerJobName::getListByArea($id_area);
        return $job_name_list;
    }

    public static function ajaxProcessGetComboCountries()
    {   
        return self::getCountriesList();
    }

    public static function getCountriesList()
    {
        $module = new MpGdpr();
        $db = Db::getInstance();
        $sql = new DbQueryCore();
        $sql->select('c.id_country')
            ->select('c.id_zone')
            ->select('c.iso_code')
            ->select('c.contains_states')
            ->select('c.need_zip_code')
            ->select('c.zip_code_format')
            ->select('cl.name')
            ->from('country', 'c')
            ->innerJoin('country_lang', 'cl', 'cl.id_country=c.id_country')
            ->where('cl.id_lang='.(int)Context::getContext()->language->id)
            ->orderBy('cl.name');
        $result = $db->executeS($sql);
        if ($result) {
            array_unshift(
                $result,
                array(
                    'id_country' => 0,
                    'id_zone' => 0,
                    'iso_code' => '',
                    'contains_states' => 0,
                    'need_zip_code' => 0,
                    'zip_code_format' => '',
                    'name' => $module->l('Please select a Country'),
                )
            );
            return $result;
        } else {
            return array();
        }
    }

    public static function ajaxProcessGetComboStates()
    {
        $module = new MpGdpr();
        $id_country = (int)Tools::getValue('id_country');
        $db = Db::getInstance();
        $sql = "select * from "._DB_PREFIX_."state where id_country = ".(int)$id_country." order by `name`";
        $rows = $db->executeS($sql);
        if ($rows) {
            foreach ($rows as &$row) {
                $row['label'] = $row['name'] . ' ('.$row['iso_code'].')';
                $row['id'] = $row['id_state'];
            }
            array_unshift(
                $rows,
                array(
                    'name' => $module->l('Select a State', 'MpGdprTools'),
                    'id' => 0,
                    'iso_code' => '',
                )
            );
            return $rows;
        } else {
            return array();
        }
    }

    public static function ajaxProcessGetComboTowns()
    {
        $module = new MpGdpr();
        $iso_code = Tools::getValue('iso_code');
        $db = Db::getInstance();
        $sql = "select * from "._DB_PREFIX_."mp_town where iso_code = '".pSQL($iso_code)."' order by `name`";
        $rows = $db->executeS($sql);
        if ($rows) {
            foreach ($rows as &$row) {
                $row['label'] = $row['name'];
                $row['id'] = $row['iso_code'];
            }
            array_unshift(
                $rows,
                array(
                    'name' => $module->l('Select a town', 'MpGdprTools'),
                    'id' => 0,
                    'id_mp_town' => 0,
                    'id_istat' => '',
                    'id_region' => '',
                    'postcode' => '',
                )
            );
            return $rows;
        } else {
            return array();
        }
    }

    /** Check if email exists */
    public static function ajaxProcessCheckEmail()
    {
        $email = Tools::getValue('email', '');
        if (empty($email)) {
            return Tools::jsonEncode(
                array(
                    'result' => 1,
                    'message' => 'Email empty',
                )
            );
        }
        return Tools::jsonEncode(
            array(
                'result' => (int)self::emailExists($email),
                'message' => 'Checking email.',
            )
        );
    }

    public static function emailExists($email)
    {
        $db = Db::getInstance();
        $sql = "select count(*) from "._DB_PREFIX_."customer where email = '".pSQL($email)."'";
        return (int)$db->getValue($sql);
    }

    public static function ajaxProcessAutocompleteItem()
    {
        $id_item = Tools::getValue('id_item', '');
        $id_country = (int)Tools::getValue('id_country');
        $id_state = (int)Tools::getValue('id_state');
        $id_city = (int)Tools::getValue('id_city');
        $term = Tools::getValue('term');

        switch ($id_item) {
            case "state" :
                return self::getStates($id_country, $term);
            case "city" :
                return self::getCities($id_state, $term);
            default:
                return array();
        }
    }

    public static function getStates($id_country, $term)
    {
        $db = Db::getInstance();
        $sql = "select * from "._DB_PREFIX_."state where id_country = ".(int)$id_country." and `name` like '%".pSQL($term)."%' order by `name`";
        $rows = $db->executeS($sql);
        if ($rows) {
            foreach ($rows as &$row) {
                $row['value'] = $row['name'] . ' ('.$row['iso_code'].')';
                $row['id'] = $row['id_state'];
            }
            return $rows;
        } else {
            return array();
        }
    }

    public function getCities($id_state, $term)
    {
        if ($id_state != 10) {
            return array();
        }

        $db = Db::getInstance();
        $sql = "select(*) from "._DB_PREFIX_."state where id_country = ".(int)$id_country." and name like '%".pSQL($term)."%' order by name";
        $rows = $db->executeS($sql);
        if ($rows) {
            foreach ($rows as &$row) {
                $row['id'] = $row['id_state'];
                $row['value'] = $row['name'];
            }
            return $rows;
        } else {
            return array();
        }
    }

    /**
     * Process submit on an account
     */
    public static function processSubmitAccount()
    {
        $module = new MpGdpr();
        $controller = Context::getContext()->controller;
        $account = Tools::jsonDecode(Tools::getValue('form_data_object'), '{}');

        /**
         * Add Customer
         * @var Customer $customer
         */
        $customer = new Customer();
        $customer->id_gender = (int)$account['gender'];
        $customer->firstname = Tools::ucwords($account['firstname']);
        $customer->lastname = Tools::ucwords($account['lastname']);
        $customer->birthday = $account['birthday'];
        $customer->email = Tools::strtolower($account['email']);
        $customer->passwd = md5(_COOKIE_KEY_.$account['passwd']);
        $customer->newsletter = $account['newsletter'];
        $customer->ip_registration_newsletter = pSQL(Tools::getRemoteAddr());
        $customer->newsletter_date_add = date('Y-m-d H:i:s');
        $customer->is_guest = 0;
        $customer->active = 1;
        $add_customer = $customer->add();
        
        if (!$add_customer) {
            return false;
        }

        /**
         * Add Delivery address
         * @var Address $delivery
         */
        $delivery = new Address();
        $delivery->firstname = $customer->firstname;
        $delivery->lastname = $customer->lastname;
        $delivery->alias = $module->l('Delivery address', 'mpgdpr');
        $delivery->address1 = $account['address_delivery']['address1'];
        $delivery->address2 = $account['address_delivery']['address2'];
        $delivery->postcode = $account['address_delivery']['postcode'];
        $delivery->city = MpGdprObjectModelTown::getTownName($account['address_delivery']['id_city']);
        $delivery->other = $account['address_delivery']['other'];
        $delivery->phone = $account['address_delivery']['phone'];
        $delivery->phone_mobile = $account['address_delivery']['phone_mobile'];
        $delivery->active = 1;
        $delivery->deleted = 0;
        $delivery->id_country = (int)$account['address_delivery']['id_country'];
        $delivery->id_state = (int)$account['address_delivery']['id_state'];
        $delivery->id_customer = (int)$customer->id;
        $delivery->id_manufacturer = 0;
        $delivery->id_supplier = 0;
        $delivery->id_warehouse = 0;
        $delivery->dni = '';
        $delivery->type = 'delivery';
        $res_delivery = $delivery->add();

        $invoice = new Address();
        $invoice = $delivery;
        $invoice->id = 0;
        $invoice->type = 'invoice';
        $invoice->alias = $module->l('Invoice address', 'mpgdpr');
        if ((int)$account['has_invoice']) {
            $invoice->company = $account['invoice_header'];
            $invoice->vat_number = Tools::strtoupper($account['vat_number']);
        }
        $invoice->add();

        if ($account['has_alternative_address']) {
            /**
             * Add invoice address
             * @var Address $invoice
             */
            $altern_addr = new Address();
            $altern_addr->company = $account['address_alternative']['address_to'];
            $altern_addr->firstname = $customer->firstname;
            $altern_addr->lastname = $customer->lastname;
            $altern_addr->alias = $module->l('Delivery address alternative', 'mpgdpr');
            $altern_addr->address1 = $account['address_alternative']['address1'];
            $altern_addr->address2 = $account['address_alternative']['address2'];
            $altern_addr->postcode = $account['address_alternative']['postcode'];
            $altern_addr->city = MpGdprObjectModelTown::getTownName($account['address_alternative']['id_city']);
            $altern_addr->other = $account['address_alternative']['other'];
            $altern_addr->phone = $account['address_alternative']['phone'];
            $altern_addr->phone_mobile = $account['address_alternative']['phone_mobile'];
            $altern_addr->dni = '';
            $altern_addr->vat_number = '';
            $altern_addr->active = 1;
            $altern_addr->deleted = 0;
            $altern_addr->id_country = (int)$account['address_alternative']['id_country'];
            $altern_addr->id_state = (int)$account['address_alternative']['id_state'];
            $altern_addr->id_customer = (int)$customer->id;
            $altern_addr->id_manufacturer = 0;
            $altern_addr->id_supplier = 0;
            $altern_addr->id_warehouse = 0;
            $altern_addr->type='delivery';
            $res_invoice = $altern_addr->add();
        }

        /**
         * Add Job profilation
         */
        $id_job_area = (int)$account['id_job_area'];
        $id_job_name = (int)$account['id_job_name'];
        $newsletter = (int)$account['newsletter'];
        if ((int)$id_job_area || (int)$id_job_name) {
            $job = new MpGdprObjectModelCustomerProfile();
            $job->id_customer = (int)$customer->id;
            $job->id_job_area = (int)$id_job_area;
            $job->id_job_name = (int)$id_job_name;
            $result = $job->add();
        }

        /**
         * Add Gdpr informations **
         * @var MpGdprObjectModelGdpr $gdpr
         */
        $ip_address = Tools::getRemoteAddr();
        if ($id_job_area) {
            $gdpr = new MpGdprObjectModelCustomerGdpr();
            $gdpr->id_customer = $customer->id;
            $gdpr->date_sign = date('Y-m-d H:i:s');
            $gdpr->ip_address = $ip_address;
            $gdpr->name = $module->l('job area');
            $gdpr->text = $module->l('User registration choice');
            $gdpr->choice_value = (string)($id_job_area);
            $result = $gdpr->add();
        }
        if ($id_job_name) {
            $gdpr = new MpGdprObjectModelCustomerGdpr();
            $gdpr->id_customer = $customer->id;
            $gdpr->date_sign = date('Y-m-d H:i:s');
            $gdpr->ip_address = $ip_address;
            $gdpr->name = $module->l('job name');
            $gdpr->text = $module->l('User registration choice');
            $gdpr->choice_value = (string)($id_job_name);
            $result = $gdpr->add();
        }
        if ($newsletter) {
            $gdpr = new MpGdprObjectModelCustomerGdpr();
            $gdpr->id_customer = $customer->id;
            $gdpr->date_sign = date('Y-m-d H:i:s');
            $gdpr->ip_address = $ip_address;
            $gdpr->name = $module->l('newsletter');
            $gdpr->text = $module->l('User registration choice');
            $gdpr->choice_value = (string)($newsletter);
            $result = $gdpr->add();
        }

        return $customer;
    }

    public static function getHtmlBadgeElement($value, $name='', $background='', $color='', $templatePath='')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'name' => $name,
                'id' => '',
                'value' => $value,
                'background' => $background,
                'color' => $color,
            )
        );
        $input = $smarty->fetch($templatePath.'html_element_badge.tpl');
        return $input;   
    }

    public static function getHtmlSelectEmptyElement($name, $chosen = true, $multiple = false, $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'name' => $name,
                'chosen' => $chosen,
                'multiple' => $multiple,
            )
        );
        $input = $smarty->fetch($templatePath.'html_element_select_empty.tpl');
        return $input;
    }

    /**
     * Display an input element for text values
     * @param  float $value Text value
     * @param  string $name Name of the element
     * @param  array $options Array of options ['key', 'value']
     * @param  string $width Optional input width
     * @param  string $align Optional input align
     * @param  bool $chosen Optional chosen style
     * @param  bool $multiple Optional Multiple choices
     * @param  string $select_first Optional First element with id 0
     * @return string HTML Template Input element
     */
    public static function getHtmlSelectElement(
        $value,
        $name,
        $options = array('query', array()),
        $width = 'fixed-width-md',
        $align = 'text-left',
        $chosen = true,
        $multiple = false,
        $first = '',
        $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'name' => $name,
                'id' => '',
                'class' => $width.$align,
                'value' => Tools::displayPrice($value),
                'options' => $options,
                'chosen' => $chosen,
                'multiple' => $multiple,
                'select_first' => $first,
            )
        );
        $input = $smarty->fetch($templatePath.'html_element_select.tpl');
        return $input;
    }

    /**
     * Display an input element for text values
     * @param  float $value Text value
     * @param  string $name Name of the element
     * @param  string $width Optional input width
     * @param  string $align Optional input align
     * @param  string $color Optional Text color
     * @param  string $templatePath Optional Template path
     * @return string HTML Template Input element
     */
    public static function getHtmlTextElement($value, $name, $width = 'fixed-width-md', $align = 'text-left', $color = '', $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'name' => $name,
                'id' => '',
                'class' => 'input input-text '.$width.$align,
                'value' => Tools::displayPrice($value),
                'color' => $color,
            )
        );
        $input = $smarty->fetch($templatePath.'html_element_text.tpl');
        return $input;
    }

    /**
     * Display an input element for price values
     * @param  float value Price value
     * @param  string name Name of the element
     * @param  string templatePath Optional Template path
     * @return string HTML Template Input element
     */
    public static function getHtmlPriceTextElement($value, $name, $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'name' => $name,
                'id' => '',
                'class' => 'input text-right fixed-width-sm input-price',
                'value' => Tools::displayPrice($value),
            )
        );
        $input = $smarty->fetch($templatePath.'html_element_text.tpl');
        return $input;
    }

    /**
     * Display an input element for percentage values
     * @param  float $value Percentage value
     * @param  string $name The name of the text element
     * @param  string $templatePath Template path
     * @return string HTML Template input element
     */
    public static function getHtmlPercentTextElement($value, $name, $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        $percentage = self::displayTaxRate($value);
        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'name' => $name,
                'id' => '',
                'class' => 'input text-right fixed-width-sm input-percent',
                'value' => $percentage
            )
        );
        $input = $smarty->fetch($templatePath.'html_element_text.tpl');
        return $input;
    }

    /**
     * Display an input element for quantity values
     * @param  int $value Quantity value
     * @param  string $name Optional Name of the element
     * @param  string $templatePath Optional Template Path
     * @return string HTML Template input element
     */
    public static function getHtmlQuantityTextElement($value, $name = '', $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        if (empty($name)) {
            $name = 'input_text_qty[]';
        }
        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'name' => $name,
                'id' => '',
                'class' => 'input text-right fixed-width-sm input-integer',
                'value' => $value,
                'color' => $value<0?'#BB6060':'#555555',
            )
        );
        $input = $smarty->fetch($templatePath.'html_element_text.tpl');
        return $input;
    }

    public static function getHtmlButtonCallBack($name, $icon, $callback='javascript:void(0);', $color='', $title='', $templatePath='')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        
        Context::getContext()->smarty->assign(
            array(
                'name' => $name,
                'icon' => $icon,
                'color' => $color,
                'title' => $title,
                'callback'=> $callback
            )
        );
        return Context::getContext()->smarty->fetch($templatePath.'html_element_button.tpl');
    }

    public static function getHtmlLinkButton($name, $icon, $href='javascript:void(0);', $color='', $title='', $templatePath='')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        
        Context::getContext()->smarty->assign(
            array(
                'name' => $name,
                'icon' => $icon,
                'color' => $color,
                'title' => $title,
                'href'=> $href
            )
        );
        return Context::getContext()->smarty->fetch($templatePath.'html_element_link_button.tpl');
    }
    
    /**
     * Get HTML Template icon element
     * @param string $name Title of column, can be empty
     * @param string $icon Icon code [ex: icon-times, icon-pencil...]
     * @param string $color Color of icon
     * @param string $title Display title of icon
     * @return string HTML Template of icon element
     */
    public static function getHtmlIcon($name, $icon, $color = '', $title = '', $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        
        Context::getContext()->smarty->assign(
            array(
                'name' => $name,
                'icon' => $icon,
                'color' => $color,
                'title' => $title,
            )
        );
        return Context::getContext()->smarty->fetch($templatePath.'html_element_icon.tpl');
    }
    
    /**
     * Get HTML Template of a default button with href
     * @param string $name
     * @param string $icon
     * @param string $href
     * @param string $target
     * @param string $color
     * @param string $title
     * @param string $templatePath
     * @return string HTML Template of a default button
     */
    public static function getHtmlHrefButton($name, $icon, $href='#', $target='_blank', $color='', $title='', $templatePath='')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        
        Context::getContext()->smarty->assign(
            array(
                'name' => $name,
                'icon' => $icon,
                'href' => $href,
                'target' => $target,
                'color' => $color,
                'title' => $title,
            )
        );
        return Context::getContext()->smarty->fetch($templatePath.'html_element_button_href.tpl');
    }
    
    /**
     * Get HTML Template list of select element options
     * @param array $list [value, name]
     * @param string $templatePath The admintemplate path
     * @return string HTML options list
     */
    public static function getOptionsCombination($list, $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        
        Context::getContext()->smarty->assign(
            array(
                'rows' => $list,
            )
        );
        return Context::getContext()->smarty->fetch($templatePath.'html_element_options.tpl');
    }
    
    /**
     * Retirn HTML Template of product image
     * @param int $id_product id product
     * @param string $templatePath optional template path
     * @return string HTML template of image product
     */
    public static function getImageProduct($id_product, $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);
        
        $id_shop = (int)Context::getContext()->shop->id;
        $shop = new ShopCore($id_shop);
        if ((int)$id_product == 0) {
            return $shop->getBaseURL(true) . 'img/404.gif';
        }
        $db = Db::getInstance();
        $sql = new DbQueryCore();
        $sql->select('id_image')
            ->from('image')
            ->where('id_product='.(int)$id_product)
            ->where('cover IS NOT NULL');
        
        $id_image = (int)$db->getValue($sql);
        if ((int)$id_image==0) {
            /** Image not found, display default 404.gif **/
            $image_path = $shop->getBaseURL(true) . 'img/404.gif';
        } else {
            $imageObj = new ImageCore($id_image);
            $image_path = $shop->getBaseURL(true) . 'img/p/'. $imageObj->getExistingImgPath() . '-small.jpg';
        }
        $image = array(
            'source' => $image_path,
            'width' => '48px',
        );
        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'element' => 'image',
                'image' => $image
            )
        );
        return $smarty->fetch($templatePath.'html_elements.tpl');
    }
    
    /**
     * Capitalize first letter of every word
     * @param string $str The string to be transformed
     * @return string The string processed
     */
    public static function ucFirst($str)
    {
        $str_lower = Tools::strtolower($str);
        $parts = explode(' ', $str_lower);
        foreach ($parts as &$part) {
            $part = Tools::ucfirst($part);
        }
        return implode(' ', $parts);
    }
    
    /**
     * Add a text element in table row
     * @param array $list byRef Collections of elements
     * @param string $title Title of column
     * @param string $key Key of column
     * @param string $width Width of column
     * @param string $alignment Text alignment of column [text-left. text-center, text-right]
     * @param boolean $search If true, a search field will be shown in table
     */
    public static function addText(&$list, $title, $key, $width, $alignment, $search = false)
    {
        $item = array(
            'title' => $title,
            'width' => $width,
            'align' => $alignment,
            'type' => 'text',
            'search' => $search,
        );

        $list[$key] = $item;
    }
    
    /**
     * Add a Date element in table row
     * @param array $list byRef Collections of elements
     * @param string $title Title of column
     * @param string $key Key of column
     * @param string $width Width of column
     * @param string $alignment Text alignment of column [text-left. text-center, text-right]
     * @param boolean $search If true, a search field will be shown in table
     */
    public static function addDate(&$list, $title, $key, $width, $alignment, $search = false)
    {
        $item = array(
            'title' => $title,
            'width' => $width,
            'align' => $alignment,
            'type' => 'date',
            'search' => $search,
        );

        $list[$key] = $item;
    }

    /**
     * Add a price element in table row
     * @param array $list byRef Collections of elements
     * @param string $title Title of column
     * @param string $key Key of column
     * @param string $width Width of column
     * @param string $alignment Text alignment of column [text-left. text-center, text-right]
     * @param boolean $search If true, a search field will be shown in table
     */
    public static function addPrice(&$list, $title, $key, $width, $alignment, $search = false)
    {
        $item = array(
            'title' => $title,
            'width' => $width,
            'align' => $alignment,
            'type' => 'price',
            'search' => $search,
        );

        $list[$key] = $item;
    }

    /**
     * Add an HTML element in table row
     * @param array $list byRef Collections of elements
     * @param string $title Title of column
     * @param string $key Key of column
     * @param string $width Width of column
     * @param string $alignment Text alignment of column [text-left. text-center, text-right]
     * @param boolean $search If true, a search field will be shown in table
     */
    public static function addHtml(&$list, $title, $key, $width, $alignment, $search = false)
    {
        $item = array(
            'title' => $title,
            'width' => $width,
            'align' => $alignment,
            'type' => 'bool',
            'float' => true,
            'search' => $search,
        );

        $list[$key] = $item;
    }

    /**
     * Display a float number into tax rate with percent symbol
     * @param  float Tax rate value
     * @return string Tax rate formatted value
     */
    public static function displayTaxRate($value)
    {
        $localeInfo = self::getLocaleInfo();
        $output =  number_format(
            $value,
            2,
            $localeInfo['decimal_point'],
            $localeInfo['thousands_sep']
        ) . ' %';

        return $output;
    }

    /**
     * Display a formatted price value
     * @param  int quantity value
     * @param  string optional templatePath
     * @return string HTML span element with formatted price
     */
    public static function displayPrice($value, $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);

        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'style' => array(
                    'color' => '#555555',
                    'font-weight' => 'lighter',
                ),
                'value' => Tools::displayPrice($value),
            )
        );

        return $smarty->fetch($templatePath.'html_element_span.tpl');
    }

    /**
     * Display a quantity value into colored one
     * @param  int quantity value
     * @param  string optional templatePath
     * @return string HTML span element with formatted quantity
     */
    public static function displayQuantity($value, $templatePath = '')
    {
        $templatePath = self::getDefaultTemplatePath($templatePath);

        $smarty = Context::getContext()->smarty;
        if ($value>0) {
            $smarty->assign(
                array(
                    'style' => array(
                        'color' => '#50BB50',
                        'font-weight' => 'bold',
                    ),
                    'value' => $value,
                )
            );
        } else {
            $smarty->assign(
                array(
                    'style' => array(
                        'color' => '#BB5050',
                        'font-weight' => 'bold',
                    ),
                    'value' => $value,
                )
            );
        }

        return $smarty->fetch($templatePath.'html_element_span.tpl');
    }

    /**
     * Get all combinations of a specified product
     * @param type $id_product product id to search
     * @return array Array of combinations
     * ['id_product_attribute', 'reference', 'name', 'ean13', 'price', 'wholesale_price', 'tax_rate']
     */
    public static function getCombinations($id_product)
    {
        $db = Db::getInstance();
        /** Get id_product_attribute of specified id_product **/
        $sql_product_attribute = new DbQueryCore();
        $sql_product_attribute->select('id_product_attribute')
            ->select('pa.reference')
            ->select('pa.ean13')
            ->select('p.price')
            ->select('pa.quantity')
            ->select('p.wholesale_price')
            ->select('pa.quantity as stock')
            ->from('product_attribute', 'pa')
            ->innerJoin('product', 'p', 'p.id_product=pa.id_product')
            ->where('pa.id_product='.(int)$id_product);
        $result_product_attribute = $db->executeS($sql_product_attribute);
        if (!$result_product_attribute) {
            return array();
        }
        $combinations = array();
        $tax_rate = self::getTaxRateFromIdProduct($id_product);
        foreach ($result_product_attribute as $row) {
            $sql_combination = new DbQueryCore();
            $sql_combination->select('distinct a.id_attribute')
                ->select('al.name')
                ->from('attribute', 'a')
                ->innerJoin('attribute_lang', 'al', 'al.id_attribute=a.id_attribute')
                ->innerJoin('attribute_group', 'ag', 'ag.id_attribute_group=a.id_attribute_group')
                ->innerJoin('product_attribute_combination', 'pac', 'pac.id_attribute=a.id_attribute')
                ->where('al.id_lang='.(int) Context::getContext()->language->id)
                ->where('pac.id_product_attribute='.(int)$row['id_product_attribute'])
                ->orderBy('ag.position')
                ->orderBy('al.name');
            $result_combination = $db->executeS($sql_combination);
            $name_combination = array();
            if ($result_combination) {
                foreach ($result_combination as $attribute) {
                    $name_combination[] = $attribute['name'];
                }
                $combination = implode(' - ', $name_combination);
            }
            $combinations[] = array(
                'id_product_attribute' => $row['id_product_attribute'],
                'reference' => $row['reference'],
                'ean13' => $row['ean13'],
                'wholesale_price' => $row['wholesale_price'],
                'price' => $row['price'],
                'tax_rate' => $tax_rate,
                'name' => $combination,
                'stock' => $row['stock'],
            );
        }
        usort($combinations, function($a, $b) {
            $a = $a['name'];
            $b = $b['name'];

            if ($a == $b) return 0;
            return ($a < $b) ? -1 : 1;
        });
        return $combinations;
    }

    public static function getProductValues($ean13, $reference) 
    {
        $db = Db::getInstance();
        $sql = "select id_product, id_product_attribute "
        ."from "._DB_PREFIX_."product_attribute "
        ."where "
        ."ean13='".pSQL($ean13)."' and "
        ."reference = '".pSQL($reference)."'";
        $row = $db->getRow($sql);
        if ($row) {
            return array(
                'id_product' => $row['id_product'],
                'id_product_attribute' => $row['id_product_attribute'],
            );
        } else {
            return false;
        }
    }

    /**
     * Get product combination name
     * @param  int $id_product_attribute Id product attribute
     * @return string|array The name of the product combination or the error
     */
    public static function getProductCombinationName($id_product_attribute)
    {
        $id_lang = (int)Context::getContext()->language->id;
        $importErrors = array();
        $db = Db::getInstance();
        $sql = new DbQueryCore();
        $sql->select('a.id_attribute')
            ->select('a.color')
            ->select('ag.position')
            ->select('al.name')
            ->from('attribute', 'a')
            ->innerJoin('attribute_group', 'ag', 'ag.id_attribute_group=a.id_attribute_group')
            ->innerJoin('attribute_lang', 'al', 'al.id_attribute=a.id_attribute')
            ->innerJoin('product_attribute_combination', 'pac', 'pac.id_attribute=a.id_attribute')
            ->where('al.id_lang='.(int)$id_lang)
            ->where('pac.id_product_attribute='.(int)$id_product_attribute)
            ->orderBy('ag.position');

        $name = array();
        $rows = $db->executeS($sql);
        if (!$rows) {
            $importErrors[] = sprintf(
                "Error %s on product attribute %d",
                $db->getMsgError(),
                $id_product_attribute
            );
        } else {
            foreach ($rows as $row) {
                $name[] = Tools::strtolower($row['name']);
            }
        }
        $name_str = implode(' ', $name);
        if ($importErrors) {
            return array(
                'name' => '',
                'errors' => $importErrors,
            );
        } else {
            return MpStockTools::ucFirst($name_str);    
        }
    }

    /**
     * Get product combination name
     * @param  int $id_product_attribute Id product attribute
     * @return string|array The name of the product combination or the error
     */
    public static function getProductName($id_product)
    {
        $id_lang = (int)Context::getContext()->language->id;
        $db = Db::getInstance();
        $sql = new DbQueryCore();
        $sql->select('distinct pl.name')
            ->from('product_lang', 'pl')
            ->innerJoin('product', 'p', 'p.id_product=pl.id_product')
            ->where('pl.id_lang='.(int)$id_lang)
            ->where('p.id_product='.(int)$id_product);

        $name = $db->getValue($sql);
        return $name;
    }

    /**
     * Get the tax rate amount from a product
     * @param  int $id_product Id product
     * @return float Tax rate percent
     */
    public static function getTaxRateFromIdProduct($id_product, $displayFormatted = false)
    {
        $db = Db::getInstance();
        $sql = new DbQueryCore();
        $sql->select('t.rate')
            ->from('tax', 't')
            ->innerJoin('tax_rule', 'tr', 't.id_tax=tr.id_tax')
            ->innerJoin('product', 'p', 'p.id_tax_rules_group=tr.id_tax_rules_group')
            ->where('p.id_product='.(int)$id_product);
        $tax_rate = (float)$db->getValue($sql);
        if ($displayFormatted) {
            return self::formatPercent($tax_rate);
        } else {
            return (float)$tax_rate;    
        }
    }

    /**
     * Get the movement name
     * @param  int $id_mp_stock_type_movement Type movement id
     * @return string|boolean The name of the movement or false
     */
    public static function getMovementName($id_mp_stock_type_movement)
    {
        $db = Db::getInstance();
        $sql = new DbQueryCore();

        $sql->select('name')
            ->from('mp_stock_type_movement')
            ->where('id_mp_stock_type_movement='.(int)$id_mp_stock_type_movement);
        return $db->getValue($sql);
    }

    public static function parseValue($value)
    {        
        $curr = new CurrencyCore((int)Context::getContext()->currency->id);
        switch ($curr->format) {
            case 1: //USD
                $value = preg_replace("/[^\d.,]/", "", $value);
                break;
            case 2: //EUR
                $value = preg_replace("/[^\d,]/", "", $value);
                $value = str_replace(",", ".", $value);
                break;
            case 3: //EUR-BEFORE
                $value = preg_replace("/[^\d,]/", "", $value);
                $value = str_replace(",", ".", $value);
                break;
            case 4: //USD-AFTER
                $value = preg_replace("/[^\d.,]/", "", $value);
                break;
            case 5: //USD-APC
                $value = preg_replace("/[^\d.,]/", "", $value);
                break;
        }
        return $value;
    }

    public static function formatCurrency($value)
    {
        return Tools::displayPrice($value);
    }

    public static function formatPercent($value)
    {
        $perc = Tools::displayPrice($value);
        $perc_value = preg_replace("/[^\d.,]/", "", $perc);
        return $perc_value.' %';
    }
}
