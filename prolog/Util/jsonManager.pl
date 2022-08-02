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


% representação em formato String de um person em JSON
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

% Remove Person
removerPersonJson([], _, []).
removerPersonJson([H|T], H.cpf, T).
removerPersonJson([H|T], Cpf, [H|Out]) :- 
  removerPersonJson(T, Cpf, Out).

removerPerson(FileName, Cpf) :-
   readJson(FileName, File),
   removerPersonJson(File, Cpf, SaidaParcial),
   personsToJson(SaidaParcial, Saida),
   getFilePath(FileName, FilePath),
   open(FilePath, write, Stream), 
   write(Stream, Saida), 
   close(Stream).


% GetPersonById
getPersonRecursivamente([], _, "").
getPersonRecursivamente([H|T], Cpf, Out):-
     (H.cpf = Cpf -> Out = H);(getPersonRecursivamente(T, Cpf, Out)).

getPersonByID(FileName, Cpf, Result):-
    readJson(FileName, File),
    getPersonRecursivamente(File, Cpf, Result).

checaExistencia(FileName, Cpf):-
    readJson(FileName, File),
    % atom_string(Id, IdString),
    getPersonRecursivamente(File, Cpf, Result),
    Result \= "".

% Update person
updatePersonJson([], _, _, []).
updatePersonJson([H|T], H.cpf, Nome, Tel, Endereco, TipoSangue, [_{cpf:H.cpf, nome:Nome, tel:Tel, endereco:Endereco, tipoSangue: TipoSangue}|T]).
updatePersonJson([H|T], Cpf, Nome, Tel, Endereco, TipoSangue, [H|Out]) :- 
  updatePersonJson(T, Cpf, Nome, Tel, Endereco, TipoSangue, Out).

updatePerson(FileName, Cpf, NovoNome, NovoTel, NovoEndereco, NovoTipoSangue) :-
		readJson(FileName, File),
		updatePersonJson(File, CPf, NovoNome, NovoTel, NovoEndereco, NovoTipoSangue, SaidaParcial),
		personsToJson(SaidaParcial, Saida),
		open(FilePath, write, Stream), 
    write(Stream, Saida),
    close(Stream).