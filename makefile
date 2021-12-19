# Locations
LUA_INCLUDE_DIR:=${LUAINCLUDE}# directory of lua library for linking

# names
LUA_LIB_NAME:=lua# name of the library in the lua include dir (in this case, it's "liblua", which is just -llua when linking)
SHARED_LIBNAME:=shared# name of .c and .h files, and name of .so to be generated

# Library path locations
LIBFLAGS:=-L$(LUA_INCLUDE_DIR)
LIBFLAGS:=-L./lib $(LIBFLAGS)

# -l lib file includes
LIBS:=-l$(LUA_LIB_NAME)
SHARED_LIBS:=-l$(SHARED_LIBNAME)
ALL_LIBS:=$(LIBS) $(SHARED_LIBS)

# Include directories
INCLFLAGS:=-I$(LUA_INCLUDE_DIR)

OUT:=test# output name
#ERRORFLAGS:=-Wall -Werror
ERRORFLAGS:=

CC:=gcc $(LIBFLAGS) $(INCLFLAGS)

.PHONY: all build clean
all: clean build run
clean:
	rm -r ./lib ./bin && mkdir lib bin
build: ./lib/lib$(SHARED_LIBNAME).so ./bin/$(OUT)
./lib/lib$(SHARED_LIBNAME).so: ./src/$(SHARED_LIBNAME).c ./include/$(SHARED_LIBNAME).h
	$(CC) $(LIBS) -shared $(ERRORFLAGS) -fpic -o ./lib/lib$(SHARED_LIBNAME).so ./src/$(SHARED_LIBNAME).c
./bin/$(OUT): ./lib/lib$(SHARED_LIBNAME).so
	$(CC) $(ALL_LIBS) -o ./bin/$(OUT) ./src/main.c
run: ./bin/$(OUT)
	./bin/$(OUT)
