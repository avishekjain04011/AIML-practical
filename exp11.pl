%% ============================================================
%%  Experiment 11: Tic-Tac-Toe agent (Minimax, adversarial search)
%%  Run:  swipl exp11.pl      (demo runs automatically)
%%  Or:   ?- exp11_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
%% Board = list of 9 cells (x, o, or e = empty). Agent plays x.
%% ------------------------------------------------------------
e11_line([0,1,2]). e11_line([3,4,5]). e11_line([6,7,8]).
e11_line([0,3,6]). e11_line([1,4,7]). e11_line([2,5,8]).
e11_line([0,4,8]). e11_line([2,4,6]).

e11_win(B, P) :- e11_line([A,C,D]), nth0(A,B,P), nth0(C,B,P), nth0(D,B,P), P \== e.
e11_full(B) :- \+ memberchk(e, B).

e11_other(x, o).  e11_other(o, x).

e11_move(B, P, I, NB) :- nth0(I, B, e), e11_set(B, I, P, NB).
e11_set([_|T], 0, P, [P|T]) :- !.
e11_set([H|T], I, P, [H|R]) :- I1 is I-1, e11_set(T, I1, P, R).

% minimax value from x's point of view: +1 x wins, -1 o wins, 0 draw
e11_value(B, _, 1)  :- e11_win(B, x), !.
e11_value(B, _, -1) :- e11_win(B, o), !.
e11_value(B, _, 0)  :- e11_full(B), !.
e11_value(B, P, V)  :-
    findall(V1, (e11_move(B, P, _, NB), e11_other(P, Q), e11_value(NB, Q, V1)), Vs),
    ( P == x -> max_list(Vs, V) ; min_list(Vs, V) ).

e11_best_move(B, I) :-       % best move for x
    findall(V-J, (e11_move(B, x, J, NB), e11_value(NB, o, V)), L),
    msort(L, S), last(S, _-I).

e11_show(B) :-
    forall(member(R, [[0,1,2],[3,4,5],[6,7,8]]),
           ( forall(member(I, R), (nth0(I, B, C), (C == e -> write('. ') ; format('~w ', [C])))), nl )).

exp11_demo :-
    nl, writeln('=== EXP 11: Tic-Tac-Toe Minimax Agent ==='),
    B = [x,o,x,
         e,o,e,
         e,e,e],
    writeln('  Current board (x to move):'), e11_show(B),
    e11_best_move(B, I),
    format('  Best move for x: cell ~w~n', [I]),
    e11_move(B, x, I, NB),
    writeln('  Board after move:'), e11_show(NB).

:- initialization(exp11_demo).
