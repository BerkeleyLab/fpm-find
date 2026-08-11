! Copyright (c) 2026, The Regents of the University of California
! Terms of use are as specified in LICENSE.txt

program main
  !! Run the unit tests for fpm-find library functions
  use test_utilities_m, only : fmt
  use test_fpm_find_m , only : test_fpm_find
  implicit none

  integer :: tests = 0, passes = 0

  call test_fpm_find(tests, passes)

  print fmt(tests), new_line(''), passes, " of ", tests, " tests passed in total. "// "____" // new_line('')

  if (passes /= tests) error stop   "______ Some tests failed. ______"

end program main
