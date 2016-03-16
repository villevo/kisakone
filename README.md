Kisakone
========

Kisakone is [Finnish Disc Golf Associations (Suomen frisbeegolfliitto ry)](http://frisbeegolfliitto.fi/)
disc golf tournament management software, which powers all the sanctioned disc golf events in Finland.

This fork is intended for disc golf club use. Code for handicapped competitions etc. has been developed during 2012-2015, 
but code hasn't been generally available. In March 2016 Tuminoid's head codes were forked and old changes
were merged here to make it available for all and easen future development.

Basic testing has been done for this fork, but it still needs some testing. This fork is not in use yet even
at [Jyli Kisakone](http://jyli.fi/kisakone)

Main differences comapred to official Kisakone:

- Handicap calculation and handicapped results
-- Rating and slope values for courses
-- A handicap is calculated from each round result
-- Handicapped results are shown in results
- Some changes to help local competition organization
-- User/competitor addition without sfl or pdga integrations
-- Usernames are automatically created for TD-added competitors, usernames may also be changed
-- User listing available for all to show handicaps (some details visible only for admin users)
-- Handicaps are used to resolve ties in leaderboard


Installation
============

See [Tuminoid's instructions](https://github.com/tuminoid/kisakone).

RoundResultHandicap and CourseRating tables are automatically added

Upgrading
=========

See [Tuminoid's instructions](https://github.com/tuminoid/kisakone).

Upgrade scripts for different versions of this fork are not yet available. But added tables have not
been changed from older versions (distributed for interested parties in various ways...) so you propably
can run official upgrades if you wish altough upgrades have not been tested properly.


Development
===========

For development, clone [kisakone-dev](https://github.com/tuminoid/kisakone-dev) at same directory level as `kisakone`.
There is ready-made setup for Vagrant VM, usable for local development.


Built with
==========

Kisakone is a legacy project, built originally with PHP 5.2, Smarty templating engine, jQuery and TinyMCE editor.

A lot of effort has been put to clean up the code and modernize the codebase for maintainability, features
and performance. Long-term plan is to continue codebase improvements, move to HTML5 with proper UTF-8 and Unicode support,
and treat mobile clients as first-class citizens by recreating user interface with responsive design, while
improving user experience by offering more logical user interface.

Current list of requirements and frameworks in use:
 - [PHP 5.3](http://www.php.net/) (use [HHVM](http://hhvm.com/), it works 100%)
 - [Smarty](http://www.smarty.net/) (latest 2.6 series, 2.6.28)
 - [jQuery](http://jquery.com/) and [jQuery UI](http://jqueryui.com/) (latest 1.x series, 1.11.2)
 - [jQuery DateTimePicker](http://trentrichardson.com/examples/timepicker/) add-on
 - [jQuery Autocomplete](https://www.devbridge.com/sourcery/components/jquery-autocomplete/) add-on
 - [TinyMCE](http://www.tinymce.com/) (latest 3.5 series)
 - [Flag-icon CSS](https://github.com/lipis/flag-icon-css)
 - [AddThisEvent](http://www.addthisevent.com/) widgets
 - [Google Analytics](http://www.google.com/analytics/) support
 - [TrackJS](http://www.trackjs.com/) support
 
 Future
===========

A completely new player level and handicap method is under development. It will be based on PDGA ratings type 
of calculation. These features will most likely be developed ready in April 2016 so stay tuned!

The new calculation is better because we don't need rating and slope values for courses and calculation
makes more sense when shorter courses are used.
