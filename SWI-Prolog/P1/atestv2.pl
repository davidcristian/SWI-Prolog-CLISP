:- begin_tests(isEvenv2).
:- include(isEvenv2).

test(0) :-
    isEvenv2([], R),
    assertion(R == 1).

test(1) :-
    isEvenv2([1], R),
    assertion(R == 0).

test(2) :-
    isEvenv2([1,2], R),
    assertion(R == 1).

test(3) :-
    isEvenv2([1,2,3], R),
    assertion(R == 0).

test(4) :-
    isEvenv2([1,2,3,4], R),
    assertion(R == 1).

:- end_tests(isEvenv2).
