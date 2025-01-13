class Figure {

    calcArea() {
        throw new Error("Метод вычисления площади должен быть переопределен");
    }

    calcPerimeter() {
        throw new Error("Метод вычисления периметра должен быть переопределен");
    }

}

class Rectangle extends Figure {
    public width:number;
    public height:number;
    constructor(width: number, height: number) {
        super();
        this.width = width;
        this.height = height;
    }

    calcArea() {
        return this.width * this.height;
    }

    calcPerimeter() {
        return 2 * (this.width + this.height);
    }
}

class Circle extends Figure {
    public radius:number;
    constructor(radius: number) {
        super();
        this.radius = radius;
    }

    calcArea() {
        return Math.PI * this.radius * this.radius;
    }

    calcPerimeter() {
        return 2 * Math.PI * this.radius;
    }
}

class Student {
    protected studentName: string;
    protected age: number;
    protected grades: number;
    constructor(studentName: string, age: number, grades: number) {
        this.studentName = studentName;
        this.age = age;
        this.grades = grades;
    }


    getName() {
        return this.studentName;
    }

    getAge() {
        return this.age;
    }

    getGrades() {
        return this.grades;
    }

    setName(newName: string) {
        this.studentName = newName;
    }

    setAge(newAge: number) {
        this.age = newAge;
    }

    setGrades(newGrades: number) {
        this.grades = newGrades;
    }
}

class Calc {

    Addition(a: any, b: any) {
        return a + b;
    }

    Subtraction(a: number, b: number) {
        return a - b;
    }

    Multiply(a: number, b: number) {
        return a * b;
    }

    Division(a: number, b: number) {
        return a / b;
    }
}

let rect = new Rectangle(6, 6);
let circ = new Circle(9);
let student = new Student('Иванов Иван', 12, 5.5);
let calc = new Calc();

let output = document.getElementById('outputSpan');

output.innerHTML += `Прямоугольник: <br> Площадь: ${rect.calcArea()} <br> Периметр: ${rect.calcPerimeter()} <br><br>`;

output.innerHTML += `Круг: <br> Площадь: ${circ.calcArea()} <br> Периметр: ${circ.calcPerimeter()} <br><br>`;

output.innerHTML += `Студент: <br> Name: ${student.getName()} <br> Возраст: ${student.getAge()} <br> Средний балл: ${student.getGrades()} <br><br>`;

student.setName('Петров Петр');
student.setAge(23);
student.setGrades(5.7);

output.innerHTML += `Измененная информация о студенте: <br> Name: ${student.getName()} <br> Возраст: ${student.getAge()} <br> Средний балл: ${student.getGrades()} <br><br>`;

output.innerHTML += `Калькулятор: <br> Сложение (0+1): ${calc.Addition(0, 1)} <br> Вычитание(1-0): ${calc.Subtraction(1, 0)} <br> Умножение(2*2): ${calc.Multiply(2, 2)} <br> Деление(4/2): ${calc.Division(4, 2)} <br><br>`;
