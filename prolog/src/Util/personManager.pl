:- module(personManager, [
  checaExistenciaBag/2,
  getAllPersonsAux/1,
  getAllPersons/1,
  getPersonByID/3,
  getPersonRecursivamente/3,
  personToJson/6,
  personsToJson/2,
  addPerson/6,
  removerPersonJson/3,
  updatePersonJson/4,
  updatePerson/6
  ]).
:- use_module(jsonManager).


checaExistenciaPerson(FileName, Cpf):-
  readJson(FileName, File),
  getPersonRecursivamente(File, Cpf, Result),
  Result \= "".

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


getPersonByID(FileName, Cpf, Result):-
  readJson(FileName, File),
  getPersonRecursivamente(File, Cpf, Result).


% GetPersonById
getPersonRecursivamente([], _, "").
getPersonRecursivamente([H|T], Cpf, Out):-
  (H.cpf = Cpf -> Out = H);(getPersonRecursivamente(T, Cpf, Out)).

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


main :-
  getAllPersons('doadores').