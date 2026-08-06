! Copyright (c) 2026, The Regents of the University of California
! Terms of use are as specified in LICENSE.txt

program main
  use test_utilities_m   , only : fmt
  use test_fpm_search_m  , only : test_fpm_search
  use test_fpm_download_m, only : test_fpm_download
  implicit none

  integer :: tests = 0, passes = 0

  call test_fpm_search(tests, passes)
  call test_fpm_download(tests, passes)

  print fmt(tests), new_line(''), passes, " of ", tests, " tests passed in total. "// "____" // new_line('') 

  if (passes /= tests) error stop   "______ Some tests failed. ______"

#ifdef __GFORTRAN__
              stop ! work around gfortran 13-16 seg faults
#endif

end program main
