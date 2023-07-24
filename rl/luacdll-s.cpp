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


static int forLua_GetTable(lua_State* ctx) {
//	Table t = ctx.global["myTable"];
//	t.iterate([](Valref k, Valref v)
//		{
//			cout << int(k) << int(v);
//		});	
	//return(1);
	//lua_getglobal(ctx, "bid_count");
	lua_Integer	bid_count = lua_tointeger(ctx, -2);
	//lua_getglobal(ctx, "offer_count");
	lua_Integer offer_count = lua_tointeger(ctx, -1);
	//lua_pushinteger(ctx, bid_count);
	//lua_pushinteger(ctx, offer_count);
	//int bc = bid_count * 2;
	//int oc = offer_count * 2;
	//lua_pushinteger(ctx, bc);
	//lua_pushinteger(ctx, oc);
	lua_pop(ctx, 2);

	//if (!lua_istable(ctx, -1) || !lua_istable(ctx, -2)) {
	//	lua_pushstring(ctx, "Conversion error table");
	//	return lua_error(ctx);
	//}

	//int	type1 = lua_getfield(ctx, -1, "bid_count");
	//int type2 = lua_getfield(ctx, -2, "offer_count");

	//int type3 = lua_getfield(ctx, -3, "bid");
	//int type4 = lua_getfield(ctx, -4, "offer");

	//if (lua_istable(ctx, -1)) {
	//	lua_pushstring(ctx, "True table");
	//}

	//else {
	//	lua_pushstring(ctx, "False table");
	//}

	//lua_len(ctx, -2);
	//lua_len(ctx, -2);

	//lua_getglobal(ctx, "tb");
	//int type1 = lua_gettable(ctx, -1); // -1 -2
	//lua_pushstring(ctx, lua_typename(ctx, type1));

	int t = lua_gettop(ctx);
	lua_pushnil(ctx);
	lua_next(ctx, t);
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

	t = lua_gettop(ctx);
	lua_pushinteger(ctx, t);

	return(t + 1);


	//int t = lua_gettop(ctx);
	lua_pushnil(ctx);
	//size_t visited = 0;
	int i = 0;
	int n[20];
	while (lua_next(ctx, t) != 0) {
		//++visited;
		//if (!lua_isnumber(ctx, -2) || !lua_isnumber(ctx, -1)) {
		//	lua_pushstring(ctx, "Conversion error");
		//	return lua_error(ctx);
		//}
		//		std::cout << lua_tointeger(ctx, -2) << lua_tointeger(ctx, -1);
		//printf("%s - %s\n",
		//	lua_typename(ctx, lua_type(ctx, -2)),
		//	lua_typename(ctx, lua_type(ctx, -1)));
		//			lua_tostring(ctx, -2),
		//			lua_tostring(ctx, -1));

		//if (lua_type(ctx, -1) == LUA_TNUMBER) {
		//	n[i] = lua_tointeger(ctx, -1);
		//	i++;
		//}

		//if (lua_type(ctx, -1) == LUA_TTABLE) {
		//	n[i] = lua_tointeger(ctx, -1);
		//	i++;
		//}

		//lua_getfield(ctx, i, "quantity");
		//n[i++] = lua_tointeger(ctx, -1);

		lua_pop(ctx, 1);
	}
	//for (int i = 0; i < 20; ++i) {
	//	lua_pushinteger(ctx, n[i]);
	//}





	//lua_pushstring(ctx, lua_typename(ctx, lua_type(ctx, -3)));
	//lua_pushstring(ctx, lua_typename(ctx, lua_type(ctx, -4)));
	//lua_pushstring(ctx, lua_tostring(ctx, -3));
	//lua_pushstring(ctx, lua_tostring(ctx, -4));
	return(2);



	if (!lua_isnumber(ctx, -2) || !lua_isnumber(ctx, -1)) {
		lua_pushstring(ctx, "Conversion error number");
		return(1);
	}

	if (lua_isnumber(ctx, -1)) {
		lua_pushinteger(ctx, lua_tointeger(ctx, -1));
	}
	else {
		lua_pushstring(ctx, lua_tostring(ctx, -1));
	}

	if (lua_isnumber(ctx, -2)) {
		lua_pushinteger(ctx, lua_tointeger(ctx, -2));
	}
	else {
		lua_pushstring(ctx, lua_tostring(ctx, -2));
	}
	return(2);
	//int n;
	//lua_pushnil(ctx);
	//int visited = 0;
	//while (lua_next(ctx, t)) {
	//	++visited;
	//	if (!lua_isnumber(ctx, -2) || !lua_isnumber(ctx, -1)) {
	//		lua_pushstring(ctx, "Conversion error");
	//		return lua_error(ctx);
	//	}
	//	//std::cout << lua_tointeger(ctx, -2) << lua_tointeger(ctx, -1);
	//	//std::cin >> n;
	//	lua_pop(ctx, 1);
	//}

	//lua_pushnumber(ctx, visited);
	//lua_pushnumber(ctx, t);
	//lua_pushnumber(ctx, n);

	//return(3);
}

	// получаем первый и второй параметры вызова функции из стека с проверкой каждого на число
//    double d1 = luaL_checknumber(L, 1);
//    double d2 = luaL_checknumber(L, 2);
	
//	const int n = lua_gettop(L);  // количество переданных аргументов
//		if (lua_type(L, i) == LUA_TNUMBER)
//			res *= lua_tonumber(L, i);
//		lua_pushnumber(L, res);


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

