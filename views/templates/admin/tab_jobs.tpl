{*
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
*}

<div id="job-tabs">
    <ul>
        <li><a href="#tabs-1"><i class="icon icon-list"></i>&nbsp;{l s='Job area' mod='mpgdpr'}</a></li>
        <li><a href="#tabs-2"><i class="icon icon-list"></i>&nbsp;{l s='Job name' mod='mpgdpr'}</a></li>
        <li><a href="#tabs-3"><i class="icon icon-list"></i>&nbsp;{l s='Job association' mod='mpgdpr'}</a></li>
    </ul>
    <div id="tabs-1">
        {$tab_job_area}
    </div>
    <div id="tabs-2">
        {$tab_job_name}
    </div>
    <div id="tabs-3">
        {$tab_job_association}
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        console.log('Tabs!');
        $('#job-tabs').tabs();
        $('.chosen').chosen(
            {
                disable_search_threshold: 10
            }
        );
    });
</script>
