/*
    TP4-2017
    Trabajo Práctico Nº4
    Grupo 01
    Integrantes:
    Chipian, Rocío          159.474-6
    Gabadian, Gastón        159.080-7
    Mallea, Martín          159.093-5
    Tripodi, María Belén    159.981-7
*/

#include <stdio.h>
#include "scanner.h"
#include "parser.h"

extern int yynerrs;
int yylexerrs = 0;
int main() {
	switch( yyparse() ){
	case 0:
		puts("Compilación terminada con éxito");
		break;
	case 1:
		puts("Hubo errores de compilación");
		break;
	case 2:
		puts("Memoria insuficiente");
		break;
	}
	printf("Cantidad de errores léxicos: %d\tCantidad de errores sintácticos: %d\n",yylexerrs,yynerrs);
	return 0;
}
/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}
