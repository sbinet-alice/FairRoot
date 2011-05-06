MACRO (WRITE_CONFIG_FILE filename)

  If(NOT DEFINED FULL_CONFIG_FILE)
    Set(FULL_CONFIG_FILE "true")
  EndIf(NOT DEFINED FULL_CONFIG_FILE)

  SET(FAIRLIBDIR ${CMAKE_CURRENT_BINARY_DIR}/lib)  
  SET(LD_LIBRARY_PATH ${FAIRLIBDIR} ${LD_LIBRARY_PATH}) 
  
  IF(CMAKE_SYSTEM_NAME MATCHES Linux)
    configure_file(${PROJECT_SOURCE_DIR}/cmake/scripts/check_system.sh.in
                   ${CMAKE_CURRENT_BINARY_DIR}/check_system.sh
                  )
    FILE(READ /etc/issue _linux_flavour)
    STRING(REGEX REPLACE "[\\]" " " _result1 "${_linux_flavour}")
    STRING(REGEX REPLACE "\n" ";" _result "${_result1}")
    SET(_counter 0)
    FOREACH(_line ${_result})
      if (_counter EQUAL 0)
        SET(_counter 1)
        set(_linux_flavour ${_line})
      endif (_counter EQUAL 0)
    ENDFOREACH(_line ${_result})
    EXECUTE_PROCESS(COMMAND uname -m 
                    OUTPUT_VARIABLE _system 
                    OUTPUT_STRIP_TRAILING_WHITESPACE
                   )
   
  ElseIf(CMAKE_SYSTEM_NAME MATCHES Darwin)
    configure_file(${PROJECT_SOURCE_DIR}/cmake/scripts/check_system_mac.sh.in
                   ${CMAKE_CURRENT_BINARY_DIR}/check_system.sh
                  )
    EXECUTE_PROCESS(COMMAND uname -sr 
                    OUTPUT_VARIABLE _linux_flavour
                    OUTPUT_STRIP_TRAILING_WHITESPACE
                   )
    EXECUTE_PROCESS(COMMAND uname -m 
                    OUTPUT_VARIABLE _system 
                    OUTPUT_STRIP_TRAILING_WHITESPACE
                   )
  ENDIF(CMAKE_SYSTEM_NAME MATCHES Linux)

   
  CONVERT_LIST_TO_STRING(${GEANT4_LIBRARY_DIR})
  Set(GEANT4_LIBRARY_DIR ${output})

  CONVERT_LIST_TO_STRING(${GEANT4_INCLUDE_DIR})
  Set(GEANT4_INCLUDE_DIR ${output})

  CONVERT_LIST_TO_STRING(${GEANT4VMC_INCLUDE_DIR})
  Set(GEANT4VMC_INCLUDE_DIR ${output})

  CONVERT_LIST_TO_STRING(${GEANT4VMC_LIBRARY_DIR})
  Set(GEANT4VMC_LIBRARY_DIR ${output})

  CONVERT_LIST_TO_STRING(${GEANT4VMC_MACRO_DIR})
  Set(GEANT4VMC_MACRO_DIR ${output})

  CONVERT_LIST_TO_STRING(${CLHEP_INCLUDE_DIR})
  Set(CLHEP_INCLUDE_DIR ${output})

  CONVERT_LIST_TO_STRING(${CLHEP_LIBRARY_DIR})
  Set(CLHEP_LIBRARY_DIR ${output})
  
  CONVERT_LIST_TO_STRING(${PLUTO_LIBRARY_DIR})
  Set(PLUTO_LIBRARY_DIR ${output})

  CONVERT_LIST_TO_STRING(${PLUTO_INCLUDE_DIR})
  Set(PLUTO_INCLUDE_DIR ${output})

  CONVERT_LIST_TO_STRING(${PYTHIA6_LIBRARY_DIR})
  Set(PYTHIA6_LIBRARY_DIR ${output})

  CONVERT_LIST_TO_STRING(${GEANT3_SYSTEM_DIR})
  Set(G3SYS ${output})

  CONVERT_LIST_TO_STRING(${GEANT3_INCLUDE_DIR})
  Set(GEANT3_INCLUDE_DIR ${output})

  CONVERT_LIST_TO_STRING(${GEANT3_LIBRARY_DIR})
  Set(GEANT3_LIBRARY_DIR ${output})

  CONVERT_LIST_TO_STRING(${GEANT3_LIBRARIES})
  Set(GEANT3_LIBRARIES ${output})

  CONVERT_LIST_TO_STRING(${ROOT_LIBRARY_DIR})
  Set(ROOT_LIBRARY_DIR ${output})

  CONVERT_LIST_TO_STRING(${ROOT_LIBRARIES})
  Set(ROOT_LIBRARIES ${output})

  CONVERT_LIST_TO_STRING(${ROOT_INCLUDE_DIR})
  Set(ROOT_INCLUDE_DIR ${output} )

  Set(VMCWORKDIR ${CMAKE_SOURCE_DIR})

  Set(FAIRLIBDIR ${FAIRLIBDIR})

  CONVERT_LIST_TO_STRING(${LD_LIBRARY_PATH})
  IF(CMAKE_SYSTEM_NAME MATCHES Linux)
    Set(MY_LD_LIBRARY_PATH ${output})
  ELSE(CMAKE_SYSTEM_NAME MATCHES Linux)
    IF(CMAKE_SYSTEM_NAME MATCHES Darwin)
      Set(MY_DYLD_LIBRARY_PATH ${output})
    ENDIF(CMAKE_SYSTEM_NAME MATCHES Darwin)
  ENDIF(CMAKE_SYSTEM_NAME MATCHES Linux)

  Set(USE_VGM 1)

  SET (PATH ${ROOTSYS}/bin ${PATH})
  UNIQUE(PATH "${PATH}")
  CONVERT_LIST_TO_STRING(${PATH})
  Set(MY_PATH ${output})

  Set(PYTHIA8DATA "${SIMPATH}/generators/pythia8/xmldoc")

  CONVERT_LIST_TO_STRING($ENV{NEW_CLASSPATH})
  Set(MY_CLASSPATH ${output})
  
  IF(${filename} MATCHES "[.]csh")
    configure_file(${PROJECT_SOURCE_DIR}/cmake/scripts/config.csh.in
	           ${CMAKE_CURRENT_BINARY_DIR}/${filename}
                  )
  ELSE(${filename} MATCHES "[.]csh")
    configure_file(${PROJECT_SOURCE_DIR}/cmake/scripts/config.sh.in
	           ${CMAKE_CURRENT_BINARY_DIR}/${filename}
                  )
  ENDIF(${filename} MATCHES "[.]csh")


ENDMACRO (WRITE_CONFIG_FILE)


MACRO (CONVERT_LIST_TO_STRING)

  set (tmp "")
  foreach (_current ${ARGN})

    set(tmp1 ${tmp})
    set(tmp "")
    set(tmp ${tmp1}:${_current})

  endforeach (_current ${ARGN})
  If(tmp)
    STRING(REGEX REPLACE "^:(.*)" "\\1" output ${tmp}) 
  Else(tmp)
    Set(output "")
  EndIf(tmp)

ENDMACRO (CONVERT_LIST_TO_STRING LIST)