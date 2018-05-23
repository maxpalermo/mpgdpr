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
			<i class='fas fa-question-circle'></i>
			&nbsp;
			{l s='Optional informations' mod='mpgdpr'}
		</span>
		<br>
		<label class="small" style="font-size: 0.9em; text-align: justify;">
			Questi dati sono opzionali e servono esclusivamente a migliorare la tua navigazione sul 
			nostro sito. Puoi revocare questa scelta in qualsiasi momento dal tuo pannello utente, nella 
			sezione <strong>Elimina i miei dati</strong>.
		</label>
	</div>
	<div class="card-body">
		<div class="form-group" >
			<label for="id_job_area">Settore</label>
			<br>
			<select class="select" id="id_job_area">
				<option value="0">{l s='Please select a job area' mod='mpgdpr'}</option>
				{foreach $job_areas as $job_area}
					<option value="{$job_area.id_mp_customer_job_area}">{$job_area.name}</option>
				{/foreach}
			</select>
		</div>
		<div class="form-group" >
			<label for="id_job_name">Professione</label>
			<br>
			<select class="select" id="id_job_name">
				<option selected>Seleziona</option>
			</select>
		</div>
		<br>
		<div class="form-group" >
			<label>{l s='Subscribe to our newsletter!' mod='mpgdpr'}</label>
			<br>	
			<button type="button" class="btn btn-outline-primary btn-large" id="newsletter_on" value="1">
				<i class='fas fa-check'></i> {l s='YES' mod='mpgdpr'}
			</button>
			<button type="button" class="btn btn-outline-primary btn-large" id="newsletter_off" value="2">
				<i class='fas fa-times'></i> {l s='NO' mod='mpgdpr'}
			</button>
			<input type="hidden" id='newsletter' value="0">
		</div>
	</div>	
</div>