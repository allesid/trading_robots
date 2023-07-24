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

// реализация пользовательских функций, вызываемых из Lua

static int forLua_GetCurrentThreadId(lua_State* L) {
	// возвращаем одно целочисленное значение, полученное от Win API функции
	lua_pushinteger(L, GetCurrentThreadId());
	return(1);
}

static int forLua_GetTable(lua_State* ctx) {
//	Table t = ctx.global["myTable"];
//	t.iterate([](Valref k, Valref v)
//		{
//			cout << int(k) << int(v);
//		});	
	//return(1);
	lua_getglobal(ctx, "tb");
	if (!lua_istable(ctx, -1)) {
		lua_pushstring(ctx, "Conversion error");
		return lua_error(ctx);
	}
	int t = lua_gettop(ctx);
	lua_pushnil(ctx);
	int visited = 0;
	while (lua_next(ctx, t)) {
		++visited;
		if (!lua_isnumber(ctx, -2) || !lua_isnumber(ctx, -1)) {
			lua_pushstring(ctx, "Conversion error");
			return lua_error(ctx);
		}
//		std::cout << lua_tointeger(ctx, -2) << lua_tointeger(ctx, -1);
		lua_pop(ctx, 1);
	}

	lua_pushnumber(ctx, visited);

	return(1);  // эта функция возвращает одно значение
}

static int forLua_MultTwoNumbers(lua_State *L) {
	// получаем первый и второй параметры вызова функции из стека с проверкой каждого на число
    double d1 = luaL_checknumber(L, 1);
    double d2 = luaL_checknumber(L, 2);

	// помещаем в стек результат умножения
    lua_pushnumber(L, d1 * d2);

    return(1);  // эта функция возвращает одно значение
}
	
static int forLua_MultAllNumbers(lua_State *L) {
	const int n = lua_gettop(L);  // количество переданных аргументов
	double res = 1;
	bool isNumberFound = false;
	for (int i = 1; i <= n; ++i)
		if (lua_type(L, i) == LUA_TNUMBER)
		{
			res *= lua_tonumber(L, i);
			isNumberFound = true;
		}

    if (isNumberFound)
		lua_pushnumber(L, res);
	else
		lua_pushnil(L);

    return(1);
}
	
// список реализованных в dll пользовательских функций
static struct luaL_Reg ls_lib[] = {
    {"GetCurrentThreadId", forLua_GetCurrentThreadId},
	{"GetTable", forLua_GetTable},
    {"MultTwoNumbers", forLua_MultTwoNumbers},
    {"MultAllNumbers", forLua_MultAllNumbers},
    {nullptr, nullptr}
};

extern "C" LUALIB_API int luaopen_luacdll(lua_State *L) {
	// эта функция выполнится в момент вызова require() в Lua-коде
	// регистрируем реализованные в dll функции, чтобы они стали дуступны для Lua
	// в Lua 5.1 и Lua 5.3 для этого предназначены разные функции
	#if LUA_VERSION_NUM >= 502
		luaL_newlib(L, ls_lib);
	#else
		luaL_openlib(L, "luacdll", ls_lib, 0);
	#endif

	return 1;
}

