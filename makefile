# Locations
LUA_INCLUDE_DIR:=${LUAINCLUDE}# directory of lua library for linking

# names
LUA_LIB_NAME:=lua# name of the library in the lua include dir (in this case, it's "liblua", which is just -llua when linking)
SHARED_LIBNAME:=shared# name of .c and .h files, and name of .so to be generated

# Libraries
LIBFLAGS:=-L$(LUA_INCLUDE_DIR)
LIBFLAGS:=-L./lib $(LIBFLAGS)

# Include directories
INCLFLAGS:=-I$(LUA_INCLUDE_DIR)

# -l lib includes
LIBS:=-l$(LUA_LIB_NAME)
LIBS:=-l$(SHARED_LIBNAME) $(LIBS)

# output name
OUT:=test

.PHONY: all build clean
all: clean build run
clean:
	-rm ./lib/* ./bin/*
build: ./lib/lib$(SHARED_LIBNAME).so ./bin/$(OUT)
./lib/lib$(SHARED_LIBNAME).so: ./src/$(SHARED_LIBNAME).c ./include/$(SHARED_LIBNAME).h
	gcc -shared -Wall -Werror -fpic -o ./lib/lib$(SHARED_LIBNAME).so ./src/$(SHARED_LIBNAME).c
./bin/$(OUT): ./lib/lib$(SHARED_LIBNAME).so
	gcc $(LIBFLAGS) $(INCLFLAGS) -o ./bin/$(OUT) ./src/main.c $(LIBS)
run: ./bin/$(OUT)
	./bin/$(OUT)
