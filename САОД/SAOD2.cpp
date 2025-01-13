// SAOD2.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>

using namespace std;

int input_int() {
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

struct Elem
{
	int value;
	Elem* next, * prev;
};

class List {
	int count = 0;
	Elem* head, *tail;
public:
	int get_len() {
		return count;
	}

	void add_tail() {
		Elem* tmp = new Elem;
		int value = input_int();
		if (count == 0) {
			head = tail = tmp;
			tmp->next = tmp;
			tmp->prev = tmp;
		}
		else {
			tail->next = tmp;
			head->prev = tmp;
			tmp->prev = tail;
			tail = tmp;
			tmp->next = head;
		}
		tmp->value = value;
		count++;
	}
	
	void add_tail(int value) {
		Elem* tmp = new Elem;
		if (count == 0) {
			head = tail = tmp;
			tmp->next = tmp;
			tmp->prev = tmp;
		}
		else {
			tail->next = tmp;
			head->prev = tmp;
			tmp->prev = tail;
			tail = tmp;
			tmp->next = head;
		}
		tmp->value = value;
		count++;
	}

	void show_list() {
		Elem* tmp = head;
		for (int i = 0; i < count; i++) {
			cout << tmp->value << " ";
			tmp = tmp->next;
		}
	}

	Elem* get_elem(int position) {
		Elem* elem = head;
		int i = 0;
		while (i < position)
		{
			elem = elem->next;
			i++;
		}
		return elem;
	}

	void del_elem(int position) {
		Elem* del = get_elem(position);
		if (count != 1) {
			Elem* prevDel = del->prev;
			Elem* afterDel = del->next;
			prevDel->next = afterDel;
			afterDel->prev = prevDel;
			if (position == 0)
				head = afterDel;
			else if (position == count - 1)
				tail = prevDel;
			
		}
		else {
			head = 0;
			tail = 0;
		}
		delete del;
		count--;
	}

	void del_list() {
		while (count != 0)
			del_elem(0);
	}

	void copy_1(List list_a) {
		for (int i = 0; i < list_a.get_len(); i++) {
			add_tail((list_a.get_elem(i)->value) * (-1));
		}
	}

	void copy_2(List list_a) {
		for (int i = 0; i < list_a.get_len(); i++) {
			add_tail(abs(list_a.get_elem(i)->value));
		}
	}

	void copy_3(List list_a, List list_b) {
		for (int i = 0; i < list_a.get_len(); i++) {
			if (list_a.get_elem(i)->value + list_b.get_elem(i)->value != 0)
				add_tail(list_a.get_elem(i)->value + list_b.get_elem(i)->value);
		}
	}
};




int main()
{
	setlocale(0, "");
	List list;
	cout << "Введите длину списка\n";
	int n = input_int();
	cout << "\nЗаполните список\n";
	for (int i = 0; i<n; i++)
		list.add_tail();
	cout << "\nПолученный список\n" << endl;
	list.show_list();
	List list_a; 
	list_a.copy_1(list);
	cout << "\nСписок для 1 последовательности\n";
	list_a.show_list();
	List list_b;
	list_b.copy_2(list);
	cout << "\nСписок для 2 последовательности\n";
	list_b.show_list();
	List list_c;
	list_c.copy_3(list_a, list_b);
	cout << "\nСписок для 3 последовательности\n";
	list_c.show_list();
	list.del_list();
	list_b.del_list();
	list_a.del_list();
	list_c.del_list();
	return 0;
}

