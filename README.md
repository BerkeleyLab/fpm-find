Fortran package search utilities
--------------------------------
This repository contains programs designed to run either as standalone utilities or as
plugins for the [Fortran Package Manager] (`fpm`):

- `fpm-search` searches fortran-lang.org's package index and
- `fpm-download` downloads software listed in the package index.

Installation
------------
With `fpm` installed on macOS, Linux, or Windows Subsystem for Linux, and with your
present working directory set to any directory inside the Fpm-search source tree,
run `fpm install` at the command line in a terminal window.  To customize aspects
of your installation, such as the installation path, run `fpm install --help`.

Usage
-----
### fpm plugin use
With `fpm` and `fpm-search` in your `PATH`, find information about packages with a
given search string in their package-index entry by running the command
```
fpm search <search-string>
```
which should return package entries that containing the case-insenstive
substring `<search-string>`, where angular-bracketed text denates user input.
To see additional usage informaiton, run `fpm search --help` (or use `-h`).

To download a package listed in the fortran-lang package index, run the command
```
fpm download <package-name>
```
where the package name is case-insensitive and defaults to `./build/dependencies`.
To see additional usage informaiton, run `fpm download --help` (or `-h`).

### Standalone use
If `fpm` is not in your `PATH`, but `fpm-search` and `fpm-download` are, run the latter
programs directory using hyphens, replacing `fpm search` and `fpm download` with
`fpm-search` and `fpm-download`.

Example
--------
As of this writing, the command
```
fpm search --find julienne
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
Before attempting to read the package index file, `fpm-search` attempts to
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
To verify a working build, clone the `fpm-search` repository and run the test suite
as follows:
```
fpm test --compiler <compiler-name> --profile release
```
The table below lists platform configurations that have been tested and the flags required
 for each configuration.

<div align="center">
Platforms Tested
</div>

Vendor  |Compiler  |Version(s) Tested    |OS   |Recommended `--flag` argument
--------|----------|---------------------|-----|---------------------------------------------------
GCC     |`gfortran`|13-17                |macOS|`-ffree-line-length-none` for version 13
LLVM    |`flang`   |23                   |macOS|`-O3 -mmlir -allow-assumed-rank` for version 19
NAG     |`nagfor`  |7.2 Build 7238       |Linux|`-fpp -O3 -coarray`
Intel   |`ifx`     |2026.1.0 20260617    |Linux|`-fpp -O3 -coarray`
LFortran|`lfortran`|0.64.0-157-g1e0305cfd|Linux|`--cpp --realloc-lhs-arrays --separate-compilation`

Documentation
-------------
With the [FORD] Fortran documentation generator installed in your `PATH` and your present
working directory set to Fpm-search's root directory, run
```
ford ford.md
```
Open the generated file, `doc/html/index.html`, in a web browser to view the generated
Fpm-search documentation.

Licensing, Support, and Contributing
-----------------------------------
Please see [LICENSE.txt] for the copyright and license under which Fpm-search is distributed.
To report any difficulty with building, testing, or using Fpm-search, please submit an [issue].
To contribute code, please submit a [pull request] from a fork of .

Funding
-------
Fpm-search was developed on funding from the U.S. Department of Energy, Office of Science,
Office of Advanced Scientific Computing Research via the Next-Generation Scientific
Software Technologies (NGSST) programs under Contract No. DE-AC02-05CH11231.

[Fortran Package Manager]: https://github.com/fortran-lang/fpm
[issue]: https://github.com/berkeleylab/fpm-search/issues
[pull request]: https://github.com/berkeleylab/fpm-search/pulls
[LICENSE.txt]: ./LICENSE.txt
[FORD]: https://github.com/Fortran-FOSS-Programmers/ford
