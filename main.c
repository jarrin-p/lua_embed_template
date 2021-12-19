#include <stdio.h>

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#include "shared.h"

int main(void) {
    puts("Main function working");
    sayHello();

    lua_State *L = luaL_newstate();
    luaL_openlibs(L); // Opens standard libraries

    int status = luaL_loadfile(L, "test.lua"); // Loads test file
    if(status) { puts("ERROR"); }

    status = lua_pcall(L, 0, 0, 0);
    if(status) { puts("ERROR"); }

    return 0;
}
