(defun reverse-and-nest-head (lst)
  (if (null lst)                   ; Базовий випадок: якщо список порожній
      nil                          ; повернути порожній список
      (if (null (cdr lst))         ; якщо список містить лише один елемент
          (list (car lst))         ; повернути цей елемент у вигляді списку
          (list (reverse-and-nest-head (cdr lst)) (car lst))))) ; рекурсивно обробити хвіст і додати голову


;; Реалізація функції duplicate-elements
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

;; Функція для перевірки результатів
(defun check-function (name fn input expected &optional extra)
  (let ((result (if extra
                    (funcall fn input extra)
                    (funcall fn input))))
    (format t "~:[FAILED~;passed~]... ~a~%~%Expected: ~a~%Got: ~a~%~%"
            (equal result expected)
            name expected result)))

;; Тести для reverse-and-nest-head
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

;; Тести для duplicate-elements
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

;; Виконання тестів
(defun run-tests ()
  (test-reverse-and-nest-head)
  (test-duplicate-elements))

;; Викликаємо тести
(run-tests)
