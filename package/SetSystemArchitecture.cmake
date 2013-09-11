# Set SYSTEM_ARCHITECTURE with current system architecture #
############################################################

function(set_system_architecture FOR_DEB)

  if(FOR_DEB)
    # Use 'dpkg'
    execute_process(COMMAND dpkg --print-architecture TIMEOUT 1 RESULT_VARIABLE RETURN_CODE OUTPUT_VARIABLE SYSARCH)
  else()
    # Use 'arch'
    execute_process(COMMAND arch TIMEOUT 1 RESULT_VARIABLE RETURN_CODE OUTPUT_VARIABLE SYSARCH)
    if(NOT RETURN_CODE STREQUAL "0")
      # Use 'uname'
      execute_process(COMMAND uname -m TIMEOUT 1 RESULT_VARIABLE RETURN_CODE OUTPUT_VARIABLE SYSARCH)
    endif()
  endif()

  if(NOT RETURN_CODE STREQUAL "0")
  # none
    message(WARNING "Can't obtain system architecture, using 'i386'")
    set(SYSTEM_ARCHITECTURE "i386")
  else()
  # parsing
    string(LENGTH ${SYSARCH} SA_LENGTH)
    math(EXPR SA_LENGTH "${SA_LENGTH} -1")
    string(SUBSTRING ${SYSARCH} 0 ${SA_LENGTH} SYSARCH)
  endif()
  set(SYSTEM_ARCHITECTURE ${SYSARCH} PARENT_SCOPE)
  
endfunction()
