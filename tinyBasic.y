%{
#include <iostream>
#include <cstdio>

int yylex();
extern int line_num;
int yyerror(const char *p) { std::cerr << "error: " << p << " line no.: " << line_num << std::endl; };

extern "C" FILE *yyin;
%}

%union {
    char* val;
};

%start prog

%token <val> PRINT IF THEN GOTO INPUT LET GOSUB RETURN CLEAR LIST RUN END
%token <val> LPAREN RPAREN
%token <val> STRING VAR
%token <val> COMMA RELOP
%token <val> PLUMIN MULDIV
%token <val> CR
%token <val> DIGIT

%type <val> prog lines line statement stringExp commaStringExp exprList commaVar varList expression multdivFactor term factor number

%%

prog : lines                           { std::cout << $1 << std::endl; }
     ;

lines : line
      | line lines
      ;

line : number statement CR
     | statement CR
     ;

statement : PRINT exprList
          | IF expression RELOP expression THEN statement
          | GOTO expression
          | INPUT varList
          | LET VAR RELOP expression
          | GOSUB expression
          | RETURN
          | CLEAR
          | LIST
          | RUN
          | END
          ;

stringExp : STRING
          | expression
          ;

commaStringExp :
               | COMMA stringExp commaStringExp
               ;

exprList : stringExp commaStringExp
          ;

commaVar : 
         | COMMA VAR commaVar
         ;

varList : VAR commaVar
         ;

expression : 
           | PLUMIN term expression
           ;

multdivFactor :
              | MULDIV factor multdivFactor
              ;

term : factor multdivFactor
     ;

factor : VAR
       | number
       | LPAREN expression RPAREN
       ;

number : DIGIT
       | DIGIT number
       ;


%%

int main()
{
    // open a file handle to a particular file:
    FILE *myfile = fopen("test.in", "r");
    // make sure it's valid:
    if (!myfile) {
        std::cerr << "I can't open this file!" << std::endl;
        return -1;
    }
    // set lex to read from it instead of defaulting to STDIN:
    yyin = myfile;

    // parse through the input until there is no more:
    
    do {
        yyparse();
    } while (!feof(yyin));
    
    std::cerr << "Done!" << std::endl;
    
    return 0;
}
