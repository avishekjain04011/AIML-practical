%% ============================================================
%%  Experiment 14: University Course Advisory Expert System
%%  Run:  swipl exp14.pl      (demo runs automatically)
%%  Or:   ?- exp14_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
e14_elective(machine_learning,   [maths, programming]).
e14_elective(data_science,       [maths, statistics]).
e14_elective(web_development,    [programming, design]).
e14_elective(cyber_security,     [networking, programming]).
e14_elective(computer_graphics,  [design, maths]).

e14_student(amit,  [maths, programming, statistics]).
e14_student(riya,  [design, programming]).
e14_student(sara,  [networking, programming, maths]).

% recommend if student has at least one required interest;
% "fully suited" if all of them are matched.
e14_recommend(S, E) :- e14_student(S, I), e14_elective(E, Req), subtract(Req, I, []).
e14_partial(S, E)   :- e14_student(S, I), e14_elective(E, Req),
                       intersection(Req, I, M), M \== [], \+ subtract(Req, I, []).

exp14_demo :-
    nl, writeln('=== EXP 14: Elective Course Advisor ==='),
    forall(e14_student(S, I),
           ( format('  ~w (interests: ~w)~n', [S, I]),
             forall(e14_recommend(S, E), format('     recommended: ~w~n', [E])),
             forall(e14_partial(S, E),   format('     partial fit: ~w~n', [E])) )).

:- initialization(exp14_demo).
