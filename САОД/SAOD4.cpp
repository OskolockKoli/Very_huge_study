// SAOD4.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//
#pragma comment(linker, "/STACK:16777216")

#include <iostream>
#include<string>
#include <cctype>
#include <fstream>
#include <ctime>
#include <regex>

using namespace std;

const int c = 1, d = 1, table_len = 3000;
const int key_lenght = 6;

struct Elem {
    string key;
    bool deleted = false;
};


class Dict {
    Elem dict[table_len];
    bool is_key(string key) {
        static const regex r(R"(^[0-9][A-Z][A-Z][A-Z][A-Z][0-9]$)");
        return regex_match(key.data(), r);
    }
    int hash(string key) {
        return (char(key[0]) + char(key[1]) * 5 + char(key[2]) * 5 ^ 2 + char(key[3]) * 5 ^ 3 + char(key[4]) * 5 ^ 4 + char(key[5]) * 5 ^ 5) % 3000;
    }
    
public:
    void add(string key) {
        if (!is_key(key)) {
            cout << "Incorrect key";
            return;
        }
        int id;
        for (int i = 0;; i++) {
            id = hash(key) + c * i + d * pow(i, 2);
            if (id >= table_len) {
              //cout << "\nTable overflow\n";
                return;
            }
            //if (dict[id].key == key) {
            //    //cout << "\nThis key is already in the dict\n";
            //    return;
            //}
            if (dict[id].key.empty()) {
                dict[id].key = key;
                return;
            }
        }
    }

    int find(string key) {
        if (!is_key(key)) {
            cout << "\nIncorrect key\n";
            return -1;
        }
        int id;
        for (int i = 0;; i++) {
            id = hash(key) + c * i + d * pow(i, 2);
            if (id >= table_len || (!dict[id].deleted && dict[id].key.empty())) {
                return -1;
            }
            if (dict[id].key == key) {
                return id;
            }
        }
    }

    string find(int index) {
        if (index >= table_len) {
            cout << "Incorrect index";
            return "";
        }
        if (dict[index].key.empty())
            return "";
        return dict[index].key;
    }

    void show() {
        for (int i = 0; i < table_len; i++)
            if (!dict[i].key.empty())
                cout << dict[i].key << " " << i << " ";
        cout << endl;
    }

    void del(string key) {
        if (!is_key(key)) {
            cout << "\nIncorrect key\n";
            return;
        }
        int id = find(key);
        if (id != -1) {
            dict[id].deleted = true;
            dict[id].key = "";
        }
    }
};

void fill_table(Dict &table) {
    string key = "123456";
    for (int i = 0; i < table_len * 2; i++) {
        for (int j = 0; j < key_lenght; j++) {
            if (j == 0 || j == 5)
                key[j] = '0' + rand() % ('9' - '0');
            else
                key[j] = 'A' + rand() % ('Z' - 'A');
        }
        table.add(key);
    }
}

void w_file(Dict table) {
    fstream file("stat.txt", ios_base::out);
    if (!file.is_open()) {
        cerr << "File can't open\n";
        return;
    }
    for (int i = 0; i < table_len; i++) {
        if (!table.find(i).empty())
            file << i << "\t" << table.find(i) << '\n';
    }
    file.close();
}

string input_str() {
    cout << "Input correct string\n";
    string value;
    cin >> value;
    while (cin.fail() || cin.get() != '\n')
    {
        cin.clear(); // очистить флаги ошибок
        cin.ignore(9999, '\n'); //поугглить нада
        cin.sync(); //очистить поток
        cout << "Input correct string\n";
        cin >> value;
    }
    return value;
}

int input_int() {
    cout << "Input correct int\n";
    int value;
    cin >> value;
    while (cin.fail() || cin.get() != '\n')
    {
        cin.clear(); // очистить флаги ошибок
        cin.ignore(9999, '\n'); //поугглить нада
        cin.sync(); //очистить поток
        cout << "Input correct int\n";
        cin >> value;
    }
    return value;
}

int main()
{
    setlocale(0, "");
    srand(time(NULL));
    int choise = 9;
    bool flag = false;
    Dict test;
    cout << "Table creadted!\n";
    for(;;) {
        cout << "1. Fill table\n";
        cout << "2. Add element\n";
        cout << "3. Print table\n";
        cout << "4. Find element\n";
        cout << "5. Delete elemet\n";
        cout << "6. Save table in file\n";
        cout << "0. Exit\n";
        cout << "\n";
        cout << "Choise punct: ";
        choise = input_int();
        cout << "--------------------------------------\n";
        cout << "\n";
        switch (choise) {
        case 1: {
            fill_table(test);
            break;
        }
        case 2:{
            string key;
            key = input_str();
            test.add(key);
            break;
        }
        case 3: {
            test.show();
            break;
        }
        case 4: {
            string key;
            key = input_str();
            test.find(key);
            break;
        }
        case 5: {
            string key;
            key = input_str();
            test.del(key);
            break;
        }
        case 6: {
            w_file(test);
            break;
        }
        case 0: {
            return 0;
        }

        }
    }
}
