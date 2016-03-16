<?php
/**
 * Suomen Frisbeegolfliitto Kisakone
 * Copyright 2009-2010 Kisakone projektiryhmä
 * Copyright 2013-2016 Tuomo Tanskanen <tuomo@tanskanen.org>
*
 * Data access module for Course
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

require_once 'data/db.php';
require_once 'core/hole.php';


function GetCourseHoles($courseid)
{
    $courseid = esc_or_null($courseid, 'int');

    $result = db_all("SELECT id, Course, HoleNumber, HoleText, Par, Length
                            FROM :Hole
                            WHERE Course = $courseid
                            ORDER BY HoleNumber");

    if (db_is_error($result))
        return $result;

    $retValue = array();
    foreach ($result as $row)
        $retValue[] = new Hole($row);

    return $retValue;
}


function CourseUsed($courseid)
{
    $courseid = esc_or_null($courseid, 'int');

    return count(db_one("SELECT id FROM :Round WHERE :Round.Course = $courseid LIMIT 1"));
}


function GetCourses()
{
    return db_all("SELECT id, Name, Event FROM :Course ORDER BY Name");
}


function GetCourseDetails($id)
{
    $id = esc_or_null($id, 'int');
    return db_one("SELECT :Course.id AS id, Name, Description, Link, Map, Event, Rating, Slope FROM :Course LEFT JOIN :CourseRating on :Course.id=Course WHERE :Course.id = $id");
}


function SaveCourse($course)
{
    $name = esc_or_null($course['Name'], 'string');
    $description = esc_or_null($course['Description'], 'string');
    $link = esc_or_null($course['Link'], 'string');
    $map = esc_or_null($course['Map'], 'string');

    if ($course['id']) {
        $id = esc_or_null($course['id'], 'int');

        return db_exec("UPDATE :Course
                                SET Name = $name, Description = $description, Link = $link, Map = $map
                                WHERE id = $id");
    }

    $eventid = esc_or_null(@$course['Event'], 'int');

    return db_exec("INSERT INTO :Course (Name, Description, Link, Map, Event)
                            VALUES ($name, $description, $link, $map, $eventid)");
}

/*HCP*/
function SaveCourseRating($id,$course) {

    if ($course['Rating'] > 0 && $course['Slope'] > 0) {

		$rating = $course['Rating'];
		$slope = $course['Slope'];
		
		$query = format_query("SELECT id FROM :CourseRating WHERE Course = $id");
		$result = db_all($query);
		
		if (count($result) > 0) {
			$query = format_query("UPDATE :CourseRating
					SET Rating = $rating, Slope = $slope
					WHERE Course = $id");
			$result = db_exec($query);	
		} else {
			$query = format_query("INSERT INTO :CourseRating (Course,Rating,Slope )
					VALUES ($id,$rating,$slope)");
			$result = db_exec($query);
			if (!$result)
				return Error::Query($query);		
		}
    }
}

function DeleteCourse($id)
{
    $id = esc_or_null($id, 'int');

    db_exec("DELETE FROM :Hole WHERE Course = $id");
    db_exec("DELETE FROM :Course WHERE id = $id");
}
