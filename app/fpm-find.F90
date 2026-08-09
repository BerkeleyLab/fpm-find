! Copyright (c) 2026, The Regents of the University of California
! Terms of use are as specified in LICENSE.txt

program fpm_find
  !! fpm plugin for searching the fortran-lang package index
  use julienne_m, only : file_t, command_line_t
  use fpm_find_m, only : package_index_t
  implicit none

  type(command_line_t) command_line

  if (command_argument_count() < 1 .or. command_line%argument_present([character(len=len("--help")) :: ("--help"), "-h"])) then
    stop                                 new_line('') // new_line('') &
      // 'Usage:'                     // new_line('') // new_line('') &
      // '  fpm find --help|-h'       // new_line('') &
      // '  fpm find <search-string>' // new_line('') // new_line('') &
      // 'where pipe-separated square brackets indicate alternative optional' // new_line('') &
      // 'arguments and angular brackets indicate user input values.'         // new_line('')
  end if

  block
    character(len=*), parameter :: url_base = "https://raw.githubusercontent.com/fortran-lang/webpage/refs/heads/main/data"
    character(len=*), parameter :: infix = ".local/share/fpm-find", file_name = "package_index.yml"
    character(len=:), allocatable :: search_string, default_prefix
    integer exit_status, search_string_length, prefix_length

    call get_environment_variable(name="HOME", length = prefix_length)
    allocate( character(len=prefix_length)           :: default_prefix)
    call get_environment_variable(name="HOME", value  = default_prefix)

    define_file_path: &
    associate(file_path =>  default_prefix // "/" // infix)

      call execute_command_line( &
         command = "mkdir -p " // file_path &
        ,wait = .true. &
        ,exitstat = exit_status &
      )
      call execute_command_line( &
         command = "curl --silent -L " // url_base // "/" // file_name // " > "  // file_path // "/" // file_name &
        ,wait = .true. &
        ,exitstat = exit_status &
      )
      if (exit_status /= 0) then
        call execute_command_line( &
           command  = "wget --quiet " //  url_base // "/" // file_name // " -O " // file_path // "/" // file_name &
          ,wait     = .true. &
          ,exitstat = exit_status &
        )
      end if

      call get_command_argument(number=1, length=search_string_length)
      allocate(character(len=search_string_length) :: search_string)
      call get_command_argument(number=1, value=search_string)

      associate(package_index  => package_index_t(file_t(file_path // "/" // file_name)))
        associate(search_results => package_index%find(search_string))
          if (trim(adjustl(search_results)) == "") then
            print '(a)',"No packages found."
            stop ! work around malloc error in gfortran 13-16
          else
            print '(a)', new_line('') // search_results
          end if
        end associate
      end associate
    end associate define_file_path
  end block
end program fpm_find