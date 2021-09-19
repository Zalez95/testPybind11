# Searchs the pybind11 library
# This module will set the next variables:
#	PYBIND11_FOUND		- pybind11 was succesfully found
#	PYBIND11_INCLUDE_DIR- pybind11 header "pybind11/pybind11.h"
#	pybind11_headers	- pybind11 target

include(FindPackageHandleStandardArgs)

# Search for the headers
find_path(
	PYBIND11_INCLUDE_DIR
	QUIET
	NAMES "pybind11/pybind11.h"
)

find_package_handle_standard_args(
	Pybind11
	REQUIRED_VARS PYBIND11_INCLUDE_DIR
)

if(PYBIND11_FOUND)
	# Create the dependency target
	add_library(pybind11_headers INTERFACE)
	set_target_properties(pybind11_headers PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES ${PYBIND11_INCLUDE_DIR}
	)
endif()
