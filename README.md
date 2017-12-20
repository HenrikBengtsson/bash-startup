[![Build Status](https://travis-ci.org/HenrikBengtsson/bash-startup.svg?branch=develop)](https://travis-ci.org/HenrikBengtsson/bash-startup)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/bed069f5d96b4e2ea2b3ab1a96b4b784)](https://www.codacy.com/app/HenrikBengtsson/bash-startup?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=HenrikBengtsson/bash-startup&amp;utm_campaign=Badge_Grade)

# bash-startup - Bash Startup Utility Functions

**WARNING: This is work in progress and is likely to change at anytime**


## Usage
```sh
(B[mBash Startup Utility Functions

This script defines utility functions for the Bash startup sequence,
specificially, startup_source_d() sources all _executable_ scripts in a set
of folders (recursively) conditionally on pathname-specific tags.
This script is preferrably sourced from ~/.bashrc or similar.

USAGE:
. /path/to/bash-startup [options] folder folder2 ...
. /path/to/bash-startup; startup [options] folder folder2 ...
. /path/to/bash-startup; startup_source_d folder folder2 ...

Options:
 --reset       resets timer when calling startup()

 --help        Display this help
 --version     Display version

 --dryrun      Dry run with output without sourcing anything
 --verbose     Display verbose messages
 --debug       Display debug messages ("more verbose")


EXAMPLES:
The easiest way is to source the bash-startup script with a set of folders:

  . /path/to/bash-startup ~/.bashrc.d
  . /path/to/bash-startup --debug ~/.bashrc.d
  STARTUP_DEBUG=true . /path/to/bash-startup ~/.bashrc.d

The bash-startup script can also be used to import a set of functions
(startup and startup_source_d) and then call those afterward, e.g.

  . /path/to/bash-startup
  startup /etc/bashrc
  startup --debug ~/.bashrc.d

or

  . /path/to/bash-startup
  startup_source_d /etc/bashrc
  STARTUP_DEBUG=true startup_source_d ~/.bashrc.d

FILE AND DIRECTORY NAME FILTERS:
It is only files that are _executable_ that are considered; all other
files are ignored.  Further more, files matching *~, *#, or #* are
always dropped.
Files and directories are filtered based on key-value rules incorporated
in their names.  Such key-value rules are separated by commas (,) or
folder separators (/).  The following key-value rules are supported:

 - a=x               keep if value of 'a' is 'x'
 - a=x%OR%y%OR%z     keep if value of 'a' is 'x', 'y', or 'z'
 - a!=x              keep if value of 'a' is not 'x'
 - a!=x%OR%y%OR%z    keep if value of 'a' is neither 'x', 'y', nor 'z'

where key 'a' is any environment variable or one of the following
predefined variables:

 - 'interactive'  'true' if env var 'PS1' is set, otherwise 'false'

A value 'x' must _not_ contain a folder separator (/), a period (.),
a comma (,), or any of the logical operators (%OR%).

If a pathname (path + filename) has multiple key-value pairs, then all
key-value rules must be fulfilled in order for the pathname not to be 
dropped by the filtering.  For example, file

 ~/.bashrc.d/interactive=true/z.USER!=alice%OR%bob/hello,PAPERSIZE=a4.sh

will only be used in an interactive Bash session, if the USER is neither
'alice' nor 'bob', and the PAPERSIZE is set to 'a4'.


DEBUGGING AND TESTING:
To debug what files are sourced and how long each of them takes set
STARTUP_DEBUG=1.  To perform a dry run set STARTUP_DRYRUN=1.
If calling startup(), these may be setup (temporarily) by using
options --debug and --dryrun, respectively.

Version: 0.2.2-9000
Copyright: Henrik Bengtsson (2017)
License: GPL (>= 3.0)
Source: https://github.com/HenrikBengtsson/bash-startup

```