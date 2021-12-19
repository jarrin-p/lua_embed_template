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

    // register function
    lua_pushcfunction(L, l_testputs);
    lua_setglobal(L, "attempt_puts");

    // functions return true if there's an error
    if(luaL_loadfile(L, script_path)) puts("Script unable to be loaded.");
    if(lua_pcall(L, 0, 0, 0)) puts("Script unable to run.");

    return 0;
}
