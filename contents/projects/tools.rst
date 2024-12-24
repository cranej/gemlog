=================
 Small CLI tools
=================
.. title:: small command line tools written in Common Lisp

Small CLI tools I wrote. Code structure follows the excellent blog_ by  **Steve**. Only tested in *SBCL*.

.. _blog: https://stevelosh.com/blog/2021/03/small-common-lisp-cli-programs/

.. contents:: Table of Contents

Downloads
=========

Please download them from codeberg__.

.. __: https://codeberg.org/cranej/lisp-clis

Range HTTP Server
=================

A HTTP server serve static files like ``python3 -m http.server`` do, but with range request ([rfc9110]_, Section 14) supports.  Code is in ``range-http.lisp``.

Build it with ``make bin/range-http`` and see the help text ``./bin/range-http --help``::

   range-http - A HTTP server serve static files with range request supported.

   USAGE: ./bin/range-http [OPTIONS]
   
   Serve static files via HTTP with range requests supported.
   
   When browsing directories, files and sub directories are listed as usual, but
   files are recognized as video files are rendered as links that when clicked,
   opens a new page which contains a <video> tag with 'src' point to that video
   file. So videos can be watched directly in browser, no other tools needed.
   
   Options:
     -h, --help            Display help and exit.
     -d DIRECTORY, --directory DIRECTORY
                           serve this directory (default: current directory)
     -p PORT, --port PORT  bind to this port (default: 4242)
     -e EXT, --ext EXT     treat files with these EXTs as video files (default:
                           (list "mp4"))
   

Implemented the full support of range request: all three forms of range-spec and ``multipart/byteranges``. 

.. [rfc9110] Fielding, R., Ed., Nottingham, M., Ed., and J. Reschke, Ed., "HTTP Semantics", STD 97, RFC 9110, DOI 10.17487/RFC9110, June 2022, <https://www.rfc-editor.org/info/rfc9110>.

六爻
====

六爻装卦、练习工具。

依赖的 ``cl-ganzhi``, 正在 release 到 ``Quicklisp`` 中， 可以先从 `这里`_ 下载。

.. _这里: https://codeberg.org/cranej/cl-ganzhi

Usage
-----

You can build it with ``make bin/liuyao``. 

::

   liuyao - ancient Chinese divination 六爻

   USAGE: ./bin/liuyao -p/--puzzle | [OPTIONS] chu er san si wu shang
   
   Each yao(爻) can be one of: lyin, lyang, yin, yang, 6, 7, 8, 9
   
   lyin and 6 means 老阴 in 六爻 terms, lyang and 9 means 老阳, yin and 8 means 阴, yang
   and 7 means 阳
   
   Options:
     -h, --help            Display help and exit.
     -t TIME-STRING, --time TIME-STRING
                           Use this time instead of now when assembling gua. Valid
                           formats are like: a single number 10 means 10 o'clock
                           today; '10:30' means today 10:30; '5 10:30' means 10:30
                           at 5th this month; '2-5 10:30' means Feb. 5th this year;
                           '2021-3-7 10:30' is a full spec which should explain
                           itself.
     -r NAME, --record-name NAME
                           Save the result by appending write it into '~/.uranai'
                           with name NAME.
     -p, --puzzle          Enter puzzle mode for practicing.
   
   Examples:
   
     进入 puzzle 模式练习手动装卦：
   
         liuyao -p
   
     装卦，起卦时间取当前时间：
   
         liuyao lyin yang yin yang lyang yin
   
     装卦，指定起卦时间为本月 12 号下午 3 点：
   
         liuyao -t "12 15" lyin yang yin yang lyang yin
   
     装卦，指定起卦时间为本月 6 月 5 号上午 8 点半，同时保存结果：
   
         liuyao -t "6-5 8:30" -r "占出行" lyin yang yin yang lyang yin

A sample output:

::

   甲辰年 丙子月 丙辰日 壬辰时 (旬空 子丑)

   天医—亥 天喜—未 贵人—亥酉 禄神—巳 羊刃—午 
   文昌—申 驿马—寅 桃花—酉 将星—子 劫煞—巳 
   华盖—辰 谋星—戌 灾煞—午 
   
   火风鼎(离・火)                             山天大畜(艮)
   青龙 　　　　　 兄弟己巳火 ——————  　         父母丙寅木 ——————  
   玄武 　　　　　 子孙己未土 ——  ——  应         官鬼丙子水 ——  ——  
   白虎 　　　　　 妻财己酉金 ——————o 　   -->   子孙丙戌土 ——  ——  
   腾蛇 　　　　　 妻财辛酉金 ——————  　         子孙甲辰土 ——————  
   勾陈 　　　　　 官鬼辛亥水 ——————  世         父母甲寅木 ——————  
   朱雀 父母己卯木 子孙辛丑土 ——  ——x 　   -->   官鬼甲子水 ——————  

Bug and Suggestion
==================
Please email me mailto:cranejin.com or open an issue on codeberg.

License
=======

Copyright 2024 "Jin, ChunHe" and contributors.

Licensed under version 3 of the GPL.

Remember that you can use GPL'ed software through their command line interfaces **without** any license-related restrictions. This repo are all command line tools, so this license doesn't affect you unless you're:

* Trying to copy the code and release a non-GPL'ed version of peat.
* Trying to use them as Lisp systems from other Lisp code (for your own sanity I urge you to not do this) and release the result under a non-GPL license.
