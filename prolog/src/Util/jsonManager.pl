:- module(jsonManager, [
  readJson/2,
  id/1,
  incrementa_id/0,
  getFilePath/2
  ]).

:- use_module(library(http/json)).

id(1).
incrementa_id :- retract(id(X)), Y is X + 1, assert(id(Y)).
:- dynamic id/1.


% Ler um arquivo Json
readJson(FileName, File) :-
  getFilePath(FileName, FilePath),
  open(FilePath, read, F),
  json_read_dict(F, File).

getFilePath(FileName, FilePath) :-
  atom_concat("../database/", FileName, Saida),
  atom_concat(Saida, ".json", FilePath).