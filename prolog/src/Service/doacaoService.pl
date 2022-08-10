:- module('doacaoService', [
    createDonation/1,
    createDirectDonation/6,
    getAllDonations/1,
    getDonationById/0
    ]).
:- use_module('../Util/doacaoManager.pl', [addDoacao/5, addDoacaoDirecionada/6, getDoacaoById/3, getAllDoacoes/1]).

:- use_module('../Util/personManager.pl', [getPersonByID/3]).
:- use_module('../Util/bagManager.pl', [getBagByBloodType/3, updateBag/3]).

:- use_module('../Util/input.pl', [input/1, inputString/1, inputCadastroDoacao/3]).

today(Today) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(date, DateTime, Today).

%Verificar as checagens que precisam ser feitas.
createDonation :-
    today(Today),
    inputCadastroDoacao(Cpf, TipoSangue, Quantidade),
    
    getPersonByID('doadores', Cpf, Doador),

    % Verificar doador

    % pega as bolsas atuais desse tipo sanguineo
    getBagByBloodType('bolsaSangue', TipoSangue, Result),
    atom_number(Quantidade, QntNumber),
    Soma is QntNumber + Result.quantidade,
    
    % update a o database de bolsas 
    updateBag('bolsaSangue', TipoSangue, Soma), 
    
    % adiciona a doacao no seu database
    addDoacao('doacoes', Cpf, TipoSangue, Quantidade, Today),
    writeln('Doação criada com sucesso!').

% Todo addDoacaoDirecionada
% createDirectDonation(FileName, Doador, Receptor, TipoSangue, Quantidade, Data):-
%     addDoacaoDirecionada(FileName, Doador, Receptor, TipoSangue, Quantidade, Data),
%     writeln('Doação criada com sucesso!').

getAllDonations(FileName):-
    writeln('Lista de Doações: '),
    writeln('------------------'),
    getAllDoacoes(FileName).

getDonationById:-
    writeln('Id'),
    input(IdAtom),
    atom_number(IdAtom, Id),
    getDoacaoById('doacoes', Id, Result),
    writeln(Result).