! Copyright (c) 2026, The Regents of the University of California
! Terms of use are as specified in LICENSE.txt

module test_utilities_m
  implicit none

  private
  public :: test
  public :: fmt

contains

  subroutine test(test_condition, test_description, num_tests, num_passes)
    logical, intent(in) :: test_condition
    integer, intent(inout) :: num_tests, num_passes
    character(len=*), intent(in) :: test_description
    print '(a)', "  " // merge("passes on", "FAILS  on", test_condition)// test_description
    num_tests = num_tests + 1
    num_passes = num_passes + merge(1, 0, test_condition)
  end subroutine

  pure function fmt(num_tests)
    integer, intent(in) :: num_tests
    character(len=:), allocatable :: fmt
    select case(num_tests)
    case(0:9)
      fmt = "(*(a,i1))"
    case(10-99)
      fmt = "(*(a,i2))"
    case(100-999)
      fmt = "(*(a,i3))"
    case(1000-9999)
      fmt = "(*(a,i4))"
    case default
      fmt = "(*(a,i9))"
    end select
  end function

end module test_utilities_m
