﻿// Network4RL.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <string>
#include <iostream>
using namespace std;

int main()
{
    string s;
    float price_step;
    int offer_count;
    int bid_count;

    cout << "Hello World!\n";
    int j = 0;
    //std::size_t ssz;
    while (true) {
        cin >> s;
        cout << "=====  " << s << " ======" << endl;
        if (s == "s") {
            cin >> s;
            //ssz = s.size();
            //price_step = stof(s, &ssz);
            price_step = stof(s);
            cin >> s;
            offer_count = stoi(s);
            cin >> s;
            bid_count = stoi(s);
            for (int i = 1; i <= 40; i++) {
                cin >> s;
                cin >> s;
            }
            cout << "=====  " << j++ << " ======" << endl;
        }
        //if (s == "0") break;
    }
}

// Запуск программы: CTRL+F5 или меню "Отладка" > "Запуск без отладки"
// Отладка программы: F5 или меню "Отладка" > "Запустить отладку"

// Советы по началу работы 
//   1. В окне обозревателя решений можно добавлять файлы и управлять ими.
//   2. В окне Team Explorer можно подключиться к системе управления версиями.
//   3. В окне "Выходные данные" можно просматривать выходные данные сборки и другие сообщения.
//   4. В окне "Список ошибок" можно просматривать ошибки.
//   5. Последовательно выберите пункты меню "Проект" > "Добавить новый элемент", чтобы создать файлы кода,
//       или "Проект" > "Добавить существующий элемент", чтобы добавить в проект существующие файлы кода.
//   6. Чтобы снова открыть этот проект позже, выберите пункты меню "Файл" > "Открыть" > "Проект" и выберите SLN-файл.

