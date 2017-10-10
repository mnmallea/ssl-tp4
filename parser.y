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
%token IDENTIFICADOR CONSTANTE PUNTUACION PROGRAMA LEER ESCRIBIR DEFINIR FIN VARIABLES CODIGO ASIGNACION 
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
			;
listaIdentificadores	: listaIdentificadores ',' IDENTIFICADOR
			| IDENTIFICADOR 
			| error
			;
listaExpresiones	: expresion ',' listaExpresiones
			| expresion
			;
expresion		: expresion '+' termino {printf("Suma\n");}
			| expresion '-' termino {printf("Resta\n");}
			| termino
			;
termino			: termino '*' factor {printf("Multiplicacion\n");}
			| termino '/' factor {printf("Division\n");}
			| factor
			;
factor			: CONSTANTE
			| '(' expresion ')' {printf("Parentesis\n");}
			| '-' expresion {printf("Inversion\n");}
			| IDENTIFICADOR
			| error
			;
%%
