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

class MpGdprProcessPageEraseData
{
    /** @var MpGdpr $module Module */
    private $module;
    /** @var int $id_customer customer reference */
    public $id_customer;
    /** @var date $date_sign date customer sign */
    public $date_sign;
    /** @var int $ip_address customer ip address */
    public $ip_address;
    /** @var string $name signature name */
    public $name;
    /** @var string $text signature content */
    public $text;
    /** @var string $value choice value */
    public $choice_value;

    public static $definition = array(
        'table' => 'mp_customer_gdpr',
        'primary' => 'id_mp_customer_gdpr',
        'multilang' => false,
        'fields' => array(
            'id_customer' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => 'false',
            ),
            'date_sign' => array(
                'type' => self::TYPE_DATE,
                'validate' => 'isDate',
                'required' => 'true',
            ),
            'ip_address' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => 'true',
            ),
            'name' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'required' => 'true',
            ),
            'text' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'required' => 'true',
            ),
            'choice_value' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'required' => 'true',
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
        $sql[] = "CREATE TABLE IF NOT EXISTS `"._DB_PREFIX_."mp_customer_gdpr` (
              `id_mp_customer_gdpr` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
              `id_customer` int(11) NOT NULL,
              `date_sign` datetime NOT NULL,
              `ip_address` int(11) NOT NULL,
              `name` varchar(255) NOT NULL,
              `text` text NOT NULL,
              `choice_value` varchar(255) NOT NULL
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
}
