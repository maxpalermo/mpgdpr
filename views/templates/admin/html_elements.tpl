{*
* 2007-2018 PrestaShop
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
*  @author    Massimiliano Palermo <info@mpsoft.it>
*  @copyright 2007-2018 Digital Solutions®
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{if $element == 'badge'}
	<span class="badge" style="{if $background}background-color: {$background|escape:'htmlall':'UTF-8'};{/if}{if $color}color: {$color|escape:'htmlall':'UTF-8'};{/if}">{$value}</span>
{/if}
{if $element == 'button'}
	<button {if $name}name="{$name|escape:'htmlall':'UTF-8'}"{/if} type="button" class="btn btn-default" onclick="{$callback|escape:'htmlall':'UTF-8'}">
	    <i class="{$icon|escape:'htmlall':'UTF-8'}" {if $color}style="color: {$color|escape:'htmlall':'UTF-8'};"{/if}></i>
	    {if $title}{$title|escape:'htmlall':'UTF-8'}{/if}
	</button>
{/if}
{if $element == 'icon'}
	<i {if $name}name="{$name|escape:'htmlall':'UTF-8'}"{/if} class="icon {$icon|escape:'htmlall':'UTF-8'}" {if $color}style="color: {$color|escape:'htmlall':'UTF-8'};{/if}"></i>
	{if $title}&nbs&nbsp;$title|escape:'htmlall':'UTF-8'{/if}
{/if}
{if $element == 'image'}
	<img src='{$image.source}' style='{if !empty($image.width)}width: {$image.width|escape:'htmlall':'UTF-8'}; {/if}{if !empty($image.height)}height: {$image.height|escape:'htmlall':'UTF-8'};{/if} object-fit: content;'>
{/if}
{if $element == 'link-button'}
	<a {if $name}name="{$name|escape:'htmlall':'UTF-8'}"{/if} class="btn btn-default" href="{$href}">
	    <i class="icon {$icon|escape:'htmlall':'UTF-8'}" {if $color}style="color: {$color|escape:'htmlall':'UTF-8'};"{/if}></i>
	    {if $title}&nbsp;{$title|escape:'htmlall':'UTF-8'}{/if}
	</a>
{/if}
{if $element == 'option'}
	{foreach $rows as $row}
	    <option value='{$row.value|escape:'htmlall':'UTF-8'}'>{$row.name|escape:'htmlall':'UTF-8'}</option>
	{/foreach}
{/if}
{if $element == 'select'}
	<select name="{$name|escape:'htmlall':'UTF-8'}" {if $id}id="{$id}"{/if} class="select {if $chosen}chosen{/if}" {if $multiple}multiple{/if}>
	    {if $select_first}
	    	<option value='0'>{$select_first|escape:'htmlall':'UTF-8'}</option>
	    {/if}
	    {if isset($options.query)}
		    {foreach $options.query as $option}
		        <option value="{$option[$options.key]|escape:'htmlall':'UTF-8'}">{$option[$options.value]|escape:'htmlall':'UTF-8'}</option>
		    {/foreach}
		{/if}
	</select>
{/if}
{if $element == 'span'}
	<span {if isset($style)}
	        style="
	        {foreach $style as $key=>$val}
	            {$key|escape:'htmlall':'UTF-8'} : {$val|escape:'htmlall':'UTF-8'};
	         {/foreach}
	        "
	    {/if}
	    >
	    {$value|escape:'htmlall':'UTF-8'}
	</span>
{/if}
{if $element == 'text'}
	<input
	    type='text'
	    name="{$name|escape:'htmlall':'UTF-8'}"
	    {if $id}
	        id="{$id|escape:'htmlall':'UTF-8'}"
	    {/if}
	    {if $class}
	        class="{$class|escape:'htmlall':'UTF-8'}"
	    {else}
	        class="input"
	    {/if}
	    value="{$value|escape:'htmlall':'UTF-8'}"
	    {if $color}
	    style="color: {$color|escape:'htmlall':'UTF-8'};"
	    {/if}
    >
{/if}

