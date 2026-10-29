%% ============================================================
%%  Experiment 7: Breadth-First Search - shortest path
%%  Run:  swipl exp07.pl      (demo runs automatically)
%%  Or:   ?- exp7_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
e7_edge(a, b).  e7_edge(a, c).  e7_edge(b, d).
e7_edge(c, d).  e7_edge(c, e).  e7_edge(d, f).  e7_edge(e, f).
e7_adj(X, Y) :- e7_edge(X, Y) ; e7_edge(Y, X).

e7_bfs(Start, Goal, Path) :- e7_bfs_q([[Start]], Goal, [Start], P), reverse(P, Path).
e7_bfs_q([[Goal|T]|_], Goal, _, [Goal|T]) :- !.
e7_bfs_q([[N|T]|Rest], Goal, Seen, Sol) :-
    findall([M,N|T], (e7_adj(N, M), \+ memberchk(M, Seen)), Next),
    findall(M, member([M|_], Next), NewNodes),
    append(Seen, NewNodes, Seen2),
    append(Rest, Next, Queue),
    e7_bfs_q(Queue, Goal, Seen2, Sol).

exp7_demo :-
    nl, writeln('=== EXP 7: BFS shortest path ==='),
    e7_bfs(a, f, P), format('  Shortest path a -> f: ~w~n', [P]),
    e7_bfs(b, e, P2), format('  Shortest path b -> e: ~w~n', [P2]).

:- initialization(exp7_demo).
