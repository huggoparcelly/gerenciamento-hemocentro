:- module(menu, [menuPrincipal/0]).
:- use_module('Service/personService',[addUser/1, removeUser/1, updateUser/1, getUserByCpf/1, getAllUsers/1]).
:- use_module('Service/doacaoService', [createDonation/0, createDirectDonation/0, getAllDonations/0, getDonationById/0]).
:- use_module('Service/bolsaService', [getBolsas/0, getBolsaByTipo/2]).
:- use_module('Service/comprovanteService', [getAllComprov/1, getComprovByCpf/2]).
:- use_module('Util/input.pl', [input/1]).
:- use_module('Service/recepcaoService', [createReception/0]).
%inserir restante dos services
:- encoding(utf8).

clear :- writeln('\e[H\e[2J').

menuPrincipal :- writeln('\n\nBem vindo ao Gerenciamento de Hemocentro! \n'), subMenu.

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
    %clear,
    menuInput(Input).

menuInput('1') :-
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
    clear,
    menuCadastro(Input).

menuInput('2') :-
    writeln('--------------'),
    writeln('>>> EDITAR <<<'),
    writeln('--------------'),
    writeln('1 - Doador'),
    writeln('2 - Receptor'),
    writeln('3 - Voltar para o Menu Principal'),
    writeln('> Opção: '),
    input(Input),
    clear,
    menuEdit(Input).

menuInput('3') :-
    writeln('--------------'),
    writeln('>>> BUSCAR <<<'),
    writeln('--------------'),
    writeln('1 - Doador'),
    writeln('2 - Receptor'),
    writeln('3 - Doação'),
    writeln('4 - Doação de Medula'),
    writeln('5 - Buscar Comprovante'),
    writeln('6 - Voltar para o Menu Principal'),
    writeln('> Opção: '),
    input(Input),
    clear,
    menuBuscar(Input).

menuInput('4') :-
    writeln('---------------'),
    writeln('>>> REMOVER <<<'),
    writeln('---------------'),
    writeln('1 - Doador'),
    writeln('2 - Receptor'),
    writeln('3 - Voltar para o Menu Principal'),
    writeln('> Opção: '),
    input(Input),
    clear,
    menuRemover(Input).

menuInput('5') :-
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
    clear,
    menuListar(Input).

menuInput('6'):- halt.
menuInput(_) :- opcaoInvalida, menuPrincipal.


menuCadastro('1'):- addUser('doadores'), subMenu.
menuCadastro('2'):- addUser('receptores'), subMenu.
menuCadastro('3'):- createDonation, subMenu.
% menuCadastro('4'):- createDirectDonation.
% %menuCadastro('5'):- 
menuCadastro('6'):- createReception, subMenu.
menuCadastro('7'):- subMenu.
menuCadastro(_) :- opcaoInvalida, menuInput('1').


menuEdit('1'):- updateUser('doadores'), subMenu.
menuEdit('2'):- updateUser('receptores'), subMenu.
menuEdit('3'):- subMenu.
menuEdit(_) :- opcaoInvalida, menuInput('2').


menuBuscar('1'):- getUserByCpf('doadores'), subMenu.
menuBuscar('2'):- getUserByCpf('receptores'), subMenu.
menuBuscar('3'):- getDonationById, subMenu.
%menuBuscar('4'):- 
menuBuscar('5'):- getComprovByCpf('comprovantes'), subMenu.
menuBuscar('6'):- subMenu.
menuBuscar(_) :- opcaoInvalida, menuInput('3').


menuRemover('1'):- removeUser('doadores'), subMenu.
menuRemover('2'):- removeUser('receptores'), subMenu.
menuRemover('3'):- subMenu.
menuRemover(_) :- opcaoInvalida, menuInput('4').


menuListar('1'):- getAllUsers('doadores'), subMenu.
menuListar('2'):- getAllUsers('receptores'), subMenu.
menuListar('3'):- getAllDonations, subMenu.
menuListar('4'):- getAllComprov('comprovantes'), subMenu. 
%menuListar('5'):- 
%menuListar('6'):- 
menuListar('7'):- subMenu.
menuListar(_) :- opcaoInvalida, menuInput('5').


opcaoInvalida :- 
    clear,
    writeln('Opção inválida. Tente novamente!').