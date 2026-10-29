%% ============================================================
%%  Experiment 4: College Timetable Knowledge Base
%%  Run:  swipl exp04.pl      (demo runs automatically)
%%  Or:   ?- exp4_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
%% e4_slot(Day, Time, Subject, Faculty, Room)
%% ------------------------------------------------------------
e4_slot(monday,    '9:00',  ai,    dr_sharma, r101).
e4_slot(monday,    '10:00', dbms,  dr_verma,  r102).
e4_slot(tuesday,   '9:00',  ml,    dr_sharma, r101).
e4_slot(tuesday,   '11:00', os,    dr_khan,   r103).
e4_slot(wednesday, '10:00', ai,    dr_sharma, r104).
e4_slot(thursday,  '9:00',  dbms,  dr_verma,  r102).

e4_teaches(F, S)      :- e4_slot(_, _, S, F, _).
e4_room_of(S, R)      :- e4_slot(_, _, S, _, R).
e4_faculty_day(F, D)  :- e4_slot(D, _, _, F, _).
e4_room_busy(R, D, T) :- e4_slot(D, T, _, _, R).

exp4_demo :-
    nl, writeln('=== EXP 4: Timetable Database ==='),
    writeln('Subjects taught by dr_sharma:'),
    forall(setof(S, e4_teaches(dr_sharma, S), L), forall(member(X, L), format('  ~w~n', [X]))),
    writeln('Rooms used for dbms:'),
    forall(setof(R, e4_room_of(dbms, R), L2), forall(member(X, L2), format('  ~w~n', [X]))),
    writeln('Days dr_khan teaches:'),
    forall(e4_faculty_day(dr_khan, D), format('  ~w~n', [D])),
    writeln('Full timetable:'),
    forall(e4_slot(D, T, S, F, R), format('  ~w ~w: ~w by ~w in ~w~n', [D, T, S, F, R])).

:- initialization(exp4_demo).
