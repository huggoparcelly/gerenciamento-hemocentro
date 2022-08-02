% funcao/quantDeParametros
% :- module('jsonManager', [
%   addDoadores/5,
%   readJSON/2,
%   getFilePath/2,
%   main/1
%   ]).

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

% GetAll persons
getAllPersonsAux([]).
getAllPersonsAux([H|T]) :-
  write("cpf:"), writeln(H.cpf),
  write("nome:"), writeln(H.nome),
  write("tel:"), writeln(H.tel),
  write("endereco:"), writeln(H.endereco),
  write("tipoSangue:"), writeln(H.tipoSangue), nl,
  getAllPersonsAux(T).
  

getAllPersons(FileName) :-
  readJson(FileName, File),
  getAllPersonsAux(File).


% representação em formato String de um agente em JSON
personToJson(Cpf, Nome, Tel, Endereco, TipoSangue, Saida) :-
  swritef(Saida, '{"cpf":"%w", "nome":"%w", "tel":"%w", "endereco":"%w", "tipoSangue":"%w"}', 
  [Cpf, Nome, Tel, Endereco, TipoSangue]).


% Convertendo uma lista de objetos JSON
personsToJson([], []).
personsToJson([H|T], [X|Saida]) :- 
    personToJson(H.cpf, H.nome, H.tel, H.endereco, H.tipoSangue, X), 
		personsToJson(T, Saida).

% Salvar em arquivo JSON
addPerson(FileName, Cpf, Nome, Tel, Endereco, TipoSangue) :- 
		readJson(FileName, File),
		personsToJson(File, ListaPersonsJSON),
		personToJson(Cpf, Nome, Tel, Endereco, TipoSangue, PersonJSON),
		append(ListaPersonsJSON, [PersonJSON], Saida),
    getFilePath(FileName, FilePath),
		open(FilePath, write, Stream), 
    write(Stream, Saida), 
    close(Stream).
  
