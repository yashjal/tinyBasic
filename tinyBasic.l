%{
#include <iostream>
#include <stdlib.h>
#include <string.h>
#include "tinyBasic.tab.h"

int line_num = 1;
%}

%option noyywrap

%%

"PRINT"					{ yylval.val = strdup(yytext); return PRINT; }
"IF"					{ yylval.val = strdup(yytext); return IF; }
"THEN"					{ yylval.val = strdup(yytext); return THEN; }
"GOTO"					{ yylval.val = strdup(yytext); return GOTO; }
"INPUT"					{ yylval.val = strdup(yytext); return INPUT; }
"LET"					{ yylval.val = strdup(yytext); return LET; }
"GOSUB"					{ yylval.val = strdup(yytext); return GOSUB; }
"RETURN"				{ yylval.val = strdup(yytext); return RETURN; }
"CLEAR"					{ yylval.val = strdup(yytext); return CLEAR; }
"LIST"					{ yylval.val = strdup(yytext); return LIST; }
"RUN"					{ yylval.val = strdup(yytext); return RUN; }
"END"					{ yylval.val = strdup(yytext); return END; }
","						{ yylval.val = strdup(yytext); return COMMA; }
">"|"<"|"="				{ yylval.val = strdup(yytext); return RELOP; }
[A-Z]					{ yylval.val = strdup(yytext); return VAR; }
["][ A-Za-z0-9\_]+["]	{ yylval.val = strdup(yytext); return STRING; }
[0-9]                   { yylval.val = strdup(yytext); return DIGIT; }
"+"|"-"                 { yylval.val = strdup(yytext); return PLUMIN; }
"*"|"/"                 { yylval.val = strdup(yytext); return MULDIV; }
"("                     { yylval.val = strdup(yytext); return LPAREN; }
")"                     { yylval.val = strdup(yytext); return RPAREN; }
[\n\r]            		{ ++line_num; yylval.val = strdup(yytext); return CR; }
[ \t]+ 	                { /* Ignore white space */ }
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%
