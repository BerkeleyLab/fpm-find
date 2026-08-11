! Copyright (c) 2026, The Regents of the University of California
! Terms of use are as specified in LICENSE.txt

#ifndef FPM_FIND_LANGUAGE_SUPPORT
#define FPM_FIND_LANGUAGE_SUPPORT

#ifdef __GNUC__
#  define GCC_VERSION (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__)
#else
#  define GCC_VERSION 0
#endif

#ifndef HAVE_DO_CONCURRENT_TYPE_SPEC_SUPPORT
#  if (GCC_VERSION < 160100)
#    define HAVE_DO_CONCURRENT_TYPE_SPEC_SUPPORT 0
#  else
#    define HAVE_DO_CONCURRENT_TYPE_SPEC_SUPPORT 1
#  endif
#endif

#ifndef HAVE_LOCALITY_SPECIFIER_SUPPORT
#  if (GCC_VERSION < 150100)
#    define HAVE_LOCALITY_SPECIFIER_SUPPORT 0
#  else
#    define HAVE_LOCALITY_SPECIFIER_SUPPORT 1
#  endif
#endif

#endif
