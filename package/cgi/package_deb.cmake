set(COMPONENT_NAME "cgi")

set(CPACK_DEB_${COMPONENT_NAME}_PACKAGE_DESCRIPTION "LizardFS CGI Monitor")
set(CPACK_DEB_${COMPONENT_NAME}_PACKAGE_ARCHITECTURE "all")

configure_file(empty.prerm.in deb.${COMPONENT_NAME}.prerm)
configure_file(empty.postinst.in deb.${COMPONENT_NAME}.postinst)
set_deb_component_control_extra(${COMPONENT_NAME} "postinst" "${CMAKE_CURRENT_BINARY_DIR}/deb.${COMPONENT_NAME}.postinst")
set_deb_component_control_extra(${COMPONENT_NAME} "prerm" "${CMAKE_CURRENT_BINARY_DIR}/deb.${COMPONENT_NAME}.prerm")