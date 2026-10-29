%% ============================================================
%%  Experiment 2: Arithmetic, Factorial, Fibonacci (recursion)
%%  Run:  swipl exp02.pl      (demo runs automatically)
%%  Or:   ?- exp2_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
e2_arith(A, B) :-
    Sum is A + B, Diff is A - B, Prod is A * B,
    ( B =\= 0 -> Quot is A / B ; Quot = undefined ),
    ( B =\= 0 -> Mod is A mod B ; Mod = undefined ),
    format('  ~w + ~w = ~w~n  ~w - ~w = ~w~n  ~w * ~w = ~w~n  ~w / ~w = ~w~n  ~w mod ~w = ~w~n',
           [A,B,Sum, A,B,Diff, A,B,Prod, A,B,Quot, A,B,Mod]).

e2_fact(0, 1) :- !.
e2_fact(N, F) :- N > 0, N1 is N - 1, e2_fact(N1, F1), F is N * F1.

e2_fib(0, 0).
e2_fib(1, 1).
e2_fib(N, F) :- N > 1, N1 is N-1, N2 is N-2,
                e2_fib(N1, F1), e2_fib(N2, F2), F is F1 + F2.

e2_fib_series(N) :- N1 is N-1, forall(between(0, N1, I), (e2_fib(I, F), write(F), write(' '))), nl.

exp2_demo :-
    nl, writeln('=== EXP 2: Arithmetic, Factorial, Fibonacci ==='),
    e2_arith(12, 4),
    e2_fact(6, F), format('  Factorial of 6 = ~w~n', [F]),
    write('  First 10 Fibonacci numbers: '), e2_fib_series(10).

:- initialization(exp2_demo).
