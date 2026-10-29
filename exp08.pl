%% ============================================================
%%  Experiment 8: Depth-First Search - state-space tree / graph
%%  Run:  swipl exp08.pl      (demo runs automatically)
%%  Or:   ?- exp8_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
e8_child(root, a).  e8_child(root, b).
e8_child(a, c).     e8_child(a, d).
e8_child(b, e).     e8_child(e, goal).

e8_dfs(Goal, Goal, Path, [Goal|Path]).
e8_dfs(Node, Goal, Path, Sol) :-
    e8_child(Node, Next), \+ memberchk(Next, Path),
    e8_dfs(Next, Goal, [Node|Path], Sol).

e8_dfs_path(S, G, Path) :- e8_dfs(S, G, [], R), reverse(R, Path).

e8_order(Node, [Node|Rest]) :-          % DFS visiting order
    findall(C, e8_child(Node, C), Cs),
    foldl([C, A, B]>>(e8_order(C, O), append(A, O, B)), Cs, [], Rest).

exp8_demo :-
    nl, writeln('=== EXP 8: DFS on state-space tree ==='),
    e8_order(root, Ord), format('  DFS visiting order: ~w~n', [Ord]),
    e8_dfs_path(root, goal, P), format('  Path root -> goal: ~w~n', [P]),
    writeln('  All paths root -> goal:'),
    forall(e8_dfs_path(root, goal, Q), format('    ~w~n', [Q])).

:- initialization(exp8_demo).
