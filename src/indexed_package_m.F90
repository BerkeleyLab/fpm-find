module indexed_package_m
  use iso_c_binding, only : c_int
  use julienne_m, only : string_t
  implicit none

  private
  public :: indexed_package_t

  type indexed_package_t
    !! Encapslate package-specific information from the fortran-lang package_index.yml file
    private
    character(len=:), allocatable :: name_, host_, description_, categories_
    type(string_t), allocatable :: tags_(:)
    character(len=:), allocatable :: license_, version_ ! optional (zero length if not present)
  contains
    procedure package_data
  end type

  interface indexed_package_t

    pure module function new_indexed_package_from_components(name, host, description, categories, tags, license, version) &
      result(indexed_package)
      !! Construct new indexed_package_t object from components
      implicit none
      character(len=*), intent(in) :: name, host, description, categories
      type(string_t), intent(in) :: tags(:)
      character(len=*), intent(in), optional :: license, version
      type(indexed_package_t) indexed_package 
    end function

    pure module function new_indexed_package_from_lines(lines) result(indexed_package)
      !! Construct new indexed_package_t object from file lines
      implicit none
      type(string_t), intent(in) :: lines(:)
      type(indexed_package_t) indexed_package 
    end function

  end interface

  interface

    pure module function package_data(self) result(data)
      implicit none
      class(indexed_package_t), intent(in) :: self
      character(len=:), allocatable :: data
    end function

  end interface

end module indexed_package_m