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
{if !$opc}
	{assign var='current_step' value='address'}
	{capture name=path}{l s='Addresses'}{/capture}
	{assign var="back_order_page" value="order.php"}
	<h1 class="page-heading">{l s='Addresses'}</h1>
	{include file="$tpl_dir./order-steps.tpl"}
	{include file="$tpl_dir./errors.tpl"}
		<form action="{$link->getPageLink($back_order_page, true)|escape:'html':'UTF-8'}" method="post">
{else}
	{assign var="back_order_page" value="order-opc.php"}
	<h1 class="page-heading step-num"><span>1</span> {l s='Addresses'}</h1>
	<div id="opc_account" class="opc-main-block">
		<div id="opc_account-overlay" class="opc-overlay" style="display: none;"></div>
{/if}
<div class="addresses clearfix">
	<div class="row">
	</div> <!-- end row -->
	<div class="row">
		<div class="col-xs-12 col-sm-6"{if $cart->isVirtualCart()} style="display:none;"{/if}>
			<ul class="address item box" id="address_delivery">
				<h3>Indirizzo di spedizione</h3>
				<br>
				{if count($delivery_addresses)>1}
					<style>
						#alternate-address {
							background: white !important;
							border: 1px solid #bbbbbb !important;
							padding: 10px !important;
							width: 100% !important;
						}
					</style>
					<label for="alternate-address">{l s='Select an alternate address' mod='mpgdpr'}</label>
					<br>
					<select id='alternate-address'>
						{foreach $delivery_addresses as $addr}
							<option value="{$addr.id_address}"
								{if $addr.id_address==$delivery_address.id_address}
									selected
								{/if}
							>
								{$addr.address1} - {$addr.city} - {$addr.postcode}
							</option>
						{/foreach}
					</select>
					<script src="text/javascript">
						{assign var=idx value=0}
						var addresses = [
							{foreach $delivery_addresses as $addr}
								{if $idx != 0}
									,
								{/if}
								{
									'id_address' : '{$addr.id_address}',
									'company': '{$addr.company}',
									'firstname': '{$addr.firstname}',
									'lastname': '{$addr.lastname}',
									'address1': '{$addr.address1}',
									'address2': '{$addr.address2}',
									'city': '{$addr.city}',
									'postcode': '{$addr.postcode}',
									'phone': '{$addr.phone}',
									'phone_mobile': '{$addr.phone_mobile}'
								}
								{assign var=idx value=1}
							{/foreach}
						];
						$(document).ready(function(){
							$('#alternate-address').on('change', function(){
								var cur_id_address = this.value;
								$('#id_address_delivery').val(this.value);
								var addr = {};
								$(addresses).each(function(){
									if (this.id_address == cur_id_address) {
										addr = this;
										return this;
									} 
								});
								if (addr.company!='') {
									var addressat = addr.company;
								} else {
									var addressat = addr.firstname+' '+addr.lastname;
								}
								if (addr.phone_mobile!='') {
									var phone = addr.phone_mobile;
								} else {
									var phone = addr.phone;
								}

								$('#address-data-delivery').html(
									"<span><strong>"+addressat+"</strong></span><br>"+
									"<span>"+addr.address1+"</span><br>"+
									"<span>"+addr.address2+"</span><br>"+
									"<span>"+addr.postcode+"</span><br>"+
									"<span>"+addr.city+"</span><br>"+
									"<span>"+phone+"</span><br>"
								);
							});
						});
					</script>
				{/if}
				<hr>
				<div id='address-data-delivery'>
					{foreach $delivery_address as $key=>$addr}
						{if $key!='id_address'}
							<span>{$addr}</span>
							<br>
						{/if}
					{/foreach}
				</div>
				<input type="hidden" name="id_address_delivery" id="id_address_delivery" value="{$delivery_address.id_address}">
			</ul>
		</div>
		<div class="col-xs-12 col-sm-6">
			<ul class="address alternate_item{if $cart->isVirtualCart()} full_width{/if} box" id="address_invoice">
				<h3>Indirizzo di fatturazione</h3>
				<hr>
				{foreach $invoice_address as $key=>$addr}
					{if $key!='id_address'}
						<span>{$addr}</span>
						<br>
					{/if}
				{/foreach}
				<input type="hidden" name="id_address_invoice" id="id_address_invoice" value="{$invoice_address.id_address}">
			</ul>
		</div>
	</div> <!-- end row -->
	{if !$opc}
		<div id="ordermsg" class="form-group">
			<label>{l s='If you would like to add a comment about your order, please write it in the field below.'}</label>
			<textarea class="form-control" cols="60" rows="6" name="message">{if isset($oldMessage)}{$oldMessage}{/if}</textarea>
		</div>
	{/if}
</div> <!-- end addresses -->
{if !$opc}
			<p class="cart_navigation clearfix">
				<input type="hidden" class="hidden" name="step" value="2" />
				<input type="hidden" name="back" value="{$back}" />
				<a href="{$link->getPageLink($back_order_page, true, NULL, "{if $back}back={$back}{/if}")|escape:'html':'UTF-8'}" title="{l s='Previous'}" class="button-exclusive btn btn-default">
					<i class="icon-chevron-left"></i>
					{l s='Continue Shopping'}
				</a>
				<button type="submit" name="processAddress" class="button btn btn-default button-medium">
					<span>{l s='Proceed to checkout'}<i class="icon-chevron-right right"></i></span>
				</button>
			</p>
		</form>
{else}
	</div> <!--  end opc_account -->
{/if}
{strip}
{if !$opc}
	{addJsDef orderProcess='order'}
	{addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
	{addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}
	{addJsDefL name=CloseTxt}{l s='Submit' js=1}{/addJsDefL}
{/if}
{capture}{if $back}&mod={$back|urlencode}{/if}{/capture}
{capture name=addressUrl}{$link->getPageLink('address', true, NULL, 'back='|cat:$back_order_page|cat:'?step=1'|cat:$smarty.capture.default)|escape:'quotes':'UTF-8'}{/capture}
{addJsDef addressUrl=$smarty.capture.addressUrl}
{capture}{'&multi-shipping=1'|urlencode}{/capture}
{addJsDef addressMultishippingUrl=$smarty.capture.addressUrl|cat:$smarty.capture.default}
{capture name=addressUrlAdd}{$smarty.capture.addressUrl|cat:'&id_address='}{/capture}
{addJsDef addressUrlAdd=$smarty.capture.addressUrlAdd}
{addJsDef opc=$opc|boolval}
{capture}<h3 class="page-subheading">{l s='Your billing address' js=1}</h3>{/capture}
{addJsDefL name=titleInvoice}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{capture}<h3 class="page-subheading">{l s='Your delivery address' js=1}</h3>{/capture}
{addJsDefL name=titleDelivery}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{capture}<a class="button button-small btn btn-default" href="{$smarty.capture.addressUrlAdd}" title="{l s='Update' js=1}"><span>{l s='Update' js=1}<i class="icon-chevron-right right"></i></span></a>{/capture}
{addJsDefL name=liUpdate}{$smarty.capture.default|@addcslashes:'\''}{/addJsDefL}
{/strip}