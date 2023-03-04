module(isEvenv2, [isEvenv2/2]).

% Mathematical model:
% isEvenv2(l1,...,ln) =>
%   = 1,                    if n = 0
%   = 0,                    if n = 1
%   = isEvenv2(l3,...,ln),  otherwise

% isEvenv2 (L - list, R - number)
% flow model (i, o)

isEvenv2([], R):-
    R = 1.
isEvenv2([_], R):-
    R = 0,
    !.
isEvenv2([_,_|T], R):-
    isEvenv2(T, R).

% TESTS:
% isEvenv2([]).           = 1
% isEvenv2([1]).          = 0
% isEvenv2([1,2]).        = 1
% isEvenv2([1,2,3]).      = 0
% isEvenv2([1,2,3,4]).    = 1

print_solution(L):-
    isEvenv2(L, R),
    format('isEvenv2(~w); R = ~w~n', [L, R]).

test:-
    print_solution([]),         % 1
    print_solution([1]),        % 0
    print_solution([1,2]),      % 1
    print_solution([1,2,3]),    % 0
    print_solution([1,2,3,4]).  % 1
