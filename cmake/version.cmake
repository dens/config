if (NOT PROGRAM_VERSION)
  set (PROGRAM_NAME "myprogram"
    CACHE STRING "program name" FORCE)
endif()

if (NOT PROGRAM_VERSION)
  set (PROGRAM_VERSION "1.2.3"
    CACHE STRING "program version" FORCE)
endif()
