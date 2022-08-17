:- module('bagManager', [
    checaExistenciaBag/1,
    getAllBagsAux/1,
    getAllBags/1,
    getBagByBloodType/3,
    getBagRecursivamente/3,
    updateBag/3
    ]).

:- use_module(jsonManager).


checaExistenciaBag(TipoSangue):-
    readJson('bolsaSangue', File),
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
    (H.tipoSangue = Tipo -> Out = H);
    (getBagRecursivamente(T, Tipo, Out)).


% UpdateQuantity
updateBagJson([], _, _, []).
updateBagJson([H|T], H.tipoSangue, Quantidade, [_{tipoSangue: H.tipoSangue, quantidade: Quantidade}|T]).
updateBagJson([H|T], TipoSangue, Quantidade, [H|Out]) :- 
  updateBagJson(T, TipoSangue, Quantidade, Out).

updateBag(FileName, TipoSangue, NovaQuantidade) :-
  readJson(FileName, File),
  updateBagJson(File, TipoSangue, NovaQuantidade, SaidaParcial),
  bagsToJson(SaidaParcial, Saida),
  getFilePath(FileName, FilePath),
  open(FilePath, write, Stream), 
  write(Stream, Saida),
  close(Stream).

bagsToJson([], []).
bagsToJson([H|T], [X|Saida]) :- 
  bagToJson(H.tipoSangue, H.quantidade, X), 
  bagsToJson(T, Saida).

bagToJson(TipoSangue, Quantidade, Saida) :-
    swritef(Saida, '{"tipoSangue":"%w", "quantidade": %w}', 
    [TipoSangue, Quantidade]).