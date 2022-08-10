:- module('input',[input/1, inputString/1, inputCadastroUser/5, inputCadastroDoacao/3]).

input(Input) :-
    read_line_to_codes(user_input, X1),
    string_to_atom(X1,Input).


inputString(InputString) :-
  input(Input),
  atom_string(Input, InputString).

inputCadastroUser(Cpf, Nome, Tel, Endereco, TipoSangue) :-
    writeln('CPF: '),
    inputString(Cpf),
    writeln('Nome: '),
    inputString(Nome),
    writeln('Telefone: '),
    inputString(Tel),
    writeln('Endereco: '),
    inputString(Endereco),
    writeln('Tipo Sanguineo: '),
    inputString(TipoSangue).


inputCadastroDoacao(Cpf, TipoSangue, Quantidade) :-
  writeln('CPF: '),
  inputString(Cpf),
  writeln('Tipo Sanguineo: '),
  inputString(TipoSangue),
  writeln('Quantidade: '),
  input(Quantidade).