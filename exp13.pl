%% ============================================================
%%  Experiment 13: Blocks World - on / clear / on_table, validate stacking
%%  Run:  swipl exp13.pl      (demo runs automatically)
%%  Or:   ?- exp13_demo.
%% ============================================================

:- style_check(-singleton).
:- style_check(-discontiguous).
e13_state([on(a,b), on(b,c), on_table(c), on_table(d)]).

e13_clear(S, X) :- \+ memberchk(on(_, X), S).               % nothing on top of X
e13_block(S, X) :- ( memberchk(on(X,_), S) ; memberchk(on_table(X), S) ).

% a state is valid if each block has exactly one support and is not on itself
e13_valid(S) :-
    forall(e13_block(S, X),
           ( findall(Y, memberchk(on(X,Y), S), Ys),
             findall(t,  memberchk(on_table(X), S), Ts),
             append(Ys, Ts, Supp), length(Supp, 1),
             \+ memberchk(on(X, X), S) )),
    forall(e13_block(S, X), \+ e13_loop(S, X, X)).
e13_loop(S, Start, X) :- memberchk(on(X, Y), S), ( Y == Start ; e13_loop(S, Start, Y) ).

% can X be moved onto Y?  both must be clear, and X \== Y
e13_can_stack(S, X, Y) :- X \== Y, e13_block(S, X), e13_block(S, Y),
                          e13_clear(S, X), e13_clear(S, Y).

e13_stack(S, X, Y, NS) :-
    e13_can_stack(S, X, Y),
    ( select(on(X,_), S, S1) -> true ; select(on_table(X), S, S1) ),
    NS = [on(X,Y)|S1].

exp13_demo :-
    nl, writeln('=== EXP 13: Blocks World ==='),
    e13_state(S),
    format('  State: ~w~n', [S]),
    ( e13_valid(S) -> writeln('  State is valid') ; writeln('  State is INVALID') ),
    forall(e13_block(S, B), ( e13_clear(S, B) -> format('  ~w is clear~n', [B]) ; format('  ~w is NOT clear~n', [B]) )),
    ( e13_can_stack(S, a, d) -> writeln('  Can stack a on d: yes') ; writeln('  Can stack a on d: no') ),
    ( e13_can_stack(S, b, d) -> writeln('  Can stack b on d: yes') ; writeln('  Can stack b on d: no (b has a on top)') ),
    e13_stack(S, a, d, S2), format('  After moving a onto d: ~w~n', [S2]),
    Bad = [on(a,b), on(b,a)],
    ( e13_valid(Bad) -> true ; format('  ~w is INVALID (circular stacking)~n', [Bad]) ).

:- initialization(exp13_demo).
