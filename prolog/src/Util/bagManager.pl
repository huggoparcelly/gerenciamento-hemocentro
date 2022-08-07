:- module('bagManager', [
    checaExistenciaBag/2,
    getAllBagsAux/1,
    getAllBags/1,
    getBagByBloodType/3,
    getBagRecursivamente/3
    ]).
:- use_module('../src/Util/jsonManager.pl', [readJson/2]).

checaExistenciaBag(Filename, TipoSangue):-
    readJson(FileName, File),
    getBagRecursivamente(File, TipoSangue, Result),
    Result \= "".

% GetAllBags
getAllBagsAux([]).
getAllBagsAux([H|T]):-
    write("tipo: "), write(H.tipoSangue), nl,
    write("quantidade: "), write(H.quantidade), nl,
    getAllBagsAux(T).

getAllBags(FileName):-
    readJson(FileName, File),
    getAllBagsAux(File).

getBagByBloodType(FileName, Tipo, Result):-
    readJson(FileName, File),
    getBagRecursivamente(File, Tipo, Result).

%GetBagByBloodType
getBagRecursivamente([], _, "").
getBagRecursivamente([H|T], Tipo, Out):-
    (H.Tipo = Tipo -> Out = H);
    (getBagRecursivamente(File, Id, Out)).