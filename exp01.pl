%% ============================================================
%%  Experiment 1: Knowledge Base - Student/Course database
%%  Run:  swipl exp01.pl      (demo runs automatically)
%%  Or:   ?- exp1_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
%% (Facts, predicates, clauses, goals)
%% ------------------------------------------------------------
e1_student(amit).
e1_student(riya).
e1_student(sara).
e1_student(john).

e1_course(ai).
e1_course(ml).
e1_course(dbms).

e1_enrolled(amit, ai).
e1_enrolled(amit, ml).
e1_enrolled(riya, ai).
e1_enrolled(sara, dbms).
e1_enrolled(john, ml).

e1_likes(amit, prolog).
e1_likes(riya, python).

% Rule: classmates share a course
e1_classmates(X, Y) :- e1_enrolled(X, C), e1_enrolled(Y, C), X \== Y.

exp1_demo :-
    nl, writeln('=== EXP 1: Student-Course Knowledge Base ==='),
    writeln('Goal: students enrolled in ai'),
    forall(e1_enrolled(S, ai), (write('  '), writeln(S))),
    writeln('Goal: courses of amit'),
    forall(e1_enrolled(amit, C), (write('  '), writeln(C))),
    writeln('Goal: classmates'),
    forall(e1_classmates(X, Y), format('  ~w and ~w~n', [X, Y])).

:- initialization(exp1_demo).
