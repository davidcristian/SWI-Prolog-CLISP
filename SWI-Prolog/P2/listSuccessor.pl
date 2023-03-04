% 8.
%   b. For a heterogeneous list, formed from integer numbers and list of numbers,
%       determine the successor of a sublist considered as a number.
%   Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] =>
%        [1, [2, 4], 4, 5, [6, 8, 0], 10, 11, [1, 2, 1], 6]

% Mathematical model:
% is_list(l) =>
%   = is_list(l2,l3,...,ln),    if n > 0
%   = true,                     if l is not an unbound term (is an empty storage cell)
%   = false,                    otherwise

% is_list (L)
% flow models (i)

% TESTS:
% is_list([]).      R = true
% is_list([1]).     R = true
% is_list(1).       R = false
% is_list(0).       R = false
% is_list([1,2]).   R = true

is_list([]):- !.
is_list([_|T]):-
    is_list(T), !.
is_list(H):-
    var(H),
    !,
    fail.

% Mathematical model:
% listSuccessor(l) =>
%   = successor(l1) U listSuccessor(l2,l3,...,ln),  if is_list(l1)
%   = listSuccessor(l2,l3,...,ln),                  otherwise

% listSuccessor (L - list, R - list)
% flow models (i, o), (i, i)

% TESTS:
% set_prolog_flag(answer_write_options, [max_depth(0), spacing(next_argument)]).
% listSuccessor([1,[2,3],4,5,[6,7,9],10,11,[1,2,0],6],R).       R = [1,[2,4],4,5,[6,8,0],10,11,[1,2,1],6]
% listSuccessor([],R).                                          R = []
% listSuccessor([1],R).                                         R = [1]
% listSuccessor([1,[],R).                                       R = [1,[]]
% listSuccessor([1,[2,9],R).                                    R = [1,[3,0]]

listSuccessor([], []).
listSuccessor([H|T], [HR|TR]):-
    is_list(H),
    !,
    successor(H, 0, HR),
    listSuccessor(T, TR).
listSuccessor([H|T], [H|R]):-
    listSuccessor(T, R).


testIsList():-
    is_list([]),
    is_list([1]),
    not(is_list(1)),
    not(is_list(0)),
    is_list([1,2]).

testListSuccessor():-
    listSuccessor([1,[2,3],4,5,[6,7,9],10,11,[1,2,0],6], [1,[2,4],4,5,[6,8,0],10,11,[1,2,1],6]),
    listSuccessor([], []),
    listSuccessor([1], [1]),
    listSuccessor([1,[]], [1,[]]),
    listSuccessor([1,[2,9]], [1,[3,0]]).
