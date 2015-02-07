<?php
/**
 * Suomen Frisbeegolfliitto Kisakone
 * Copyright 2015 Tuomo Tanskanen <tuomo@tanskanen.org>
 *
 * Data access module for Club
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

require_once 'data/db_init.php';
require_once 'core/club.php';


function GetClub($clubid)
{
    $clubid = (int) $clubid;

    $query = format_query("SELECT id, Name, ShortName FROM :Club WHERE id = $clubid");
    $result = execute_query($query);

    if (!$result)
        return Error::Query($query);

    $retValue = null;
    if (mysql_num_rows($result) == 1)
        $retValue = new Club(mysql_fetch_assoc($result));
    mysql_free_result($result);

    return $retValue;
}


function SaveClub($clubid, $clubname, $clubshort)
{
    $clubid = (int) $clubid;
    if (!$clubname || !$clubshort)
        return null;

    $clubname = esc_or_null($clubname);
    $clubshort = esc_or_null($clubshort);

    $query = format_query("INSERT INTO :Club VALUES($clubid, $clubname, $clubshort)
                            ON DUPLICATE KEY UPDATE Name = $clubname, ShortName = $clubshort");
    $result = execute_query($query);

    if (!$result)
        return false;

    return true;
}
