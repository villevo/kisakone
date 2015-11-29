<?php
/**
 * Suomen Frisbeegolfliitto Kisakone
 * Copyright 2015 Tuomo Tanskanen <tuomo@tanskanen.org>
 *
 * Config edidor input handler
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
 * */

require_once 'data/config.php';
require_once 'sfl/pdga_integration.php';


/**
 * Processes the edit tournament form
 * @return Nothing or Error object on error
 */
function processForm()
{
    $problems = array();

    if (!isAdmin())
        return Error::AccessDenied();

    // Check for errors
    $admin_email = $_POST[ADMIN_EMAIL];

    $email_enabled = $_POST[EMAIL_ENABLED] ? 1 : 0;
    $email_sender = $_POST[EMAIL_SENDER];
    $email_address = $_POST[EMAIL_ADDRESS];
    if ($email_enabled && !$email_sender)
        $problems[EMAIL_SENDER] = translate('FormError_NotEmptyIfEnabled');
    if ($email_enabled && !$email_address)
        $problems[EMAIL_ADDRESS] = translate('FormError_NotEmptyIfEnabled');

    $ok_licenses = array('no', 'sfl', 'internal');
    $license_check = $_POST[LICENSE_ENABLED];
    if (!in_array($license_check, $ok_licenses))
        $problems[LICENSE_ENABLED] = translate('FormError_Default');

    $sfl_enabled = $_POST[SFL_ENABLED] ? 1 : 0;
    if ($license_check == 'sfl' && !$sfl_enabled) {
        $problems[LICENSE_ENABLED] = translate('FormError_SFLNotEnabled');
        $problems[SFL_ENABLED] = translate('FormError_SFLNotEnabled');
    }

    /* SFL API is disabled
    $sfl_user = $_POST[SFL_USERNAME];
    $sfl_pass = $_POST[SFL_PASSWORD];
    if ($sfl_enabled && !$sfl_user)
        $problems[SFL_USERNAME] = translate('FormError_NotEmptyIfEnabled');
    if ($sfl_enabled && !$sfl_pass)
        $problems[SFL_PASSWORD] = translate('FormError_NotEmptyIfEnabled');

    // TODO: Check SFL API credentials
    */

    $pdga_enabled = $_POST[PDGA_ENABLED] ? 1 : 0;
    $pdga_user = $_POST[PDGA_USERNAME];
    $pdga_pass = $_POST[PDGA_PASSWORD];
    if ($pdga_enabled && !$pdga_user)
        $problems[PDGA_USERNAME] = translate('FormError_NotEmptyIfEnabled');
    if ($pdga_enabled && !$pdga_pass)
        $problems[PDGA_PASSWORD] = translate('FormError_NotEmptyIfEnabled');
    if ($pdga_enabled && !pdga_testCredentials($pdga_user, $pdga_pass))
        $problems[PDGA_ENABLED] = translate('FormError_APIFailed');

    $ok_types = array('memcached');
    $cache_enabled = $_POST[CACHE_ENABLED] ? 1 : 0;
    $cache_type = $_POST[CACHE_TYPE];
    $cache_name = $_POST[CACHE_NAME];
    $cache_host = $_POST[CACHE_HOST];
    $cache_port = $_POST[CACHE_PORT];
    if (!in_array($cache_type, $ok_types))
        $problems[CACHE_TYPE] = translate('FormError_Default');
    if ($cache_enabled && !$cache_name)
        $problems[CACHE_NAME] = translate('FormError_NotEmptyIfEnabled');
    if ($cache_enabled && !$cache_host)
        $problems[CACHE_HOST] = translate('FormError_NotEmptyIfEnabled');
    if ($cache_enabled && (!$cache_port || !is_numeric($cache_port)))
        $problems[CACHE_PORT] = translate('FormError_NotPositiveInteger');

    $trackjs_enabled = $_POST[TRACKJS_ENABLED] ? 1 : 0;
    $trackjs_token = $_POST[TRACKJS_TOKEN];
    if ($trackjs_enabled && !$trackjs_token)
        $problems[TRACKJS_TOKEN] = translate('FormError_NotEmptyIfEnabled');

    $db_log = $_POST[DEVEL_DB_LOGGING] ? 1 : 0;
    $db_die = $_POST[DEVEL_DB_DIEONERROR] ? 1 : 0;


    // Don't save if there is errors
    if (count($problems)) {
        $error = new Error();
        $error->title = 'Config form error';
        $error->function = 'InputProcessing:Config:processForm';
        $error->cause = array_keys($problems);
        $error->data = $problems;

        return $error;
    }


    // Save configs
    SetConfig(ADMIN_EMAIL, $admin_email, 'string');

    SetConfig(EMAIL_ENABLED, $email_enabled, 'int');
    SetConfig(EMAIL_ADDRESS, $email_address, 'string');
    SetConfig(EMAIL_SENDER,  $email_sender, 'string');

    SetConfig(LICENSE_ENABLED, $license_check, 'string');

    SetConfig(SFL_ENABLED,  $sfl_enabled, 'int');
    /*
    SetConfig(SFL_USERNAME, $sfl_user, 'string');
    SetConfig(SFL_PASSWORD, $sfl_pass, 'string');
    */

    SetConfig(PDGA_ENABLED,  $pdga_enabled, 'int');
    SetConfig(PDGA_USERNAME, $pdga_user, 'string');
    SetConfig(PDGA_PASSWORD, $pdga_pass, 'string');

    SetConfig(CACHE_ENABLED, $cache_enabled, 'int');
    SetConfig(CACHE_TYPE,    $cache_type, 'string');
    SetConfig(CACHE_NAME,    $cache_name, 'string');
    SetConfig(CACHE_HOST,    $cache_host, 'string');
    SetConfig(CACHE_PORT,    $cache_port, 'int');

    SetConfig(TRACKJS_ENABLED, $trackjs_enabled, 'int');
    SetConfig(TRACKJS_TOKEN,   $trackjs_token, 'string');

    SetConfig(DEVEL_DB_LOGGING,    $db_log, 'int');
    SetConfig(DEVEL_DB_DIEONERROR, $db_die, 'int');


    // Go to main admin page after success
    redirect("Location: " . url_smarty(array('page' => 'admin'), $_GET));
}