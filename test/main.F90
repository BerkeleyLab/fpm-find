program main
  use julienne_m, only : file_t, string_t
  use package_index_m, only : package_index_t
  implicit none

  integer package_count

  print '(a)', "The fortran-lang 'package_index.yml' reader"

  associate(packages => package_index_t(berkeley_packages()))
  end associate

contains

  pure function berkeley_packages() result(yaml_file)
    type(file_t) yaml_file

    yaml_file = file_t([ &
       string_t("# File Header") &
      ,string_t("#") &
      ,string_t("") &
      ,string_t("- name: formal") &
      ,string_t("  github: BerkeleyLab/formal") &
      ,string_t("  description: Formulaic mimetic abstraction language") &
      ,string_t("  categories: numerical") &
      ,string_t("  tags: machine-learning deep-learning high-performance-computing") &
      ,string_t("  license: BSD") &
      ,string_t("  version: 0.3.0") &
      ,string_t("") &
      ,string_t("# Section Header") &
      ,string_t("") &
      ,string_t("- name: assert") &
      ,string_t("  github: BerkeleyLab/assert") &
      ,string_t("  description: Formulaic mimetic abstraction language") &
      ,string_t("  categories: numerical") &
      ,string_t("  tags: machine-learning deep-learning high-performance-computing") &
      ,string_t("  license: BSD") &
      ,string_t("") &
      ,string_t("- name: julienne") &
      ,string_t("  github: BerkeleyLab/julienne") &
      ,string_t("  description: A correctness-checking framework supporting expressive idioms for writing assertions and tests") &
      ,string_t("  categories: testing") &
      ,string_t("  tags: unit-testing assertions diagnostics") &
      ,string_t("  version: 3.4.1") &
      ,string_t("") &
      ,string_t("- name: caffeine") &
      ,string_t("  github: BerkeleyLab/Caffeine") &
      ,string_t("  description: CoArray Fortran Framework of Efficient Interfaces to Network Environments") &
      ,string_t("  categories: testing") &
      ,string_t("  tags: unit-testing assertions diagnostics") &
    ])
  end function

end program main
