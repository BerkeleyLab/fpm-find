! Copyright (c) 2026, The Regents of the University of California
! Terms of use are as specified in LICENSE.txt

program unit_tests
  !! Test the package-search library functions
  use julienne_m, only : file_t, string_t
  use fpm_search_m, only : indexed_package_t, package_index_t
  use test_utilities_m, only : test, fmt
  implicit none

  ! ______ Test data ______
  define_package_index_items: &
  associate( &
    veggies => [ &
       string_t("- name: veggies") &
      ,string_t("  gitlab: everythingfunctional/veggies") &
      ,string_t("  description: A Fortran testing framework written using functional programming principles.") &
      ,string_t("  categories: programming") &
      ,string_t("  tags: testing assert") &
    ] &
    ,pfunit => [ &
       string_t("- name: pFUnit") &
      ,string_t("  github: Goddard-Fortran-Ecosystem/pFUnit") &
      ,string_t("  description: Parallel Fortran Unit Testing Framework") &
      ,string_t("  categories: programming") &
      ,string_t("  tags: unit testing") &
      ,string_t("  license: NASA-1.3") &
    ] &
    ,findent => [ &
       string_t("- name: findent") &
      ,string_t("  url: https://sourceforge.net/projects/findent/") &
      ,string_t("  description: Indents/beautifies/converts Fortran sources") &
      ,string_t("  categories: programming") &
      ,string_t("  tags: formatter converter") &
      ,string_t("  license: BSD-3-Clause") &
      ,string_t("  version: 3.1.7") &
    ] &
  )
    define_package_index_file_object: &
    associate( &
      some_packages => file_t([ &
         string_t("# File Header") &
        ,string_t("#") &
        ,pFUnit &
        ,veggies &
        ,findent &
      ]))

      ! ______ Test subject ______
      print '(a)', new_line('') // "The 'download --package' feature"

      ! ______ Tests ______
      define_index_and_package_entries: &
      associate( &
                packages => package_index_t(some_packages) &
        , pFUnit_package => indexed_package_t(pFUnit) &
        ,veggies_package => indexed_package_t(veggies) &
        ,findent_package => indexed_package_t(findent) &
      )
        capture_package_entry_text: &
        associate( &
            pFUnit_url =>  pFUnit_package%url() &
          ,veggies_url => veggies_package%url() &
          ,findent_url => findent_package%url() &
        )
          block
            integer :: tests = 0, passes = 0

            call test( &
              packages%url("pFUnit")  == "https://github.com/Goddard-Fortran-Ecosystem/pFUnit", &
              " forming a correct GitHub URL", tests, passes &
            )
            call test( &
              packages%url("veggies") == "https://gitlab.com/everythingfunctional/veggies", &
              " forming a correct GitLab URL", tests, passes &
            )
            call test( &
              packages%url("findent") == "https://sourceforge.net/projects/findent/", &
              " getting a correct sourceforge URL", tests, passes)

            if (passes /= tests) then
              print fmt(tests), "______ ", tests - passes, " of ", tests, " tests failed. ______"
              error stop
            else
              print fmt(tests), "All ", tests, " tests passed." // new_line('')
#ifdef __GFORTRAN__
              stop ! work around gfortran 13-16 seg faults
#endif
            end if
          end block
        end associate capture_package_entry_text
      end associate define_index_and_package_entries
    end associate define_package_index_file_object
  end associate define_package_index_items

end program unit_tests
