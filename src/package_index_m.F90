module package_index_m
  use julienne_m, only : file_t
  use indexed_package_m, only : indexed_package_t
  implicit none

  private
  public :: package_index_t

  type, extends(file_t) :: package_index_t
    !! Encapsulate package list from from the fortran-lang package_index.yml file
    !private
    type(indexed_package_t), allocatable :: packages_(:)
  end type

  interface package_index_t

    pure module function new_index_from_file_object(yaml_file) result(package_index)
      !! Construct new package_index_t object from a file_t object representation of a fortran-lang package_index.yml file
      implicit none
      type(file_t), intent(in) :: yaml_file
      type(package_index_t) package_index
    end function

  end interface

end module package_index_m