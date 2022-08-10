:- module(menu, [menuPrincipal/0]).
:- use_module('Service/personService',[addUser/1, removeUser/1, updateUser/1, getUserByCpf/1, getAllUsers/1]).
:- use_module('Service/doacaoService', [createDonation/0, createDirectDonation/0, getAllDonations/0, getDonationById/0]).
:- use_module('Service/bolsaService', [getBolsas/0, getBolsaByTipo/2]).
:- use_module('Util/input.pl', [input/1]).
%inserir restante dos services
:- encoding(utf8).

clear :- writeln('\e[H\e[2J').

menuPrincipal :- clear, writeln('\n\nBem vindo ao Gerenciamento de Hemocentro! \n'), subMenu.

subMenu :-
    writeln('--------------------------------'),
    writeln('----->>> MENU PRINCIPAL <<<-----'),
    writeln('--------------------------------'),
    writeln('\t[ 1 ] Cadastrar'),
    writeln('\t[ 2 ] Editar'),
    writeln('\t[ 3 ] Buscar'),
    writeln('\t[ 4 ] Remover'),
    writeln('\t[ 5 ] Listar'),
    writeln('\t[ 6 ] SAIR'),
    writeln('> Opção: '),
    input(Input),
    menuInput(Input).

menuInput('1') :-
    clear,
    writeln('-----------------'),
    writeln('>>> CADASTRAR <<<'),
    writeln('-----------------'),
    writeln('1 - Doador'),
    writeln('2 - Receptor'),
    writeln('3 - Doação'),
    writeln('4 - Doação Direcionada'),
    writeln('5 - Doação de Medula'),
    writeln('6 - Coleta de Sangue'),
    writeln('7 - Voltar para o Menu Principal'),
    writeln('> Opção: '),
    input(Input),
    menuCadastro(Input).

menuInput('2') :-
    clear,
    writeln('--------------'),
    writeln('>>> EDITAR <<<'),
    writeln('--------------'),
    writeln('1 - Doador'),
    writeln('2 - Receptor'),
    writeln('3 - Voltar para o Menu Principal'),
    writeln('> Opção: '),
    input(Input),
    menuEdit(Input).

menuInput('3') :-
    clear,
    writeln('--------------'),
    writeln('>>> BUSCAR <<<'),
    writeln('--------------'),
    writeln('1 - Doador'),
    writeln('2 - Receptor'),
    writeln('3 - Doação'),
    writeln('4 - Doação de Medula'),
    writeln('5 - Voltar para o Menu Principal'),
    writeln('> Opção: '),
    input(Input),
    menuBuscar(Input).

menuInput('4') :-
    clear,
    writeln('---------------'),
    writeln('>>> REMOVER <<<'),
    writeln('---------------'),
    writeln('1 - Doador'),
    writeln('2 - Receptor'),
    writeln('3 - Voltar para o Menu Principal'),
    writeln('> Opção: '),
    input(Input),
    menuRemover(Input).

menuInput('5') :-
    clear,
    writeln('--------------'),
    writeln('>>> LISTAR <<<'),
    writeln('--------------'),
    writeln('1 - Doadores'),
    writeln('2 - Receptores'),
    writeln('3 - Doações'),
    writeln('4 - Doações Direcionadas'),
    writeln('5 - Doações de Medula'),
    writeln('6 - Comprovante de Doações'),
    writeln('7 - Voltar para o Menu Principal'),
    writeln('> Opção: '),
    input(Input),
    menuListar(Input).

menuInput('6'):- halt.

menuCadastro('1'):- addUser('doadores').
menuCadastro('2'):- addUser('receptores').
menuCadastro('3'):- createDonation.
% menuCadastro('4'):- createDirectDonation.
% %menuCadastro('5'):- 
% %menuCadastro('6'):- 
menuCadastro('7'):- subMenu.

menuEdit('1'):- updateUser('doadores').
menuEdit('2'):- updateUser('receptores').
menuEdit('3'):- subMenu.

menuBuscar('1'):- getUserByCpf('doadores').
menuBuscar('2'):- getUserByCpf('receptores').
menuBuscar('3'):- getDonationById.
%menuBuscar('4'):- 
menuBuscar('5'):- subMenu.

menuRemover('1'):- removeUser('doadores').
menuRemover('2'):- removeUser('receptores').
menuRemover('3'):- subMenu.

menuListar('1'):- getAllUsers('doadores').
menuListar('2'):- getAllUsers('receptores').
menuListar('3'):- getAllDonations.
%menuListar('4'):- 
%menuListar('5'):- 
%menuListar('6'):- 
menuListar('7'):- subMenu.