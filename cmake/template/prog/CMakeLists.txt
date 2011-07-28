cmake_minimum_required (VERSION 2.6)
project (YYY)

include (../cmake/require.cmake)
require (libXXX)

include_directories (XXX_INCLUDE_DIR)

add_executable (YYY YYY.cpp)
target_link_libraries (YYY XXX)
