cmake_minimum_required (VERSION 2.6)
project (libXXX)

include (../cmake/require.cmake)

set (XXX_INCLUDE_DIR
  ${CMAKE_CURRENT_SOURCE_DIR}/include)

provide (
  XXX_INCLUDE_DIR)

add_library (XXX XXX.cpp)
