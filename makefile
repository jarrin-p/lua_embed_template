.PHONY: all build clean
all: clean build run
clean: 
	-rm libshared.so shared.o compile_commands.json test
build: shared.o libshared.so test
shared.o: shared.c shared.h
	gcc -c -Wall -Werror -fpic shared.c
libshared.so: shared.o
	gcc -shared -o libshared.so shared.o
test: libshared.so
	gcc -L${LUAINCLUDE} -L$(shell pwd) -I${LUAINCLUDE} -o test main.c -llua -lshared # works
run: test
	./test
