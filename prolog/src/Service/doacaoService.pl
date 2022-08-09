:- module('doacaoService', [
    createDonation/1,
    createDirectDonation/6,
    getAllDonations/1,
    getDonationByCPF/3
    ]).
:- use_module('../Util/doacaoManager.pl', [addDoacao/5, addDoacaoDirecionada/6, getDoacaoById/3, getAllDoacoes/1]).

:- use_module('../Util/personManager.pl', [getPersonByID/3]).

:- use_module('../Util/input.pl', [input/1]).

% isDonor(Cpf) :- .

today(Today) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(date, DateTime, Today).

%Verificar as checagens que precisam ser feitas.
createDonation(FileName) :-
    % pega a data atual
    today(Today),
    writeln(Today),
    % instancia uma nova doacao
    writeln('CPF: '),
    input(Cpf),
    getPersonByID('doadores', Cpf, Person),
    writeln(Person).
    % pega as bolsas atuais desse tipo sanguineo
    % atualiza a quantidade
    % update a o database de bolsas 
    % adiciona a doacao no seu database
    % addDoacao(FileName, Doador, TipoSangue, Quantidade, Data),
    % writeln('Doação criada com sucesso!').

% Todo addDoacaoDirecionada
% createDirectDonation(FileName, Doador, Receptor, TipoSangue, Quantidade, Data):-
%     addDoacaoDirecionada(FileName, Doador, Receptor, TipoSangue, Quantidade, Data),
%     writeln('Doação criada com sucesso!').

getAllDonations(FileName):-
    writeln('Lista de Doações: '),
    getAllDoacoes(FileName).

getDonationByCPF(FileName, CPF, Result):-
    getDoacaoById(FileName, CPF, Result).