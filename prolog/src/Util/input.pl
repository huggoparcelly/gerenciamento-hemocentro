:- module('input',[input/1]).

input(Input) :-
    read_line_to_codes(user_input, X1),
    string_to_atom(X1,Input).


inputString(InputString) :-
  input(Input),
  atom_string(Input, InputString).

inputCadastroUser(Cpf, Nome, Tel, Endereco, TipoSangue) :-
    writeln('CPF: '),
    input(Cpf),
    writeln('Nome: '),
    input(Nome),
    writeln('Telefone: '),
    input(Tel),
    writeln('Endereco: '),
    input(Endereco),
    writeln('Tipo Sanguineo: '),
    input(TipoSangue).


inputCadastroDoacao(Cpf, TipoSangue, Quantidade) :-
  writeln('CPF: '),
  inputString(Cpf),
  writeln('Tipo Sanguineo: '),
  inputString(TipoSangue),
  writeln('Quantidade: '),
  input(Quantidade).