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

class MpGdprObjectModelCustomerJobs extends ObjectModelCore
{
    /** @var MpGdpr $module Module */
    private $module;
    /** @var date $id_customer_job_area job area reference */
    public $id_mp_customer_job_area;
    /** @var string $id_customer_job_name job name reference */
    public $id_mp_customer_job_name;
    /** @var string $tablename Table Name */
    private $tablename = 'mp_customer_jobs';
    /** @var array Definitions */

    public static $definition = array(
        'table' => 'mp_customer_jobs',
        'primary' => 'id_customer_job_name',
        'multilang' => false,
        'fields' => array(
            'id_mp_customer_job_area' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => 'true',
            ),
            'id_mp_customer_job_name' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => 'true',
            ),
        ),
    );

    public function __construct($id = null)
    {
        parent::__construct($id);
        $this->module = new MpGdpr();
        $this->link = new Link();
        $this->context = Context::getContext();
        $this->id_lang = (int)$this->context->language->id;
        $this->id_shop = (int)$this->context->shop->id;
    }

    public function installTable()
    {
        $sql[] = "CREATE TABLE IF NOT EXISTS `"._DB_PREFIX_."mp_customer_jobs` (
              `id_mp_customer_job_area` int(11) NOT NULL ,
              `id_mp_customer_job_name` int(11) NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=latin1;";

        foreach ($sql as $query) {
            try {
                if (Db::getInstance()->execute($query) == false) {
                    $this->module->addError(Db::getInstance()->getMsgError());
                    return false;
                }
            } catch (Exception $ex) {
                PrestaShopLoggerCore::addLog('Install MPGDPR: error '.$ex->getCode().' '.$ex->getMessage());
            }
        }
        return true;
    }

    public function display()
    {
        return $this->displayForm().$this->displayList().$this->getScript();
    }

    public function displayForm()
    {
        $form = new HelperFormCore();
        $form->table = $this->tablename;
        $form->default_form_language = (int) ConfigurationCore::get('PS_LANG_DEFAULT');
        $form->allow_employee_form_lang = (int) ConfigurationCore::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG');
        $form->submit_action = 'submitAddJobAssociation';
        $form->currentIndex = $this->link->getAdminLink($this->module->getAdminClassName(), false);
        $form->token = Tools::getAdminTokenLite($this->module->getAdminClassName());
        $form->tpl_vars = array(
            'fields_value' => $this->getFieldsValue(),
            'languages' => $this->context->controller->getLanguages(),
        );
        return $form->generateForm($this->getFieldsForm());
    }

    private function getFieldsValue()
    {
        return array(
            $this->tablename.'_current_index' => '',
            $this->tablename.'_token' => Tools::getAdminTokenLite($this->module->getAdminClassName()),
            'input_select_job_area_id' => Tools::getValue('input_select_job_area_id', 0),
            'input_select_job_name_id' => Tools::getValue('input_select_job_name_id', 0),
        );
    }
    
    private function getFieldsForm()
    {
        $link = new LinkCore();
        $current_index =  $link->getAdminLink($this->module->getAdminClassName());
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->module->l('Job Associations', get_class($this)),
                    'icon' => 'icon-download',
                ),
                'input' => array(
                    array(
                        'type' => 'hidden',
                        'name' => $this->tablename.'_current_index',
                    ),
                    array(
                        'type' => 'hidden',
                        'name' => $this->tablename.'_token',
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->module->l('Job area', get_class($this)),
                        'name' => 'input_select_job_area_id',
                        'class' => 'fixed-width-xxl chosen',
                        'options' => array(
                            'query' => MpGdprObjectModelCustomerJobArea::getList(),
                            'id' => 'id_mp_customer_job_area',
                            'name' => 'name',
                        ),
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->module->l('Job name', get_class($this)),
                        'name' => 'input_select_job_name_id',
                        'class' => 'fixed-width-xxl chosen',
                        'options' => array(
                            'query' => MpGdprObjectModelCustomerJobName::getList(),
                            'id' => 'id_mp_customer_job_name',
                            'name' => 'name',
                        ),
                    ),
                ),
                'buttons' => array(
                    'submitSaveJobArea' => array(
                        'title' => $this->module->l('Save Association', get_class($this)),
                        'icon' => 'process-icon-save',
                        'href' => 'javascript:$(\'#mp_customer_jobs_form\').submit();',
                    ),
                ),
            )
        );
        return (array($fields_form));
    }

    public function displayList()
    {
        $list = new HelperList();
        $list->bootstrap = true;
        $list->actions = array('edit', 'delete');
        $list->currentIndex = $list->context->link->getAdminLink('AdminMpGdpr', false);
        $list->identifier = 'id_mp_customer_job_area';
        $list->no_link = true;
        $list->page = Tools::getValue('submitFilterconfiguration', 1);
        $list->_default_pagination = Tools::getValue('configuration_pagination', 20);
        $list->show_toolbar = true;
        $list->shopLinkType='';
        $list->simple_header = false;
        $list->token = Tools::getAdminTokenLite('AdminMpGdpr');
        $list->title = $this->module->l('Record found: ', get_class($this));
        $list->table = 'mp_customer_jobs';
        $this->fields_list = $this->getHelperListFields();
        $list->rows = $this->getHelperListContent();
        
        return $list->generateList($list->rows, $this->fields_list);
    }

    private function getHelperListFields()
    {
        $fields_list = array(
            'id_association' => array(
                'title' => $this->module->l('Id', get_class($this)),
                'width' => 48,
                'align' => 'right',
                'type' => 'text',
                'filter_key' => 'a\!id_mp_customer_job_area',
                'order_by' => true,
                'search' => true,
                'hint' => $this->module->l('Job area code'),
            ),
            'job_area' => array(
                'title' => $this->module->l('Job area', get_class($this)),
                'width' => 'auto',
                'align' => 'left',
                'type' => 'text',
                'filter_key' => '',
                'order_by' => false,
                'search' => true,
                'hint' => $this->module->l('Job area name'),
            ),
            'job_name' => array(
                'title' => $this->module->l('Job name', get_class($this)),
                'width' => 'auto',
                'align' => 'left',
                'type' => 'text',
                'filter_key' => '',
                'order_by' => false,
                'search' => true,
                'hint' => $this->module->l('Job name'),
            ),
        );
        return $fields_list;
    }

    private function getHelperListContent()
    {
        $db = Db::getInstance();
        $sql = new DbQueryCore();
        $sql->select('j.id_mp_customer_job_area')
            ->select('j.id_mp_customer_job_name')
            ->select('ja.name as job_area')
            ->select('jn.name as job_name')
            ->from($this->tablename, 'j')
            ->innerJoin('mp_customer_job_area', 'ja', 'ja.id_mp_customer_job_area=j.id_mp_customer_job_area')
            ->innerJoin('mp_customer_job_name', 'jn', 'jn.id_mp_customer_job_name=j.id_mp_customer_job_name')
            ->where('ja.id_lang='.(int)$this->id_lang)
            ->where('jn.id_lang='.(int)$this->id_lang)
            ->orderBy('j.id_mp_customer_job_area')
            ->orderBy('j.id_mp_customer_job_name');

        $result = $db->executeS($sql);
        foreach ($result as &$row) {
            $row['id_association'] = $row['id_mp_customer_job_area'].'-'.$row['id_mp_customer_job_name'];
        }
        return $result;
    }

    private function getFlag($id_lang)
    {
        $shop = new ShopCore((int)$this->id_shop);
        $path =  $shop->physical_uri . 'img/l/' . $id_lang . '.jpg';
        $template = $this->module->getAdminTemplatePath().'html_elements.tpl';
        $smarty = Context::getContext()->smarty;
        $smarty->assign(
            array(
                'element' => 'image',
                'image' => array(
                    'source' => $path,
                    'width' => 0,
                    'height' => 0,
                ),
            )
        );

        return $smarty->fetch($template);
    }

    private function getScript()
    {
        return '';
    }
}
