:- module(personService, [
    ehDoador/1,
    ehReceptor/1,
    getUserByCpf/1, 
    getAllUsers/1, 
    addUser/1, 
    removeUser/1, 
    updateUser/1
]).
:- use_module('../Util/personManager.pl').
:- use_module('../Util/input.pl').

% Verificar as checagens que precisam ser feitas.

ehDoador(Cpf) :- checaExistenciaPerson('doadores', Cpf).

ehReceptor(Cpf) :- checaExistenciaPerson('receptores', Cpf).

addUser(FileName) :-
    writeln('Insira os dados do usuario: '),
    inputCadastroUser(Cpf, Nome, Tel, Endereco, TipoSangue),
    addPerson(FileName, Cpf, Nome, Tel, Endereco, TipoSangue).

removeUser(FileName) :-
    writeln('Cpf'),
    inputString(Cpf),
    removerPerson(FileName, Cpf),
    writeln('Usuário removido com sucesso!').

getUserByCpf(FileName) :-
    writeln('Usuário procurado: '),
    writeln('Cpf'),
    inputString(Cpf),
    getPersonByID(FileName, Cpf, Person),
    writeln(Person).
    
getAllUsers(FileName) :-
    writeln('Lista dos usuários: '),
    getAllPersons(FileName).

updateUser(FileName) :-
    writeln('Digite os novos dados do usuário: '),
    inputCadastroUser(Cpf, NovoNome, NovoTel, NovoEndereco, NovoTipoSangue),
    updatePerson(FileName, Cpf, NovoNome, NovoTel, NovoEndereco, NovoTipoSangue),
    writeln('Usuário atualizado com sucesso!').