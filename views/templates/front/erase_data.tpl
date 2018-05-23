{*
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
<link rel="stylesheet" href="{$bootstrap4}/css/bootstrap.min.css">
<link rel="stylesheet" href="{$bootstrap4}/css/fontawesome-all.min.css">
<link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet'>

<script src="{$bootstrap4}/js/popper.min.js"></script>
<script src="{$bootstrap4}/js/bootstrap.min.js"></script>
<style>
	.user-data
	{
		font-family: Montserrat !important;
		font-size: 1.2em !important;
	}
	.user-data h3
	{
		font-size: 1,4em;
	}
	.user-data td
	{
		font-family: Montserrat !important;
		font-size: 1.2em !important;
		border: 1px solid #cccccc !important;
	}
	.user-data td:nth-child(1)
	{
		font-family: Montserrat !important;
		background: #6f93ce !important;
		border: 1px solid white !important;
		font-weight: bold !important;
		color: white !important;
	}
	.user-orders thead tr
	{
		font-family: Montserrat !important;
		background: #6f93ce !important;
		border: 1px solid white !important;
		font-weight: bold !important;
		text-align: center !important;
		color:white !important;
	}
	.user-orders thead tr th
	{
		font-family: Montserrat !important;
		border: 1px solid #white !important;
	}
	.user-orders td
	{
		font-family: Montserrat !important;
		font-size: 1.2em;
	}
	.container div 
	{
		.font-family: Montserrat !important;
		.font-size: 2em !important;
	}
</style>
{capture name=path}
	<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='My account'}">{l s='My account'}</a>
	<span class="navigation-pipe">{$navigationPipe}</span>{l s='Erase your personal data'}
{/capture}
<div class="container">
	<div class="row">
		<div class="card">
			<div class="card-header user-data">
				<h3>
					<i class="fas fa-user"></i>
					&nbsp;
					{l s='Customer data' mod='mpgdpr'}
				</h3>
			</div>
			<div class="card-body">
				<table class="table-responsive user-data">
					<tbody>
						<tr>
							<td>{l s='id' mod='mpgdpr'}</td>
							<td>{$customer->id}</td>
						</tr>
						<tr>
							<td>{l s='Firstname' mod='mpgdpr'}</td>
							<td>{$customer->firstname}</td>
						</tr>
						<tr>
							<td>{l s='Lastname' mod='mpgdpr'}</td>
							<td>{$customer->lastname}</td>
						</tr>
						<tr>
							<td>{l s='Date add' mod='mpgdpr'}</td>
							<td>{$customer->date_add}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="card-footer">
				
			</div>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="card">
			<div class="card-header user-data">
				<h3>
					<i class="far fa-envelope"></i>
					&nbsp;
					{l s='Newsletter' mod='mpgdpr'}
				</h3>
			</div>
			<div class="card-body">
				{if $customer->newsletter}
					<button type="button" class="btn btn-primary btn-large" value="0" style="font-size: 2em;" id="btn-newsletter">
						<i class="fas fa-times"></i>
						&nbsp;
						{l s='Unsubscribe me' mod='mpgdpr'}
					</button>
				{else}
					<h3>{l s='You have not subscribed our newsletter' mod='mpgdpr'}</h3>
				{/if}
			</div>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="card">
			<div class="card-header user-data">
				<h3>
					<i class="fab fa-optin-monster"></i>
					&nbsp;
					{l s='Preferences' mod='mpgdpr'}
				</h3>
			</div>
			<div class="card-body">
				<table class="table-responsive table-striped user-orders" id='tbl-preferences'>
					<thead>
						<tr>
							<th>{l s='id' mod='mpgdpr'}</th>
							<th>{l s='Date sign' mod='mpgdpr'}</th>
							<th>{l s='Ip address' mod='mpgdpr'}</th>
							<th>{l s='Name' mod='mpgdpr'}</th>
							<th>{l s='Text' mod='mpgdpr'}</th>
							<th>{l s='Choice' mod='mpgdpr'}</th>
							<th>{l s='Options' mod='mpgdpr'}</th>
						</tr>
					</thead>
					<tbody>
					{foreach $preferences as $pref}
						<tr>
							<td class="text-right">{$pref.id}</td>
							<td>{$pref.date}</td>
							<td>{$pref.ip_address}</td>
							<td>{$pref.name}</td>
							<td>{$pref.text}</td>
							<td>{$pref.choice_value}</td>
							<td>
								<a href="javascript:removePreferences({$pref.id});" class="btn btn-default">
									<i class="fas fa-times"></i>
									&nbsp;
									{l s='Remove' mod='mpgdpr'}
								</a>
							</td>
						</tr>
					{/foreach}
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="card">
			<div class="card-header user-data">
				<h3>
					<i class="far fa-file-alt"></i>
					&nbsp;
					{l s='Orders list' mod='mpgdpr'}
				</h3>
			</div>
			<div class="card-body">
				<table class="table-responsive table-striped user-orders">
					<thead>
						<tr>
							<th>{l s='id' mod='mpgdpr'}</th>
							<th>{l s='date' mod='mpgdpr'}</th>
							<th>{l s='reference' mod='mpgdpr'}</th>
							<th>{l s='total' mod='mpgdpr'}</th>
							<th>{l s='payment' mod='mpgdpr'}</th>
							<th>{l s='status' mod='mpgdpr'}</th>
						</tr>
					</thead>
					<tbody>
					{foreach $orders as $order}
						<tr>
							<td class="text-right">{$order.id_order}</td>
							<td>{$order.date}</td>
							<td>{$order.reference}</td>
							<td class="text-right">{$order.total}</td>
							<td>{$order.payment}</td>
							<td>{$order.status.name}</td>
						</tr>
					{/foreach}
					</tbody>
				</table>
			</div>
			<div class="card-footer">
				
			</div>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="card">
			<div class="card-header user-data">
				<h3>
					<i class="fas fa-info-circle"></i>
					&nbsp;
					{l s='Delete my data' mod='mpgdpr'}
				</h3>
			</div>
			<div class="card-body" style="font-size: 2em;">
				{if $orders}
					<span>{l s='You can\'t erase your data because there are orders on our archive.' mod='mpgdpr'}</span>
					<span>{l s='Your data will be stored in our server for 10 years, as established by Italian law.' mod='mpgdpr'}</span>
				{else}
					<button type="button" class="btn btn-primary btn-large" value="0" style="font-size: 2em;" id="erase-my-data">
						<i class="fas fa-times"></i>
						&nbsp;
						{l s='Erase my data' mod='mpgdpr'}
					</button>
				{/if}
			</div>
		</div>
	</div>
</div>
<script src="text/javascript">
	$(document).ready(function(){
		$('#erase-my-data').on('click', function(){
			console.log("oblivion???");
			if (confirm("{l s='Confirm erasing of your data? All data will be lost!' mod='mpgdpr'}")) {
				oblivion('{$customer->id}');
			}
		});
		$('#btn-newsletter').on('click', function(){
			if (confirm("{l s='Confirm unsubscribe from our newsletter?' mod='mpgdpr'}")) {
				unsubscribe({$customer->id});
				window.reload();
			}
		});
	});
	function removePreferences(id)
	{
		if (confirm("{l s='Confirm erasing of this preference? All data will be lost!' mod='mpgdpr'}")) {
			$.ajax({
				dataType: "json",
				type: "post",
				data:
				{
					ajax: true,
					action: "removePreference",
					id: id
				},
				success: function(data)
				{
					if (data.result) {
						$.growl.notice({
							title: '{l s='Erase preferences' mod='mpgdpr'}',
							message: '{l s='Operation done.' mod='mpgdpr'}'
						});
						$('#tbl-preferences tbody tr').each(function(){
							var id_cell = String($(this).find('td:nth-child(1)').text()).trim();
							console.log('looking for ', id_cell);
							if (id_cell == id) {
								$(this).remove();
							}
							return true;
						});
					}
				},
				error: function(){
					$.growl.error({
						title: "{l s='Error' mod='mpgdpr'}",
						message: "{l s='Unable to delete preferences. Please contact customer care.' mod='mpgdpr'}"
					});
				}
			});
		}
		console.log("remove ", id);
	}

	function oblivion(id_customer)
	{
		$.ajax({
			dataType: "json",
			type: "post",
			data:
			{
				ajax: true,
				action: "oblivion",
				id_customer: id_customer
			},
			success: function(data)
			{
				if (data.result.result) {
					$.growl.notice({
						title: '{l s='Erase preferences' mod='mpgdpr'}',
						message: '{l s='Operation done.' mod='mpgdpr'}'
					});
					console.log('redirect:', data.result.redirect);
					window.location.href=data.result.redirect;
					return false;
				}
			},
			error: function(){
				$.growl.error({
					title: '{l s='Error' mod='mpgdpr'}',
					message: '{l s='Unable to delete your data. Please contact customer care.'}'
				});
			}
		});
	}

	function unsubscribe(id_customer)
	{
		$.ajax({
			dataType: "json",
			type: "post",
			data:
			{
				ajax: true,
				action: "unsubscribe",
				id_customer: id_customer
			},
			success: function(data)
			{
				if (data.result) {
					$.growl.notice({
						title: '{l s='Unsubscribe' mod='mpgdpr'}',
						message: '{l s='Operation done.' mod='mpgdpr'}'
					});
					window.location.reload();
				}
			},
			error: function(){
				$.growl.error({
					title: '{l s='Error' mod='mpgdpr'}',
					message: '{l s='Unable to delete your data. Please contact customer care.'}'
				});
			}
		});
	}
</script>
