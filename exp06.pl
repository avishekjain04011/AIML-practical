%% ============================================================
%%  Experiment 6: Travel Route Recommendation
%%  Run:  swipl exp06.pl      (demo runs automatically)
%%  Or:   ?- exp6_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
e6_road(delhi,  agra,    230).
e6_road(agra,   gwalior, 120).
e6_road(gwalior, jhansi, 100).
e6_road(jhansi, bhopal,  290).
e6_road(delhi,  jaipur,  280).
e6_road(jaipur, indore,  600).
e6_road(bhopal, indore,  190).

e6_conn(A, B, D) :- e6_road(A, B, D).
e6_conn(A, B, D) :- e6_road(B, A, D).

% route(From, To, Visited, Path, TotalDistance)
e6_route(A, B, Path, D) :- e6_route(A, B, [A], P, D), reverse(P, Path).
e6_route(A, A, V, V, 0).
e6_route(A, B, V, P, D) :-
    e6_conn(A, C, D1), \+ memberchk(C, V),
    e6_route(C, B, [C|V], P, D2), D is D1 + D2.

e6_best(A, B, Path, D) :-
    findall(D0-P0, e6_route(A, B, P0, D0), L),
    L \== [], keysort(L, [D-Path|_]).

exp6_demo :-
    nl, writeln('=== EXP 6: Route Recommendation ==='),
    writeln('All routes delhi -> indore:'),
    forall(e6_route(delhi, indore, P, D), format('  ~w  (~w km)~n', [P, D])),
    e6_best(delhi, indore, BP, BD),
    format('Recommended (shortest): ~w  (~w km)~n', [BP, BD]).

:- initialization(exp6_demo).
