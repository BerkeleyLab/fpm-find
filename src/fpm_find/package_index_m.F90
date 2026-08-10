! Copyright (c) 2026, The Regents of the University of California
! Terms of use are as specified in LICENSE.txt

module package_index_m
  !! Define an abstraction for the fortran-lang package index
  use julienne_m, only : file_t
  use indexed_package_m, only : indexed_package_t
  implicit none

  private
  public :: package_index_t

  type, extends(file_t) :: package_index_t
    !! Encapsulate package list from from the fortran-lang package_index.yml file
    private
    type(indexed_package_t), allocatable :: packages_(:)
  contains
    procedure find 
  end type

  interface package_index_t

    pure module function new_index_from_file_object(yaml_file) result(package_index)
      !! Construct new package_index_t object from a file_t object representation of a fortran-lang package_index.yml file
      implicit none
      type(file_t), intent(in) :: yaml_file
      type(package_index_t) package_index
    end function

  end interface

  interface
 
    pure module function find(self, search_string, search_name, search_url, case_sensitive) result(package_list)
      !! Result is a listing of the packages that have entries containing the provided search_string
      implicit none
      class(package_index_t), intent(in) :: self
      character(len=*), intent(in) :: search_string
      logical, intent(in) :: search_name, search_url, case_sensitive
      type(indexed_package_t), allocatable :: package_list(:)
    end function

  end interface

end module package_index_m