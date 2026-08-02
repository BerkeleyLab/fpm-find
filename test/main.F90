program main
  use julienne_m, only : file_t, string_t
  use indexed_package_m, only : indexed_package_t
  use package_index_m, only : package_index_t
  implicit none

  integer p
  
  ! ______ Test data ______
  type(string_t), allocatable :: formal(:), julienne(:), assert(:), caffeine(:)
  character(len=*), parameter :: fmt = '(a)'

  formal = [ &
     string_t("- name: formal") &
    ,string_t("  github: BerkeleyLab/formal") &
    ,string_t("  description: Formulaic mimetic abstraction language") &
    ,string_t("  categories: numerical") &
    ,string_t("  tags: partial-differential-equations domain-specific-language mimetic-discretizations") &
    ,string_t("  license: BSD") &
    ,string_t("  version: 0.3.0") &
  ]
  julienne = [ &
     string_t("- name: julienne") &
    ,string_t("  github: berkeleylab/Julienne") &
    ,string_t("  description: A correctness-checking framework supporting expressive idioms for writing assertions and tests") &
    ,string_t("  categories: testing") &
    ,string_t("  tags: unit-testing assertions pure-procedure-diagnostic-output") &
    ,string_t("  version: 3.4.1") &
  ]
  assert = [ &
       string_t("- name: assert") &
      ,string_t("  url: https://github.com/BerkeleyLab/assert") &
      ,string_t("  description: A library for the run-time checking of program invariants and for providing diagnostic error output inside pure procedures") &
      ,string_t("  categories: testing") &
      ,string_t("  tags: programming-utilities learning high-performance-computing") &
      ,string_t("  license: BSD") &
  ]
  caffeine = [ &
     string_t("- name: caffeine") &
    ,string_t("  github: BerkeleyLab/Caffeine") &
    ,string_t("  description: CoArray Fortran Framework of Efficient Interfaces to Network Environments") &
    ,string_t("  categories: compiler") &
    ,string_t("  tags: parallel-runtime-library prif llvm-flang lfortran gasnet") &
  ]

  define_package_index_file_object: &
  associate( &
    berkeley_packages => file_t([ &
       string_t("# File Header") &
      ,string_t("#") &
      ,string_t("") &
      ,formal &
      ,string_t("") &
      ,string_t("# Section Header") &
      ,string_t("") &
      ,assert &
      ,string_t("") &
      ,caffeine &
      ,string_t("") &
      ,julienne &
    ]))
  
    ! ______ Test subject ______
    print fmt, "The fpm-search program output"

    ! ______ Test ______
    associate( &
           packages => package_index_t(berkeley_packages) &
      ,  assert_pkg => indexed_package_t(assert) &
      ,caffeine_pkg => indexed_package_t(caffeine) &
      ,  formal_pkg => indexed_package_t(formal) &
      ,julienne_pkg => indexed_package_t(julienne) &
    )
      print fmt,"  " // check(packages%find(  "assert")  ==   assert_pkg%as_text()) // " matching the 'assert' package index item"
      print fmt,"  " // check(packages%find("caffeine")  == caffeine_pkg%as_text()) // " matching the 'caffeine' package index item"
      print fmt,"  " // check(packages%find(  "formal")  ==   formal_pkg%as_text()) // " matching the 'formal' package index item"
      print fmt,"  " // check(packages%find("julienne")  == julienne_pkg%as_text()) // " matching the 'julienne' package index item"
      print fmt,"  " // check(packages%find("numerical") ==   formal_pkg%as_text()) // " finding a package based on category text"
      print fmt,"  " // check(packages%find("fake")      == "") // " returning zero-length text for a non-existant package search"
    end associate
  end associate define_package_index_file_object

contains

  function check(test_condition) result(outcome)
    logical, intent(in) :: test_condition
    character(len=:), allocatable :: outcome
    outcome =  merge("passes on", "FAILS  on", test_condition)
  end function
 
end program main
