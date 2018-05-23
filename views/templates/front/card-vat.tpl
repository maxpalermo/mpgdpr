{*
* 2007-2016 PrestaShop
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<div class="card" >
	<div class="card-header">
		<div class="form-group" >
			<label>{l s='Customer type' mod='mpgdpr'}</label>
			<br>
			<button type="button" class="btn btn-primary btn-large" id="btn-no-invoice" value="0">
				<i class='fas fa-user'></i> {l s='Physical person' mod='mpgdpr'}
			</button>
			<button type="button" class="btn btn-outline-primary btn-large" id="btn-invoice" value="1">
				<i class='fas fa-home'></i> {l s='Legal Entity' mod='mpgdpr'}
			</button>
		</div>
	</div>
	<div class="card-body" style="display: none;" id="invoice-def">
		<div class="form-group" >
			<label for="invoice_header">{l s='Invoice header' mod='mpgdpr'}</label>	
			<input type="text" class="form-control required" id="invoice_header" style="min-width: 50%;">
		</div>
		<div class="form-group" >
			<label for="dni_invoice">{l s='Vat number or DNI if you are a No-Profit Association' mod='mpgdpr'}</label>		
			<input 
				type="text" 
				class="form-control required" 
				id="vat_number" 
				style="min-width: 50%; text-transform: uppercase;"
			>
		</div>
		<input type="hidden" id="hasInvoice" value="0">
	</div>
</div>