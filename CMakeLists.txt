cmake_minimum_required(VERSION 3.11 FATAL_ERROR)

###############################################################################
# 								SOMBRA ENGINE
###############################################################################
# Project name and version
project(TestPybind LANGUAGES CXX)
set(TESTPYBIND_VERSION_MAJOR "1")
set(TESTPYBIND_VERSION_MINOR "1")
set(TESTPYBIND_VERSION "${TESTPYBIND_VERSION_MAJOR}.${TESTPYBIND_VERSION_MINOR}")

# Global compiler options
set(MY_DEBUG_POSTFIX "d")
if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
	option(FORCE_STATIC_VCRT "Force /MT for static VC runtimes" OFF)
	if(NOT BUILD_SHARED_LIBS AND FORCE_STATIC_VCRT)
		foreach(flagVar
			CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
			CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO
		)
			if(${flagVar} MATCHES "/MD")
				string(REGEX REPLACE "/MD" "/MT" ${flagVar} "${${flagVar}}")
			endif()
		endforeach()
	endif()
endif()

# Create the libraries and the executables
include(GNUInstallDirs)

# Include the dependencies
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(Dependencies)

# Find the executable source files
file(GLOB_RECURSE TESTPYBIND_SOURCES "src/*.cpp")

# Create the executable
add_executable(testPybind ${TESTPYBIND_SOURCES})

# Add the compiler options
set_target_properties(testPybind PROPERTIES
	CXX_STANDARD			17
	CXX_STANDARD_REQUIRED	On
	DEBUG_POSTFIX			${MY_DEBUG_POSTFIX}
)
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
	target_compile_options(testPybind PRIVATE "-Wall" "-Wextra" "-Wpedantic")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
	target_compile_options(testPybind PRIVATE "/W4" "-D_CRT_SECURE_NO_WARNINGS")
endif()

# Link the dependencies
target_link_libraries(testPybind PRIVATE pybind11::embed)

# Install the target
install(TARGETS testPybind DESTINATION ${CMAKE_INSTALL_BINDIR})
