% 8.
%   a. Determine the successorof a number represented as digits in a list.
%   Eg.: [1 9 3 5 9 9] => [1 9 3 6 0 0]

% Mathematical model:
% successor(l, c) =>
%   = void,     if l is void
%   = [0],      if l1 = 9 and c = 1 and n = 1
%   = [1,0],    if l1 = 9 and c = 0 and n = 1
%   = [l1+1],   if l1 =/= 9 and c = 0
%   = {0} U successor(l2,l3,...,ln, 1), if l1 = 9 and c = 1
%   = {l1+c} U successor(l2,l3,...,ln, 0), otherwise

% successor (L - list, R - list)
% flow models (i, o), (i, i)

% TESTS:
% successor([1,9,3,5,9,9],R).   R = [1,9,3,6,0,0]
% successor([1],R).             R = [2]
% successor([],R).              R = []
% successor([1,9],R).           R = [2,0]
% successor([9],R).             R = [1,0]

successor([], _, []).
successor([9], 1, [0]):-
    !.
successor([9], 0, [1,0]):-
    !.

successor([H], 0, [HR]):-
    H=\=9,
    HR is H + 1,
    !.
successor([9|T], 1, [0|R]):-
    successor(T, 1, R),
    !.
successor([H|T], 0, [HR|R]):-
    successor(T, C, R),
    HR is H + C.

% wrapper
successor([], []).
successor([H|T], [HR|TR]):-
    successor([H|T], 0, [HR|TR]).


testSuccessor():-
    successor([1,9,3,5,9,9], [1,9,3,6,0,0]),
    successor([1], [2]),
    successor([], []),
    successor([1,9], [2,0]),
    successor([9], [1,0]).
