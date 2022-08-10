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
  write("cpf: "), write(H.cpf), nl,
  write("tipoSangue: "), write(H.tipoSangue), nl,
  write("quantidade: "), write(H.quantidade), nl,
  write("data: "), write(H.data), nl,
  writeln('------------------'),
  getAllDoacoesAux(T).

getAllDoacoes(FileName):-
  readJson(FileName, File),
  getAllDoacoesAux(File).

getDoacaoById(FileName, Id, Saida):-
  readJson(FileName, File),
  getDoacaoRecursivamente(File, Id, Result),
  doacaoToJson(Result.id, Result.cpf, Result.tipoSangue, Result.quantidade, Result.data, Saida).

%GetDoacaoById
  getDoacaoRecursivamente([], _, "").
  getDoacaoRecursivamente([H|T], Id, Out):-
  (H.id = Id -> Out = H); 
  (getDoacaoRecursivamente(T, Id, Out)).


doacaoToJson(Id, Cpf, TipoSangue, Quantidade, Data, Saida) :-
  swritef(Saida, '{"id":%w, "cpf":"%w", "tipoSangue":"%w", "quantidade":"%w", "data":"%w"}', 
  [Id, Cpf, TipoSangue, Quantidade, Data]).


% Convertendo uma lista de objetos JSON
doacoesToJson([], []).
doacoesToJson([H|T], [X|Saida]) :- 
  doacaoToJson(H.id, H.cpf, H.tipoSangue, H.quantidade, H.data, X), 
  doacoesToJson(T, Saida).

%AddDoacao
addDoacao(FileName, Cpf, TipoSangue, Quantidade, Data) :- 
  id(Id), incrementa_id,
  readJson(FileName, File),
  doacoesToJson(File, ListaDoacoesJSON),
  doacaoToJson(Id, Cpf, TipoSangue, Quantidade, Data, DoacaoJSON),
  append(ListaDoacoesJSON, [DoacaoJSON], Saida),
  getFilePath(FileName, FilePath),
  open(FilePath, write, Stream), 
  write(Stream, Saida), 
  close(Stream).