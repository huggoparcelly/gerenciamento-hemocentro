:- module('medulaService', [
    createDonationMedula/0,
    buscarDonationMedula/0,
    getAllDonationsMedula/0
    ]).

:- use_module('../Util/personManager.pl', [getPersonByCpf/3]).
:- use_module('../Service/comprovanteService.pl').
:- use_module('../Util/input.pl', [input/1, inputString/1, inputCadastroDoacao/2]).
:- use_module('../Service/personService.pl').
:- use_module('../Util/doacaoManager.pl').

today(Today) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(date, DateTime, Today).

createDonationMedula :-
    today(Data),
    inputString(Cpf),    
    ehDoador(Cpf) -> (
        getPersonByCpf("doadores", Cpf, Result),
        addDoacaoMedula("doacoesMedula", Cpf, Data),
        getPersonByCpf("doadores", Cpf, Result),
        createComprovante("comprovanteDoacao", Cpf, Today),
        writeln('\n>>> Doação de medula realizada!.\n')
    );
    writeln('\n>>> CPF não consta no cadastro de doadores.\n').

buscarDonationMedula :-
    write("digite o id a ser buscado: "),
    input(Id),
    getDoacaoMedulaById(Id).
    
getAllDonationsMedula :-
    writeln('>>> Listagem de Doações de Medula <<< '),
    writeln('---------------------------'),
    getAllDoacoesMedula('doacoesMedula').