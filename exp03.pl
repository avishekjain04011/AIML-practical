%% ============================================================
%%  Experiment 3: List operations - append, reverse, member, length
%%  Run:  swipl exp03.pl      (demo runs automatically)
%%  Or:   ?- exp3_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
e3_append([], L, L).
e3_append([H|T], L, [H|R]) :- e3_append(T, L, R).

e3_reverse(L, R) :- e3_rev(L, [], R).
e3_rev([], A, A).
e3_rev([H|T], A, R) :- e3_rev(T, [H|A], R).

e3_member(X, [X|_]).
e3_member(X, [_|T]) :- e3_member(X, T).

e3_length([], 0).
e3_length([_|T], N) :- e3_length(T, M), N is M + 1.

exp3_demo :-
    nl, writeln('=== EXP 3: List Operations ==='),
    e3_append([1,2,3], [4,5], A),   format('  append([1,2,3],[4,5]) = ~w~n', [A]),
    e3_reverse([a,b,c,d], R),       format('  reverse([a,b,c,d])    = ~w~n', [R]),
    ( e3_member(3, [1,2,3]) -> writeln('  3 is a member of [1,2,3]') ; writeln('  not a member') ),
    ( e3_member(9, [1,2,3]) -> writeln('  9 is a member') ; writeln('  9 is NOT a member of [1,2,3]') ),
    e3_length([a,b,c,d,e], N),      format('  length([a,b,c,d,e])   = ~w~n', [N]).

:- initialization(exp3_demo).
