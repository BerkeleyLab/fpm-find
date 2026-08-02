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
          do concurrent(integer :: p = 1:size(indexed_packages)) default(none) shared(indexed_packages, lines, delimiters)
            indexed_packages(p) = indexed_package_t(lines(delimiters(p):delimiters(p+1)-1))
          end do
        end associate
      end associate
    end function

    pure function name_key_line_numbers(lines) result(line_numbers)
      type(string_t), intent(in) :: lines(:)
      integer, allocatable :: line_numbers(:), tmp(:)
      integer name_keys, l

      name_keys = 0
      allocate(line_numbers(name_keys))

      do l = 1, size(lines)
        if (dash_name_colon(lines(l)%string())) then
          name_keys = name_keys + 1
          if (name_keys > size(line_numbers)) then 
            call move_alloc(line_numbers, tmp)
            allocate(line_numbers(2*name_keys))
            line_numbers(1:size(tmp)) = tmp 
            deallocate(tmp)
          end if
          line_numbers(name_keys) = l
        end if
      end do

      line_numbers = line_numbers (1:name_keys)

    end function

    pure function dash_name_colon(line) result(match)
       character(len=*), intent(in) :: line
       logical match

       block
         character(len=:), allocatable :: dash_blank_etc
         dash_blank_etc = adjustl(line)
          match = dash_blank_etc(1:2) == "- " 
          if (.not. match) return
          block
            character(len=:), allocatable :: name_etc
            name_etc = adjustl(dash_blank_etc(len("- ")+1:))
            match = name_etc(1:4) == "name"
            if (.not. match) return
            block
              character(len=:), allocatable :: colon_etc
              colon_etc = adjustl(name_etc(len("name")+1:))
              match = colon_etc(1:1) == ":"
            end block
          end block
       end block
    end function

  end procedure

  module procedure as_text
    integer p

    allocate(character(len=0) :: index_as_text)

    do p = 1, size(self%packages_)
      index_as_text = index_as_text // new_line('') // self%packages_(p)%as_text()
    end do
  end procedure

  module procedure find
    integer p

    allocate(character(len=0) :: package_list)

    do p = 1, size(self%packages_)
      if (self%packages_(p)%contains(search_string)) package_list = package_list // self%packages_(p)%as_text() // new_line('')
    end do

  end procedure

end submodule package_index_s