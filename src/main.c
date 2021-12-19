#include <stdio.h>

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#include "../include/shared.h"

int main(void) {
    char script_path[] = "lua/test.lua"; // should be relative from build directory not bin location

    puts("Main function working");
    sayHello();

    lua_State *L = luaL_newstate();
    luaL_openlibs(L); // Opens lua standard libraries

    int status = luaL_loadfile(L, script_path); // Loads test file
    if(status) { puts("Script unable to be loaded."); }

    status = lua_pcall(L, 0, 0, 0);
    if(status) { puts("Script unable to run."); }

    return 0;
}
