//
// Пример простой библиотеки на C++ для вызова ее из LUA
// http://quik2dde.ru/viewtopic.php?id=18
//

#include <windows.h>
#include <process.h>
#include <iostream>
#include <stdio.h>

// в случае вызова функций из Lua-кода во внешней DLL
// необходимо определить эти константы до подключения заголовочных файлов Lua
#define LUA_LIB
#define LUA_BUILD_AS_DLL

int** create_array2d(size_t a, size_t b);
void free_array2d(int** m, size_t a, size_t b);

// подключаем заголовочные файлы из дистрибутива Lua
// т.к. наш проект C++, то подключаем единый файл заголовка, где правильно подключаются заголовочные файлы Lua, сделанные для "чистого C"
// правильный путь к файлам Lua5.1, Lua5.3 или Lua5.4 задан в настройках проекта (разный в зависимости от выбранного варианта 
// в Solution Configurations)
#include "lua.hpp"

// стандартная точка входа для DLL
BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
	return TRUE;
}

// Эффективное выделение и освобождение двумерного массива размера a x b.
int** create_array2d(size_t a, size_t b) {
	int** m = new int* [a];
	m[0] = new int[a * b];
	for (size_t i = 1; i != a; ++i)
		m[i] = m[i - 1] + b;
	return m;
}
void free_array2d(int** m, size_t a, size_t b) {
	delete[] m[0];
	delete[] m;
}

static int forLua_GetTable(lua_State* ctx) {
	lua_Number price_step = lua_tonumber(ctx, -1);
	lua_Integer	bid_count = lua_tointeger(ctx, -2);
	lua_Integer offer_count = lua_tointeger(ctx, -3);
	lua_pop(ctx, 3);

	//for (int i = 0; i < offer_count; i++) {
	//	lua_next(ctx, t);
	//	lua_pop(ctx, 1);
	//}

	//int t1 = lua_gettop(ctx);
	//lua_pushnil(ctx);
	//lua_next(ctx, t1);
	//lua_next(ctx, t1);
	//lua_pushinteger(ctx, t);
	//lua_pushinteger(ctx, t1);
	//int t2 = lua_gettop(ctx);
	//lua_pushinteger(ctx, t2);

	//lua_next(ctx, -2);

	int t = lua_gettop(ctx);
	lua_pushnil(ctx);
	//size_t visited = 0;
	int i0 = 0;
	int price[6] = { 0, 0, 0, 0, 0, 0 };
	int quantity[6] = { 0, 0, 0, 0, 0, 0 };
	//lua_pushinteger(ctx, t);
	while (lua_next(ctx, t) != 0) {
		lua_getfield(ctx, -1, "price");
		price[i0] = lua_tonumber(ctx, -1) / price_step;
		lua_getfield(ctx, -2, "quantity");
		quantity[i0] = lua_tointeger(ctx, -1);
		++i0;
		lua_pop(ctx, 3);
	};
	lua_pop(ctx, 1);
	t = lua_gettop(ctx);
	lua_pushnil(ctx);
	while (lua_next(ctx, t) != 0) {
		lua_getfield(ctx, -1, "price");
		price[i0] = lua_tonumber(ctx, -1) / price_step;
		lua_getfield(ctx, -2, "quantity");
		quantity[i0] = lua_tointeger(ctx, -1);
		++i0;
		lua_pop(ctx, 3);
	};
	for (int i = 0; i < 6; ++i) {
		lua_pushinteger(ctx, quantity[i]);
		lua_pushinteger(ctx, price[i]);
	};
	t = lua_gettop(ctx);
	lua_pushinteger(ctx, t);
	return(t);
};

// список реализованных в dll пользовательских функций
static struct luaL_Reg ls_lib[] = {
	{"GetTable", forLua_GetTable},
    {nullptr, nullptr}
};

extern "C" LUALIB_API int luaopen_luacdll(lua_State *L) {
	// эта функция выполнится в момент вызова require() в Lua-коде
	// регистрируем реализованные в dll функции, чтобы они стали доступны для Lua
	// в Lua 5.1 и Lua 5.3 для этого предназначены разные функции
	#if LUA_VERSION_NUM >= 502
		luaL_newlib(L, ls_lib);
	#else
		luaL_openlib(L, "luacdll", ls_lib, 0);
	#endif

	return 1;
}

