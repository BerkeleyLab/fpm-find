submodule(package_index_m) package_index_s
  use julienne_m, only : string_t
  implicit none

contains

  module procedure new_index_from_file_object

    package_index%file_t = yaml_file
    package_index%packages_ = extract_packages(yaml_file)

  contains

    pure function extract_packages(file) result(indexed_packages)
      type(file_t), intent(in) :: file
      type(indexed_package_t), allocatable :: indexed_packages(:)

      associate(lines => file%lines())
        associate(delimiters => [name_key_line_numbers(lines),size(lines)+1])
          allocate(indexed_packages(size(delimiters)-1))
          !do concurrent(integer :: p = 1:size(indexed_packages)) default(none) shared(package_index%packages_, lines, delimiters)
          !  package_index%packages_(p) = indexed_package_t(lines(delimiters(p):delimiters(p+1)-1))
          !end do
        end associate
      end associate
    end function

    pure function name_key_line_numbers(lines) result(locations)
      type(string_t), intent(in) :: lines(:)
      integer, allocatable :: locations(:), tmp(:)
      integer num_keys, l

      !num_keys = 0
      !allocate(locations(num_keys))

      !do l = 1, size(lines)
      !  associate(line => lines(l)%string())
      !    if (line(1:6) == "- name") then
      !      num_keys = num_keys + 1
      !      if (num_keys > size(locations)) then 
      !        call move_alloc(locations, tmp)
      !        allocate(locations(2*num_keys))
      !        locations(1:size(tmp)) = tmp 
      !        deallocate(tmp)
      !      end if
      !    end if
      !  end associate
      !end do

      !locations = locations(1:num_keys)

    end function

  end procedure

end submodule package_index_s