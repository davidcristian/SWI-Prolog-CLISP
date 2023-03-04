; 11.
; a) Determine the least common multiple of the numerical values of a nonlinear list.
; b) Write a function to test if a linear list of numbers has a "mountain" aspect (a list has a "mountain" aspect if the items increase to a certain point and then decreases.
;       Eg. (10 18 29 17 11 10). The list must have at least 3 atoms to fullfil this criteria.
; c) Remove all occurrences of a maximum numerical element from a nonlinear list.
; d) Write a function which returns the product of numerical even atoms from a list, to any level.

; a) Determine the least common multiple of the numerical values of a nonlinear list.

; cGCD(a, b) = 
; = a,                  if b = 0
; = cGCD(b, a % b),    otherwise

(defun cGCD (a b)
    (cond
        ((equal b 0) a)
        (T (cGCD b (mod a b)))
    )
)

; cLCM(a, b) = 
; = a,                      if b is not a number
; = b,                      if a is not a number
; = a * b / cGCD(a, b),    otherwise

(defun cLCM (a b)
    (cond
        ((not (numberp b)) a)
        ((not (numberp a)) b)
        (t (/ (* a b) (cGCD a b)))
    )
)

; listLCM(l1l2...ln) = 
; = l1,                                     if n = 1 and l1 is a number
; = cLCM(listLCM(l1), listLCM(l2...ln)),   if l1 is a list
; = cLCM(l1, listLCM(l2...ln)),            otherwise

(defun listLCM (l)
    (cond
        ((and (atom (car l)) (null (cdr l))) (car l))
        ((listp (car l)) (cLCM (listLCM (car l)) (listLCM (cdr l))))
        (T (cLCM (car l) (listLCM (cdr l))))
    )
)

(defun testA()
    (assert
        (and
            (equal (listLCM '(24 (16 (12 A B)) 72)) 144)
            (equal (listLCM '(1 2 (3 (4 (5))))) 60)
            (equal (listLCM '(1 2 (3 (4 (5 6))))) 60)
            (equal (listLCM '(1 2 (3 (4 (5 6) 7)))) 420)
            (equal (listLCM '(1 2 (3 (4 (5 6) 7) 8))) 840)
            (equal (listLCM '(1 2 (3 (4 (5 6) 7) 8) 9)) 2520)
            (equal (listLCM '(1 2 (3 (4 (5 6) 7) 8) 9 10)) 2520)
            (equal (listLCM '()) nil)
            (equal (listLCM '(7)) 7)
            (equal (listLCM '(1 2 () 3)) 6)
            (equal (listLCM '(1 2 (()) 3)) 6)
            (equal (listLCM '(1 2 3 A)) 6)
            (equal (listLCM '(A 1 2 3)) 6)
        )
    )
)

; b) Write a function to test if a linear list of numbers has a "mountain" aspect (a list has a "mountain" aspect if the items increase to a certain point and then decreases.
;       Eg. (10 18 29 17 11 10). The list must have at least 3 atoms to fullfil this criteria.

; mountain(l1l2...ln, prev, decr) =
; = decr, if n = 0
; = mountain(l2l3...ln, l1, decr), if prev is nil
; = mountain(l2l3...ln, l1, 0), if prev < l1 and decr = 0
; = 0, if prev < l1 and decr = 1
; = mountain(l2l3...ln, l1, 1), if prev > l1 and decr = 0
; = 0, otherwise

(defun mountain (l l1 decr modi)
	(cond
        ((and (null l) (= modi 1) decr))
		((null l1) (mountain (cdr l) (car l) decr 0))

		((and (< l1 (car l)) (= decr 0)) (mountain (cdr l) (car l) 0 1))
		((and (< l1 (car l)) (= decr 1)) 0)
		
        ((and (> l1 (car l)) (= decr 0)) (mountain (cdr l) (car l) 1 1))
		
        (t 0)
	)
)

(defun mainB (l)
    (cond
        ((< (list-length l) 3) 0)
        (t (mountain l nil 0 0))
    )
)

(defun testB()
    (assert
        (and
            (equal (mainB '(1 2 3 2)) 1)
            (equal (mainB '(3 2 1)) 0)
            (equal (mainB '(1 2 3 4)) 0)
            (equal (mainB '(1 2 3 2)) 1)
            (equal (mainB '(4 3 2 1)) 0)
            (equal (mainB '(4 3 2 3)) 0)
            (equal (mainB '(10 18 29 17 11 10 12)) 0)
            (equal (mainB '(10 18 29 17 11 29 10)) 0)
            (equal (mainB '()) 0)
            (equal (mainB '(1)) 0)
            (equal (mainB '(1 2)) 0)
            (equal (mainB '(1 2 3)) 0)
            (equal (mainB '(1 2 3 2)) 1)
        )
    )
)

; c) Remove all occurrences of a maximum numerical element from a nonlinear list.

; cMax(a, b) = 
; = a , if b is not a number
; = b , if a is not a number
; = a , if a > b
; = b , otherwise

(defun cMax(a b)
    (cond
        ((not (numberp b)) a)
        ((not (numberp a)) b)
        ((> a b) a)
        (t b)
    )
)

; listMax(l1l2...ln) = 
; = nil , if n = 0
; = cMax(listMax(l1), listMax(l2...ln)) , if l1 is a list
; = cMax(l1, listMax(l2...ln)) , otherwise

(defun listMax(l)
    (cond
        ((null l) nil)
        ((listp (car l)) (cMax (listMax (car l)) (listMax (cdr l))))
        (t (cMax (car l) (listMax (cdr l))))
    )
)

; cAppend (l1l2...ln, p1p2...pm) = 
; = p1p2...pm, if n = 0
; = {l1} U cAppend(l2...ln, p1p2...pm) , otherwise

(defun cAppend (l p)
    (cond
        ((null l) p)
        (t (cons (car l) (cAppend (cdr l) p)))
    )
)

; listRemove(l1l2...ln, elem) = 
; = nil , if n = 0
; = listRemove(l1, elem) U listRemove(l2...ln, elem) , if l1 is a list
; = listRemove(l2...ln, elem) , if l1 = elem
; = {l1} U listRemove(l2...ln, elem) , otherwise

(defun listRemove(l elem)
    (cond
        ((null l) nil)
        ((listp (car l)) (cons (listRemove (car l) elem) (listRemove (cdr l) elem)))
        ((equal (car l) elem) (listRemove (cdr l) elem))
        (t (cons (car l) (listRemove (cdr l) elem)))
    )
)

(defun mainC(l)
    (listRemove l (listMax l))
)

(defun testC()
    (assert
        (and
            (equal (mainC '(1 2 3 4)) '(1 2 3))
            (equal (mainC '()) nil)
            (equal (mainC '(1 (2 3) 4 4)) '(1 (2 3)))
            (equal (mainC '(1 5 (3 5) 4)) '(1 (3) 4))
            (equal (mainC '(1 5 5 (5 5))) '(1 ()))
        )
    )
)

; d) Write a function which returns the product of numerical even atoms from a list, to any level.

; isEven(a) = 
; = t , if a % 2 = 1
; = nil (false) , otherwise

(defun isEven (a)
    (equal 0 (mod a 2))
)

; evenProduct(l1l2...ln) = 
; = 1, if n = 0
; = evenProduct(l1) * evenProduct(l2...ln) , if l1 is a list
; = l1 * evenProduct(l2...ln) , if l1 is a number and is even
; = evenProduct(l2...ln) , otherwise

(defun evenProduct(l)
    (cond
        ((null l) 1)
        ((listp (car l)) (* (evenProduct (car l)) (evenProduct (cdr l))))
        ((and (numberp (car l)) (isEven (car l))) (* (car l) (evenProduct (cdr l))))
        (t (evenProduct (cdr l)))
    )
)

(defun testD()
    (assert
        (and
            (equal (evenProduct '(1 2 3 4)) 8)
            (equal (evenProduct '()) 1)
            (equal (evenProduct '(1 2 3 4 4)) 32)
            (equal (evenProduct '(1 (5 3) (5) 4)) 4)
            (equal (evenProduct '(1 (5 (2) 5) 5)) 2)
            (equal (evenProduct '(1 (5 (2) 5) 5 6)) 12)
        )
    )
)

; b) Write a function to test if a linear list of numbers has a "valley" aspect (a list has a "mountain" aspect if the items decrease to a certain point and then increases.
;       Eg. (29 18 10 17 18 20). The list must have at least 3 atoms to fullfil this criteria.

; valley(l1l2...ln, prev, incr) =
; = incr, if n = 0
; = valley(l2l3...ln, l1, incr), if prev is nil

; = valley(l2l3...ln, l1, 0), if prev > l1 and incr = 0
; = 0, if prev > l1 and incr = 1
; = valley(l2l3...ln, l1, 1), if prev < l1 and incr = 0
; = 1, otherwise

(defun valley (l l1 incr modi)
	(cond
        ((and (null l) (= modi 1)) incr)
		((null l1) (valley (cdr l) (car l) incr 0))

		((and (> l1 (car l)) (= incr 0)) (valley (cdr l) (car l) 0 1))
		((and (> l1 (car l)) (= incr 1)) 0)
        
		((and (< l1 (car l)) (= incr 0)) (valley (cdr l) (car l) 1 1))

        (t 0)
	)
)

(defun mainV (l)
    (cond
        ((< (list-length l) 3) 0)
        (t (valley l nil 0 0))
    )
)

(defun testV()
    (assert
        (and
            (equal (mainV '(5 4 3 2)) 0)
            (equal (mainV '(5 4 3 2 4)) 1)
            (equal (mainV '()) 0)
            (equal (mainV '(1 2)) 0)
            (equal (mainV '(1)) 0)
            (equal (mainV '(3 2 1 2)) 1)
            (equal (mainV '(1 2 3 2)) 0)
            (equal (mainV '(3 2 1)) 0)
        )
    )
)
