module(removeFirstMin, [removeFirstMin/2]).

% Mathematical model:
% min(a,b) =>
%   = a,    if a < b
%   = b,    otherwise

% min (A - number, B - number, R - number)
% flow model (i, i, o)

% TESTS:
% min(6,5,R).   R = 5
% min(3,2,R).   R = 2
% min(3,3,R).   R = 3
% min(1,5,R).   R = 1
% min(4,6,R).   R = 4

min(A,B,A):-
    A < B,
    !.
min(_,B,B).

% -------------------------

% Mathematical model:
% getMin(l1,...,ln) =>
%   = -999,                         if n is void
%   = l1,                           if n = 1
%   = min(l1, getMin(l2,...,ln)),   otherwise

% getMin (L - list, R - number)
% flow model (i, o)

% TODO: flow model i i i

% TESTS:
% getMin([1,2,3],R).    R = 1
% getMin([3,2,4],R).    R = 2
% getMin([5,4,3],R).    R = 3
% getMin([4,4,4],R).    R = 4
% getMin([],R).         R = -999

getMin([],R):-
    R = -999.
getMin([H|T],R):-
    getMin(T,H,R).
getMin([],Min,Min).
getMin([H|T],CurrMin,Min):-
    min(H,CurrMin,R),
    getMin(T,R,Min).

% -------------------------

% Mathematical model:
% remFirst(l1,...,ln, elem) =>
%   = [],                           if n = 0
%   = l2,...,ln,                    if l1 = elem
%   = remFirst(l2,...,ln, elem),    otherwise

% remFirst (L - list, E - number, R - list)
% flow model (i, i, o)

% TESTS:
% remFirst([1,2,3],3,R).    R = [1,2]
% remFirst([1,1,1],1,R).    R = [1,1]
% remFirst([2,3,2],2,R).    R = [3,2]
% remFirst([5,3,3],3,R).    R = [5,3]
% remFirst([4,4,6],4,R).    R = [4,6]

remFirst([],_,[]).
remFirst([E|T],E,T):-
    !.
remFirst([H|T],E,[H|R]):-
    remFirst(T,E,R).

% -------------------------

removeFirstMin(L,R):-
   	getMin(L,Min),
    remFirst(L,Min,R).

% TESTS:
% removeFirstMin([3,2,4,2,6],R).    R = [3,4,2,6]
% removeFirstMin([1,2,3,1,4],R).    R = [2,3,1,4]
% removeFirstMin([5,4,3,2,1],R).    R = [5,4,3,2]
% removeFirstMin([1,1,1,1,1],R).    R = [1,1,1,1]
% removeFirstMin([3,2,2,4,2],R).    R = [3,2,4,2]

print_solution(L):-
    removeFirstMin(L,R),
    format('removeFirstMin(~w); R = ~w~n', [L, R]).

test:-
    writeln('Removes the first occurrence of the minimum element.'),
    print_solution([3,2,4,2,6]),    % R = [3,4,2,6]
    print_solution([1,2,3,1,4]),    % R = [2,3,1,4]
    print_solution([5,4,3,2,1]),    % R = [5,4,3,2]
    print_solution([1,1,1,1,1]),    % R = [1,1,1,1]
    print_solution([3,2,2,4,2]).    % R = [3,2,4,2]
