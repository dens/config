# Mögliche Konfigurationen: Dbg, Debug, Release
set (CMAKE_CONFIGURATION_TYPES Dbg Debug Release)
set (CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}"
  CACHE STRING "Reset the configurations to what we need"
  FORCE)

# Konfig: Dbg
if (NOT CMAKE_C_FLAGS_DBG)
  set (CMAKE_C_FLAGS_DBG "$ENV{CFLAGS} -O2 -DDBG"
    CACHE STRING "C-Flags Dbg" FORCE)
endif()

if (NOT CMAKE_CXX_FLAGS_DBG)
  set (CMAKE_CXX_FLAGS_DBG "$ENV{CXXFLAGS} -O2 -DDBG"
    CACHE STRING "CXX-Flags Dbg" FORCE)
endif()

if (NOT CMAKE_EXE_LINKER_FLAGS_DBG)
  set (CMAKE_EXE_LINKER_FLAGS_DBG "$ENV{LFLAGS} -Wl,-enable-new-dtags"
    CACHE STRING "Linker-Flags Dbg (executables)" FORCE)
endif()

if (NOT CMAKE_SHARED_LINKER_FLAGS_DBG)
  set (CMAKE_SHARED_LINKER_FLAGS_DBG "$ENV{LFLAGS} -Wl,-enable-new-dtags"
    CACHE STRING "Linker-Flags Dbg (shared libs)" FORCE)
endif()

# Konfig: Debug
if (NOT CMAKE_C_FLAGS_DEBUG)
  set (CMAKE_C_FLAGS_DEBUG "$ENV{CFLAGS} -g -DDBG"
    CACHE STRING "C++-Flags Debug" FORCE)
endif()

if (NOT CMAKE_CXX_FLAGS_DEBUG)
  set (CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -g -DDBG"
    CACHE STRING "C++-Flags Debug" FORCE)
endif()

if (NOT CMAKE_EXE_LINKER_FLAGS_DEBUG)
  set (CMAKE_EXE_LINKER_FLAGS_DEBUG "$ENV{LFLAGS} -Wl,-enable-new-dtags"
    CACHE STRING "Linker-Flags (executables)" FORCE)
endif()

if (NOT CMAKE_SHARED_LINKER_FLAGS_DEBUG)
  set (CMAKE_SHARED_LINKER_FLAGS_DEBUG "$ENV{LFLAGS} -Wl,-enable-new-dtags"
    CACHE STRING "Linker-Flags (shared libs)" FORCE)
endif()

# Konfig: Release
if (NOT CMAKE_C_FLAGS_RELEASE)
  set (CMAKE_C_FLAGS_RELEASE "$ENV{CFLAGS} -O2"
    CACHE STRING "C-Flags Release" FORCE)
endif()

if (NOT CMAKE_CXX_FLAGS_RELEASE)
  set (CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O2"
    CACHE STRING "C++-Flags Release" FORCE)
endif()

if (NOT CMAKE_EXE_LINKER_FLAGS_RELEASE)
  set (CMAKE_EXE_LINKER_FLAGS_RELEASE "$ENV{LFLAGS} -Wl,-enable-new-dtags"
    CACHE STRING "Linker-Flags Release (executables)" FORCE)
endif()

if (NOT CMAKE_SHARED_LINKER_FLAGS_RELEASE)
  set (CMAKE_SHARED_LINKER_FLAGS_RELEASE "$ENV{LFLAGS} -Wl,-enable-new-dtags"
    CACHE STRING "Linker-Flags Release (shared libs)" FORCE)
endif()

# Default ist Release
if (NOT CMAKE_BUILD_TYPE)
  set (CMAKE_BUILD_TYPE Release
    CACHE STRING "Choose the type of build, options are: Dbg Debug Release"
    FORCE)
endif()


#### output directory

if (NOT OUTPUT_DIRECTORY)
  set (OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/out"
    CACHE STRING "Output-Directory" FORCE)
endif()

set (CMAKE_SKIP_RPATH OFF)
set (CMAKE_BUILD_WITH_INSTALL_RPATH ON)

# TARGET wird in OUTPUT_DIRECTORY/subdir abgelegt und der RPATH
# relativ auf OUTPUT_DIRECTORY/lib ergänzt
function (set_output_directory target subdir)
  get_filename_component (destdir "${OUTPUT_DIRECTORY}/${subdir}" ABSOLUTE)
  get_filename_component (libpath "${OUTPUT_DIRECTORY}/lib" ABSOLUTE)
  file (RELATIVE_PATH rpath "${destdir}" "${libpath}")
  get_target_property (oldrpath ${target} INSTALL_RPATH)
  if (oldrpath)
    set (oldrpath ":${oldrpath}")
  endif()
  set_target_properties (${target} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${destdir}"
    LIBRARY_OUTPUT_DIRECTORY "${destdir}"
    INSTALL_RPATH "$ORIGIN/${rpath}${oldrpath}")
endfunction()


#### Versionierung

include (${MODULE_ROOT}/cmake/version.cmake)

set (BUILDINFO_INCLUDE_DIR ${MODULE_ROOT}/cmake/include)

if (NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release")
  set (PROGRAM_VERSION_EXTRA "-${CMAKE_BUILD_TYPE}")
else()
  set (PROGRAM_VERSION_EXTRA "")
endif()

set (PROGRAM_VERSION_FILE ${CMAKE_BINARY_DIR}/buildinfo_program_version.c)

set_source_files_properties (${PROGRAM_VERSION_FILE} PROPERTIES
  GENERATED TRUE)

add_custom_command (
  OUTPUT ${PROGRAM_VERSION_FILE}
  COMMAND ${MODULE_ROOT}/cmake/bin/mkprogramversion
  ARGS "${PROGRAM_NAME}" "${PROGRAM_VERSION}" "${PROGRAM_VERSION_EXTRA}" "${PROGRAM_VERSION_FILE}"
  VERBATIM)

get_property (GUARD_d816d979367d41ddbbf79a0f29d4c86f GLOBAL PROPERTY "GUARD_d816d979367d41ddbbf79a0f29d4c86f" SET)
if (NOT GUARD_d816d979367d41ddbbf79a0f29d4c86f)

  macro (add_executable name)
    _add_executable (${name} ${ARGN} ${PROGRAM_VERSION_FILE})
  endmacro()

  macro (add_library name shared)
    if ("${shared}" STREQUAL "SHARED")
      _add_library (${name} SHARED ${ARGN} ${PROGRAM_VERSION_FILE})
    else()
      _add_library (${name} ${ARGN})
    endif()
  endmacro()

  add_custom_target (release
    COMMAND rm ${PROGRAM_VERSION_FILE})

endif()
set_property (GLOBAL PROPERTY "GUARD_d816d979367d41ddbbf79a0f29d4c86f" TRUE)