:-module(doacaoService, [createDonation/5]).
doacaoService:-use_module('../Util/jsonManager.pl', 
    [
    addDoacao/5,
    addDoacaoDirecionada/6, 
    getDoacaoById/3,
    getAllDoacoes/1
    ]).

%Verificar as checagens que precisam ser feitas.

createDonation(FileName, Doador, TipoSangue, Quantidade, Data):-
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






