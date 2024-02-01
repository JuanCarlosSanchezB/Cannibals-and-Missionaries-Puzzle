% MI = Misioneros izquierda
% MD = Misioneros derecha
% CI = Canibales izquierda
% CD = Canibales derecha
% NI = Número en la izquierda (Para los misioneros)
% ND = Número en la derecha (Para los misioneros)
% DI = Número en la izquierda (Para los canibales)
% DD = Número en la derecha (Para los canibales)
% Izquierda/Derecha = De que lado está el bote

solucion(Solucion) :-
    inicial(Inicial),
    final(Final),
    camino(Inicial, Solucion, Final).

% Declaramos el estado inicial y el estado final
inicial(miscan(3,3,0,0,izquierda)).
final(miscan(0,0,3,3,derecha)).

camino(Inicial, Camino, Final) :-
    camino(Inicial, Camino, Final, []).

camino(Inicial, [Cruce], Final, _) :-
    valido(Cruce, Inicial, Final).

camino(Inicial, [Cruce | Resto], Final, Visitadas) :-
    valido(Cruce, Inicial, Intermedia),
    noEn(Intermedia, Visitadas),
    camino(Intermedia, Resto, Final, [Inicial | Visitadas]).

noEn(_, []).

noEn(X, [Y | Resto]) :-
    X \= Y,
    noEn(X,Resto).

% Just one missionare crosses
valido(bote(1,0,izquierda),
       miscan(MI,CI,MD,CD,derecha),
       miscan(NI,CI,ND,CD,izquierda)) :-
    ND is MD - 1,
    NI is MI + 1,
    ND >= 0,
    NI =< 3,
    (NI = 0; NI >= CI),
    (ND = 0; ND >= CD).

valido(bote(1,0,derecha),
       miscan(MI,CI,MD,CD,izquierda),
       miscan(NI,CI,ND,CD,derecha)) :-
    NI is MI - 1,
    ND is MD + 1,
    NI >= 0,
    ND =< 3,
    (NI = 0; NI >= CI),
    (ND = 0; ND >= CD).

% One cannibal crosses
valido(bote(0,1,izquierda),
       miscan(MI,CI,MD,CD,derecha),
       miscan(MI,DI,MD,DD,izquierda)) :-
    DD is CD - 1,
    DI is CI + 1,
    DD >= 0,
    DI =< 3,
    (MI = 0; MI >= DI),
    (MD = 0; MD >= DD).

valido(bote(0,1,derecha),
       miscan(MI,CI,MD,CD,izquierda),
       miscan(MI,DI,MD,DD,derecha)) :-
    DI is CI - 1,
    DD is CD + 1,
    DI >= 0,
    DD =< 3,
    (MI = 0; MI >= DI),
    (MD = 0; MD >= DD).

% Two people crosses
valido(bote(2,0,izquierda),
       miscan(MI,CI,MD,CD,derecha),
       miscan(NI,CI,ND,CD,izquierda)) :-
    ND is MD - 2,
    NI is MI + 2,
    ND >= 0,
    NI =< 3,
    (NI = 0; NI >= CI),
    (ND = 0; ND >= CD).

valido(bote(2,0,derecha),
       miscan(MI,CI,MD,CD,izquierda),
       miscan(NI,CI,ND,CD,derecha)) :-
    NI is MI - 2,
    ND is MD + 2,
    NI >= 0,
    ND =< 3,
    (NI = 0; NI >= CI),
    (ND = 0; ND >= CD).

valido(bote(0,2,izquierda),
       miscan(MI,CI,MD,CD,derecha),
       miscan(MI,DI,MD,DD,izquierda)) :-
    DD is CD - 2,
    DI is CI + 2,
    DD >= 0,
    DI =< 3,
    (MI = 0; MI >= DI),
    (MD = 0; MD >= DD).

valido(bote(0,2,derecha),
       miscan(MI,CI,MD,CD, izquierda),
       miscan(MI,DI,MD,DD, derecha)) :-
    DI is CI - 2,
    DD is CD + 2,
    DI >= 0,
    DD =< 3,
    (MI = 0; MI >= DI),
    (MD = 0; MD >= DD).

% One crosses, at a time
valido((1,1,izquierda),
       miscan(MI,CI,MD,CD,derecha),
       miscan(NI,DI,ND,DD,izquierda)) :-
    ND is MD - 1,
    DD is CD - 1,
    NI is MI + 1,
    DI is CI + 1,
    ND >= 0,
    DD >= 0,
    NI =< 3,
    DI =< 3,
    (NI = 0; NI >= DI),
    (ND = 0; ND >= DD).

valido(bote(1,1,derecha),
       miscan(MI,CI,MD,CD,izquierda),
       miscan(NI,DI,ND,DD,derecha)) :-
    NI is MI - 1,
    DI is CI - 1,
    ND is MD + 1,
    DD is CD + 1,
    NI >= 0,
    DI >= 0,
    ND =< 3,
    DD =< 3,
    (NI = 0; NI >= DI),
    (ND = 0; ND >= DD).
