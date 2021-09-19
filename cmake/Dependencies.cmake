# Sets all the dependencies of the project
option(INSTALLED_PYBIND11	"Use installed pybind11 library"		ON)

set(original_cmake_build_type ${CMAKE_BUILD_TYPE})

find_package(Pybind11 "2.7.1" QUIET)
if(PYBIND11_FOUND AND INSTALLED_PYBIND11)
	message("PYBIND11 FOUND: Using system library")
else()
	message("PYBIND11 NOT FOUND: Downloading and building PYBIND11 from source")
	include(ExternalPybind11)
endif()

set(CMAKE_BUILD_TYPE "${original_cmake_build_type}" CACHE INTERNAL "")
