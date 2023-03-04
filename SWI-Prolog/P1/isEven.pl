module(isEven, [isEven/2]).

% Mathematical model:
% isEven(l1,...,ln) =>
%   = true,                 if n = 0
%   = false,                if n = 1
%   = isEven(l3,...,ln),    otherwise

% isEven (L - list)
% flow model (i)

isEven([]).
isEven([_,_|T]):-
    isEven(T).

% TESTS:
% isEven([]).           = true
% isEven([1]).          = false
% isEven([1,2]).        = true
% isEven([1,2,3]).      = false
% isEven([1,2,3,4]).    = true

print_solution(L):-
    (  isEven(L)
    -> R = true
    ;  R = false
    ),
    format('isEven(~w); R = ~w~n', [L, R]).

test:-
    print_solution([]),         % true
    print_solution([1]),        % false
    print_solution([1,2]),      % true
    print_solution([1,2,3]),    % false
    print_solution([1,2,3,4]).  % true
