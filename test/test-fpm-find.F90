! Copyright (c) 2026, The Regents of the University of California
! Terms of use are as specified in LICENSE.txt

module test_fpm_find_m
  !! Define unit tests for fpm-find library functions:
  !! - the `indexed_package_t` constructor,
  !! - the `package_index_t` constructor, and
  !! - the `find` type-bound function.
  use julienne_m, only : file_t, string_t
  use fpm_find_m, only : indexed_package_t, package_index_t
  use test_utilities_m, only : test, fmt
  implicit none

contains

subroutine test_fpm_find(tests, passes)
  integer, intent(inout) :: tests, passes

  ! ______ Test data ______
  define_package_index_items: &
  associate( &
    formal_entry => [ &
       string_t("- name: formal") &
      ,string_t("  github: berkeleylab/formal") &
      ,string_t("  description: Formulaic mimetic abstraction language") &
      ,string_t("  categories: numerical") &
      ,string_t("  tags: partial-differential-equations domain-specific-language mimetic-discretizations") &
      ,string_t("  license: BSD") &
      ,string_t("  version: 0.3.0") &
    ] &
    ,julienne_entry => [ &
       string_t("- name: julienne") &
      ,string_t("  github: berkeleylab/julienne") &
      ,string_t("  description: A correctness-checking framework supporting expressive idioms for writing assertions and tests") &
      ,string_t("  categories: testing") &
      ,string_t("  tags: unit-testing assertions pure-procedure-diagnostic-output") &
      ,string_t("  version: 3.4.1") &
    ] &
    ,assert_entry => [ &
         string_t("- name: assert") &
        ,string_t("  url: https://github.com/berkeleylab/assert") &
        ,string_t("  description: A library for the run-time checking of program invariants and for providing diagnostic error output inside pure procedures") &
        ,string_t("  categories: testing") &
        ,string_t("  tags: programming-utilities learning high-performance-computing") &
        ,string_t("  license: BSD") &
    ] &
    ,fiats_entry => [ &
         string_t("- name : fiats") &
        ,string_t("description : A deep learning library for use in high-performance computing applications in modern Fortran") &
        ,string_t("categories : numerical") &
        ,string_t("tags : machine-learning deep-learning high-performance-computing") &
        ,string_t("url : https://github.com/BerkeleyLab/fiats") &
    ] &
    ,caffeine_entry => [ &
       string_t("- name: caffeine") &
      ,string_t("  github: berkeleylab/caffeine") &
      ,string_t("  description: CoArray Fortran Framework of Efficient Interfaces to Network Environments") &
      ,string_t("  categories: compiler") &
      ,string_t("  tags: parallel-runtime-library prif llvm-flang lfortran gasnet") &
    ] &
  )
    define_package_index_file_object: &
    associate( &
      berkeley_packages => file_t([ &
         string_t("# File Header") &
        ,string_t("#") &
        ,formal_entry &
        ,string_t("") &
        ,string_t("# Section Header") &
        ,julienne_entry &
        ,string_t("") &
        ,assert_entry &
        ,fiats_entry &
        ,string_t("") &
        ,caffeine_entry &
      ]))

      ! ______ Test subject ______
      print '(a)', new_line('') // "The fpm 'find' plugin"

      ! ______ Tests ______
      define_index_and_package_entries: &
      associate( &
        packages => package_index_t(berkeley_packages) &
        ,caffeine_pkg => indexed_package_t(caffeine_entry) &
        ,  formal_pkg => indexed_package_t(  formal_entry) &
        ,   fiats_pkg => indexed_package_t(   fiats_entry) &
        ,julienne_pkg => indexed_package_t(julienne_entry) &
        ,  assert_pkg => indexed_package_t(  assert_entry) &
      )
        find_package_entries: &
        associate( &
           formal          => packages%find("formal"     , search_name=.false., search_url=.false., case_sensitive=.false.) &
          ,fiats           => packages%find("BerkeleyLab", search_name=.false., search_url=.true. , case_sensitive=.true. ) &
          ,caffeine        => packages%find("caffeine"   , search_name=.true. , search_url=.false., case_sensitive=.false.) &
          ,nothing         => packages%find("nonexistent", search_name=.true. , search_url=.false., case_sensitive=.false.) &
          ,julienne_assert => packages%find("assert"     , search_name=.false., search_url=.false., case_sensitive=.false.) &
        )
          block
            integer :: tests_subtotal = 0, passes_subtotal = 0

            call test(size(  formal)==1 .and.   formal(1)%as_text() ==   formal_pkg%as_text(), &
              " searching without optional arguments"     , tests_subtotal, passes_subtotal)
            call test(size(   fiats)==1 .and.    fiats(1)%as_text() ==    fiats_pkg%as_text(), &
              " searching on case-sensitive URL text via the options `--url --case`"          , tests_subtotal, passes_subtotal)
            call test(size(caffeine)==1 .and. caffeine(1)%as_text() == caffeine_pkg%as_text(), &
              " searching on package-name text via the option `--name`"                , tests_subtotal, passes_subtotal)
            call test(size( nothing)==0                                                      , &
              " finding nothing for an unlisted package", tests_subtotal, passes_subtotal)
            call test(size(julienne_assert) == 2 &
              .and.  julienne_assert(1)%as_text() ==  julienne_pkg%as_text() &
              .and.  julienne_assert(2)%as_text() ==    assert_pkg%as_text(), &
               " finding two matching packages", tests_subtotal, passes_subtotal)

            print fmt(tests), "______ ", passes_subtotal, " of ", tests_subtotal, " tests passed. ______"

            tests  = tests  + tests_subtotal
            passes = passes + passes_subtotal
          end block
        end associate find_package_entries
      end associate define_index_and_package_entries
    end associate define_package_index_file_object
  end associate define_package_index_items

end subroutine test_fpm_find

end module test_fpm_find_m
