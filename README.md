<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>

<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>

<p align="right"><b>Студент</b>: Абраменко Данило Олександрович КВ-13</p>
<p align="right"><b>Рік</b>: 2024</p>

## Загальне завдання

Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за
можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно
реалізувати, задаються варіантом (п. 2.1.1). Вимоги до функцій:

1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового
   списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій
   для роботи зі списками, що не наведені в четвертому розділі навчального
   посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції
   в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів.
   Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
   мають бути оформленні у вигляді модульних тестів

## Варіант 3

1. Написати функцію reverse-and-nest-head , яка обертає вхідний список та утворює
вкладeну структуру з підсписків з його елементами, починаючи з голови:

```lisp
CL-USER> (reverse-and-nest-head '(a b c))
(((C) B) A)
```

2. Написати функцію duplicate-elements , що дублює елементи вхідного списку
задану кількість разів:

```lisp
CL-USER> (duplicate-elements '(a b c) 3)
(A A A B B B C C C)
```

## Лістинг функції reverse-and-nest-head

```lisp
(defun reverse-and-nest-head (lst)
  (if (null lst)                   ; Базовий випадок: якщо список порожній
      nil                          ; повернути порожній список
      (if (null (cdr lst))         ; якщо список містить лише один елемент
          (list (car lst))         ; повернути цей елемент у вигляді списку
          (list (reverse-and-nest-head (cdr lst)) (car lst))))) ; рекурсивно обробити хвіст і додати голову
```

### Тестові набори

```lisp
(defun test-reverse-and-nest-head ()
  (check-function "reverse-and-nest-head test 1"
                  #'reverse-and-nest-head '(a b c)
                  '(((c) b) a))
  (check-function "reverse-and-nest-head test 2"
                  #'reverse-and-nest-head '(1 2 3)
                  '(((3) 2) 1))
  (check-function "reverse-and-nest-head test 3"
                  #'reverse-and-nest-head '()
                  nil))
```

### Тестування

```lisp
passed... reverse-and-nest-head test 1

Expected: (((C) B) A)
Got: (((C) B) A)

passed... reverse-and-nest-head test 2

Expected: (((3) 2) 1)
Got: (((3) 2) 1)

passed... reverse-and-nest-head test 3

Expected: NIL
Got: NIL
```

## Лістинг функції list-set-union

```lisp
(defun duplicate-elements (lst n)
  (if (null lst)                   ; Базовий випадок: якщо список порожній
      nil                          ; повернути порожній список
      (append                      ; додаємо результат для поточного елемента до результату для хвоста
       (duplicate-element (car lst) n) ; дублюємо поточний елемент n разів
       (duplicate-elements (cdr lst) n)))) ; рекурсивно обробляємо хвіст списку

(defun duplicate-element (element n)
  (if (= n 0)                      ; якщо n досягнуло 0
      nil                          ; повернути порожній список
      (cons element (duplicate-element element (1- n))))) ; додаємо елемент до списку і рекурсивно зменшуємо n
```

### Тестові набори

```lisp
(defun test-duplicate-elements ()
  (check-function "duplicate-elements test 1"
                  #'duplicate-elements '(a b c)
                  '(a a a b b b c c c)
                  3)
  (check-function "duplicate-elements test 2"
                  #'duplicate-elements '(1 2)
                  '(1 1 2 2)
                  2)
  (check-function "duplicate-elements test 3"
                  #'duplicate-elements '()
                  nil
                  5))
```

### Тестування

```lisp
passed... test 1
passed... duplicate-elements test 1

Expected: (A A A B B B C C C)
Got: (A A A B B B C C C)

passed... duplicate-elements test 2

Expected: (1 1 2 2)
Got: (1 1 2 2)

passed... duplicate-elements test 3

Expected: NIL
Got: NIL
```
