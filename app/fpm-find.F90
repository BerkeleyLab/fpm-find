! Copyright (c) 2026, The Regents of the University of California
! Terms of use are as specified in LICENSE.txt

program fpm_find
  !! fpm plugin for searching the fortran-lang package index
  use julienne_m, only : file_t, command_line_t, string_t
  use fpm_find_m, only : package_index_t
  implicit none

  type(command_line_t) command_line

  if (command_argument_count() < 1 .or. command_line%argument_present([character(len=len("--help")) :: ("--help"), "-h"])) then
    stop                                                                                new_line('') &
      // ''                                                                          // new_line('') &
      // 'Usage:'                                                                    // new_line('') &
      // ''                                                                          // new_line('') &
      // '  fpm find [--help|-h]'                                                    // new_line('') &
      // '  fpm find  <search-string> [--name|-n] [--url|-u] [--case|-c]'            // new_line('') &
      // ''                                                                          // new_line('') &
      // 'where angular brackets indicate user input values, square brackets'        // new_line('') &
      // 'surround optional arguments, and pipes separate equivalent alternatives .' // new_line('') &
      // 'Please see the README.md file for more detailed explanations.'             // new_line('')
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

      associate( &
         name_search    => command_line%argument_present([string_t("--name"), string_t("-n")]) &
        ,url_search     => command_line%argument_present([string_t("--url" ), string_t("-u")]) &
        ,case_sensitive => command_line%argument_present([string_t("--case"), string_t("-c")]) &
      )
        associate(package_index => package_index_t(file_t(file_path // "/" // file_name)))
          associate(matching_packages => package_index%find(search_string, name_search, url_search, case_sensitive))
            print *
            if (size(matching_packages) == 0) print '(a)', "No packages found."
            block
              integer p
              do p = 1, size(matching_packages)
                print '(a)', matching_packages(p)%as_text()
              end do
            end block
            print *
            stop ! work around malloc error in gfortran 13-16
          end associate
        end associate
      end associate
    end associate define_file_path
  end block
end program fpm_find