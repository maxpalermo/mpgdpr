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

class MpGdprObjectModelCustomerProfile extends ObjectModelCore
{
    /** @var MpGdpr $module Module */
    private $module;
    /** @var int $id_customer customer reference */
    public $id_customer;
    /** @var int $id_job_area date customer sign */
    public $id_job_area;
    /** @var int $id_job_name customer ip address */
    public $id_job_name;

    public static $definition = array(
        'table' => 'mp_customer_profile',
        'primary' => 'id_mp_customer_profile',
        'multilang' => false,
        'fields' => array(
            'id_customer' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => 'false',
            ),
            'id_job_area' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => 'false',
            ),
            'id_job_name' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => 'false',
            ),
        ),
    );

    public function __construct($id = null)
    {
        parent::__construct($id);
        $this->module = new MpGdpr();
    }

    public function installTable()
    {
        $sql[] = "CREATE TABLE IF NOT EXISTS `"._DB_PREFIX_."mp_customer_profile` (
              `id_mp_customer_profile` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
              `id_customer` int(11) NOT NULL,
              `id_job_area` int(11) NOT NULL,
              `id_job_name` int(11) NOT NULL
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

    public function save($null_values = false, $auto_date = true)
    {
        $db = Db::getInstance();
        $sql = "select id_mp_customer_profile "
            ."from "._DB_PREFIX_."mp_customer_profile "
            ."where "
            ."id_customer=".(int)$this->id_customer
            ." and "
            ."id_job_area=".(int)$this->id_job_area
            ." and "
            ."id_job_name=".(int)$this->id_job_name;
        PrestaShopLoggerCore::addLog('Profile query:'.$sql);
        $id = (int)$db->getValue($sql);
        if ($id) {
            $this->id = $id;
        }
        if ((int)$this->id) {
            return parent::save($null_values = false, $auto_date = true);    
        } else {
            return parent::add($null_values = false);
        }
    }
}
