Upgrading to version xxxxx:
================================

We need to create a new `:Club` table and also add `SflId` to `:User` table.  
Upgrade script will read your database settings from `config.php`, no changes required.

1. Check `upgrade.sql` for intended SQL changes.
2. While in this upgrade directory, run `php upgrade.php`

It should print no output on success.