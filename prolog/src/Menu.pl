:- module(Menu, [menuPrincipal/0, menuInput/1, menuCadastro/1, menuEdit/1, menuBuscar/1, menuRemover/1, menuListar/1]).
:- use_module('Service/personService',[addUser/1, removeUser/2, updateUser/6, getUserByCpf/3, getAllUsers/1]).
:- use_module('Service/doacaoService', [
    createDonation/0, createDirectDonation/6,
    getAllDonations/1, getDonationByCPF/3
    ]).
:- use_module('Service/bolsaService', [getBolsas/0, getBolsaByTipo/2]).

:- use_module('Util/input.pl', [input/1, inputCadastroUser/0]).
%inserir restante dos services

menuPrincipal() :- writeln('\n\nBem vindo ao Gerenciamento de Hemocentro! \n'), menu().

menu():-
    writeln('Para cadastrar, digite 1'),
    writeln('Para editar, digite 2'),
    writeln('Para buscar, digite 3'),
    writeln('Para remover, digite 4'),
    writeln('Para listar, digite 5'),
    writeln('Para sair, digite 6'),
    input(Input),
    menuInput(Input).

menuInput('1'):-
    writeln('Cadastrar novo Doador, digite 1'),
    writeln('Cadastrar novo Receptor, digite 2'),
    writeln('Cadastrar nova Doação, digite 3'),
    writeln('Cadastrar nova Doação Direcionada, digite 4'),
    writeln('Cadastrar nova Doação Medula, digite 5'),
    writeln('Cadastrar nova Coleta de Sangue, digite 6'),
    writeln('Voltar para o Menu Principal, digite 7'),
    input(Input),
    menuCadastro(Input).

menuCadastro('1'):- addUser('doadores').
menuCadastro('2'):- addUser('receptores').
menuCadastro('3'):- createDonation.
% menuCadastro('4'):- createDirectDonation('doacoes').
% %menuCadastro('5'):- 
% %menuCadastro('6'):- 
menuCadastro('7'):- menu().


% menuInput('2'):-
%     writeln('Editar Doador, digite 1'),
%     writeln('Editar Receptor, digite 2'),
%     writeln('Voltar para Menu Principal, digite 3'),
%     input(Input),
%     menuEdit(Input)

% menuEdit('1'):- updatePerson(doadores.json).
% menuEdit('2'):- updatePerson(receptores.json).
% menuEdit('3'):- menu().

% menuInput('3'):-
%     writeln('Buscar Doador, digite 1'),
%     writeln('Buscar Receptor, digite 2'),
%     writeln('Buscar Doação, digite 3'),
%     writeln('Buscar Doação de Medula, digite 4'),
%     writeln('Voltar para Menu Principal, digite 5'),
%     input(Input),
%     menuBuscar(Input).

% menuBuscar('1'):- getUserByCpf(doadores.json).
% menuBuscar('2'):- getUserByCpf(receptores.json).
% menuBuscar('3'):- getDonationByCPF(doacoes.json).
% %menuBuscar('4'):- 
% menuBuscar('5'):- menu().


% menuInput('4'):-
%     writeln('Remover Doador, digite 1'),
%     writeln('Remover Receptor, digite 2'),
%     writeln('Voltar para Menu Principal, digite 3'),
%     input(Input),
%     menuRemover(Input).

% menuRemover('1'):- removeUser(doadores.json).
% menuRemover('2'):- removeUser(receptores.json).
% menuRemover('3'):- menu().


% menuInput('5'):-
%     writeln('Listar Doadores, digite 1'),
%     writeln('Listar Receptores, digite 2'),
%     writeln('Listar Doações, digite 3'),
%     writeln('Listar Doações de Medula, digite 4'),
%     writeln('Listar Comprovante de Doações, digite 5'),
%     writeln('Voltar para Menu Principal, digite 6'),
%     input(Input),
%     menuListar(Input).

% menuListar('1'):- getAllUsers(doadores.json).
% menuListar('2'):- getAllUsers(receptores.json).
% menuListar('3'):- getAllDonations(doacoes.json).
% %menuListar('4'):- 
% %menuListar('5'):- 
% mennuListar('6'):- menu().


menuInput('6'):- halt.