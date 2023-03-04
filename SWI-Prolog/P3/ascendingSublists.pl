% 4. The list a1... an is given. Write a predicate to determine all sublists strictly ascending of this list a.

% subset(l1,l2,...,ln) = 
% = void,                           if n = 0
% = {l1} U subset(l2,l3,...,ln),    if n > 0
% = subset(l2,l3,...,ln),           if n > 0 and the right list is a subset of the tail of the left list

% subset(L - list, R - list)
% flow models: (i,o)

subset([],[]).
subset([H|T],[H|R]):-
    subset(T,R).
subset([_|T],R):-
    subset(T,R).

% isSubList(L - list, R - list)
% flow models: (i, i)

isSubList(L, R) :-
    append(R2, _, R),
    append(_, L, R2).

% ascending(l1,l2,...,ln) = 
% = true,                       if n = 1
% = false,                      if l1 >= l2
% = ascending(l2,l3,...,ln),    otherwise

% ascending(L - list)
% flow models: (i)

ascending([_]):- !.
ascending([H1,H2|T]):-
    H1 < H2,
    ascending([H2|T]).

% generateSolutions(l1,l2,...,ln) = 
% = void,                   if n = 0
% = subset(l1,l2,...,ln),   if ascending(l1,l2,...,ln)

% generateSolutions(L - list, R - list)
% flow models: (i,o)

generateSolutions([],[]).
generateSolutions(L,R):-
    subset(L,R),
    isSubList(R, L),
    ascending(R).

% combineSolutions(L - list, R - list)
% flow models: (i,o), (i,i)

combineSolutions(L,R):-
    findall(R2,generateSolutions(L,R2),R).


% TESTS

testCombineSolutions():-
    combineSolutions([1], [[1]]),
    combineSolutions([1,2], [[1,2], [1], [2]]),
    combineSolutions([1,2,3], [[1,2,3], [1,2], [1], [2,3], [2], [3]]),
    combineSolutions([1,4,2], [[1,4], [1], [4], [2]]),
    combineSolutions([1,4], [[1,4], [1], [4]]),
    combineSolutions([2,4], [[2,4], [2], [4]]),
    combineSolutions([], [[]]).
