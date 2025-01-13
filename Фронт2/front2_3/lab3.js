var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var Figure = /** @class */ (function () {
    function Figure() {
    }
    Figure.prototype.calcArea = function () {
        throw new Error("Метод вычисления площади должен быть переопределен");
    };
    Figure.prototype.calcPerimeter = function () {
        throw new Error("Метод вычисления периметра должен быть переопределен");
    };
    return Figure;
}());
var Rectangle = /** @class */ (function (_super) {
    __extends(Rectangle, _super);
    function Rectangle(width, height) {
        var _this = _super.call(this) || this;
        _this.width = width;
        _this.height = height;
        return _this;
    }
    Rectangle.prototype.calcArea = function () {
        return this.width * this.height;
    };
    Rectangle.prototype.calcPerimeter = function () {
        return 2 * (this.width + this.height);
    };
    return Rectangle;
}(Figure));
var Circle = /** @class */ (function (_super) {
    __extends(Circle, _super);
    function Circle(radius) {
        var _this = _super.call(this) || this;
        _this.radius = radius;
        return _this;
    }
    Circle.prototype.calcArea = function () {
        return Math.PI * this.radius * this.radius;
    };
    Circle.prototype.calcPerimeter = function () {
        return 2 * Math.PI * this.radius;
    };
    return Circle;
}(Figure));
var Student = /** @class */ (function () {
    function Student(studentName, age, grades) {
        this.studentName = studentName;
        this.age = age;
        this.grades = grades;
    }
    Student.prototype.getName = function () {
        return this.studentName;
    };
    Student.prototype.getAge = function () {
        return this.age;
    };
    Student.prototype.getGrades = function () {
        return this.grades;
    };
    Student.prototype.setName = function (newName) {
        this.studentName = newName;
    };
    Student.prototype.setAge = function (newAge) {
        this.age = newAge;
    };
    Student.prototype.setGrades = function (newGrades) {
        this.grades = newGrades;
    };
    return Student;
}());
var Calc = /** @class */ (function () {
    function Calc() {
    }
    Calc.prototype.Addition = function (a, b) {
        return a + b;
    };
    Calc.prototype.Subtraction = function (a, b) {
        return a - b;
    };
    Calc.prototype.Multiply = function (a, b) {
        return a * b;
    };
    Calc.prototype.Division = function (a, b) {
        return a / b;
    };
    return Calc;
}());
// Создание экземпляров классов
var rect = new Rectangle(6, 6);
var circ = new Circle(9);
var student = new Student('Иванов Иван', 12, 5.5);
var calc = new Calc();
// Получение элемента для вывода
var output = document.getElementById('outputSpan');
// Вывод информации о прямоугольнике
output.innerHTML += "\u041F\u0440\u044F\u043C\u043E\u0443\u0433\u043E\u043B\u044C\u043D\u0438\u043A: <br> \u041F\u043B\u043E\u0449\u0430\u0434\u044C: ".concat(rect.calcArea(), " <br> \u041F\u0435\u0440\u0438\u043C\u0435\u0442\u0440: ").concat(rect.calcPerimeter(), " <br><br>");
// Вывод информации о круге
output.innerHTML += "\u041A\u0440\u0443\u0433: <br> \u041F\u043B\u043E\u0449\u0430\u0434\u044C: ".concat(circ.calcArea(), " <br> \u041F\u0435\u0440\u0438\u043C\u0435\u0442\u0440: ").concat(circ.calcPerimeter(), " <br><br>");
// Вывод информации о студенте
output.innerHTML += "\u0421\u0442\u0443\u0434\u0435\u043D\u0442: <br> Name: ".concat(student.getName(), " <br> \u0412\u043E\u0437\u0440\u0430\u0441\u0442: ").concat(student.getAge(), " <br> \u0421\u0440\u0435\u0434\u043D\u0438\u0439 \u0431\u0430\u043B\u043B: ").concat(student.getGrades(), " <br><br>");
// Изменение информации о студенте
student.setName('Петров Петр');
student.setAge(23);
student.setGrades(5.7);
// Вывод измененной информации о студенте
output.innerHTML += "\u0418\u0437\u043C\u0435\u043D\u0435\u043D\u043D\u0430\u044F \u0438\u043D\u0444\u043E\u0440\u043C\u0430\u0446\u0438\u044F \u043E \u0441\u0442\u0443\u0434\u0435\u043D\u0442\u0435: <br> Name: ".concat(student.getName(), " <br> \u0412\u043E\u0437\u0440\u0430\u0441\u0442: ").concat(student.getAge(), " <br> \u0421\u0440\u0435\u0434\u043D\u0438\u0439 \u0431\u0430\u043B\u043B: ").concat(student.getGrades(), " <br><br>");
// Вывод результатов работы калькулятора
output.innerHTML += "\u041A\u0430\u043B\u044C\u043A\u0443\u043B\u044F\u0442\u043E\u0440: <br> \u0421\u043B\u043E\u0436\u0435\u043D\u0438\u0435 (1+0): ".concat(calc.Addition(1, 0), " <br> \u0412\u044B\u0447\u0438\u0442\u0430\u043D\u0438\u0435(1-0): ").concat(calc.Subtraction(1, 0), " <br> \u0423\u043C\u043D\u043E\u0436\u0435\u043D\u0438\u0435(2*2): ").concat(calc.Multiply(2, 2), " <br> \u0414\u0435\u043B\u0435\u043D\u0438\u0435(4/2): ").concat(calc.Division(4, 2), " <br><br>");
