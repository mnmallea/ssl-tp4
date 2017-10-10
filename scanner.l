%{
#include <stdio.h>
#include "parser.h"
%}
%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput

letra [a-zA-Z]
digito [0-9]
invalido [[:punct:]]{-}[;,()+*/-]

%%
programa			return PROGRAMA;
leer				return LEER;
escribir			return ESCRIBIR;
variables			return VARIABLES;
codigo				return CODIGO;
fin				return FIN;
definir				return DEFINIR;
{digito}+			return CONSTANTE;
{letra}({letra}|{digito})*	return IDENTIFICADOR;
:=				return ASIGNACION;
"+"				return '+';
-				return '-';
"*"				return '*';
"/"				return '/';
;				return ';';
,				return ',';
"("				return '(';
")"				return ')';		
{digito}+{letra}+		printf("Error léxico: constante con sufijo inválido: %s\n",yytext);
{letra}({letra}|{digito})*{invalido}({invalido}|{letra}|{digito})*	printf("Error léxico: identificador invalido: %s\n",yytext);
{invalido}+			printf("Error léxico: cadena desconocida: %s\n",yytext);
"/""/".*			;
\t|\n|" "    			;

%%
