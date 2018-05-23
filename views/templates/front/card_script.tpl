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

<script type="text/javascript">
	var DateDiff = {
	    inDays: function(d1, d2) {
	        var t2 = d2.getTime();
	        var t1 = d1.getTime();

	        return parseInt((t2-t1)/(24*3600*1000));
	    },

	    inWeeks: function(d1, d2) {
	        var t2 = d2.getTime();
	        var t1 = d1.getTime();

	        return parseInt((t2-t1)/(24*3600*1000*7));
	    },

	    inMonths: function(d1, d2) {
	        var d1Y = d1.getFullYear();
	        var d2Y = d2.getFullYear();
	        var d1M = d1.getMonth();
	        var d2M = d2.getMonth();

	        return (d2M+12*d2Y)-(d1M+12*d1Y);
	    },

	    inYears: function(d1, d2) {
	        return d2.getFullYear()-d1.getFullYear();
	    }
	}

	function empty( val ) {
	    // test results
	    //---------------
	    // []        true, empty array
	    // {}        true, empty object
	    // null      true
	    // undefined true
	    // ""        true, empty string
	    // ''        true, empty string
	    // 0         false, number
	    // true      false, boolean
	    // false     false, boolean
	    // Date      false
	    // function  false

	    if (val==='')
	    	return true;

	    if (val === undefined)
	        return true;

	    if (typeof (val) == 'function' || typeof (val) == 'number' || typeof (val) == 'boolean' || Object.prototype.toString.call(val) === '[object Date]')
	        return false;

	    if (val == null || val.length === 0)        // null or 0 length array
	        return true;

	    if (typeof (val) == "object") {
	        // empty object

	        var r = true;

	        for (var f in val)
	            r = false;

	        return r;
	    }

	    return false;
	}

	function isDNI(dni)
	{
		dni = String(dni).toUpperCase();
		pattern = /^[A-Z][A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][A-Z][0-9][0-9][A-Z][0-9][0-9][0-9][A-Z]$/;
		test = pattern.test(dni); 
		return test;
	}

	function isDate(date, element, diff = 18)
	{
		var result = new Date(date);
		if (String(date).trim()==='' || result == 'Invalid Date') {
			var label = $(element).parent().find('label').text();
			//$('#account-creation_form').find('label[for="'+element.id+'"]').text();
			$.growl.warning({
				title: 'Attenzione',
				message: 'Inserisci una data valida per il campo '+label+'.'
			});
			$(element).focus();
			return false;
		}
		if (diff!=0) {
			var now = new Date();
			var date_diff = Math.abs(DateDiff.inYears(now, new Date(date)));
			if (diff>date_diff) {
				$.growl.error({
					title: 'ERRORE',
					message: 'Devi essere maggiorenne per poterti iscrivere.'
				});
				$(element).focus();
				return false;
			}
		}
		return true;
	}

	function isUnselected(field_value, element)
	{
		if (field_value==0) {
			var label = $(element).parent().find('label').text();
			//$('#account-creation_form').find('label[for="'+element.id+'"]').text();
			$.growl.warning({
				title: 'Attenzione',
				message: 'Devi selezionare almeno un valore per il campo '+label+'.'
			});
			$(element).focus();
			return true;
		}
		return false;
	}

	function isEmpty(field_value, element)
	{
		if (String(field_value).trim() === '') {
			var label = $(element).parent().find('label').text();
			//$('#account-creation_form').find('label[for="'+element.id+'"]').text();
			$.growl.warning({
				title: 'Attenzione',
				message: 'Il campo ' + label + ' non può essere lasciato vuoto.'
			});
			$(element).focus();
			return true;
		}
		return false;
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
			console.log('suffix: ', suff);
		}
		if (id_country != 10) {
			$('#id_state'+suff).val('').hide();
			$('#id_state_text'+suff).val('').show();
			$('#id_city'+suff).val('').hide();
			$('#id_city_text'+suff).val('').show();
			$('#postcode'+suff).val('');
			return false;
		}
		/** Italy **/
		$('#id_state'+suff).val('').show();
		$('#id_state_text'+suff).val('').hide();
		$('#id_city'+suff).val('').show();
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
			},
			error: function()
			{
				console.log('Errore durante la chiamata ajax')
			}
		});
	}

	function fillComboCountries()
	{
		$.ajax({
			type: "post",
			dataType: "json",
			data:
			{
				ajax: true,
				action: 'getComboCountries',
			},
			success: function(data){
				$('#id_country').html('');
				$('#id_country_invoice').html('');
				$.each(data.result, function(){
					var option1 = $('<option></option>').attr('value', this.id_country).text(this.name);
					var option2 = $('<option></option>').attr('value', this.id_country).text(this.name);
					$('#id_country').append(option1);
					$('#id_country_invoice').append(option2);
				});
			},
			error: function()
			{
				console.log('Errore durante la chiamata ajax')
			}
		});
	}

	function fillComboJobArea()
	{
		$.ajax({
			type: "post",
			dataType: "json",
			data:
			{
				ajax: true,
				action: 'getComboJobArea',
			},
			success: function(data){
				$('#id_job_name').html('');
				$.each(data.result, function(){
					var option = $('<option></option>').attr('value', this.id_mp_customer_job_area).text(this.name);
					$('#id_job_area').append(option);
				});
			},
			error: function()
			{
				console.log('Errore durante la chiamata ajax')
			}
		});
	}

	function validate_form()
	{
		console.log("validate form");
		var gender = $('#id_gender').val();
		var firstname = $('#customer_firstname').val();
		var lastname = $('#customer_lastname').val();
		var birthday = $('#birthday').val();
		var email = $('#email').val();
		var passwd = $('#passwd').val();
		var id_country = $('#id_country').val();
		var id_state = $('#id_state').val();
		var id_city = $('#id_city').val();
		var id_state_text = $('#id_state_text').val();
		var id_city_text = $('#id_city_text').val();
		var postcode = $('#postcode').val();
		var address1 = $('#address1').val();
		var address2 = $('#address2').val();
		var phone = $('#phone').val();
		var phone_mobile = $('#phone_mobile').val();
		var other = $('#other').val();
		var show_invoice_form = $('#show_invoice_form').val();
		var same_address_data = $('#same_address_data').val();
		var company = $('#company_name').val();
		var id_country_invoice = $('#id_country_invoice').val();
		var id_state_invoice = $('#id_state_invoice').val();
		var id_city_invoice = $('#id_city_invoice').val();
		var id_state_text_invoice = $('#id_state_text_invoice').val();
		var id_city_text_invoice = $('#id_city_text_invoice').val();
		var postcode_invoice = $('#postcode_invoice').val();
		var address1_invoice = $('#address1_invoice').val();
		var address2_invoice = $('#address2_invoice').val();
		var phone_invoice = $('#phone_invoice').val();
		var phone_mobile_invoice = $('#phone_mobile_invoice').val();
		var other_invoice = $('#other_invoice').val();
		var dni = $('#dni_invoice').val();
		var vat = $('#vat_invoice').val();
		var newsletter = $('#newsletter').is(':checked');

		if (isUnselected(gender, $('#id_gender'))) { return false; }
		if (isEmpty(firstname, $('#customer_firstname'))) { return false; }
		if (isEmpty(lastname, $('#customer_lastname'))) { return false; }
		if (!isDate(birthday, $('#birthday'))) { return false; }
		if (isEmpty(email, $('#email'))) { return false; }
		if (checkEmail(email)) {
			$.growl.error({
				title: 'Errore',
				message: "Inserisci un'email valida!"
			});
			$('#email').focus();
			return false;
		}
		if (isEmpty(passwd, $('#passwd'))) { return false; }
		if (passwd.length<8) {
			$.growl.warning({
				title: 'Attenzione',
				message: 'La password deve essere almeno 8 caratteri.'
			});
			$('#passwd').focus();
			return false;
		}
		if (isUnselected(id_country, $('#id_country'))) { return false; }
		if (id_country==10) {
			if (isUnselected(id_state, $('#id_state'))) { return false; }
			if (isUnselected(id_city, $('#id_city'))) { return false; }
		} else {
			if (isEmpty(id_state_text, $('#id_state_text'))) { return false; }
			if (isEmpty(id_city_text, $('#id_city_text'))) { return false; }
		}
		if (isEmpty(postcode, $('#postcode'))) { return false; }
		if (isEmpty(address1, $('#address1'))) { return false; }
		if (empty(phone) && empty(phone_mobile))
		{
			$.growl.warning({
				title: 'Attenzione',
				message: 'Devi inserire almeno un numero di telefono fisso o di cellulare.'
			});
			$('#phone').focus();
			return false;
		}
		/*********************
		 * DATI FATTURAZIONE *
		 *********************/

		if (show_invoice_form == 1) {
			if (isUnselected(id_country_invoice, $('#id_country_invoice'))) { return false; }
			if (id_country_invoice==10) {
				if (isUnselected(id_state_invoice, $('#id_state_invoice'))) { return false; }
				if (isUnselected(id_city_invoice, $('#id_city_invoice'))) { return false; }
			} else {
				if (isEmpty(id_state_text_invoice, $('#id_state_text_invoice'))) { return false; }
				if (isEmpty(id_city_text_invoice, $('#id_city_text_invoice'))) { return false; }
			}
			if (isEmpty(postcode_invoice, $('#postcode_invoice'))) { return false; }
			if (isEmpty(address1_invoice, $('#address1_invoice'))) { return false; }
			if (empty(phone_invoice) && empty(phone_mobile_invoice))
			{
				$.growl.warning({
					title: 'Attenzione',
					message: 'Devi inserire almeno un numero di telefono fisso o di cellulare.'
				});
				$('#phone_invoice').focus();
				return false;
			}
			if (isEmpty(dni, $('#dni')) && isEmpty(vat, $('#vat'))) {
				$.growl.warning({
					title: 'Attenzione',
					message: 'Devi inserire o il Codice Fiscale o la Partita Iva.'
				});
				$('#dni').focus();
				return false;
			}
			if (id_country_invoice == 10) {
				var status = true;
				var dni = String($('#dni_invoice').val()).toUpperCase();
				if (dni.length!=16) {
					status = false;
				}
				pattern = /^[A-Z][A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][A-Z][0-9][0-9][A-Z][0-9][0-9][0-9][A-Z]$/;
				test = pattern.test(dni); 
				if (!test) {
					$.growl.warning({
						title: 'Attenzione',
						message: 'Il codice Fiscale non è corretto.'
					});
					return false;
				}
			}
		}

		console.log("end validation");
		$('#account-creation_form').submit();
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

	/** DOCUMENT READY **/
	$(document).ready(function(){
		/** GDPR ACCEPT **/
		$('#btn-gdpr').on('click', function(){
			$('#btn-save').removeClass('btn-secondary').addClass('btn-primary').prop('disabled', false);
		});
		/** SUBMIT FORM **/
		$('#btn-save').on('click', function(event){
			event.preventDefault();
			if (validate_form()) {
				if (checkEmail(email)) {
					$("#submitAccount").val("1");
					//$('#account-creation_form').submit();		
				} else {
					$.growl.error({
						title: 'ERRORE',
						message: "L'email inserita è già esistente.\nProva a inserirne un'altra o a recuperare la password."
					});
				}
			}
			return false;
		});
		/** FILL COUNTRIES **/
		fillComboCountries();
		/** FILL JOB AREA **/
		fillComboJobArea();
		/** CHECK EMAIL  **/
		$('#email').on('blur', function(){
			return checkEmail(this.value);
		});
		/** COUNTRY CHOOSE **/
		$('#id_country').on('change', function(){
			getStates(this.value, $('#id_state'));
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
		/** COUNTRY  INVOICE CHOOSE **/
		$('#id_country_invoice').on('change', function(){
			getStates(this.value, $('#id_state_invoice'));
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
		/** SHOW/HIDE INVOICE DATA **/
		$('button[name="invoice_btn"]').on('click', function(){
			if ($(this).attr('value')=="1") {
				$('#show_invoice_form').val("1");
				$('#invoice-address').fadeIn();
				this.value="1";
			} else {
				$('#show_invoice_form').val("0");
				$('#invoice-address').fadeOut();
				this.value="0";
			}
		});
		/** SAME ADDRESS **/
		$("#same_address").on('click', function(){
			$('#same_address_data').val("1");
			$('#id_country_invoice').html($('#id_country').html());
			$('#id_state_invoice').html($('#id_state').html());
			$('#id_city_invoice').html($('#id_city').html());
			$('#id_country_invoice').val($('#id_country').val());
			$('#id_state_invoice').val($('#id_state').val());
			$('#id_city_invoice').val($('#id_city').val());
			$('#postcode_invoice').val($('#postcode').val());
			$('#address1_invoice').val($('#address1').val());
			$('#address2_invoice').val($('#address2').val());
			$('#phone_invoice').val($('#phone').val());
			$('#phone_mobile_invoice').val($('#phone_mobile').val());
			$('#other_invoice').text($('#other').text());
		});
		/** DNI **/
		$('#dni_invoice').on('blur', function(){
			dni = String(this.value).toUpperCase();
			if ($('#id_country_invoice').val() == 10 && dni.length>0) {
				pattern = /^[A-Z][A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][A-Z][0-9][0-9][A-Z][0-9][0-9][0-9][A-Z]$/;
				test = pattern.test(dni); 
				if (!test) {
					$.growl.warning({
						title: 'Attenzione',
						message: 'Il codice Fiscale non è corretto.'
					});
					return false;
				}
			}
			return true;
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
	});
</script>