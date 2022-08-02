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


%GetDoacaoById

getDoacaoRecursivamente([], _, "").
getDoacaoRecursivamente([H|T], Id, Out):-
(H.Id = Id -> Out = H); 
(getDoacaoRecursivamente(T, Id, Out)).

getDoacaoById(FileName, Id, Result):-
readJson(FileName, File),
getDoacaoRecursivamente(File, Id, Result).

checaExistenciaDoacao(Filename, Id):-
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

%AddDoacao

addDoacao(FileName, Id, Doador, TipoSangue, Quantidade, Data) :- 
readJson(FileName, File),
doacaoToJson(File, ListaDoacoesJSON),
doacaoToJson(Id, Doador, TipoSangue, Quantidade, Data, DoacaoJSON),
append(ListaDoacoesJSON, [DoacaoJSON], Saida),
getFilePath(FileName, FilePath),
open(FilePath, write, Stream), 
write(Stream, Saida), 
close(Stream).

%GetBagByBloodType

getBagRecursivamente([], _, "").
getBagRecursivamente([H|T], Tipo, Out):-
(H.Tipo = Tipo -> Out = H);
(getBagRecursivamente(File, Id, Out)).

getBagByBloodType(FileName, Id, Result):-
readJson(FileName, File),
getBagRecursivamente(File, Id, Result).

checaExistenciaBag(Filename, TipoSangue):-
readJson(FileName, File),
getBagRecursivamente(File, TipoSangue, Result),
Result \= "".

%GetAllBags

getAllBagsAux([]).
getAllBagsAux([H|T]):-
write("tipo: "), write(H.tipoSangue), nl,
write("quantidade: "), write(H.quantidade), nl,
getAllBagsAux(T).

getAllBags(FileName):-
readJson(FileName, File),
getAllBagsAux(File).


%GetAllComprovantes

getAllComprovantesAux([]).
getAllComprovantesAux([H|T]):-
write("cpf: "), write(H.cpf), nl,
write("descricao: "), write(H.descricao), nl,
getAllComprovantesAux(T).

getAllComprovantes(FileName):-
readJson(FileName, File),
getAllComprovantesAux(File).

%GetComprovanteByCPF

getComprovanteByCpf(FileName, Cpf, Result):-
readJson(FileName, File),
getComprovanteRecursivamente(File, Id, Result).

getComprovanteRecursivamente([], _, "").
getComprovanteRecursivamente([H|T], Cpf, Out):-
(H.Cpf = Cpf -> Out = H); 
(getComprovanteRecursivamente(T, Cpf, Out)).

checaExistenciaComprovante(Filename, Cpf):-
readJson(FileName, File),
getComprovanteRecursivamente(File, Cpf, Result),
