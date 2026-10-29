%% ============================================================
%%  Experiment 10: Rule-based Expert System - Car Fault Diagnosis
%%  Run:  swipl exp10.pl      (demo runs automatically)
%%  Or:   ?- exp10_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
%% (IF-THEN production rules; user facts held in e10_has/1)
%% ------------------------------------------------------------
:- dynamic e10_has/1.

e10_rule(dead_battery,     [engine_wont_crank, lights_dim]).
e10_rule(starter_motor,    [engine_wont_crank, clicking_sound]).
e10_rule(out_of_fuel,      [engine_cranks, engine_wont_start, fuel_gauge_empty]).
e10_rule(overheating,      [temperature_high, steam_from_hood]).
e10_rule(worn_brake_pads,  [squealing_brakes, longer_stopping]).

e10_diagnose(Fault) :-
    e10_rule(Fault, Conditions),
    forall(member(C, Conditions), e10_has(C)).

exp10_demo :-
    nl, writeln('=== EXP 10: Car Fault Diagnosis Expert System ==='),
    retractall(e10_has(_)),
    assertz(e10_has(engine_wont_crank)),
    assertz(e10_has(lights_dim)),
    writeln('  Symptoms: engine_wont_crank, lights_dim'),
    ( e10_diagnose(F) -> format('  Diagnosis: ~w~n', [F]) ; writeln('  No fault matched') ),
    retractall(e10_has(_)),
    assertz(e10_has(temperature_high)),
    assertz(e10_has(steam_from_hood)),
    writeln('  Symptoms: temperature_high, steam_from_hood'),
    ( e10_diagnose(F2) -> format('  Diagnosis: ~w~n', [F2]) ; writeln('  No fault matched') ),
    retractall(e10_has(_)).

:- initialization(exp10_demo).
