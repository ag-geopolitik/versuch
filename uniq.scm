
;; Schreibe eine Funktion, welche doppelte Elemente
;; aus einer Liste entfernt.

;; das ist das gleiche wie null?
;; (define nil? (lambda (l) (eq? l '())))

;; (import)

(define make-unique
  (lambda (a b)
    (if (null? b) a
      (if (eq? (car a) (car b))
	(make-unique a (cdr b))
	(make-unique (append a (cons (car b) '())) (cdr b))))))

(define make-unique-x
  (lambda (a b)
    (display a)(display "\n")
    (display b)(display "\n")
    (if (null? b) a
      (if (pair? b)
        (if (eq? (car a) (car b))
	  (make-unique a (cdr b))
	  (make-unique (append a (car b)) (cdr b)))
        (if (eq? (car a) b) a
          (append a (cons b '())))))))

(define uniq
  (lambda (lst)
    (if (null? lst) '()
      (if (eq? (length lst) 1) lst
        (make-unique (list (car lst)) (uniq (cdr lst)))))))

(display (uniq '(8 8 8)))
(display (uniq '(5 6 7)))
(display (uniq '(1 2 2)))
(display (uniq '(3 4 4 3)))

