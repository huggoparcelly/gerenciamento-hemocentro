:- module('doacaoService', [
    createDonation/5,
    createDirectDonation/6,
    getAllDonations/1,
    getDonationByCPF/3
    ]).
:- use_module('../Util/doacaoManager.pl', [addDoacao/5, addDoacaoDirecionada/6, getDoacaoById/3, getAllDoacoes/1]).

% isDonor(Cpf) :- .


%Verificar as checagens que precisam ser feitas.
createDonation(FileName, Doador, TipoSangue, Quantidade, Data) :-
    % pega a data atual
    % instancia uma nova doacao 
    % pega as bolsas atuais desse tipo sanguineo
    % atualiza a quantidade
    % update a o database de bolsas 
    % adiciona a doacao no seu database
    addDoacao(FileName, Doador, TipoSangue, Quantidade, Data),
    writeln('Doação criada com sucesso!').


createDirectDonation(FileName, Doador, Receptor, TipoSangue, Quantidade, Data):-
    addDoacaoDirecionada(FileName, Doador, Receptor, TipoSangue, Quantidade, Data),
    writeln('Doação criada com sucesso!').

getAllDonations(FileName):-
    writeln('Lista de Doações: '),
    getAllDoacoes(FileName).

getDonationByCPF(FileName, CPF, Result):-
    getDoacaoById(FileName, CPF, Result).