# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(taudio_waa_library VERSION 0.0.1 LANGUAGES C)

add_library(taudio_waa SHARED
  "taudio_waa.c"
)

set_target_properties(taudio_waa PROPERTIES
  PUBLIC_HEADER taudio_waa.h
  OUTPUT_NAME "taudio_waa"
)

target_compile_definitions(taudio_waa PUBLIC DART_SHARED_LIB)
