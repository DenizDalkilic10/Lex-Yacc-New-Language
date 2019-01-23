%{
    #include<stdio.h>
%}

%token MOVE_FUNC GRAB_FUNC RELEASE_FUNC TURN_FUNC READ_FUNC SEND_FUNC RECEIVE_FUNC INT_TYPE FLOAT_TYPE STRING_TYPE VOID_TYPE CONST_TYPE PLUS MINUS ASTERISK SLASH MOD IF ELSE WHILE FOR END START COMMA LEFT_P RIGHT_P LEFT_SQUARE_P RIGHT_SQUARE_P SCOPE_BEGIN SCOPE_END OR EQUAL IS_EQUAL IS_NOT_EQUAL LESS_OR_EQ GREATER_OR_EQ LESS_THAN GREATER_THAN AND NOT RETURN INTEGER FLOAT COMMENT VARIABLE FUNCTION_NAME CONST ASK PRINT SEMICOLON INVALID

%%
program : START stmts END ;
 
stmts :  stmts stmt | stmt ;
 
stmt : non_block_stmt SEMICOLON | block_stmt | COMMENT ;
 
non_block_stmt : return_stmt | assignment_stmt | var_declaration  
     | function_call_stmt | scan_statement | print_statement | constant_declaration ;
 
assignment_stmt : left_hand_side EQUAL right_hand_side ;
 
left_hand_side : var_declaration | VARIABLE ;
 
right_hand_side : expression ;
 
expression : conditional_expression ;
 
conditional_expression : or_expression ;
 
or_expression : and_expression
     | or_expression OR and_expression ;
 
and_expression : equality_expression
     | and_expression AND equality_expression ;
 
equality_expression : relational_expression
     | equality_expression equality_operator relational_expression ;
 
relational_expression : additive_expression
| relational_expression relational_operator additive_expression ;
 
additive_expression : multiplication_expression
     | additive_expression addition_operator multiplication_expression ;
 
multiplication_expression : primary_expression
     | multiplication_expression multipication_operator primary_expression ;                                       
 
primary_expression : VARIABLE | CONST | primitive_type |  function_call_stmt
     | LEFT_P expression RIGHT_P ;
 
scan_statement : ASK VARIABLE ;
 
print_statement : PRINT expression ;
 
return_stmt : RETURN expression | RETURN ;
 
function_call_stmt : primitive_function_call | FUNCTION_NAME LEFT_P parameter_input_list RIGHT_P |  FUNCTION_NAME LEFT_P RIGHT_P;
 
parameter_input_list : expression | expression COMMA parameter_input_list ;
 
primitive_function_call :  move_func | grab_func | release_func | turn_func |
     read_func | send_func | receive_func ;
 
move_func : MOVE_FUNC LEFT_P INTEGER RIGHT_P 
| MOVE_FUNC LEFT_P VARIABLE RIGHT_P ;
 
grab_func : GRAB_FUNC LEFT_P RIGHT_P ;
 
release_func : RELEASE_FUNC LEFT_P RIGHT_P ;
 
turn_func : TURN_FUNC LEFT_P INTEGER RIGHT_P
| TURN_FUNC LEFT_P VARIABLE RIGHT_P ;
 
read_func : READ_FUNC LEFT_P INTEGER RIGHT_P
| READ_FUNC LEFT_P VARIABLE RIGHT_P ;
 
send_func : SEND_FUNC LEFT_P INTEGER RIGHT_P
| SEND_FUNC LEFT_P VARIABLE RIGHT_P ;
 
receive_func : RECEIVE_FUNC LEFT_P INTEGER RIGHT_P
| RECEIVE_FUNC LEFT_P VARIABLE RIGHT_P ;
 
block_stmt : if_then_stmt | if_then_else_stmt | loop_stmt | function_declaration ;
 
if_then_stmt : IF LEFT_P conditional_expression RIGHT_P body ;
 
if_then_else_stmt : IF LEFT_P conditional_expression RIGHT_P body ELSE body ;
 
loop_stmt : while_stmt | for_stmt ;
 
while_stmt : WHILE LEFT_P conditional_expression RIGHT_P body ;
 
for_stmt : FOR LEFT_P assignment_stmt SEMICOLON conditional_expression SEMICOLON assignment_stmt RIGHT_P body ;
 
var_declaration : type_name VARIABLE ;
 
constant_declaration : CONST_TYPE type_name CONST EQUAL expression ;
 
function_declaration : function_header  body ;
 
function_header : return_type function_declarator ;
 
function_declarator : FUNCTION_NAME LEFT_P parameter_list  RIGHT_P | FUNCTION_NAME LEFT_P RIGHT_P;
 
return_type : type_name | VOID_TYPE ;
 
parameter_list : parameter | parameter_list COMMA parameter ;
 
parameter : type_name VARIABLE ;
 
multipication_operator : ASTERISK | SLASH | MOD ;
 
addition_operator : PLUS | MINUS ;
 
relational_operator :  LESS_THAN | GREATER_THAN | LESS_OR_EQ | GREATER_OR_EQ ;
 
equality_operator : IS_EQUAL | IS_NOT_EQUAL ;
 
body :  SCOPE_BEGIN stmts SCOPE_END |  SCOPE_BEGIN SCOPE_END ;
 
type_name : INT_TYPE | FLOAT_TYPE ;
 
primitive_type : INTEGER | FLOAT ;

%%
#include "lex.yy.c"
extern int lineCounter;
int check = 0;
int yyerror(char *s)
{
    printf ("%s on line %d\n", s, lineCounter);
    check = 1;
}

int main(void)
{
    yyparse();
    if ( check == 0 )
    {
        printf ("Input program is valid\n");
    }
}