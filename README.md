fpm-find
========

A Fortran package search tool

Introduction
------------
The fpm-find tool searches the [fortran-lang] [package index].  Designed as a
[Fortran Package Manager] (`fpm`) plugin, fpm-find also runs as a stand-alone
program.

Installation
------------
With `fpm` installed on macOS, Linux, or Windows Subsystem for Linux, and with
your present working directory set to any directory inside the fpm-find source
tree, enter the following at a terminal-window command line:
```
fpm install --compiler <compiler-name> --profile release
```
For help with customizing aspects of your installation, such as the installation
path, run `fpm install --help` or `fpm --help` (or replace `--help `with `-h`).

### Supported Platforms

Vendor  |Compiler  |Version(s) Tested    |OS   |Recommended `--flag` argument
--------|----------|---------------------|-----|---------------------------------------------------
GCC     |`gfortran`|13-17                |macOS|`-ffree-line-length-none` for version 13
LLVM    |`flang`   |23                   |macOS|`-mmlir -allow-assumed-rank` for version 19
NAG     |`nagfor`  |7.2 Build 7238       |Linux|`-fpp -O3 -coarray`
Intel   |`ifx`     |2026.1.0 20260617    |Linux|`-fpp -O3 -coarray`
LFortran|`lfortran`|0.64.0-157-g1e0305cfd|Linux|`--cpp --realloc-lhs-arrays --separate-compilation`

Usage
-----
### fpm plugin use
With `fpm` and `fpm-find` in your `PATH`, search for information about packages
that have a given string in their package-index entry by running a command of the
following form:
```
fpm find <search-string> [--url|-u] [--name|-n] [--case|-c]
```
where angular brackets demarcate user input, square brackets indicate optional
arguments, and pipes (`|`) separate equivalent alternatives.  The table below
provides more detailed explanations.

Flag    |Shortcut|Effect
--------|--------|------------------------------------------------------------------
`--url `| `-u`   |Search only package URLs and other categories specified by a flag
`--name`| `-n`   |Search only package names and other categories specified by a flag
`--case`| `-c`   |Make the search case-sensitive

### Stand-alone use
If `fpm` is not in your `PATH` but `fpm-find` is, replace `fpm find` with
`fpm-find` in any commands in this document.

### Examples
```
fpm find numerical         # search of all package data for "numerical"
fpm find julienne --name   # search of package names for "julienne"
fpm find nasa --url --name # search of package names and URLS for "nasa"
fpm find BerkeleyLab -u -c # case-sensitive search of package URLS for "BerkeleyLab"
```
Before accessing the index installed in `$HOME/.local/share/package_index.yml`,
`fpm-find` tries to update the index by downloading it from fortran-lang.

Testing
-------
Test `fpm-find` by issuing a command similar to the following one with your
present working directory set to anywhere inside the `fpm-find` source tree:
```
fpm test --compiler <compiler-name> --profile release
```
Add compiler-specific flags from the [Supported platforms] table as needed.
For example, with a [Homebrew]-installed `gfortran-13`, execute
```
fpm test --compiler gfortran-13 --profile release --flag -ffree-line-length-none
```

Documentation
-------------
With the [FORD] Fortran documentation generator installed in your `PATH` and your present
working directory set to fpm-find's root directory, run
```
ford ford.md
```
Open the generated file, `doc/html/index.html`, in a web browser to view the
`fpm-find` documentation.

Licensing, Support, and Contributing
------------------------------------
Please see [LICENSE.txt] for the copyright and license under which fpm-find is
distributed.  To report any issues with building, testing, or using fpm-find,
please submit an [issue].  To contribute code, please submit a [pull request]
from a fork of fpm-find.

Funding
-------
fpm-find was developed with funding from the U.S. Department of Energy, Office
of Science, Office of Advanced Scientific Computing Research via the Next-
Generation Scientific Software Technologies (NGSST) program under Contract No.
DE-AC02-05CH11231.

[FORD]: https://github.com/Fortran-FOSS-Programmers/ford
[Fortran Package Manager]: https://github.com/fortran-lang/fpm
[fortran-lang]: https://github.com/fortran-lang
[Homebrew]: https://brew.sh
[issue]: https://github.com/berkeleylab/fpm-find/issues
[LICENSE.txt]: ./LICENSE.txt
[package index]: https://raw.githubusercontent.com/fortran-lang/webpage/refs/heads/main/data/package_index.yml
[pull request]: https://github.com/berkeleylab/fpm-find/pulls
[Supported platforms]: #supported-platforms
