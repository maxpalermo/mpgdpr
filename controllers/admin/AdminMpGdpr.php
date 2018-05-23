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
 *  @copyright 2018 Digital Solutions®
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of mpSOFT
 */

ini_set('max_execution_time', 300); //300 seconds = 5 minutes
ini_set('post_max_size', '128M');
ini_set('upload_max_filesize', '128M');

require_once _PS_MODULE_DIR_ . 'mpgdpr/classes/MpGdprObjectModelCustomerJobArea.php';
require_once _PS_MODULE_DIR_ . 'mpgdpr/classes/MpGdprObjectModelCustomerJobName.php';
require_once _PS_MODULE_DIR_ . 'mpgdpr/classes/MpGdprObjectModelCustomerJobs.php';

class AdminMpGdprController extends ModuleAdminController
{
    const TYPE_MESSAGE_ERROR = 'error';
    const TYPE_MESSAGE_CONFIRMATION = 'confirmation';
    const TYPE_MESSAGE_WARNING = 'warning';

    public function __construct()
    {
        $this->bootstrap = true;
        $this->className = 'AdminMpGdpr';
        $this->context = Context::getContext();
        $this->token = Tools::getValue('token', Tools::getAdminTokenLite($this->className));
        parent::__construct();
        $this->id_lang = (int)ContextCore::getContext()->language->id;
        $this->id_shop = (int)ContextCore::getContext()->shop->id;
        $this->id_employee = (int)ContextCore::getContext()->employee->id;
        $this->link = new LinkCore();
        $this->smarty = Context::getContext()->smarty;
    }

    public function addError($message)
    {
        $this->errors[] = Tools::displayError($message);
    }

    public function addWarning($message)
    {
        $this->warnings[] = $this->displayWarning($message);
    }

    public function addConfirmation($message)
    {
        $this->confirmations[] = $message;
    }

    public function initContent()
    {
        $this->processSubmit();
        $jobArea = new MpGdprObjectModelCustomerJobArea();
        $jobName = new MpGdprObjectModelCustomerJobName();
        $jobs = new MpGdprObjectModelCustomerJobs();

        $jobAreaContent = $jobArea->display();
        $jobNameContent = $jobName->display();
        $jobsContent = $jobs->display(); 

        $this->smarty->assign(
            array(
                'tab_job_area' => $jobAreaContent,
                'tab_job_name' => $jobNameContent,
                'tab_job_association' => $jobsContent,
            )
        );


        $this->content = $this->smarty->fetch($this->module->getAdminTemplatePath().'tab_jobs.tpl');

        parent::initContent();
    }

    private function processSubmit()
    {
        if (Tools::isSubmit('submitAddJobArea')) {
            $job_area_id = (int)Tools::getValue('input_text_job_area_id', 0);
            $job_area_name = Tools::getValue('input_text_job_area_name', '');

            if (empty($job_area_name)) {
                $this->addError($this->l('Please insert a valid name for this job area.'));
                return false;
            }

            $jobArea = new MpGdprObjectModelCustomerJobArea($id_job_area);
            $jobArea->name = $job_area_name;
            $jobArea->id_lang = (int)$this->id_lang;
            $res_job_area = $jobArea->save();
            if ($res_job_area) {
                $this->addConfirmation($this->l('Job area successfully inserted.'));
                return true;
            }
        }

        if (Tools::isSubmit('submitAddJobName')) {
            $job_name_id = (int)Tools::getValue('input_text_job_name_id', 0);
            $job_name_name = Tools::getValue('input_text_job_name_name', '');

            if (empty($job_name_name)) {
                $this->addError($this->l('Please insert a valid name for this job name.'));
                return false;
            }

            $jobName = new MpGdprObjectModelCustomerJobName($id_job_name);
            $jobName->name = $job_name_name;
            $jobName->id_lang = (int)$this->id_lang;
            $res_job_name = $jobName->save();
            if ($res_job_name) {
                $this->addConfirmation($this->l('Job name successfully inserted.'));
                return true;
            }
        }

        if (Tools::isSubmit('submitAddJobAssociation')) {
            $job_id_area = (int)Tools::getValue('input_select_job_area_id', 0);
            $job_id_name = (int)Tools::getValue('input_select_job_name_id', 0);

            if (empty($job_id_area) || empty($job_id_name)) {
                $this->addError($this->l('Please insert a valid association.'));
                return false;
            }

            $jobs = new MpGdprObjectModelCustomerJobs();
            $jobs->id_mp_customer_job_area = $job_id_area;
            $jobs->id_mp_customer_job_name = $job_id_name;
            $res_jobs = $jobs->save();
            if ($res_jobs) {
                $this->addConfirmation($this->l('Job association successfully inserted.'));
                return true;
            }
        }
    }

    public function setMedia()
    {
        if (Tools::getValue('controller') == $this->className) {
            parent::setMedia();
            $this->addCSS($this->module->getPath().'views/css/autocomplete.css');
            $this->addCSS($this->module->getPath().'views/css/jquery-confirm-min.css');
            $this->addJqueryUI('ui.dialog');
            $this->addJqueryUI('ui.progressbar');
            $this->addJqueryUI('ui.draggable');
            $this->addJqueryUI('ui.effect');
            $this->addJqueryUI('ui.effect-slide');
            $this->addJqueryUI('ui.effect-fold');
            $this->addJqueryUI('ui.autocomplete');
            $this->addJqueryUI('ui.datepicker');
            $this->addJqueryUI('ui.tabs');
            $this->addJqueryPlugin('growl');
            $this->addJqueryPlugin('idTabs');
        }
    }
}
