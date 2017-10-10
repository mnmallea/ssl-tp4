%{
#include <stdio.h>
#include "parser.h"
%}
%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
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
{digito}+			{yylval=strdup(yytext); return CONSTANTE;}
{letra}({letra}|{digito})*	{yylval=strdup(yytext); return IDENTIFICADOR;}
:=				return ASIGNACION;
"+"				return '+';
-				return '-';
"*"				return '*';
"/"				return '/';
;				return ';';
,				return ',';
"("				return '(';
")"				return ')';		
{digito}+{letra}+		{yyerror("Error léxico: constante con sufijo inválido"); yylexerrs++;}
{letra}({letra}|{digito})*{invalido}({invalido}|{letra}|{digito})*	{yyerror("Error léxico: identificador invalido"); yylexerrs++;}
{invalido}+			{yyerror("Error léxico: cadena desconocida"); yylexerrs++;}
"/""/".*			;
\t|\n|" "    			;

%%
