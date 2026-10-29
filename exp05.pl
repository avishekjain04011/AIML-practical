%% ============================================================
%%  Experiment 5: Student performance - topper / average / fail
%%  Run:  swipl exp05.pl      (demo runs automatically)
%%  Or:   ?- exp5_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
e5_marks(amit, 92).
e5_marks(riya, 78).
e5_marks(sara, 55).
e5_marks(john, 30).
e5_marks(neha, 85).

e5_grade(S, topper)  :- e5_marks(S, M), M >= 85.
e5_grade(S, average) :- e5_marks(S, M), M >= 40, M < 85.
e5_grade(S, fail)    :- e5_marks(S, M), M < 40.

exp5_demo :-
    nl, writeln('=== EXP 5: Student Performance Analysis ==='),
    forall(e5_marks(S, M),
           ( e5_grade(S, G), format('  ~w (~w marks) -> ~w~n', [S, M, G]) )).

:- initialization(exp5_demo).
