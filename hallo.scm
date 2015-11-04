
(library (hello v0.001)
   (export hello)
   (import (rnrs))

   (define (hello name)
      (if (null? name)(set! name "world"))
      (display "Hello " name "!"))
)

