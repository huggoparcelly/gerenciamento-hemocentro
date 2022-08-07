:- module('comprovanteManager', [
    addComprovante/3,
    checaExistenciaComprovante/2,
    getAllComprovantesAux/1,
    getAllComprovantes/1,
    getComprovanteByCpf/3,
    getComprovanteRecursivamente/3
    ]).

:- use_module(jsonManager).

%AddComprovante
addComprovante(FileName, Cpf, Data):-
id(Id), incrementa_id,
readJson(FileName, File),
comprovantesToJson(File, ListaComprovantesJSON),
Msg = "Declaramos para os devidos fins e com agradecimentos que o(a) Sr(a), inscrito(a) no CPF sob o nº: " + Cpf + ", doou sangue/medula voluntariamente ao(à) Hemocentro, na data: " + Data + ".",
comprovanteToJson(Id, Cpf, Data, Msg, ComprovanteJSON),
append(ListaComprovantesJSON, [DoacaoJSON], Saida),
getFilePath(FileName, FilePath),
open(FilePath, write, Stream), 
write(Stream, Saida), 
close(Stream).

% Checa a existencia de um comprovante no database
checaExistenciaComprovante(FileName, Cpf) :-
    readJson(FileName, File),
    getComprovanteRecursivamente(File, Cpf, Result),
    Result \= "".

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
    getComprovanteRecursivamente(File, Cpf, Result).

getComprovanteRecursivamente([], _, "").
getComprovanteRecursivamente([H|T], Cpf, Out):-
    (H.Cpf = Cpf -> Out = H); 
    (getComprovanteRecursivamente(T, Cpf, Out)).