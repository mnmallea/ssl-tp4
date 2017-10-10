%code top{
#include <stdio.h>
#include "scanner.h"
}
%code provides{
void yyerror(const char *);
extern int yylexerrs;
}
%defines "parser.h"
%output "parser.c"
%token IDENTIFICADOR CONSTANTE PUNTUACION PROGRAMA LEER ESCRIBIR DEFINIR FIN VARIABLES CODIGO ASIGNACION 
%precedence NEG
%define api.value.type {char *}
%define parse.error verbose
%%
todo			: PROGRAMA VARIABLES listaVariables CODIGO bloqueCodigo FIN { if (yynerrs || yylexerrs) YYABORT;};
listaVariables 		: DEFINIR IDENTIFICADOR ';' listaVariables
			| DEFINIR IDENTIFICADOR ';'
			;
bloqueCodigo		: sentencia ';' bloqueCodigo
			| sentencia ';'
			;
sentencia		: LEER '(' listaIdentificadores ')'
			| ESCRIBIR '(' listaExpresiones ')'
			| IDENTIFICADOR ASIGNACION expresion
			;
listaIdentificadores	: IDENTIFICADOR ',' listaIdentificadores
			| IDENTIFICADOR
			;
listaExpresiones	: expresion ',' listaExpresiones
			| expresion
			;
expresion		: expresion '+' termino
			| expresion '-' termino
			| termino
			;
termino			: termino '*' factor
			| termino '/' factor
			| factor
			;
factor			: CONSTANTE
			| '(' expresion ')'
			| '-' expresion //%prec NEG
			| IDENTIFICADOR
			;
%%

