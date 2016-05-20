{*
 * Suomen Frisbeegolfliitto Kisakone
 * Copyright 2009-2010 Kisakone projektiryhmä
 * Copyright 2014-2015 Tuomo Tanskanen <tuomo@tanskanen.org>
 *
 * Login box/login information
 *
 * --
 *
 * This file is part of Kisakone.
 * Kisakone is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Kisakone is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Kisakone.  If not, see <http://www.gnu.org/licenses/>.
 * *}
{if $user eq null}
<div class="loginbox loginbox_outer" id="login_panel">
    <a id="login_link" href="{url page='login'}"><i class="fa fa-sign-in fa-2x"></i> &nbsp;&nbsp;{translate id=login}</a>
	<br>
    <a id="register_link" href="{url page='register'}"><i class="fa fa-user-plus fa-2x"></i> &nbsp;{translate id=register}</a>

</div>
<form class="loginbox hidden" action="{$url_base}" id="login_form" method="post">
    <input type="hidden" name="comingFrom" value="{$smarty.server.REQUEST_URI|escape}" />
    <a id="loginform_x" href="" class="dialogx" ><i class=" red_class fa fa-times fa-2x" aria-hidden="true"></i></a>
	<br>
    <input type="hidden" name="loginAt" value="{$smarty.now}" />
    <input type="hidden" name="formid" value="login" />

    <div>
        <label for="loginUsernameInput"><i class="fa fa-user"></i>&nbsp;{translate id='username'}</label>
        <input type="text" name="username" id="loginUsernameInput" />
    </div>
	<br>
    <div>
        <label for="loginPassword"><i class="fa fa-key"></i>&nbsp;{translate id='password'}</label>
        <input type="password" id="loginPassword" name="password" />
    </div>

    <div>
        <input id="loginRememberMe" type="checkbox" name="rememberMe" />
        <label for="loginRememberMe">{translate id='rememberme'}</label>
        <input id="loginSubmit" type="submit" value="{translate id='loginbutton'}" />
    </div>
	<br>
	<br>
    <div>
        <a href="{url page='register'}"><i class="fa fa-user-plus"></i>&nbsp;{translate id=register}</a> 
		<br>
        <a href="{url page='recoverpassword'}"><i class="fa fa-undo" aria-hidden="true"></i> &nbsp;{translate id=forgottenpassword}</a>
		<br>
    </div>
</form>
{else}
    <div class="loginbox logininfo">
		<div>{translate id='loginform_loggedin_title'}</div>
		<div>{translate id='loginform_loggedin_as' user=$user->username firstname=$user->firstname lastname=$user->lastname}</div>
        <p>
            <a id="loginMyInfo" href="{url page=myinfo}"><i class="fa fa-user fa-2x" aria-hidden="true"></i>&nbsp;{translate id='my_info'}</a>
			<br>
            <a id="logout" href="{$url_base}?action=logout"><i class="fa fa-sign-out fa-2x" aria-hidden="true"></i>&nbsp;{translate id='logout'}</a>
        </p>
    </div>
{/if}
