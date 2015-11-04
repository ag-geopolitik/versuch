

(define fac
  (lambda (n)
    (if (< n 2) 1
      (* n (fac (- n 1))))))


(display (permut-helper '() 'a '((1 2 3)(2 1 3)(3 1 2))))
;; > ((a 1 2 3) (a 2 1 3) (a 3 1 2))

(define permutation
  (lambda (result lst)
    (define permutation-complete?
      (lambda (lst)
        (if (null? lst) #f
          (= (length lst)(fac (length (car lst)))))))

     (if (or (permutation-complete? result)
             (null? lst)) result
       (permutation
         (permut-helper result (car lst) (permutation '() (cdr lst)))
         (rotate lst)))))


(define permutation
  (lambda (result lst)
    (define permutation-complete?
      (lambda (lst)
        (if (null? lst) #f
          (= (length lst)(fac (length (car lst)))))))

     (if (or (permutation-complete? result)
             (null? lst)) result
       (begin 
         (permut-helper result (car lst) (permutation '() (cdr lst)))
         (permutation result (rotate lst))))))

(define permut-helper
  (lambda (result element lst)
    (if (null? lst) result
      (permut-helper
        (append result (list (append (cons element '()) lst)))
        element lst))))

;; Rotiert das erste Element der Liste an deren Ende
(define rotate
  (lambda (lst)
     (if (null? lst) lst
        (append (cdr lst)(list (car lst))))))


(define permutation
  (lambda (lst)

    (define permut-helper
      (lambda (result element lst)
        (if (null? lst) result
          (permut-helper
            (append result (list (append (list element) lst)))
            element lst))))

    (define permutate
      (lambda (result lst less)
        (display lst)(display " - ")(display result)(display "-")(display less)(display "\n")
        (if (null? less) result
            (permutate
              (append result (permut-helper '() (car lst) (permutation (cdr lst))))
              (rotate lst)
              (cdr less)))))
    
    (permutate '() lst lst)))

(permutation '(6 5))
(permutation '(5 9 4))
;;(display (permutation '() '()))


    (define permut-helper
      (lambda (result element lst)
        (if (null? lst) result
          (permut-helper
            (append result (list (append (list element) (car lst))))
            element (cdr lst)))))

(permut-helper '() 5 '((7 6)(5 9)))

(define permutation
  (lambda (lst)

    (define permut-helper
      (lambda (result element lst)
        (if (null? lst) result
          (permut-helper
            (append result (list (append (cons element '()) (car lst))))
            element (cdr lst)))))

    (define permutate
      (lambda (result lst less)
        (if (null? less) result
            (permutate
              (permut-helper result (car lst) (permutation (cdr lst)))
              (rotate lst)
              (cdr less)))))

    ;; Rotiert das erste Element der Liste an deren Ende
    (define rotate
      (lambda (lst)
        (if (null? lst) lst
          (append (cdr lst)(list (car lst))))))
    
    (if (< (length lst) 2) (cons lst '())
       (permutate '() lst lst))))


(permutation '(6 5))
(permutation '(5 9 4))
