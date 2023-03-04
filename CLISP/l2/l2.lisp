; 8. Write a function to determine the number of nodes on the level k from a n-tree represented as follows:
;   (rootlist_nodes_subtree1 ... list_nodes_subtreen)
;   Eg: tree is (a (b (c)) (d) (e (f))) and k=1 => 3 nodes

; levelNodes(l, k, currLevel) =
; = 1,                                                                                                      if l is not a list and k = currLevel
; = 0,                                                                                                      if l is not a list and k != currLevel
; = levelNodes(l1, k, currLevel+1) + levelNodes(l2, k, currLevel+1) + ... + levelNodes(ln, k, currLevel+1), otherwise
(defun levelNodes(l k currLevel)
    (cond
        ((and (atom l) (equal currLevel k)) 1)
        ((atom l) 0)
        (t  (apply #'+  (
                            mapcar #'(lambda (a) (levelNodes a k (+ currLevel 1))) l
                        )
            )
        )
    )
)

(defun mainL2(l k)
    (levelNodes l k -1)
)

(defun testL2()
    (assert
        (and
            (equal (mainL2 '(a (b (c)) (d) (e (f))) 1) 3)
            (equal (mainL2 '(a (b (c)) (d) (e (f))) 2) 2)
            (equal (mainL2 '(a (b (c)) (d) (e (f))) 3) 0)
            (equal (mainL2 '(a (b (c)) (d) (e (f))) 0) 1)
            (equal (mainL2 '() 0) 0)
            (equal (mainL2 '() 4) 0)

            (equal (mainL2 '(a (b (c d e)) (f) (g (h i j))) 2) 6)
            (equal (mainL2 '(a (b (c d e)) (f) (g (h i j))) 0) 1)
            (equal (mainL2 '(a (b (c d e)) (f) (g (h i j))) 1) 3)
            (equal (mainL2 '(a (b (c d e)) (f) (g (h i j))) 3) 0)

            (equal (mainL2 '(a (b (c (d (e (f (g h i j k))))))) 6) 5)
            (equal (mainL2 '(a (b (c (d (e (f (g h i j k))))))) 7) 0)
            (equal (mainL2 '(a (b (c (d (e (f (g h i j k))))))) 5) 1)
            (equal (mainL2 '(a (b (c (d (e (f (g h i j k))))))) 4) 1)
            (equal (mainL2 '(a (b (c (d (e (f (g h i j k))))))) 3) 1)
            (equal (mainL2 '(a (b (c (d (e (f (g h i j k))))))) 2) 1)
            (equal (mainL2 '(a (b (c (d (e (f (g h i j k))))))) 1) 1)
            (equal (mainL2 '(a (b (c (d (e (f (g h i j k))))))) 0) 1)
        )
    )
)
