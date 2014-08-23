cmake_minimum_required(VERSION 2.8)

project (pyjsonrpcembd) 

#find_package(PythonLibs)
find_package( PythonLibs 3.3 REQUIRED )

#FIND_PACKAGE(Boost COMPONENTS python REQUIRED)
FIND_PACKAGE(Boost COMPONENTS python-3.3 REQUIRED)
####when system has python2 and python3 both, here need to specipy which python use


include_directories( ${PYTHON_INCLUDE_DIRS} )

message("Include dirs of Python: " ${PYTHON_INCLUDE_DIRS} )
message("Libs of Python: " ${PYTHON_LIBRARIES} )

message("Include dirs of boost: " ${Boost_INCLUDE_DIRS} )
message("Libs of boost: " ${Boost_LIBRARIES} )

add_library (pyjsonrpcembd SHARED pyjsonrpcembd.cpp )
                            
TARGET_LINK_LIBRARIES(pyjsonrpcembd ${Boost_LIBRARIES} ${PYTHON_LIBRARIES})

install(TARGETS pyjsonrpcembd   DESTINATION lib )
install(FILES pyjsonrpcembd.h DESTINATION include )


