//
// ������ ������� ���������� �� C++ ��� ������ �� �� LUA
// http://quik2dde.ru/viewtopic.php?id=18
//

#include <windows.h>
#include <process.h>
#include <iostream>
#include <stdio.h>

// � ������ ������ ������� �� Lua-���� �� ������� DLL
// ���������� ���������� ��� ��������� �� ����������� ������������ ������ Lua
#define LUA_LIB
#define LUA_BUILD_AS_DLL

// ���������� ������������ ����� �� ������������ Lua
// �.�. ��� ������ C++, �� ���������� ������ ���� ���������, ��� ��������� ������������ ������������ ����� Lua, ��������� ��� "������� C"
// ���������� ���� � ������ Lua5.1, Lua5.3 ��� Lua5.4 ����� � ���������� ������� (������ � ����������� �� ���������� �������� 
// � Solution Configurations)
#include "lua.hpp"

// ����������� ����� ����� ��� DLL
BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
	return TRUE;
}

// ���������� ���������������� �������, ���������� �� Lua

static int forLua_GetCurrentThreadId(lua_State* L) {
	// ���������� ���� ������������� ��������, ���������� �� Win API �������
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
	size_t visited = 0;
	while (lua_next(ctx, t)) {
		++visited;
		if (!lua_isnumber(ctx, -2) || !lua_isnumber(ctx, -1)) {
			lua_pushstring(ctx, "Conversion error");
			return lua_error(ctx);
		}
//		std::cout << lua_tointeger(ctx, -2) << lua_tointeger(ctx, -1);
		printf("%s - %s\n",
			lua_typename(ctx, lua_type(ctx, -2)),
			lua_typename(ctx, lua_type(ctx, -1)));
//			lua_tostring(ctx, -2),
//			lua_tostring(ctx, -1));
		lua_pop(ctx, 1);
	}
}

static int forLua_MultTwoNumbers(lua_State *L) {
	// �������� ������ � ������ ��������� ������ ������� �� ����� � ��������� ������� �� �����
    double d1 = luaL_checknumber(L, 1);
    double d2 = luaL_checknumber(L, 2);

	// �������� � ���� ��������� ���������
    lua_pushnumber(L, d1 * d2);

    return(1);  // ��� ������� ���������� ���� ��������
}
	
static int forLua_MultAllNumbers(lua_State *L) {
	const int n = lua_gettop(L);  // ���������� ���������� ����������
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
	
// ������ ������������� � dll ���������������� �������
static struct luaL_Reg ls_lib[] = {
    {"GetCurrentThreadId", forLua_GetCurrentThreadId},
	{"GetTable", forLua_GetTable},
    {"MultTwoNumbers", forLua_MultTwoNumbers},
    {"MultAllNumbers", forLua_MultAllNumbers},
    {nullptr, nullptr}
};

extern "C" LUALIB_API int luaopen_luacdll(lua_State *L) {
	// ��� ������� ���������� � ������ ������ require() � Lua-����
	// ������������ ������������� � dll �������, ����� ��� ����� �������� ��� Lua
	// � Lua 5.1 � Lua 5.3 ��� ����� ������������� ������ �������
	#if LUA_VERSION_NUM >= 502
		luaL_newlib(L, ls_lib);
	#else
		luaL_openlib(L, "luacdll", ls_lib, 0);
	#endif

	return 1;
}

