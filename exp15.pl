%% ============================================================
%%  Experiment 15: Resolution principle and Unification (FOL)
%%  Run:  swipl exp15.pl      (demo runs automatically)
%%  Or:   ?- exp15_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
%% Theorem: all humans are mortal; Socrates is human => Socrates is mortal
%% Clauses (CNF):  1. ~human(X) v mortal(X)
%%                 2. human(socrates)
%%                 3. ~mortal(socrates)      (negated goal)
%% Representation: clause = list of literals; neg(P) for negation.
%% ------------------------------------------------------------

% --- Unification demo --------------------------------------------------
exp15_unify :-
    writeln('  -- Unification --'),
    T1 = human(X),  T2 = human(socrates),
    ( unify_with_occurs_check(T1, T2) -> format('  human(X) = human(socrates)  =>  X = ~w~n', [X]) ; true ),
    ( unify_with_occurs_check(f(A, g(B)), f(2, g(C))) ->
        format('  f(A,g(B)) = f(2,g(C))  =>  A=~w, B and C become the same variable~n', [A]) ; true ),
    ( unify_with_occurs_check(p(Z), p(f(Z))) -> true ; writeln('  p(Z) = p(f(Z)) fails (occurs check)') ).

% --- Resolution refutation ---------------------------------------------
e15_clauses([ [neg(human(X)), mortal(X)],
              [human(socrates)],
              [neg(mortal(socrates))] ]).

e15_resolve(C1, C2, R) :-
    copy_term(C1, D1), copy_term(C2, D2),
    select(L1, D1, R1),
    select(neg(L2), D2, R2),
    L1 \= neg(_),
    unify_with_occurs_check(L1, L2),
    append(R1, R2, R).

e15_refute(Clauses) :- e15_loop(Clauses, 1).
e15_loop(Cs, Step) :-
    member(C1, Cs), member(C2, Cs), C1 \== C2,
    ( e15_resolve(C1, C2, R) ; e15_resolve(C2, C1, R) ),
    \+ ( member(Old, Cs), Old == R ),
    format('  Step ~w: resolve ~w and ~w => ~w~n', [Step, C1, C2, R]),
    (   R == []
    ->  writeln('  Empty clause derived: contradiction, so theorem is PROVED.')
    ;   S1 is Step + 1, e15_loop([R|Cs], S1)
    ), !.

exp15_demo :-
    nl, writeln('=== EXP 15: Resolution & Unification ==='),
    exp15_unify,
    writeln('  -- Resolution refutation: prove mortal(socrates) --'),
    e15_clauses(Cs), e15_refute(Cs).

:- initialization(exp15_demo).
