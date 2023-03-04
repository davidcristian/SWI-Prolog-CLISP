; Write recursive Lisp functions for the following problems (optionally, you may use MAP functions):
; A binary tree is memorised in the following two ways:
;   (node no-subtrees list-subtree-1 list-subtree-2 ...) (1)
;   (node (list-subtree-1) (list-subtree-2) ...) (2)
; As an example, the tree
;      A
;     / \
;    B   C
;       / \
;      D   E
; is represented as follows:
; (A 2 B 0 C 2 D 0 E 0) (1)
; (A (B) (C (D) (E))) (2)
; Except for problems 4 and 9, conversion between types is not allowed; a direct method should be used instead.


; 7. Return the level of a node X in a tree of type (1). The level of the root element is 0.

; getLevel(l1l2...ln, el, current, ret) =
; = nil, l is void
; = current, if l1 = el

; = nil, if l1 = 0 and ret is void
; = getLevel(l2l3...ln, el, ret1 + 1, ret2ret3retn), if l1 = 0
; = getLevel(l2l3...ln, el, current + 1, ret U current (l1-1 times)), if l1 >= 2
; = getLevel(l2l3...ln, el, current + 1, ret), if l1 = 1

(defun getLevel (l e current ret)
    (cond
        ((null l) nil)
        ((equal (car l) e) current)

        ((and (null ret) (equal (cadr l) 0)) nil)
        ((equal (cadr l) 0) (getLevel (cddr l) e (+ (car ret) 1) (cdr ret) )) ; has no children, so we go to next branch
        ((>= (cadr l) 2) (dotimes (n (- (cadr l) 1)) (setq ret (cons current ret))) (getLevel (cddr l) e (+ current 1) ret )) ; has two children, we set it to return back after going through a branch
        ((equal (cadr l) 1) (getLevel (cddr l) e (+ current 1) ret)) ; has one child
    )
)

; mainB(l1l2...ln, e) =
; = nil, if l is void
; = getLevel(l1l2...ln, e, 0, void), otherwise

(defun mainB (l e)
    (cond
        ((null l) nil)
        (t (getLevel l e 0 `()))
    )
)

(defun testB()
    (assert
        (and
            (equal (mainB `(A 2 B 0 C 2 D 0 E 0) `A) 0)
            (equal (mainB `(A 2 B 0 C 2 D 0 E 0) `B) 1)
            (equal (mainB `(A 2 B 0 C 2 D 0 E 0) `C) 1)
            (equal (mainB `(A 2 B 0 C 2 D 0 E 0) `D) 2)
            (equal (mainB `(A 2 B 0 C 2 D 0 E 0) `E) 2)
            (equal (mainB `(A 2 B 0 C 2 D 0 E 0) `F) nil)
            (equal (mainB `() `F) nil)
        )
    )
)
