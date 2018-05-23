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
<div class="card">
	<div class="card-header">
		<span style="font-size: 1.2em">
			<i class='fas fa-truck'></i>
			&nbsp;
			{l s='Delivery address' mod='mpgdpr'}
		</span>
	</div>
	<div class="card-body">
		<div class="form-group" >
			<label for="id_country_invoice">{l s='Country' mod='mpgdpr'}</label>
			<br>
			<select class="select" id="id_country_invoice">
				{foreach $countries_list as $country}
					<option 
					    value="{$country.id_country}"
	                    id_zone="{$country.id_zone}"
	                    iso_code="{$country.iso_code}",
	                    contains_states="{$country.contains_states}",
	                    need_zip_code="{$country.need_zip_code}",
	                    zip_code_format={$country.zip_code_format},
					>{$country.name}</option>
				{/foreach}
			</select>
		</div>
		<div class="form-group" id='id-state-invoice-container'>
			<label for="id_state_invoice">{l s='State' mod='mpgdpr'}</label>
			<br>
			<input type="text" class="form-control" id="id_state_text_invoice" style="display: none;">
			<select class="select" id="id_state_invoice">
				<option value="0" selected>--</option>
			</select>
		</div>
		<div class="form-group" >
			<label for="id_city_invoice">{l s='Town' mod='mpgdpr'}</label>
			<br>
			<input type="text" class="form-control" id="id_city_text_invoice" style="display: none;">
			<select class="select" id="id_city_invoice">
				<option value="0" selected>--</option>
			</select>
		</div>
		<div class="form-group" >
			<label for="postcode_invoice">{l s='postcode' mod='mpgdpr'}</label>		
			<input type="text" class="form-control" id="postcode_invoice">
		</div>
		<div class="form-group" >
			<label for="address1_invoice">{l s='Address' mod='mpgdpr'}</label>		
			<input type="text" class="form-control required" id="address1_invoice">
		</div>
		<div class="form-group" >
			<label for="address2_invoice">{l s='Address notes' mod='mpgdpr'}</label>		
			<input type="text" class="form-control" id="address2_invoice">
		</div>
		<div class="form-group" >
			<span><i class="fas fa-phone"></i>&nbsp;<label for="phone_invoice">{l s='Telephone number' mod='mpgdpr'}</label></span>	
			<input type="text" class="form-control" id="phone_invoice">
		</div>
		<div class="form-group" >
			<span><i class="fas fa-mobile-alt"></i>&nbsp;<label for="phone_mobile_invoice">{l s='Mobile number' mod='mpgdpr'}</label></span>	
			<input type="text" class="form-control" id="phone_mobile_invoice">
		</div>
		<div class="form-group" >
			<label for="other_invoice">{l s='Notes' mod='mpgdpr'}</label>		
			<textarea rows=5 class="form-control col-md-12" id="other_invoice"></textarea>
		</div>
	</div>
</div>
