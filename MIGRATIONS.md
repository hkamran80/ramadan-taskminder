# Migrations

This document contains a list of migrations that were undertaken by Ramadan Taskminder
to update the data structure. The migration index prior to version 1.2.0 was `-1`.
The following list is in descending order.

- `0`: Add the hijri date to the date field of Qur'an entries to support hijri date
  offsets
  
  `[ "date", [ ... ] ]` => `[ [ "gregorian", "hijri" ], [ ... ] ]`
