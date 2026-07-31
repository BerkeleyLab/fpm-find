submodule(indexed_package_m) indexed_package_s
  implicit none

contains

  module procedure construct_from_components
    indexed_package%name_        = name
    indexed_package%description_ = description
    indexed_package%categories_  = categories
    indexed_package%tags_        = tags

    if (present(github)) then
      indexed_package%github_ = github
    else
      allocate(character(len=0) :: indexed_package%github_)
    end if

    if (present(gitlab)) then
      indexed_package%gitlab_ = gitlab
    else
      allocate(character(len=0) :: indexed_package%gitlab_)
    end if

    if (present(url)) then
      indexed_package%url_ = url
    else
      allocate(character(len=0) :: indexed_package%url_)
    end if

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

  pure function get_key_value(key, lines) result(key_value)
    character(len=*), intent(in) :: key
    type(string_t), intent(in) :: lines(:)
    character(len=:), allocatable :: key_value
    integer l

    do l = 1, size(lines)
      associate(characters => lines(l)%string())
        if (skip(characters)) cycle
        associate(colon => index(characters, ":"))
          if (colon == 0) error stop "missing key/value separator ':'"
          if (index(characters(1:colon-1), key)/=0)then
            key_value = characters(colon+1:)
            return
          end if
        end associate
      end associate
    end do

    key_value = ""

  contains

    pure function skip(line) result(comment_or_blank)
      character(len=*), intent(in) :: line
      logical comment_or_blank

      if (len(trim(line)) == 0) then
         comment_or_blank = .true.
      else 
        associate(hash_etc => adjustl(line))
          if (hash_etc(1:1) == "#") then
            comment_or_blank = .true.
          else
            comment_or_blank = .false.
            return
          end if
        end associate
      end if
    end function

  end function

  module procedure construct_from_strings
    indexed_package = construct_from_components( &
       name        =  get_key_value(     "- name", lines) &
      ,description =  get_key_value("description", lines) &
      ,categories  =  get_key_value( "categories", lines) &
      ,tags        =  get_key_value(       "tags", lines) &
      ,github      =  get_key_value(     "github", lines) &
      ,gitlab      =  get_key_value(     "gitlab", lines) &
      ,url         =  get_key_value(        "url", lines) &
      ,license     =  get_key_value(    "license", lines) &
      ,version     =  get_key_value(    "version", lines) &
    )
  end procedure

  module procedure as_text
    associate(lines =>                                         &
         "name : "        // self%name_        // new_line('') &
      // "description : " // self%description_ // new_line('') &
      // "categories : "  // self%categories_  // new_line('') &
      // "tags : "        // self%tags_                        &
    )
      text = lines
      if (len(self%github_ )/=0) text = text // new_line('') // "github : "  // self%github_
      if (len(self%gitlab_ )/=0) text = text // new_line('') // "gitlab : "  // self%gitlab_
      if (len(self%url_    )/=0) text = text // new_line('') // "url : "     // self%url_
      if (len(self%license_)/=0) text = text // new_line('') // "license : " // self%license_
      if (len(self%version_)/=0) text = text // new_line('') // "version : " // self%version_
    end associate
  end procedure

end submodule indexed_package_s