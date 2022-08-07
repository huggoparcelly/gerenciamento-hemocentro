:- module(doacaoManager, [
    checaExistenciaDoacao/2,
    getAllDoacoesAux/1,
    getAllDoacoes/1,
    getDoacaoById/3,
    getDoacaoRecursivamente/3,
    doacaoToJson/6,
    doacoesToJson/2,
    addDoacao/5
    ]).
:- use_module(jsonManager).


checaExistenciaDoacao(FileName, Id):-
  readJson(FileName, File),
  getDoacaoRecursivamente(File, Id, Result),
  Result \= "".

%GetAllDoacoes
getAllDoacoesAux([]).
getAllDoacoesAux([H|T]):-
  write("id: "), write(H.id), nl,
  write("doador: "), write(H.doador), nl,
  write("tipo: "), write(H.tipo), nl,
  write("quantidade: "), write(H.quantidade), nl,
  write("data: "), write(H.data), nl,
  getAllDoacoesAux(T).

getAllDoacoes(FileName):-
  readJson(FileName, File),
  getAllDoacoesAux(File).


getDoacaoById(FileName, Id, Result):-
  readJson(FileName, File),
  getDoacaoRecursivamente(File, Id, Result).

%GetDoacaoById
  getDoacaoRecursivamente([], _, "").
  getDoacaoRecursivamente([H|T], Id, Out):-
  (H.Id = Id -> Out = H); 
  (getDoacaoRecursivamente(T, Id, Out)).


doacaoToJson(Id, Doador, TipoSangue, Quantidade, Data, Saida) :-
  swritef(Saida, '{"id":"%w", "doador":"%w", "tipoSangue":"%w", "quantidade":"%w", "data":"%w"}', 
  [Id, Doador, TipoSangue, Quantidade, Data]).


% Convertendo uma lista de objetos JSON
doacoesToJson([], []).
doacoesToJson([H|T], [X|Saida]) :- 
  doacaoToJson(H.id, H.doador, H.tipoSangue, H.quantidade, H.data, X), 
  doacoesToJson(T, Saida).

%AddDoacao
addDoacao(FileName, Doador, TipoSangue, Quantidade, Data) :- 
  id(Id), incrementa_id,
  readJson(FileName, File),
  doacoesToJson(File, ListaDoacoesJSON),
  doacaoToJson(Id, Doador, TipoSangue, Quantidade, Data, DoacaoJSON),
  append(ListaDoacoesJSON, [DoacaoJSON], Saida),
  getFilePath(FileName, FilePath),
  open(FilePath, write, Stream), 
  write(Stream, Saida), 
  close(Stream).