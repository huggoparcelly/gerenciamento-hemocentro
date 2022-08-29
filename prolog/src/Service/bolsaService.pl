:- module(bolsaService, [
  ehTipoValido/1,
  getBolsas/0,
  getBolsaByTipo/2
]).
:- use_module('../Util/bagManager.pl').


% checkIfTipoExists
ehTipoValido(TipoSangue) :- checaExistenciaBag(TipoSangue).

% Retorna todas as bolsas de sangue registradas no sistema
getBolsas :-
  writeln('Bolsas de Sangue: '),
  getAllBags('bolsaSangue').

% Retorna as bolsas de sangue de um tipo registradas no sistema
getBolsaByTipo(Tipo, Result) :-
  swritef(Out, 'Bolsas de Sangue do Tipo %w', [Tipo]),
  write(Out),
  getBagByBloodType('bolsaSangue', Tipo, Result).