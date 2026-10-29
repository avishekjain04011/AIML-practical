%% ============================================================
%%  Experiment 12: Water Jug Problem (4L and 3L jugs, target 2L in 4L jug)
%%  Run:  swipl exp12.pl      (demo runs automatically)
%%  Or:   ?- exp12_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
%% State = j(Jug4, Jug3). BFS gives shortest sequence of states.
%% ------------------------------------------------------------
e12_move(j(X,Y), j(4,Y), 'Fill 4L jug')            :- X < 4.
e12_move(j(X,Y), j(X,3), 'Fill 3L jug')            :- Y < 3.
e12_move(j(X,Y), j(0,Y), 'Empty 4L jug')           :- X > 0.
e12_move(j(X,Y), j(X,0), 'Empty 3L jug')           :- Y > 0.
e12_move(j(X,Y), j(NX,NY), 'Pour 4L into 3L')      :- X > 0, Y < 3, T is min(X, 3-Y), NX is X-T, NY is Y+T.
e12_move(j(X,Y), j(NX,NY), 'Pour 3L into 4L')      :- Y > 0, X < 4, T is min(Y, 4-X), NX is X+T, NY is Y-T.

e12_goal(j(2,_)).

e12_solve(Path) :- e12_bfs([[j(0,0)-start]], [j(0,0)], Path0), reverse(Path0, Path).
e12_bfs([[S-A|T]|_], _, [S-A|T]) :- e12_goal(S), !.
e12_bfs([[S-A|T]|Rest], Seen, Sol) :-
    findall([N-Act,S-A|T], (e12_move(S, N, Act), \+ memberchk(N, Seen)), Next),
    findall(N, member([N-_|_], Next), Ns),
    append(Seen, Ns, Seen2),
    append(Rest, Next, Q),
    e12_bfs(Q, Seen2, Sol).

exp12_demo :-
    nl, writeln('=== EXP 12: Water Jug Problem (4L, 3L, goal 2L) ==='),
    e12_solve(P),
    forall(member(S-A, P), format('  ~w  <- ~w~n', [S, A])).

:- initialization(exp12_demo).
