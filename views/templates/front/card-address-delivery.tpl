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
		<div class="form-group" >
			<label>{l s='Do you want an alternative delivery address?' mod='mpgdpr'}</label>
			<br>	
			<button type="button" class="btn btn-outline-primary btn-large" id="btn-no-alternative-address" value="1">
				<i class='fas fa-ban'></i> {l s='NO' mod='mpgdpr'}
			</button>
			<button type="button" class="btn btn-outline-primary btn-large" id="btn-yes-alternative-address" value="2">
				<i class='fas fa-check-circle'></i> {l s='YES' mod='mpgdpr'}
			</button>
			<input type="hidden" id="hasAlternativeAddress" value="0">
		</div>
	</div>
	<div class="card-body" id='alternative-delivery-address-container' style="display: none;">
		<div class="form-group" >
			<label for="address_to">{l s='Address at' mod='mpgdpr'}</label>		
			<input type="text" class="form-control required" id="address_to">
		</div>
		<div class="form-group" >
			<label for="id_country">{l s='Country' mod='mpgdpr'}</label>
			<br>
			<select class="select" id="id_country">
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
		<div class="form-group" id='id-state-container'>
			<label for="id_state">{l s='State' mod='mpgdpr'}</label>
			<br>
			<select class="select" id="id_state">
				<option value="0" selected>--</option>
			</select>
		</div>
		<div class="form-group" >
			<label for="id_city">{l s='Town' mod='mpgdpr'}</label>
			<br>
			<input type="text" class="form-control" id="id_city_text" style="display: none;">
			<select class="select" id="id_city">
				<option value="0" selected>--</option>
			</select>
		</div>
		<div class="form-group" >
			<label for="postcode">{l s='postcode' mod='mpgdpr'}</label>		
			<input type="text" class="form-control required" id="postcode" >
		</div>
		<div class="form-group" >
			<label for="address1">{l s='Address' mod='mpgdpr'}</label>		
			<input type="text" class="form-control required" id="address1" >
		</div>
		<div class="form-group" >
			<label for="address2">{l s='Address notes' mod='mpgdpr'}</label>		
			<input type="text" class="form-control" id="address2" >
		</div>
		<div class="form-group" >
			<span><i class="fas fa-phone"></i>&nbsp;<label for="phone">{l s='Telephone number' mod='mpgdpr'}</label></span>	
			<input type="text" class="form-control" id="phone" >
		</div>
		<div class="form-group" >
			<span><i class="fas fa-mobile-alt"></i>&nbsp;<label for="phone_mobile">{l s='Mobile number' mod='mpgdpr'}</label></span>	
			<input type="text" class="form-control" id="phone_mobile" >
		</div>
		<div class="form-group" >
			<label for="other">{l s='Notes' mod='mpgdpr'}</label>		
			<textarea rows=5 class="form-control col-md-12" id="other"></textarea>
		</div>
	</div>
</div>
		

		