//
// Пример простой библиотеки на C++ для вызова ее из LUA
// http://quik2dde.ru/viewtopic.php?id=18
//

#include <windows.h>
#include <process.h>
#include <iostream>
#include <stdio.h>
#include <winuser.h>

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
BOOL APIENTRY DllMain(HANDLE hModule,
	DWORD  ul_reason_for_call,
	LPVOID lpReserved
)
{
	return TRUE;
}

// Эффективное выделение и освобождение двумерного массива размера a x b.
//int** create_array2d(size_t a, size_t b) {
//	int** m = new int* [a];
//	m[0] = new int[a * b];
//	for (size_t i = 1; i != a; ++i)
//		m[i] = m[i - 1] + b;
//	return m;
//}
//void free_array2d(int** m, size_t a, size_t b) {
//	delete[] m[0];
//	delete[] m;
//}

static int forLua_GetTable(lua_State* ctx) {
	HWND hWnd;
	hWnd = FindWindow(NULL, "C:\\QuikKITFinance\\lua-c-dll\\x64\\Release\\Network4RL.exe");

	if (hWnd) {
		PostMessage(hWnd, WM_CHAR, 's', 0);
		PostMessage(hWnd, WM_CHAR, VK_RETURN, 0);
		const char* offer_count = luaL_tolstring(ctx, -3, NULL);
		const char* bid_count = luaL_tolstring(ctx, -3, NULL);
		const char* price_step = luaL_tolstring(ctx, -3, NULL);
		while (*price_step != '\0')
			PostMessage(hWnd, WM_CHAR, *price_step++, 0);
		PostMessage(hWnd, WM_CHAR, VK_RETURN, 0);
		while (*bid_count != '\0')
			PostMessage(hWnd, WM_CHAR, *bid_count++, 0);
		PostMessage(hWnd, WM_CHAR, VK_RETURN, 0);
		while (*offer_count != '\0')
			PostMessage(hWnd, WM_CHAR, *offer_count++, 0);
		PostMessage(hWnd, WM_CHAR, VK_RETURN, 0);
		lua_pop(ctx, 6);

		int t = lua_gettop(ctx);
		lua_pushnil(ctx);
		const char* price;
		const char* quantity;
		//size_t psz = 10;
		while (lua_next(ctx, t) != 0) {
			lua_getfield(ctx, -1, "price");
			price = luaL_tolstring(ctx, -1, NULL);
			while (*price != '\0')
				PostMessage(hWnd, WM_CHAR, *price++, 0);
			PostMessage(hWnd, WM_CHAR, VK_RETURN, 0);
			lua_pop(ctx, 1);
			lua_getfield(ctx, -2, "quantity");
			quantity = luaL_tolstring(ctx, -1, NULL);
			while (*quantity != '\0')
				PostMessage(hWnd, WM_CHAR, *quantity++, 0);
			PostMessage(hWnd, WM_CHAR, VK_RETURN, 0);
			lua_pop(ctx, 1);
			lua_pop(ctx, 3);
		};

		lua_pop(ctx, 1);
		t = lua_gettop(ctx);
		lua_pushnil(ctx);
		while (lua_next(ctx, t) != 0) {
			lua_getfield(ctx, -1, "price");
			price = luaL_tolstring(ctx, -1, NULL);
			while (*price != '\0')
				PostMessage(hWnd, WM_CHAR, *price++, 0);
			PostMessage(hWnd, WM_CHAR, VK_RETURN, 0);
			lua_pop(ctx, 1);
			lua_getfield(ctx, -2, "quantity");
			quantity = luaL_tolstring(ctx, -1, NULL);
			while (*quantity != '\0')
				PostMessage(hWnd, WM_CHAR, *quantity++, 0);
			PostMessage(hWnd, WM_CHAR, VK_RETURN, 0);
			lua_pop(ctx, 1);
			lua_pop(ctx, 3);
		};
	}

	return(0);
};

// список реализованных в dll пользовательских функций
static struct luaL_Reg ls_lib[] = {
	{"GetTable", forLua_GetTable},
	{nullptr, nullptr}
};

extern "C" LUALIB_API int luaopen_luacdll(lua_State * L) {
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

