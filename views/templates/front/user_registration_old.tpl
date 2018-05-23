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
	.container input, .container select, .container label, .container button, .container textarea
	{
		font-family: 'Montserrat';
		font-size: 12pt;
		margin-bottom: 16px;
	}
	.container select {
		background-color: white;
		border-radius: 0.25rem;
		border: 1px solid #ced4da;
		color: #495057;
		transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
		padding-top: 5px;
		padding-bottom: 5px;
	}
	.container input {
		padding-top: 15px;
		padding-bottom: 15px;
	}
	#dni, #dni_invoice {
		text-transform: uppercase;
	}
</style>

<div class="container" style="font-family: sans-serif; font-size: 10pt;">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-body" style="font-size: 1.2em;">
					<hr>
					<span style="font-size: 1.2em"><i class="fas fa-user">&nbsp;</i>Dati del cliente</span>
					<hr>
					<div class="form-group">
						<label for="id_gender">Titolo</label>
						<br>
						<select class="select" id="id_gender" name="id_gender">
							<option value="0" selected>Seleziona</option>
							<option value="1">Sig.</option>
							<option value="2">Sig.ra</option>
						</select>
					</div>
					<div class="form-group">
						<label for="customer_firstname">Nome</label>		
						<input type="text" class="form-control" id="customer_firstname" name="customer_firstname" placeholder="Inserisci il tuo nome">
					</div>
					<div class="form-group">
						<label for="customer_lastname">Cognome</label>		
						<input type="text" class="form-control" id="customer_lastname" name="customer_lastname" placeholder="Inserisci il tuo cognome">
					</div>
					<div class="form-group">
						<label for="birthday">Data di nascita</label>
						<input type="date" class="form-control" id="birthday" name="birthday" placeholder="Data di nascita">
						<small>Per effettuare acquisti sul nostro sito, devi essere maggiorenne. Inserisci la tua data di nascita per un controllo automatico</small>
					</div>
					<br>
					<div class="form-group">
						<span><i class="fas fa-envelope"></i>&nbsp;<label for="email">Email</label></span>
						<input type="email" class="form-control" id="email" name="customer_email" placeholder="Inserisci la tua email"
							{if isset($email_customer)}
								value="{$email_customer}"
							{/if}
						>
					</div>
					<div class="form-group">
						<span><i class="fas fa-key"></i>&nbsp;<label for="passwd">Password</label></span>
						<input type="password" class="form-control" id="passwd" name="passwd" placeholder="Password">
					</div>
					<br>
					<hr>
					<!--
						*********************************
						* INDIRIZZO DI SPEDIZIONE *******
						*********************************
					-->
					<span style="font-size: 1.2em">
						<i class='fas fa-truck'></i>
						&nbsp;
						Indirizzo di spedizione
					</span>
					<hr>
					<div class="form-group" >
						<label for="id_country">Nazione</label>
						<br>
						<select class="select" id="id_country" name="id_country">
							<option selected>Seleziona</option>
						</select>
					</div>
					<div class="form-group" >
						<label for="id_state">Provincia</label>
						<br>
						<input type="text" class="form-control" id="id_state_text" name="id_state_text" style="display: none;" placeholder="Inserisci la Provincia">
						<select class="select" id="id_state" name="id_state">
							<option selected>Seleziona</option>
						</select>
					</div>
					<div class="form-group" >
						<label for="id_city">Città</label>
						<br>
						<input type="text" class="form-control" id="id_city_text" name="id_city_text" style="display: none;" placeholder="Inserisci la Città">
						<select class="select" id="id_city" name="id_city">
							<option selected>Seleziona</option>
						</select>
					</div>
					<div class="form-group" >
						<label for="postcode">Codice Postale</label>		
						<input type="text" class="form-control" id="postcode" name="postcode" placeholder="Inserisci il tuo codice postale">
					</div>
					<div class="form-group" >
						<label for="address1">Indirizzo 1</label>		
						<input type="text" class="form-control" id="address1" name="address1" placeholder="Inserisci il tuo indirizzo">
					</div>
					<div class="form-group" >
						<label for="address2">Indirizzo 2</label>		
						<input type="text" class="form-control" id="address2" name="address2" placeholder="Note per l'indirizzo">
					</div>
					<div class="form-group" >
						<span><i class="fas fa-phone"></i>&nbsp;<label for="phone">Telefono</label></span>	
						<input type="text" class="form-control" id="phone" name="phone" placeholder="Telefono fisso">
					</div>
					<div class="form-group" >
						<span><i class="fas fa-mobile-alt"></i>&nbsp;<label for="phone_mobile">Cellulare</label></span>	
						<input type="text" class="form-control" id="phone_mobile" name="phone_mobile" placeholder="Cellulare">
					</div>
					<div class="form-group" >
						<label for="other">Note</label>		
						<textarea rows=5 class="form-control col-md-12" id="other" name="other" placeholder="Eventuali comunicazioni"></textarea>
					</div>
					<div class="form-group" >
						<label for="fatturazione">Desideri la fattura?</label>		
						<button type="button" class="btn btn-primary btn-large" name="invoice_btn" value="1">
							<i class='fas fa-check'></i> SI
						</button>
						<button type="button" class="btn btn-secondary btn-large" name="invoice_btn" value="0">
							<i class='fas fa-times'></i> NO
						</button>
						<input type="hidden" name='show_invoice_form' id='show_invoice_form' value="0">
					</div>
					<!--
						***********************************
						* INDIRIZZO DI FATTURAZIONE *******
						***********************************
					-->
					<div id='invoice-address' style='display: none;'>
						<br>
						<hr>
							<span style="font-size: 1.2em">
								<i class='far fa-file-alt'></i>
								&nbsp;
								Indirizzo di fatturazione
							</span>
						<hr>
						<div class="form-group" >
							<button type="button" class="btn btn-info" id="same_address">
								<i class="far fa-address-card"></i>
								Usa gli stessi dati
							</button>
							<input type="hidden" name='same_address_data' id='same_address_data' value="0">
						</div>
						<div class="form-group" >
							<label for="company_name">Nome dell'Azienda</label>		
							<input type="text" class="form-control" id="company_name" name="company_name" placeholder="Inserisci il nome dell'Azienda">
						</div>
						<div class="form-group" >
							<label for="id_country_invoice">Nazione</label>
							<br>
							<select class="select" id="id_country_invoice" name="id_country_invoice">
								<option selected>Seleziona</option>
							</select>
						</div>
						<div class="form-group" >
							<label for="id_state_invoice">Provincia</label>
							<br>
							<input type="text" class="form-control" id="id_state_text_invoice" name="id_state_text_invoice" style="display: none;" placeholder="Inserisci la Provincia">
							<select class="select" id="id_state_invoice" name="id_state_invoice">
								<option selected>Seleziona</option>
							</select>
						</div>
						<div class="form-group" >
							<label for="id_city_invoice">Città</label>
							<br>
							<input type="text" class="form-control" id="id_city_text_invoice" name="id_city_text_invoice" style="display: none;" placeholder="Inserisci la Città">
							<select class="select" id="id_city_invoice" name="id_city_invoice">
								<option selected>Seleziona</option>
							</select>
						</div>
						<div class="form-group" >
							<label for="postcode_invoice">Codice Postale</label>		
							<input type="text" class="form-control" id="postcode_invoice" name="postcode_invoice" placeholder="Inserisci il tuo codice postale">
						</div>
						<div class="form-group" >
							<label for="address1_invoice">Indirizzo 1</label>		
							<input type="text" class="form-control" id="address1_invoice" name="address1_invoice" placeholder="Inserisci il tuo indirizzo">
						</div>
						<div class="form-group" >
							<label for="address2_invoice">Indirizzo 2</label>		
							<input type="text" class="form-control" id="address2_invoice" name="address2_invoice" placeholder="Note per l'indirizzo">
						</div>
						<div class="form-group" >
							<span><i class="fas fa-phone"></i>&nbsp;<label for="phone_invoice">Telefono</label></span>	
							<input type="text" class="form-control" id="phone_invoice" name="phone_invoice" placeholder="Telefono fisso">
						</div>
						<div class="form-group" >
							<span><i class="fas fa-mobile-alt"></i>&nbsp;<label for="phone_mobile_invoice">Cellulare</label></span>	
							<input type="text" class="form-control" id="phone_mobile_invoice" name="phone_mobile_invoice" placeholder="Cellulare">
						</div>
						<div class="form-group" >
							<label for="other_invoice">Note</label>		
							<textarea rows=5 class="form-control col-md-12" id="other_invoice" name="other_invoice" placeholder="Eventuali comunicazioni"></textarea>
						</div>
						<div class="form-group" >
							<label for="dni_invice">Codice Fiscale</label>		
							<input type="text" class="form-control" id="dni_invoice" name="dni_invoice" placeholder="Codice Fiscale">
						</div>
						<div class="form-group" >
							<label for="vat_invice">Partita IVA</label>		
							<input type="text" class="form-control" id="vat_invoice" name="vat_invoice" placeholder="Partita IVA">
						</div>
					</div>
					<div id='optional-data'>
						<br>
						<hr>
						<span style="font-size: 1.2em">
							<i class='far fa-file-alt'></i>
							&nbsp;
							Dati opzionali
						</span>
						<label class="small" style="font-size: 0.9em; text-align: justify;">
							Questi dati sono opzionali e servono esclusivamente a migliorare la tua navigazione sul 
							nostro sito. Puoi revocare questa scelta in qualsiasi momento dal tuo pannello utente, nella 
							sezione <strong>Elimina i miei dati</strong>.
						</label>
						<hr>
						<div class="form-group" >
							<label for="id_job_area">Settore</label>
							<br>
							<select class="select" id="id_job_area" name="id_job_area">
								<option value="0" selected>Seleziona</option>
							</select>
						</div>
						<div class="form-group" >
							<label for="id_job_name">Professione</label>
							<br>
							<select class="select" id="id_job_name" name="id_job_name">
								<option selected>Seleziona</option>
							</select>
						</div>
						<br>
						<div class="checkbox">
							<div class="checker" id="uniform-newsletter">
								<span>
									<input type="checkbox" name="newsletter" id="newsletter" value="1">
								</span>
							</div>
							<label for="newsletter"><strong>Iscriviti alla nostra newsletter!</strong></label>
						</div>
					</div>
				</div>
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
					<button type="button" id="btn-save" name="btn-save" class="btn btn-secondary btn-large pull-right" disabled>
						<i class="far fa-2x fa-save"></i>
						&nbsp;
						Salva
					</button>
					<input type="hidden" name="submitAccount" value="0">
					<button type="button" id="btn-gdpr" class="btn btn-warning btn-large pull-right" style="margin-right: 16px;">
						<i class="fas fa-2x fa-exclamation-circle"></i>
						&nbsp;
						Accetto
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
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