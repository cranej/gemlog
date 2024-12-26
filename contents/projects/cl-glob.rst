=========
 cl-glob
=========
.. title:: cl-glob: Unix style pathname pattern expansion

Abstract
========

``cl-glob`` implements Unix shell style pattern matching and pathname globbing
in Common Lisp.

``glob`` pattern matching *does not* have a clearly defined and broadly followed behavior. Python's glob module, Rust's glob crate, and Bash's glob expansion all
work differently. Please read the Api document of ``glob-matches`` function for the
detailed matching rules.

Currently ``cl-glob`` is *not* a fast implementation compare to ``c``. It uses Common Lisp's pathname Api and try its best to not manipulate pathname as string, for better portability. For now on my machine (a cheap NUC released 5 years ago), walking and matching a directory contains 9436 entries cost ~0.175 seconds. Further Optimization will be done in further releases.

The Api interface is stable already. 

.. contents:: Table Of Contents

Download
========

Please download it from codeberg__.

.. __: https://codeberg.org/cranej/cl-glob

Api
===

Functions
---------

* ``(glob pathname &optional root)``

  Return a possibly empty list of path names that match ``pathname``, which must be
  a string containing a path specification. Pathname can be either absolute
  (like ``/home/user1/lisp/**/*.lisp``) or relative (like ``../../Tools/*/*.gif``), and
  can contain shell-style wildcards.
  
  If ``root`` is specified, it has the same effect on glob as changing the current
  directory before calling it.
  
  If ``pathname`` is relative, the result returned are paths relative to ``root``.
  
  Example 1::
  
    (glob "/home/user1/lisp/**/*.lisp")
    
  Output::
  
    (#P"/home/user1/lisp/cl-template/cl-template.lisp"
     #P"/home/user1/lisp/pcl/id3/id3.lisp")
  
  Example 2 (pathname is relative)::
  
    (glob "*.lisp")
  
  Output::
    
    (#P"cl-glob.lisp"
     #P"packages.lisp"
     #P"tests.lisp")
  
  Example 3 (pathname like '../' are preserved in result)::
  
    (glob "*.lisp" "../mokubune/")
  
  Output::
  
    (#P"../mokubune/init.lisp"
     #P"../mokubune/mokubune.lisp"
     #P"../mokubune/packages.lisp"
     #P"../mokubune/version.lisp")
  
* ``(glob-matches pattern pathname)``

  Return ``t`` if pathname matches pattern.

  - ``?`` matches any single character except file path separator.
  - ``*`` matches zero or more characters except file path separator.
  - A leading ``**`` followed by a slash (``**/a``), or ``**`` between slashes (``a/**/b``)  matches zero or more directory components.
  - A trailing ``**`` (``a/**``) matches anything remain.
  - Other forms of ``**`` are treated as a single ``*``. For example ``abc/**b/Makefile`` is the same as ``abc/*b/Makefile``, and ``abc/**.gif``is the same as ``abc/*.gif``.
  - ``[...]`` matches any single character inside the brackets. Character
    sequences can also specify ranges of characters, as ordered by Unicode.
    For example, ``[0-9a-z?*]`` matches a single character which is ``?`` or ``*`` or is
    between ``0`` and ``9`` or is between ``a`` and ``z``. 
  - ``[!...]`` matches the opposite of ``[...]`` - matches any single character not in the brackets.
  - All other characters in pattern matches literally.
  
* ``(glob-matches-compiled compiled-pattern pathname)``

  Same as ``glob-matches``, except that first argument is a compiled pattern (via function ``compile-pattern``).
  
* ``(compile-pattern pattern)``

  Compile the pattern. 

  Output object should only be used as parameters of other Apis. Internal structure
  of the output object is subject to change, thus should not be depended directly.

Bug and Suggestion
==================
Please email me mailto:cranejin.com or open an issue on codeberg.

License
=======

``cl-glob`` comes with a MIT license.


