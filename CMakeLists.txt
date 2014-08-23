cmake_minimum_required(VERSION 2.8)

project (pyjsonrpcembd) 

#FIND_PACKAGE(PythonInterp 2.7 REQUIRED)
#FIND_PACKAGE(PythonInterp)
#FIND_PACKAGE(PythonLibs 2.7.1 EXACT REQUIRED)
#FIND_PACKAGE(PythonLibs 2.7 REQUIRED)
#find_package( PythonLibs 2.7 REQUIRED )
find_package( PythonLibs 3.3 REQUIRED )
#find_package(PythonLibs REQUIRED)
#find_package(PythonLibs)
include_directories( ${PYTHON_INCLUDE_DIRS} )

#FIND_PACKAGE(PythonLibs)
message("Include dirs of Python: " ${PYTHON_INCLUDE_DIRS} )
message("Libs of Python: " ${PYTHON_LIBRARIES} )


#FIND_PACKAGE(Boost COMPONENTS python REQUIRED)

FIND_PACKAGE(Boost COMPONENTS python-3.3 REQUIRED)
#when system has python2 and python3 both, here need to specipy which python use

message("Include dirs of boost: " ${Boost_INCLUDE_DIRS} )
message("Libs of boost: " ${Boost_LIBRARIES} )


add_library (pyjsonrpcembd SHARED pyjsonrpcembd.cpp )
                            
TARGET_LINK_LIBRARIES(pyjsonrpcembd ${Boost_LIBRARIES} ${PYTHON_LIBRARIES})

install(TARGETS pyjsonrpcembd   DESTINATION lib )
install(FILES pyjsonrpcembd.h DESTINATION include )

#ADD_SUBDIRECTORY(test)

#enable_testing()
#add_test( pyjsonrpcembed-test-test pyjsonrpcembed-test )
			  #MainTest
#add_custom_command(TARGET pyjsonrpcembed-test POST_BUILD COMMAND ctest -C $<CONFIGURATION> --output-on-failure)
