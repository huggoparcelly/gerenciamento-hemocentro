:- module('input',[input/1]).

input(Input) :-
    read_line_to_codes(user_input, X1),
    string_to_atom(X1,Input).


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


% inputCadastroUser(Doador, Nome, Tel, Endereco, TipoSangue) :-
%   writeln('CPF: '),
%   input(Cpf),
%   writeln('Nome: '),
%   input(Nome),
%   writeln('Telefone: '),
%   input(Tel),
%   writeln('Endereco: '),
%   input(Endereco),
%   writeln('Tipo Sanguineo: '),
%   input(TipoSangue).