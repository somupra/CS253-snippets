%{
    void yyerror (char *s);
    int yylex();

    #include <iostream>
    #include <stdio.h>     /* C declarations used in actions */
    #include <stdlib.h>
    #include <string.h>
    #include <utility>
    #include <ctype.h>
    #include <sstream>
    #include <unordered_map>
    #include <math.h>

    /* Container to store parse values and results. */
    std::unordered_map<std::string, float> symbol_table;

    float symbolVal(const char* symbol);
    void updateSymbolVal(const char* symbol, float val);
    extern int yyparse();
    extern FILE *yyin;
%}

/* Yacc definitions */

%union {float num; const char* id;}         

%start program

%token print
%token exit_command
%token sin_ cos_ tan_ log_ pow_
%token <num> number
%token <id> identifier

//%type stmt_list program assignment
%type <num> exp term

%left '+' '-'
%left '*' '/'
%%

/* descriptions of expected inputs  &   corresponding actions */

program : stmt_list
        ;

stmt_list : stmt_list assignment ';' 
          | stmt_list print exp ';'    {printf("%f\n", $3);}
          | stmt_list exit_command ';' {printf("Exitting...\n"); exit(0);}
          | /* Empty */
          ;

assignment : identifier '=' exp  { updateSymbolVal($1, $3); }
           ;

exp : term        { $$ = $1;}
    | exp '+' exp { $$ = $1 + $3;}
    | exp '-' exp { $$ = $1 - $3;}
    | exp '*' exp { $$ = $1 * $3;}
    | exp '/' exp { $$ = $1 / $3;}
    | sin_ '(' exp ')'   { $$ = sin($3); }
    | cos_ '(' exp ')'   { $$ = std::cos($3); }
    | tan_ '(' exp ')'   { $$ = std::tan($3); }
    | log_ '(' exp ')'   { $$ = std::log($3); }
    | pow_ '(' exp ',' exp ')'   { $$ = std::pow($3, $5); }
    | '(' exp ')' { $$ = $2; }
    ;

term : number     { $$ = $1; }
     | identifier { $$ = symbolVal($1); } 
     ;

%%     

/* returns the value of a given symbol from symbol table */
float symbolVal(const char* symbol)
{
std::string find(symbol);
    return symbol_table[find];
}

/* updates the value of a given symbol in symbol table */
void updateSymbolVal(const char* symbol, float val)
{
    std::string input(symbol);
    symbol_table[input] = val;
}

int main (int argc, char* argv []) {
    if(argc == 2){
        yyin = fopen(argv[1], "r");
        if(yyin == NULL){
            printf("File does not exist\n");
            return 0;
        }
    }
    return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

