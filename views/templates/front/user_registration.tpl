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
<link rel="stylesheet" href="{$bootstrap4}/css/bootstrap.min.css">
<link rel="stylesheet" href="{$bootstrap4}/css/fontawesome-all.min.css">
<link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet'>

<script src="{$bootstrap4}/js/popper.min.js"></script>
<script src="{$bootstrap4}/js/bootstrap.min.js"></script>
<style>
	.container input, .container select, .container label, .container textarea, .container .chosen-container
	{
		font-family: 'Montserrat';
		font-size: 12pt;
		margin-bottom: 16px;
		min-width: 50%;
	}
	.container button {
		font-family: 'Montserrat';
		font-size: 12pt;
	}
	.container select, .chosen-container {
		background-color: white !important;
		border-radius: 0.25rem !important;
		border: 1px solid #ced4da !important;
		color: #495057 !important;
		transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out !important;
		padding-top: 5px !important;
		padding-bottom: 15px !important;
	}
	.chosen-container {
		background: white!important;
		width: 'auto' !important;
	}
	.chosen-container-active:focus, .chosen-container-single:focus, .chosen-single:focus{
		border-color: #5050BB !important;
		box-shadow: 1px 1px 3px #707070 !important;
	}
	.chosen-container-single {
		border-radius: 0.25rem !important;
		border: 1px solid #ced4da !important;
		color: #495057 !important;
		padding-top: 5px !important;
		padding-bottom: 5px !important;
		box-shadow: none !important;
	}
	.chosen-single {
		border: none !important;
		background: white !important;
		box-shadow: none !important;
	}
	.chosen-container-active {
		border: 2px solid #A0A0BB !important;
		background: white !important;
		box-shadow: 1px 1px 3px #A0A0BB !important;
	}
	.container input {
		padding-top: 15px;
		padding-bottom: 15px;
	}
	#dni, #dni_invoice {
		text-transform: uppercase;
	}
</style>

<input type="hidden" name="form_data_object" id="form_data_object" value=''>

<div class="container" style="font-family: sans-serif; font-size: 10pt;">
	<div class="row">
		<div class="col-12">
			{assign var=invoice_tpl value="`$smarty.current_dir`/card-vat.tpl"}
			{include $invoice_tpl}
			<br>
			{assign var=customer_tpl value="`$smarty.current_dir`/card-account.tpl"}
			{include $customer_tpl}
			<br>
			{assign var=invoice_address_tpl value="`$smarty.current_dir`/card-address-invoice.tpl"}
			{include $invoice_address_tpl}
			<br>
			{assign var=delivery_address_tpl value="`$smarty.current_dir`/card-address-delivery.tpl"}
			{include $delivery_address_tpl}
			<br>
			{assign var=options_tpl value="`$smarty.current_dir`/card-options.tpl"}
			{include $options_tpl}
			<hr>
			<div class="card-footer">
				<div class="form-group">
					<label class="small" for="checkGDPR" style="font-size: 0.8em; text-align: justify;">
						<strong><i>
						In base al Regolamento UE 2016/679 (GDPR) i tuoi dati saranno registrati nei nostri server
						solamente per scopi fiscali, e i tuoi dati rimarranno registrati per un limite di 10 anni come imposto
						dalle norme vigenti in Italia. Se dopo esserti registrato non effettuerai nessun acquisto, potrai fare 
						valere il tuo diritto all'oblio sancito nell'art. 17 del GDPR, eliminandoli dal tuo pannello cliente alla
						voce Elimina i miei dati. <br>
						Dopo un tuo acquisto, i tuoi dati riguardanti la spedizione, saranno trasmessi al nostro corriere. Per
						completare la tua registrazione devi accettare questa clausola.
						</i></strong>
					</label>
				</div>
				<button type="submit" id="btn-save" name="btn-save" class="btn btn-secondary btn-large pull-right" disabled>
					<i class="far fa-2x fa-save"></i>
					&nbsp;
					Salva
				</button>
				<input type="hidden" name="submitAccount" value="1">
				<button type="button" id="btn-gdpr" class="btn btn-warning btn-large pull-right" style="margin-right: 16px;">
					<i class="fas fa-2x fa-exclamation-circle"></i>
					&nbsp;
					Accetto
				</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	String.prototype.isEmpty = function() {
    	return (this.length === 0 || !this.trim());
	};

	var globals = {};
	$(document).ready(function(){
		$('#btn-no-invoice').on('click', function(){
			$('#btn-no-invoice').removeClass('btn-outline-primary').addClass('btn-primary');
			$('#btn-invoice').removeClass('btn-primary').addClass('btn-outline-primary');
			$('#invoice-def').fadeOut();
			$('#hasInvoice').val("0");
			$('#company_name').val('');
			$('#vat_number').val('');
		});
		$('#btn-invoice').on('click', function(){
			$('#btn-invoice').removeClass('btn-outline-primary').addClass('btn-primary');
			$('#btn-no-invoice').removeClass('btn-primary').addClass('btn-outline-primary');
			$('#invoice-def').fadeIn();
			$('#hasInvoice').val("1");
		});
		$('#btn-no-alternative-address').on('click', function(){
			$('#btn-no-alternative-address').removeClass('btn-outline-primary').addClass('btn-primary');
			$('#btn-yes-alternative-address').removeClass('btn-primary').addClass('btn-outline-primary');
			$('#alternative-delivery-address-container').fadeOut();
			$('#hasAlternativeAddress').val("0");
		});
		$('#btn-yes-alternative-address').on('click', function(){
			$('#btn-yes-alternative-address').removeClass('btn-outline-primary').addClass('btn-primary');
			$('#btn-no-alternative-address').removeClass('btn-primary').addClass('btn-outline-primary');
			$('#alternative-delivery-address-container').fadeIn();
			$('#hasAlternativeAddress').val("1");
		});
		$('#btn-gdpr').on('click', function(){
			$('#btn-save').removeClass('btn-secondary').addClass('btn-primary').attr('disabled', false);
		});
		bindControls();
		/** SUBMIT **/
		$('form').on('submit', function(event){
			//event.preventDefault();
			var validate = validate_form();
			console.log('validate: ', validate);
			return Boolean(validate);
		});
	});

	function validate_form()
	{
		console.log("validate form");
		var validate_status = true;
		$('.required').each(function(){
			var isVisible = $(this).is(':visible');
			if(isVisible) {
				var isEmpty = String(this.value).isEmpty();
				if (isEmpty) {
					validate_status = false;
					$.growl.warning({
						title: "{l s='Warning' mod='mpgdpr'}",
						message: "{l s='This field can not be empty' mod='mpgdpr'}"
					});
					$(this).focus()
				}
			}
			if (validate_status == false) {
				return false;
			}
		});

		if (validate_status == false) {
			return false;
		}

		if (checkEmail($('#email').val())) {
			$.growl.error({
				title: 'Errore',
				message: "Inserisci un'email valida!"
			});
			$('#email').focus();
			return false;
		}
		if ($('#passwd').val().length<8) {
			$.growl.warning({
				title: 'Attenzione',
				message: 'La password deve essere almeno 8 caratteri.'
			});
			$('#passwd').focus();
			return false;
		}
		
		if ($('#id_gender').val() == 0) {
			$.growl.warning({
				title: '{l s='Warning' mod='mpgdpr'}',
				message: '{l s='Please select a gender' mod='mpgdpr'}'
			});
			$('#id_gender').focus();
			return false;
		}

		var date_birthday = new Date($('#birthday').val());
		var status_birthday = true;
		if (date_birthday.getFullYear()<1900) {
			status_birthday = false;
		}
		if (date_birthday == 'Invalid Date') {
			status_birthday = false;
		}

		if (!status_birthday) {
			$.growl.warning({
				title: '{l s='Warning' mod='mpgdpr'}',
				message: '{l s='Please select valid birthday date' mod='mpgdpr'}'
			});
			$('#birthday').focus();
			return false;
		}

		var now = new Date();
		if (now.getFullYear()-date_birthday.getFullYear()<18)
		{
			$.growl.warning({
				title: '{l s='Warning' mod='mpgdpr'}',
				message: '{l s='You must are in age to perform orders in our site!' mod='mpgdpr'}'
			});
			$('#birthday').focus();
			return false;
		}

		if ($('#id_country_invoice').val() == 0) {
			$.growl.warning({
				title: '{l s='Warning' mod='mpgdpr'}',
				message: '{l s='Please select a Country' mod='mpgdpr'}'
			});
			$('#id_country_invoice_chosen').focus();
			return false;
		}
		
		if ($('#id-state-invoice-container').is(":visible")) {
			if ($('#id_state_invoice').val() == 0) {
				$.growl.warning({
					title: '{l s='Warning' mod='mpgdpr'}',
					message: '{l s='Please select a State' mod='mpgdpr'}'
				});
				$('#id_state_invoice_chosen').focus();
				return false;
			}
			if ($('#id_city_invoice').val() == 0) {
				$.growl.warning({
					title: '{l s='Warning' mod='mpgdpr'}',
					message: '{l s='Please select a Town' mod='mpgdpr'}'
				});
				$('#id_city_invoice_chosen').focus();
				return false;
			}
		} else {
			if (String($('#id_city_invoice_text').val()).isEmpty()) {
				$.growl.warning({
					title: '{l s='Warning' mod='mpgdpr'}',
					message: '{l s='Please insert a Town' mod='mpgdpr'}'
				});
				$('#id_city_invoice_text').focus();
				return false;
			}
		}
		
		var isEmptyPhone = String($('#phone_invoice').val()).isEmpty();
		var isEmptyMobile = String($('#phone_mobile_invoice').val()).isEmpty();

		if (isEmptyPhone && isEmptyMobile)
		{
			$.growl.warning({
				title: '{l s='Warning' mod='mpgdpr'}',
				message: '{l s='Please insert an phone number or a mobile number' mod='mpgdpr'}'
			});
			$('#phone_invoice').focus();
			return false;
		}

		if ($('#hasAlternativeAddress').val() == "1") {
			if ($('#id_country').val() == 0) {
				$.growl.warning({
					title: '{l s='Warning' mod='mpgdpr'}',
					message: '{l s='Please select a Country' mod='mpgdpr'}'
				});
				$('#id_country_chosen').focus();
				return false;
			}
			
			if ($('#id-state-container').is(':visible')) {
				if ($('#id_state').val() == 0) {
					$.growl.warning({
						title: '{l s='Warning' mod='mpgdpr'}',
						message: '{l s='Please select a State' mod='mpgdpr'}'
					});
					$('#id_state_chosen').focus();
					return false;
				}
				if ($('#id_city').val() == 0) {
					$.growl.warning({
						title: '{l s='Warning' mod='mpgdpr'}',
						message: '{l s='Please select a Town' mod='mpgdpr'}'
					});
					$('#id_city_chosen').focus();
					return false;
				}
			} else {
				if (String($('#id_city_text').val()).isEmpty()) {
					$.growl.warning({
						title: '{l s='Warning' mod='mpgdpr'}',
						message: '{l s='Please insert a Town' mod='mpgdpr'}'
					});
					$('#id_city_text').focus();
					return false;
				}
			}
			
			var isEmptyPhone = String($('#phone').val()).isEmpty();
			var isEmptyMobile = String($('#phone_mobile').val()).isEmpty();

			if (isEmptyPhone && isEmptyMobile)
			{
				$.growl.warning({
					title: '{l s='Warning' mod='mpgdpr'}',
					message: '{l s='Please insert an phone number or a mobile number' mod='mpgdpr'}'
				});
				$('#phone').focus();
				return false;
			}
		}


		var form_data = {
			gender: $('#id_gender').val(),
			firstname: $('#customer_firstname').val(),
			lastname: $('#customer_lastname').val(),
			birthday: $('#birthday').val(),
			email: $('#email').val(),
			passwd: $('#passwd').val(),
			address_delivery: {
				id_country: $('#id_country_invoice').val(),
				id_state: $('#id_state_invoice').val(),
				id_city: $('#id_city_text_invoice').val()!=''?$('#id_city_text_invoice').val():$('#id_city_invoice').val(),
				postcode: $('#postcode_invoice').val(),
				address1: $('#address1_invoice').val(),
				address2: $('#address2_invoice').val(),
				phone: $('#phone_invoice').val(),
				phone_mobile: $('#phone_mobile_invoice').val(),
				other: $('#other_invoice').val(),
			},
			has_alternative_address: $('#hasAlternativeAddress').val(),
			address_alternative: {
				address_to: $('#address_to').val(),
				id_country: $('#id_country').val(),
				id_state: $('#id_state').val(),
				id_city: $('#id_city_text').val()!=''?$('#id_city_text').val():$('#id_city').val(),
				postcode: $('#postcode').val(),
				address1: $('#address1').val(),
				address2: $('#address2').val(),
				phone: $('#phone').val(),
				phone_mobile: $('#phone_mobile').val(),
				other: $('#other').val(),
			},
			has_invoice: $('#hasInvoice').val(),
			invoice_header: $('#invoice_header').val(),
			vat_number: $('#vat_number').val(),
			id_job_area: $('#id_job_area').val(),
			id_job_name: $('#id_job_name').val(),
			newsletter: $('#newsletter').val()
		};

		var object_string = JSON.stringify(form_data);
		console.log ('stringify value:', object_string);
		$('#form_data_object').val(object_string);

		console.log("end validation");
		return true;
	}

	/**
	 * Check if an email already exists
	 * @param  { string } email email to check
	 * @return { bool}    true if exists, false otherwise
	 */
	function checkEmail(email)
	{
		console.log("Checking email ", email);
		var pattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z][a-z]+$/;
		test = pattern.test(email);
		if (!test) {
			$.growl.error({
				title: 'Errore',
				message: "L'email inserita non è valida."
			});
			return false;
		}
		console.log('Check if email exists');
		$.ajax({
			type: "post",
			dataType: "json",
			data: 
			{	
				ajax: true,
				action: 'checkEmail',
				email: email
			},
			success: function(data)
			{
				var check = JSON.parse(data.result);
				if (check.result>0) {
					$.growl.error({
						title: 'Errore',
						message: "L'email inserita esiste già in archivio. Forse hai dimenticato la password?"
					});
				}
				return false;
			},
			error: function(data)
			{
				console.log('Ajax error: ', data);
				return false;
			}
		});
	}

	function bindControls()
	{
		/**CHOSEN**/
		$('#id_country').chosen({ 'min-width': '50%' });
		$('#id_state').chosen({ 'min-width': '50%'});
		$('#id_city').chosen({ 'min-width': '50%' });
		$('#id_country_invoice').chosen({ 'min-width': '50%' });
		$('#id_state_invoice').chosen({ 'min-width': '50%' });
		$('#id_city_invoice').chosen({ 'min-width': '50%' });
		/** COUNTRY INVOICE CHOOSE **/
		$('#id_country_invoice').on('change', function(){
			globals.invoice = {};
			$('#id_country_invoice option').each(function(){
				var value = $('#id_country_invoice').val();
				if(this.value == value) {
					globals.invoice.id_country = this.value;
					globals.invoice.id_zone = $(this).attr('id_zone');
					globals.invoice.iso_code = $(this).attr('iso_code');
					globals.invoice.contains_states = $(this).attr('contains_states');
					globals.invoice.need_zip_code = $(this).attr('need_zip_code');
					globals.invoice.zip_code_format = $(this).attr('zip_code_format');
					globals.invoice.country_name = $(this).text();
				}
				return null;
			});	
			if (globals.invoice.contains_states == 1) {
				$('#id-state-invoice-container').show();
				$('#id_city_invoice_chosen').show();
				$('#id_city_text_invoice').hide();
				getStates(this.value, $('#id_state_invoice'));
			} else {
				$('#id-state-invoice-container').hide();
				$('#id_state_invoice').html('');
				$('#id_state_invoice').trigger('chosen:updated').hide();
				$('#id_city_invoice').html('');
				$('#id_city_invoice_chosen').trigger('chosen:updated').hide();
				$('#id_city_text_invoice').show();
			}	
		});
		/** STATE INVOICE CHOOSE **/
		$('#id_state_invoice').on('change', function(){
			var selected = $('#id_state_invoice option:selected').attr('iso_code');
			getTowns(selected, $('#id_city_invoice'));
		});
		/** CITY INVOICE CHOOSE **/
		$('#id_city_invoice').on('change', function(){
			var selected = $('#id_city_invoice option:selected').attr('postcode');
			$('#postcode_invoice').val(selected);
		});
		/** COUNTRY CHOOSE **/
		$('#id_country').on('change', function(){
			globals.delivery = {};
			$('#id_country option').each(function(){
				var value = $('#id_country').val();
				if(this.value == value) {
					globals.delivery.id_country = this.value;
					globals.delivery.id_zone = $(this).attr('id_zone');
					globals.delivery.iso_code = $(this).attr('iso_code');
					globals.delivery.contains_states = $(this).attr('contains_states');
					globals.delivery.need_zip_code = $(this).attr('need_zip_code');
					globals.delivery.zip_code_format = $(this).attr('zip_code_format');
					globals.delivery.country_name = $(this).text();
				}
			});
			if (globals.delivery.contains_states == 1) {
				$('#id-state-container').show();
				$('#id_city_chosen').show();
				$('#id_city_text').hide();
				getStates(this.value, $('#id_state'));
			} else {
				$('#id-state-container').hide();
				$('#id_state').html('');
				$('#id_state').trigger('chosen:updated').hide();
				$('#id_city').html('');
				$('#id_city_chosen').trigger('chosen:updated').hide();
				$('#id_city_text').show();
			}
		});
		/** STATE CHOOSE **/
		$('#id_state').on('change', function(){
			var selected = $('#id_state option:selected').attr('iso_code');
			getTowns(selected, $('#id_city'));
		});
		/** CITY CHOOSE **/
		$('#id_city').on('change', function(){
			var selected = $('#id_city option:selected').attr('postcode');
			$('#postcode').val(selected);
		});
		
		/** CHECK EMAIL  **/
		$('#email').on('blur', function(){
			return checkEmail(this.value);
		});
		/** JOB AREA **/
		$('#id_job_area').chosen(
			{
				width: '50%',
				inherit_select_classes: true
			}
		);
		$('#id_job_area').on('change', function(){
			$.ajax({
				type: "post",
				dataType: "json",
				data: 
				{	
					ajax: true,
					action: 'getComboJobName',
					id_job_area: this.value
				},
				success: function(data)
				{
					$('#id_job_name').html('');
					if (data.result.length === 0) {
						var option = $('<option></option>').attr('value', 0).text('{l s='Nothing to select' mod='mpgdpr'}');
					} else {
						var option = $('<option></option>').attr('value', 0).text('{l s='Please select a job' mod='mpgdpr'}');	
					}
					
					$('#id_job_name').append(option);
					$.each(data.result, function(){
						var option = $('<option></option>').attr('value', this.id_mp_customer_job_name).text(this.name);
						$('#id_job_name').append(option);
					});
					$('#id_job_name').chosen(
						{
							width: '50%',
							inherit_select_classes: true
						}
					).trigger('chosen:updated');
				},
				error: function(data)
				{
					console.log('Ajax error: ', data);
					return false;
				}
			});
		});
		/** NEWSLETTER  **/
		$('#newsletter_on').on('click', function(){
			$('#newsletter_on').removeClass('btn-outline-primary').addClass('btn-primary');
			$('#newsletter_off').removeClass('btn-primary').addClass('btn-outline-primary');
			$('#newsletter').val("1");
		});

		$('#newsletter_off').on('click', function(){
			$('#newsletter_off').removeClass('btn-outline-primary').addClass('btn-primary');
			$('#newsletter_on').removeClass('btn-primary').addClass('btn-outline-primary');
			$('#newsletter').val("0");
		});
		/** JOB NAME **/
		$('#id_job_area').on('change', function(){
			$.ajax({
				type: "post",
				dataType: "json",
				data: 
				{	
					ajax: true,
					action: 'getComboJobName',
					id_job_area: this.value
				},
				success: function(data)
				{
					$('#id_job_name').html('');
					if (data.result.length === 0) {
						var option = $('<option></option>').attr('value', 0).text('{l s='Nothing to select' mod='mpgdpr'}');
					} else {
						var option = $('<option></option>').attr('value', 0).text('{l s='Please select a job' mod='mpgdpr'}');	
					}
					
					$('#id_job_name').append(option);
					$.each(data.result, function(){
						var option = $('<option></option>').attr('value', this.id_mp_customer_job_name).text(this.name);
						$('#id_job_name').append(option);
					});
				},
				error: function(data)
				{
					console.log('Ajax error: ', data);
					return false;
				}
			});
		});
	}

	function displayInvoiceData(value)
	{
		if (value==1) {
			$('#invoice-data').fadeIn();
		} else {
			$('#invoice-data').fadeOut();
		}
		$('#hasInvoice').val(value);
	}

	function getTowns(iso_code, elem)
	{
		$.ajax({
			type: "post",
			dataType: "json",
			data:
			{
				ajax: true,
				action: 'getComboTowns',
				iso_code: iso_code
			},
			success: function(data){
				$(elem).html('');
				$.each(data.result, function(){
					var option = $('<option></option>')
					.attr('value', this.id_mp_town)
					.attr('id_istat', this.id_istat)
					.attr('id_mp_region', this.regione)
					.attr('postcode', this.postcode)
					.text(this.name);
					$(elem).append(option);	
				});
				$(elem).chosen().trigger('chosen:updated');
			},
			error: function()
			{
				console.log('Errore durante la chiamata ajax')
			}
		});
	}

	function getStates(id_country, elem)
	{
		var suff = "";
		var id = $(elem).attr('id');
		console.log("element",id);
		if ($(elem).attr('id')=='id_state_invoice') {
			suff = "_invoice";
		}
		$('#id_state'+suff+"_chosen").val('0').show();
		$('#id_state_text'+suff).val('').hide();
		$('#id_city'+suff+"_chosen").val('0').show();
		$('#id_city_text'+suff).val('').hide();
		$('#postcode'+suff).val('');
		$.ajax({
			type: "post",
			dataType: "json",
			data:
			{
				ajax: true,
				action: 'getComboStates',
				id_country: id_country
			},
			success: function(data){
				$(elem).html('');
				$.each(data.result, function(){
					var option = $('<option></option>')
						.attr('value', this.id)
						.attr('iso_code', this.iso_code)
						.text(this.name);
					$(elem).append(option);	
				});
				$(elem).chosen().trigger('chosen:updated');
			},
			error: function()
			{
				console.log('Errore durante la chiamata ajax')
			}
		});
	}
</script>