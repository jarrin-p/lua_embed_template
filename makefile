# Lua linking
LUA_INCLUDE_DIR = ${LUAINCLUDE} # directory of lua library for linking
LUA_LIB_NAME = lua # name of the library in the lua include dir (in this case, it's "liblua", which is just -llua when linking)

# Dynamic linking for using C in Lua scripts
SHARED_LIBNAME = shared # name of .c and .h files, and name of .so to be generated

.PHONY: all build clean
all: clean build run
clean:
	-rm lib$(SHARED_LIBAME).so test
build: lib$(SHARED_LIBNAME).so test
lib$(SHARED_LIBNAME).so: $(SHARED_LIBNAME).c $(SHARED_LIBNAME).h
	gcc -shared -Wall -Werror -fpic -o libshared.so shared.c
test: lib$(SHARED_LIBNAME).so
	gcc -L$(LUA_INCLUDE_DIR) -L$(shell pwd) -I$(LUA_INCLUDE_DIR) -o test main.c -l$(LUA_LIB_NAME) -l$(SHARED_LIBNAME)
run: test
	./test
