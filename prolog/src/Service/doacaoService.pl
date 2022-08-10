:- module('doacaoService', [
    createDonation/0,
    createDirectDonation/0,
    getAllDonations/0,
    getDonationById/0
    ]).
:- use_module('../Util/doacaoManager.pl', [addDoacao/5, addDoacaoDirecionada/0, getDoacaoById/3, getAllDoacoes/1]).
:- use_module('../Util/personManager.pl', [getPersonByCpf/3]).
:- use_module('../Util/bagManager.pl', [getBagByBloodType/3, updateBag/3]).
:- use_module('../Service/personService.pl').
:- use_module('../Service/bolsaService.pl').
:- use_module('../Util/input.pl', [input/1, inputString/1, inputCadastroDoacao/2]).

today(Today) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(date, DateTime, Today).

% Cadastra uma doação no sistema.
createDonation :-
    today(Today),
    inputCadastroDoacao(Cpf, Quantidade),
    ehDoador(Cpf) -> (
        getPersonByCpf('doadores', Cpf, Doador),
        getBagByBloodType('bolsaSangue', Doador.tipoSangue, Result),

        atom_number(Quantidade, QntNumber),
        QtdAtt is QntNumber + Result.quantidade,
        
        updateBag('bolsaSangue', Doador.tipoSangue, QtdAtt), 
        
        addDoacao('doacoes', Cpf, Doador.tipoSangue, Quantidade, Today),
        writeln('>>> Doação criada com sucesso! <<<')
    );
    writeln('\n>>> CPF não consta no cadastro de doadores.\n').

% Todo addDoacaoDirecionada
createDirectDonation:-
    % addDoacaoDirecionada(FileName, Doador, Receptor, TipoSangue, Quantidade, Data),
    writeln('Doação criada com sucesso!').

getAllDonations :-
    writeln('>>> Listagem de Doações <<< '),
    writeln('---------------------------'),
    getAllDoacoes('doacoes').

getDonationById:-
    writeln('Id'),
    input(IdAtom),
    atom_number(IdAtom, Id),
    getDoacaoById('doacoes', Id, Result),
    writeln(Result).