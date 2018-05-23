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
		<span>
			<i class="fas fa-user"></i>
			{l s='Customer account' mod='mpgdpr'}
		</span>
	</div>
	<div class="card-body">
		<div class="form-group">
			<span><i class="fas fa-envelope"></i>&nbsp;<label for="email">Email</label></span>
			<input type="email" class="form-control required" id="email"
				{if isset($email_customer)}
					value="{$email_customer}"
				{/if}
			>
		</div>
		<div class="form-group">
			<span><i class="fas fa-key"></i>&nbsp;<label for="passwd">Password</label></span>
			<input type="password" class="form-control required" id="passwd">
		</div>
		<div class="form-group">
			<label for="id_gender">{l s='Gender' mod='mpgdpr'}</label>
			<br>
			<select class="select" id="id_gender">
				<option value="0" selected>{l s='Select' mod='mpgdpr'}</option>
				<option value="1">{l s='Mr.' mod='mpgdpr'}</option>
				<option value="2">{l s='Ms.' mod='mpgdpr'}</option>
			</select>
		</div>
		<div class="form-group">
			<label for="customer_firstname">{l s='Firstname' mod='mpgdpr'}</label>		
			<input type="text" class="form-control required" id="customer_firstname">
		</div>
		<div class="form-group">
			<label for="customer_lastname">{l s='lastname' mod='mpgdpr'}</label>		
			<input type="text" class="form-control required" id="customer_lastname">
		</div>
		<div class="form-group">
			<label for="birthday">{l s='Birthday' mod='mpgdpr'}</label>
			<input type="date" class="form-control required" id="birthday">
			<small>
				{l s='If you want to place orders on our site, you must be of age. Enter your date of birth for an automatic check. The data will be recorded on our files only for tax purposes.' mod='mpgdpr'}
			</small>
		</div>
	</div>
</div>