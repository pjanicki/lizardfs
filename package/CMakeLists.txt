include(SetSystemArchitecture.cmake)

# Add generators
if(BUILD_PACKAGE STREQUAL "DEB")
  include(package_deb.cmake)
elseif(BUILD_PACKAGE STREQUAL "RPM")
  include(package_rpm.cmake)
elseif(BUILD_PACKAGE STREQUAL "TGZ")
  include(package_tgz.cmake)
endif()

# Common config
set(CPACK_GENERATOR ${GENERATOR})
set(CPACK_COMPONENT_INCLUDE_TOPLEVEL_DIRECTORY FALSE)  

set(CPACK_PACKAGE_DESCRIPTION_FILE ${CMAKE_SOURCE_DIR}/README)
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "LizardFS - distributed, fault tolerant file system")
set(CPACK_PACKAGE_NAME "lizardfs")
set(CPACK_PACKAGE_VERSION_MAJOR ${PACKAGE_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PACKAGE_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_MICRO ${PACKAGE_VERSION_MICRO})
set(CPACK_PACKAGE_VERSION ${PACKAGE_VERSION})
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}_${CPACK_PACKAGE_VERSION}_${SYSTEM_ARCHITECTURE}")
set(CPACK_PACKAGE_VENDOR "http://www.lizardfs.org")
set(CPACK_PACKAGE_CONTACT "contact@lizardfs.org")

file(READ "daemon.postinst.in" DAEMON_POSTINST_IN_BODY)
file(READ "daemon.prerm.in" DAEMON_PRERM_IN_BODY)

#must be the last one
include(CPack)
