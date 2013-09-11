cmake_minimum_required(VERSION 2.8)
set(CMAKE_LEGACY_CYGWIN_WIN32 0) # Remove when CMake >= 2.8.4 is required
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_MODULE_PATH})

project(lizardfs)
set(PACKAGE_VERSION_MAJOR 1)
set(PACKAGE_VERSION_MINOR 6)
set(PACKAGE_VERSION_MICRO 27)
set(PACKAGE_VERSION
    "${PACKAGE_VERSION_MAJOR}.${PACKAGE_VERSION_MINOR}.${PACKAGE_VERSION_MICRO}")

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug)
endif()

set(CMAKE_CXX_FLAGS "-std=gnu++0x -Wall -Wextra -Wshadow -pedantic -fwrapv")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")

add_definitions(-D_LARGEFILE_SOURCE)
add_definitions(-D_FILE_OFFSET_BITS=64)
add_definitions(-DHAVE_CONFIG_H)
add_definitions(-D__STDC_LIMIT_MACROS)
add_definitions(-D__STDC_CONSTANT_MACROS)
add_definitions(-D__STDC_FORMAT_MACROS)

# XXX(lamvak): what about OS X?
set(DEFAULT_USER "mfs" CACHE STRING "Default user to run daemons as")
set(DEFAULT_GROUP "mfs" CACHE STRING "Default group to run daemons as")
set(ENABLE_LIGHTMFS NO CACHE BOOL "Enable light version of LizardFS")
set(ENABLE_DEBIAN_PATHS NO CACHE BOOL "Enable Debian-style install paths")
set(BUILD_DEB NO CACHE BOOL "Enable package building for Debian (using dpkg)")
set(BUILD_RPM NO CACHE BOOL "Enable package building for RedHat/Fedora (using rpmbuild)")

message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
message(STATUS "ENABLE_LIGHTMFS: ${ENABLE_LIGHTMFS}")
message(STATUS "ENABLE_DEBIAN_PATHS: ${ENABLE_DEBIAN_PATHS}")
message(STATUS "BUILD_DEB: ${BUILD_DEB}")
message(STATUS "BUILD_RPM: ${BUILD_RPM}")

set(BIN_SUBDIR   "bin")
set(SBIN_SUBDIR  "sbin")

set(ETC_PATH     "/etc")
set(RUN_PATH     "/var/run/mfs")
set(DATA_PATH    "/var/lib/mfs")
set(MAN_PATH     "/usr/share/man")
set(CGI_PATH     "/usr/share/mfscgi")

if(ENABLE_LIGHTMFS)
  set(PROTO_BASE 65536)
  set(LIGHT_MFS 1)
else()
  set(PROTO_BASE 0)
  set(LIGHT_MFS 0)
endif()

# Inter-language constants
set(CHARTS_CSV_CHARTID_BASE 90000)

## All the environment tests (libs, includes, etc.) live here:
include(EnvTests.cmake)

configure_file(config.h.in config.h)
include_directories(${CMAKE_BINARY_DIR}) # Here we have generated config.h

# main.cc shared by some LizardFS applications
set(MAIN_SRC ${CMAKE_SOURCE_DIR}/mfsmain/main.cc)

add_subdirectory(etc)
add_subdirectory(man)
add_subdirectory(mfscommon)
add_subdirectory(mfschunkserver)
add_subdirectory(mfsmaster)
add_subdirectory(mfsmetadump)
add_subdirectory(mfsmetalogger)
add_subdirectory(mfsmetarestore)
add_subdirectory(mfstools)
if (FUSE_LIBRARY)
  add_subdirectory(mfsmount)
endif()
add_subdirectory(mfscgi)
add_subdirectory(package)
