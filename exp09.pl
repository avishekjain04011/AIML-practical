%% ============================================================
%%  Experiment 9: Hill Climbing - maximise f(X) = -(X-7)^2 + 50
%%  Run:  swipl exp09.pl      (demo runs automatically)
%%  Or:   ?- exp9_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
e9_f(X, Y) :- Y is -((X-7)*(X-7)) + 50.

e9_neighbour(X, N) :- N is X + 1.
e9_neighbour(X, N) :- N is X - 1.

e9_climb(X, Best) :-
    e9_f(X, FX),
    findall(FN-N, (e9_neighbour(X, N), e9_f(N, FN), FN > FX), L),
    (   L == [] -> Best = X
    ;   msort(L, S), last(S, _-Next),
        format('  move ~w (f=~w) -> ~w~n', [X, FX, Next]),
        e9_climb(Next, Best)
    ).

exp9_demo :-
    nl, writeln('=== EXP 9: Hill Climbing  f(x) = -(x-7)^2 + 50 ==='),
    e9_climb(0, B), e9_f(B, FB),
    format('  Optimum found at x = ~w, f(x) = ~w~n', [B, FB]).

:- initialization(exp9_demo).
