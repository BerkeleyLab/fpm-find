submodule(indexed_package_m) indexed_package_s
  implicit none

  interface get_key_value
    module procedure get_key_value_from_character_mold
    module procedure get_key_value_from_string_mold
    module procedure get_array_key_value_from_character_mold
  end interface

contains

  module procedure new_indexed_package_from_components
    indexed_package%name_        = name
    indexed_package%host_        = host
    indexed_package%description_ = description
    indexed_package%categories_  = categories
    indexed_package%tags_        = tags

    if (present(license)) then
      indexed_package%license_ = license
    else
      allocate(character(len=0) :: indexed_package%license_)
    end if

    if (present(version)) then
      indexed_package%version_ = version
    else
      allocate(character(len=0) :: indexed_package%version_)
    end if
  end procedure

  pure function after(substring, line) result(characters_after_substring)
    character(len=*), intent(in) :: substring, line
    character(len=:), allocatable :: characters_after_substring
    associate(location => index(line, substring))
      if (location == 0) then
        characters_after_substring = ""
      else 
        characters_after_substring = line(location+1:)
      end if
    end associate
  end function

  pure function before(substring, line) result(characters_before_substring)
    character(len=*), intent(in) :: substring, line
    character(len=:), allocatable :: characters_before_substring
    associate(location => index(line, substring))
      if (location == 0) then
        characters_before_substring = ""
      else 
        characters_before_substring = line(:location-1)
      end if
    end associate
  end function

  pure function get_key_value_from_string_mold(key, lines, mold) result(key_value)
    character(len=*), intent(in) :: key
    type(string_t), intent(in) :: lines(:)
    type(string_t), intent(in) :: mold
    type(string_t) key_value
    key_value = get_array_key_value_from_character_mold([string_t(key)], lines, mold%string())
  end function

  pure function get_key_value_from_character_mold(key, lines, mold) result(key_value)
    character(len=*), intent(in) :: key
    type(string_t), intent(in) :: lines(:)
    character(len=*), intent(in) :: mold
    character(len=:), allocatable :: key_value
    key_value = get_array_key_value_from_character_mold([string_t(key)], lines, mold)
  end function

  pure function get_array_key_value_from_character_mold(key, lines, mold) result(key_value)
    type(string_t), intent(in) :: key(:)
    type(string_t), intent(in) :: lines(:)
    character(len=*), intent(in) :: mold
    character(len=:), allocatable :: key_value, characters
    integer l

    search_lines_for_key: &
    do l = 1, size(lines)
      characters = lines(l)%string()
      if (index(characters, "#") /= 0) characters = before("#", characters)
      associate(colon => index(characters, ":"))
        if (colon == 0) error stop "missing key/value separator ':'"
        if (any(characters(1:colon-1) == key)) then
          key_value = characters(colon+1:)
          exit search_lines_for_key
        end if
      end associate
    end do search_lines_for_key

  end function

  module procedure new_indexed_package_from_lines
    indexed_package = indexed_package_t( &
       name        = get_key_value(     "- name", lines, mold = "") &
      ,host        = get_key_value([string_t("github"), string_t("gitlab"), string_t("url")], lines, mold = "") &
      ,description = get_key_value("description", lines, mold = "") &
      ,categories  = get_key_value( "categories", lines, mold = "") &
      ,tags        = [get_key_value(          "tags", lines, mold = string_t(""))] &
      ,license     = get_key_value(    "license", lines, mold = "") &
      ,version     = get_key_value(    "version", lines, mold = "") &
    )
  end procedure

end submodule indexed_package_s