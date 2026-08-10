fpm-search 
----------

## A Fortran package search utility
`fpm-search` is a Fortran Package Manager (`fpm`) plugin that searches fortran-lang.org's package index.

Introduction
------------
The `fpm-find` tool searches the [fortran-lang] [package index].  Designed as a
[Fortran Package Manager] (`fpm`) plugin, `fpm-find` also runs as a stand-alone
program.

Installation
------------
With `fpm` installed on macOS, Linux, or Windows Subsystem for Linux, and with
your present working directory set to any directory inside the `fpm-find` source
tree, enter the following command at a command line in a terminal window:
```
fpm install --compiler <compiler-name> --profile release
```
For help with customizing aspects of your installation, such as the installation
path, run `fpm install --help` or `fpm --help` (or replace `--help `with `-h`).

The table below shows the recommended flags to include when installing.

<div align="center">
Supported Platforms
</div>

Vendor  |Compiler  |Version(s) Tested    |OS   |Recommended `--flag` argument
--------|----------|---------------------|-----|---------------------------------------------------
GCC     |`gfortran`|13-17                |macOS|`-ffree-line-length-none` for version 13
LLVM    |`flang`   |23                   |macOS|`-O3 -mmlir -allow-assumed-rank` for version 19
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
`fpm-find` in any of the above commands.

Example
--------
As of this writing, the command
```
fpm find --find julienne
```
opens `build/package_index.yml`, if present, and returns
```
- name : julienne 
description : A correctness-checking framework supporting natural-language idioms for unit testing and assertions; also facilitating formatted diagnostic output during error termination in pure procedures 
categories : programming 
tags : unit-testing assertions pure-procedure-diagnostic-output 
github : berkeleylab/julienne 
license : BSD-3-Clause 
```
Before attempting to read the package index file, `fpm-find` attempts to
download an updated copy of the file from fortran-lang's webpage repository.

Similarly, the command
```
fpm download --find julienne
```
clones Berkeley Lab's Julienne package using the information from Julienne's
package-index entry after attempting to download an up-to-date version of the
index.

Testing
-------
To test `fpm-find`, issue a command similar to the following one with your
present working directory set to anywhere inside the `fpm-find` source tree:
```
fpm test --compiler <compiler-name> --profile release
```
Include additional`fpm` flags as necessary.  For example, issue the following
command with LLVM `flang` versions 20 or higher:
```
fpm test --compiler flang --profile release
```

Documentation
-------------
With the [FORD] Fortran documentation generator installed in your `PATH` and your present
working directory set to fpm-find's root directory, run
```
ford ford.md
```
Open the generated file, `doc/html/index.html`, in a web browser to view the generated
Fpm-finder documentation.

Licensing, Support, and Contributing
-----------------------------------
Please see [LICENSE.txt] for the copyright and license under which Fpm-finder is distributed.
To report any difficulty with building, testing, or using Fpm-finder, please submit an [issue].
To contribute code, please submit a [pull request] from a fork of .

Funding
-------
Fpm-find was developed with funding from the U.S. Department of Energy, Office of Science,
Office of Advanced Scientific Computing Research via the Next-Generation Scientific
Software Technologies (NGSST) program under Contract No. DE-AC02-05CH11231.

[FORD]: https://github.com/Fortran-FOSS-Programmers/ford
[Fortran Package Manager]: https://github.com/fortran-lang/fpm
[fortran-lang]: https://github.com/fortran-lang
[issue]: https://github.com/berkeleylab/fpm-finder/issues
[LICENSE.txt]: ./LICENSE.txt
[package index]: https://raw.githubusercontent.com/fortran-lang/webpage/refs/heads/main/data/package_index.yml
[pull request]: https://github.com/berkeleylab/fpm-finder/pulls
