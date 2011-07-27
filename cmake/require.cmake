# Example:

#  $MODULE_ROOT/
#        ./cmake/
#        ./libhello/
#        ./myprog/

#  $MODULE_ROOT/cmake/require.cmake
#        this file

#  $MODULE_ROOT/myprog/CMakeLists.txt:
#        cmake_minimum_required (VERSION 2.6)
#        project (myprog)
#
#        include (../cmake/require.cmake)
#        require (libhello)
#
#        include_directories (${HELLO_INCLUDE_DIR})
#        add_definitions (${HELLO_FLAGS})
#
#        add_executable (myprog ...)
#        target_link_libraries (myprog hello)

#  $MODULE_ROOT/libhello/CMakeLists.txt:
#        cmake_minimum_required (VERSION 2.6)
#        project (libhello)
#
#        include (../cmake/require.cmake)
#
#        set (HELLO_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
#        set (HELLO_FLAGS "-Dhelloworld")
#
#        provide (
#            HELLO_INCLUDE_DIR
#            HELLO_FLAGS)
#
#        add_library (hello ...)

#  $MODULE_ROOT/libhello/include/hello.h
#        example header


get_filename_component (MODULE_ROOT ${CMAKE_CURRENT_LIST_FILE} PATH)
get_filename_component (MODULE_ROOT ${MODULE_ROOT}/.. ABSOLUTE)

macro (require module)
  # require MODULENAME [EXCLUDE_FROM_ALL]

  # 1x add_subdirectory
  require_directory ("${MODULE_ROOT}/${module}" "${module}" ${ARGN})

  # in der globalen Property PROVIDED_VARS, stehen die Namen
  # aller Variablen, die an provide() uebergeben wurden
  get_property (PROVIDED_VARS GLOBAL PROPERTY "PROVIDED_VARS")

  # jede der Variablen hat eine globale Property mit dem selben
  # Namen
  foreach (v ${PROVIDED_VARS})
    get_property (${v} GLOBAL PROPERTY "${v}")
  endforeach (v ${PROVIDED_VARS})

  # Modulspezifisches
  include ("${MODULE_ROOT}/${module}/Module.cmake" OPTIONAL)

endmacro (require subdir)

macro (provide)
  # provide VARS...

  # eine globale Property für jede Variable
  foreach (v ${ARGN})
    set_property (GLOBAL PROPERTY "${v}" "${${v}}")
  endforeach (v ${ARGN})

  # PROVIDED_VARS += VARS
  get_property (PROVIDED_VARS GLOBAL PROPERTY "PROVIDED_VARS")
  set (PROVIDED_VARS ${PROVIDED_VARS} ${ARGN})
  set_property (GLOBAL PROPERTY "PROVIDED_VARS" ${PROVIDED_VARS})

endmacro (provide)

function (require_directory dir name)
  # require_directory DIRECTORY NAME [EXCLUDE_FROM_ALL]
  # -> add_subdirectory() + include guard

  get_property (flag GLOBAL PROPERTY "${name}_directory_added" SET)
  if (NOT flag)
    message (STATUS "Require ${name} (${dir})")
    add_subdirectory ("${dir}" "${name}" ${ARGN})
  endif (NOT flag)
  set_property (GLOBAL PROPERTY "${name}_directory_added" TRUE)

endfunction (require_directory dir name)
