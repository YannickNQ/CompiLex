%{
/*Librerias que vamos a usar*/
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#include <ctype.h>
FILE *yyin;
%}
/*SECCIÓN DE OPCIONES*/
/* Esto indica a Flex que lea un solo fichero de entrada*/
%option noyywrap
/*Esto nos permitirá obtener el número de línea*/
%option yylineno

/*SECCIÓN DE TOKENS*/
LETTER          [a-zA-Z]
DIGIT           [0-9]
ESPACE          ["  "]
BEG_COMENT      ["/*"]
END_COMENT      ["*/"]
END_SENTENCE    [";"]
UNDERSCORE      [-_]
CHAR_DOT        ["."]

ID	            {LETTER}({LETTER}|{DIGIT})*
CONST_INTEGER   (-?[1-9][0-9]{0,4})|0
CONST_FLOAT     {DIGIT}{0,8}{CHAR_DOT}{DIGIT}{1,8}

/*Operadores lógicos y operados aritmeticos basicos*/
OP_SUM          ["+"]
OP_SUBT         ["-"]
OP_MULT         ["*"]
OP_DIV          ["/"]
OP_EQ           ["="]
OP_GT           [">"]
OP_LT           ["<"]
OP_GOE          ">="
OP_LOE          "<="
OP_NOT          "!"
OP_NE           "!="

/*Palabras Reservadas*/
WHERE 	        [W|w][H|h][E|e][R|r][E|e]
FROM	        [F|f][R|r][O|o][M|n]
SELECT	        [S|s][E|e][L|l][E|e][C|c][T|t]

/*SECCIÓN DE REGLAS Y ACCIÓN SEMÁNTICA*/
%%
{END_SENTENCE}  { printf("\nEND_SENTENCE (%s)", yytext);}
{CONST_INTEGER} { fn_checkran(yytext), printf("\nCONST_INTEGER (%s)", yytext);}
{CONST_FLOAT}   { printf("\nCONST_FLOAT (%s)", yytext);}

{OP_SUM}        { printf("\nOP_SUM (%s)", yytext);}
{OP_SUBT}       { printf("\nOP_SUBT (%s)", yytext);}
{OP_MULT}       { printf("\nOP_MULT (%s)", yytext);}
{OP_DIV}        { printf("\nOP_DIV (%s)", yytext);}
{OP_EQ}         { printf("\nOP_EQ (%s)", yytext);}
{OP_GT}         { printf("\nOP_GT (%s)", yytext);}
{OP_LT}         { printf("\nOP_LT (%s)", yytext);}
{OP_GOE}        { printf("\nOP_GOE (%s)", yytext);}
{OP_LOE}        { printf("\nOP_LOE (%s)", yytext);}
{OP_NOT}        { printf("\nOP_NOT (%s)", yytext);}
{OP_NE}         { printf("\nOP_NE (%s)", yytext);}

{WHERE} 	    { printf("\nPalabra Reservada WHERE: (%s)", yytext); }
{FROM} 		    { printf("\nPalabra Reservada FROM:(%s)", yytext); }
{SELECT}	    { printf("\nPalabra Reservada SELECT: (%s)", yytext);}
{ID}		    { printf("\nID: (%s)", yytext);}

"\n"
"\t"
" "
%%

int main(int argc, char *argv[])
{
    if( (yyin = fopen(argv[1], "rt")) == NULL){
        printf("\nCould not open file: %s\n", argv[1]);
        return 1;
    }
    else{
        printf("\nSuccessfully open file", argv[1]);
        yylex();
    }
    printf("\nFLEX has finished reading the file");
    fclose(yyin);
    return 0;
}
/*Esta funcion nos servira para saber si el valor esta dentro del rango*/
int fn_checkran(char *ptr)
{
    int value = atoi(ptr);
    if( value < -32768 || value > 32768 )
    {
        printf("Error: variable out of range");
        return yyerror();
    }    
}

/*Esta funcion nos retornará el error*/
int yyerror(void){
    printf("\n Error lexico: Caracter Invalido: %s \n", yytext);
    exit(1);
}