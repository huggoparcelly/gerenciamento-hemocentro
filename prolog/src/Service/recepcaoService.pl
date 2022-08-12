:- module(recepcaoService, [
    createReception/0
    ]).
:- use_module('../Util/input.pl', [input/1, inputString/1, inputCadastroDoacao/2]).
:- use_module('../Util/bagManager.pl', [checaExistenciaBag/1, retiraSangue/2]).

%Cria recepcao de sangue
createReception :- 
    write('Tipo de sangue: '),
    inputString(TipoSangue),
    %\+ checaExistenciaBag(TipoSangue), 
    %writeln('tipo invalido.');
    
    write('Quantidade: '),
    input(Qtd),
    atom_number(Qtd, QtdNumber),

    retiraSangue(TipoSangue, QtdNumber).
    
    