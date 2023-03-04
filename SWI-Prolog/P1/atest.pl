:- begin_tests(isEven).
:- include(isEven).

test(0) :-
    (  isEven([])
    -> R = true
    ;  R = false
    ),
    assertion(R == true).

test(1) :-
    (  isEven([1])
    -> R = true
    ;  R = false
    ),
    assertion(R == false).

test(2) :-
    (  isEven([1,2])
    -> R = true
    ;  R = false
    ),
    assertion(R == true).

test(3) :-
    (  isEven([1,2,3])
    -> R = true
    ;  R = false
    ),
    assertion(R == false).

test(4) :-
    (  isEven([1,2,3,4])
    -> R = true
    ;  R = false
    ),
    assertion(R == true).

:- end_tests(isEven).
