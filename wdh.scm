
(define leipzig (lambda (ziel)
  (cond
    ((eqv? ziel 'magdeburg) 130)
    ((eqv? ziel 'erfurt) 140)
    ((eqv? ziel 'dresden) 113))))

(define magdeburg (lambda (ziel)
  (cond
    ((eqv? ziel 'leipzig) 130)
    ((eqv? ziel 'erfurt) 168)
    ((eqv? ziel 'dresden) 230))))

(define erfurt (lambda (ziel)
  (cond
    ((eqv? ziel 'leipzig) 140)
    ((eqv? ziel 'magdeburg) 168)
    ((eqv? ziel 'dresden) 218))))

(define dresden (lambda (ziel)
  (cond
    ((eqv? ziel 'leipzig) 113)
    ((eqv? ziel 'erfurt) 218)
    ((eqv? ziel 'magdeburg) 230))))


