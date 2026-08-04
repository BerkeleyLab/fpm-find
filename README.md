fpm-search 
----------

## A Fortran package search utility
`fpm-search` is a Fortran Package Manager (`fpm`) plugin that searches fortran-lang.org's package index.

### Installation and testing
With the Fortran Package Manager (`fpm`) and a Fortran compiler installed and in your PATH,
install `fpm-search` by running `fpm install` in a terminal window. Then run `fpm-search`
as an `fpm` plugin with a command such as
```
fpm search --find "partial-differential"
```
which shoud return each package listing that contains the string "partial-differential".

To verify a working build of `fpm-search`, run the test suite with a command like
```
fpm test --compiler flang --profile release
```
The table below lists the platform configurations tested and the flags required for each
configuration.

<div align="center">
Platforms Tested
</div>

Vendor  |Compiler  |Version(s) Tested    |OS    |Recommended `--flag` argument
--------|----------|---------------------|------|---------------------------------------------------
GCC     |`gfortran`|13-17                |macOS | `-ffree-line-length-none` for version 13
LLVM    |`flang`   |23                   |macOS | `-O3 -mmlir -allow-assumed-rank` for version 19
NAG     |`nagfor`  |7.2 Build 7238       |Linux | `-fpp -O3 -coarray`
Intel   |`ifx`     |2026.1.0 20260617    |Linux | `-fpp -O3 -coarray`
LFortran|`lfortran`|0.64.0-157-g1e0305cfd|Linux | `--cpp --realloc-lhs-arrays --separate-compilation`
