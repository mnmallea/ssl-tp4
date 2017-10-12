%code top{
#include <stdio.h>
#include "scanner.h"
}
%code provides{
void yyerror(const char *);
extern int yylexerrs;
extern int yyerrs;
}
%defines "parser.h"
%output "parser.c"
%token IDENTIFICADOR CONSTANTE PROGRAMA LEER ESCRIBIR DEFINIR FIN VARIABLES CODIGO ASIGNACION
%left '+' '-'
%left '*' '/'
%precedence NEG 
%define api.value.type {char *}
%define parse.error verbose
%%
todo			: PROGRAMA VARIABLES listaVariables CODIGO bloqueCodigo FIN { if (yynerrs || yylexerrs) YYABORT;}
			;
listaVariables 		: listaVariables DEFINIR IDENTIFICADOR ';' {printf("Definir %s\n",$3);}
			| DEFINIR IDENTIFICADOR ';' {printf("Definir %s\n",$2);}
			| error ';'
			;
bloqueCodigo		: bloqueCodigo sentencia ';'
			| sentencia ';'
			;
sentencia		: LEER '(' listaIdentificadores ')' {printf("Leer\n");}
			| ESCRIBIR '(' listaExpresiones ')' {printf("Escribir\n");}
			| IDENTIFICADOR ASIGNACION expresion {printf("Asignacion\n");}
			| error
			;
listaIdentificadores	: listaIdentificadores ',' IDENTIFICADOR
			| IDENTIFICADOR 
			| error
			;
listaExpresiones	: expresion ',' listaExpresiones
			| expresion
			;
expresion		: expresion '+' expresion {printf("Suma\n");}
			| expresion '-' expresion {printf("Resta\n");}
			| expresion '*' expresion {printf("Multiplicacion\n");}
			| expresion '/' expresion {printf("Division\n");}
			| '-' expresion %prec NEG {printf("Inversion\n");}
			| IDENTIFICADOR
			| CONSTANTE
			| '(' expresion ')' {printf("Paréntesis\n");}
			| error
			;
%%
