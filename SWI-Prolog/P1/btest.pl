:- begin_tests(removeFirstMin).
:- include(removeFirstMin).

test(0) :-
    removeFirstMin([3,2,4,2,6],R),
    assertion(R == [3,4,2,6]).

test(1) :-
    removeFirstMin([1,2,3,1,4],R),
    assertion(R == [2,3,1,4]).

test(2) :-
    removeFirstMin([5,4,3,2,1],R),
    assertion(R == [5,4,3,2]).

test(3) :-
    removeFirstMin([3,2,2,4,2],R),
    assertion(R == [3,2,4,2]).

test(4) :-
    removeFirstMin([],R),
    assertion(R == []).

:- end_tests(removeFirstMin).
