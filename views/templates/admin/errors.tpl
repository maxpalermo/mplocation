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

{if isset($errors) && $errors}
	<div class="alert alert-danger">
		{assign var=tot_err value=$errors|@count}
		<p>{if $tot_err > 1}{l s='There are %d errors:'  mod='mpcustomization' sprintf=$tot_err}{else}{l s='There is %d error'  mod='mpcustomization' sprintf=$tot_err}{/if}</p>
		<ol>
		{foreach from=$errors key=k item=error}
			<li>{$error}</li>
		{/foreach}
		</ol>
	</div>
{/if}

{if isset($confirmations) && $confirmations}
	<div class="alert alert-success">
		{assign var=tot_msg value=$confirmations|@count}
		{if  $tot_msg > 1}<p>{l s='There are %d messages'  mod='mpcustomization' sprintf= $tot_msg}</p>{/if}
		<ol>
		{foreach from=$confirmations key=k item=confirmation}
			<li>{$confirmation}</li>
		{/foreach}
		</ol>
	</div>
{/if}
