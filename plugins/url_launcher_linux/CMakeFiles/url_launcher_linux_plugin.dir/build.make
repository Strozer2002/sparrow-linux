# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/user/Desktop/sparrow_pc/linux

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/user/Desktop/sparrow_pc

# Include any dependencies generated for this target.
include plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/compiler_depend.make

# Include the progress variables for this target.
include plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/progress.make

# Include the compile flags for this target's objects.
include plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/flags.make

plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.o: plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/flags.make
plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.o: linux/flutter/ephemeral/.plugin_symlinks/url_launcher_linux/linux/url_launcher_plugin.cc
plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.o: plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/user/Desktop/sparrow_pc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.o"
	cd /home/user/Desktop/sparrow_pc/plugins/url_launcher_linux && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.o -MF CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.o.d -o CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.o -c /home/user/Desktop/sparrow_pc/linux/flutter/ephemeral/.plugin_symlinks/url_launcher_linux/linux/url_launcher_plugin.cc

plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.i"
	cd /home/user/Desktop/sparrow_pc/plugins/url_launcher_linux && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/user/Desktop/sparrow_pc/linux/flutter/ephemeral/.plugin_symlinks/url_launcher_linux/linux/url_launcher_plugin.cc > CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.i

plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.s"
	cd /home/user/Desktop/sparrow_pc/plugins/url_launcher_linux && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/user/Desktop/sparrow_pc/linux/flutter/ephemeral/.plugin_symlinks/url_launcher_linux/linux/url_launcher_plugin.cc -o CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.s

# Object files for target url_launcher_linux_plugin
url_launcher_linux_plugin_OBJECTS = \
"CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.o"

# External object files for target url_launcher_linux_plugin
url_launcher_linux_plugin_EXTERNAL_OBJECTS =

plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/url_launcher_plugin.cc.o
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/build.make
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: linux/flutter/ephemeral/libflutter_linux_gtk.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libgtk-3.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libgdk-3.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libpango-1.0.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libharfbuzz.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libatk-1.0.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libcairo-gobject.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libcairo.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libgio-2.0.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libgobject-2.0.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: /usr/lib/x86_64-linux-gnu/libglib-2.0.so
plugins/url_launcher_linux/liburl_launcher_linux_plugin.so: plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/user/Desktop/sparrow_pc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library liburl_launcher_linux_plugin.so"
	cd /home/user/Desktop/sparrow_pc/plugins/url_launcher_linux && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/url_launcher_linux_plugin.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/build: plugins/url_launcher_linux/liburl_launcher_linux_plugin.so
.PHONY : plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/build

plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/clean:
	cd /home/user/Desktop/sparrow_pc/plugins/url_launcher_linux && $(CMAKE_COMMAND) -P CMakeFiles/url_launcher_linux_plugin.dir/cmake_clean.cmake
.PHONY : plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/clean

plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/depend:
	cd /home/user/Desktop/sparrow_pc && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Desktop/sparrow_pc/linux /home/user/Desktop/sparrow_pc/linux/flutter/ephemeral/.plugin_symlinks/url_launcher_linux/linux /home/user/Desktop/sparrow_pc /home/user/Desktop/sparrow_pc/plugins/url_launcher_linux /home/user/Desktop/sparrow_pc/plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : plugins/url_launcher_linux/CMakeFiles/url_launcher_linux_plugin.dir/depend

