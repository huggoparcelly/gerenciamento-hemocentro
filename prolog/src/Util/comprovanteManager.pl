:- module('comprovanteManager', [
    checaExistenciaComprovante/2,
    getAllComprovantesAux/1,
    getAllComprovantes/1,
    getComprovanteByCpf/3,
    getComprovanteRecursivamente/3
    ]).
% :- use_module(library(http/json)).
:- use_module('../Util/jsonManager.pl', [readJson/2]).


% Checa a existencia de um comprovante no database
checaExistenciaComprovante(FileName, Cpf) :-
    readJson(FileName, File),
    getComprovanteRecursivamente(File, Cpf, Result).

%GetAllComprovantes
getAllComprovantesAux([]).
getAllComprovantesAux([H|T]) :-
    write("cpf: "), write(H.cpf), nl,
    write("descricao: "), write(H.descricao), nl,
    getAllComprovantesAux(T).

getAllComprovantes(FileName) :-
    readJson(FileName, File),
    getAllComprovantesAux(File).

% Get de um comprovante pelo CPF do doador
getComprovanteByCpf(FileName, Cpf, Result) :-
    readJson(FileName, File),
    getComprovanteRecursivamente(File, Id, Result).

getComprovanteRecursivamente([], _, "").
getComprovanteRecursivamente([H|T], Cpf, Out):-
    (H.Cpf = Cpf -> Out = H); 
    (getComprovanteRecursivamente(T, Cpf, Out)).