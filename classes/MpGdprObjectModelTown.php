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

class MpGdprObjectModelTown extends ObjectModelCore
{
    /** @var MpGdpr $module Module */
    private $module;
    /** @var int $id_mp_region region reference */
    public $id_mp_region;
    /** @var int $id_state state reference */
    public $id_state;
    /** @var int $id_istat istat code */
    public $id_istat;
    /** @var string $name signature name */
    public $name;
    /** @var string $iso_code state iso code */
    public $iso_code;
    /** @var string $postcode town postcode */
    public $postcode;
    /** @var int $id_zone zone reference */
    public $id_zone;

    public static $definition = array(
        'table' => 'mp_town',
        'primary' => 'id_mp_town',
        'multilang' => false,
        'fields' => array(
            'id_mp_region' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => 'true',
            ),
            'id_state' => array(
                'type' => self::TYPE_INT,
                'validate' => 'isUnsignedId',
                'required' => 'true',
            ),
            'id_istat' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'required' => 'true',
            ),
            'name' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'required' => 'true',
            ),
            'iso_code' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'required' => 'true',
            ),
            'postcode' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'required' => 'true',
            ),
            'id_zone' => array(
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
    }

    public function installTable()
    {
        $sql[] = "CREATE TABLE IF NOT EXISTS `"._DB_PREFIX_."mp_town` (
              `id_mp_town` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
              `id_mp_region` int(11) NOT NULL,
              `id_state` int(11) NOT NULL,
              `id_istat` varchar(4) NOT NULL,
              `name` varchar(255) NOT NULL,
              `iso_code` varchar(2) NOT NULL,
              `postcode` varchar(30) NOT NULL,
              `id_zone` int(11) NOT NULL
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

        return $this->fillTable();
    }

    public function fillTable()
    {
        $file = $this->module->getPath().'vendor/insert_comuni.sql';
        $content = file_get_contents($file);
        $sql = str_replace('{$_DB_PREFIX_}', _DB_PREFIX_, $content);
        $result = Db::getInstance()->execute($sql);
        return $result;
    }

    public static function getTownName($id_town)
    {
        $int_id_town = (int)$id_town;
        PrestaShopLoggerCore::addLog('(int)id city ('.$id_town.'): '.$int_id_town);
        if ($int_id_town == 0) {
            return  $id_town;
        }
        $db = Db::getInstance();
        $sql = "select `name` from "._DB_PREFIX_."mp_town where id_mp_town=".(int)$id_town;
        $town = $db->getValue($sql);
        PrestaShopLoggerCore::addLog('return city: '.$town);
        return $town;
    }
}
