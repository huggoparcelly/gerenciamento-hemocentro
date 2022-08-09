:- module(personService, [
    getUserByCpf/3, 
    getAllUsers/1, 
    addUser/1, 
    removeUser/2, 
    updateUser/6
]).
:- use_module('../Util/personManager.pl', [getPersonByID/3, getAllPersons/1, addPerson/6, removerPerson/2, checaExistencia/2, updatePerson/6]).

:- use_module('../Util/input.pl', [inputCadastroUser/5]).

% Verificar as checagens que precisam ser feitas.

addUser(FileName) :-
    writeln('Insira os dados do usuario: '),
    inputCadastroUser(Cpf, Nome, Tel, Endereco, TipoSangue),
    addPerson(FileName, Cpf, Nome, Tel, Endereco, TipoSangue).

removeUser(FileName, Cpf) :-
    removerPerson(FileName, Cpf),
    writeln('Usuário removido com sucesso!').

getUserByCpf(FileName, Cpf, Person) :-
    writeln('Usuário procurado: '),
    getPersonByID(FileName, Cpf, Person).
    
getAllUsers(FileName) :-
    writeln('Lista dos usuários: '),
    getAllPersons(FileName).

updateUser(FileName, Cpf, NovoNome, NovoTel, NovoEndereco, NovoTipoSangue) :-
    writeln('Digite os novos dados do usuário: '),
    updatePerson(FileName, Cpf, NovoNome, NovoTel, NovoEndereco, NovoTipoSangue),
    writeln('Usuário atualizado com sucesso!').