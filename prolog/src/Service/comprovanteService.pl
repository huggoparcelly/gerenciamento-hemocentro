:- module('comprovanteService', [
    createComprovante/3,
    getAllComprov/1,
    getComprovByCpf/3
]).

:- use_module('../Util/comprovanteManager.pl', [addComprovante/3, getAllComprovantes/1, getComprovanteByCpf/3]).

createComprovante(FileName, Cpf, Data):-
addComprovante(FileName, Cpf, Data),
writeln("Comprovante criado com sucesso").

getAllComprov(FileName):-
getAllComprovantes(FileName).

getComprovByCpf(FileName, Cpf, Result):-
writeln("Informe o CPF do usuário"),
getComprovanteByCpf(FileName, Cpf, Result).