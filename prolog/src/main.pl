% :- module(main).
:- use_module('menu.pl', [menuPrincipal/0]).

main :- 
    prompt(_, ''),
    menuPrincipal.