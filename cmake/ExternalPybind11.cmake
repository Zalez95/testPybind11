include(FetchContent)

FetchContent_Declare(
	PYBIND11
	GIT_REPOSITORY https://github.com/pybind/pybind11.git
	GIT_TAG v2.7.1
	GIT_SHALLOW TRUE
)
FetchContent_GetProperties(PYBIND11)
if(NOT pybind11_POPULATED)
	FetchContent_Populate(PYBIND11)

	set(PYBIND11_TEST OFF CACHE INTERNAL "")
	set(CMAKE_INSTALL_PREFIX ${INSTALL_DIR} CACHE INTERNAL "")
	set(CMAKE_BUILD_TYPE ${CONFIG} CACHE INTERNAL "")

	add_subdirectory(${pybind11_SOURCE_DIR} ${pybind11_BINARY_DIR})
endif()
