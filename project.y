%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
extern int yyparse(void);
%}

%token INT FLOAT BOOL VOID CHAR STRING IMAGE STRUCT NEW ARRAY BLN_FALSE BLN_TRUE LONGITUDE LATITUDE ROAD GRAPH CROSSROAD
%token AND_OPT OR_OPT ADD REMOVE
%token IF ELSE IFELSE WHILE BREAK CONTINUE FOR
%token FUNCTION RETURN
%token BLTIN_PRINT BLTIN_SHOWONMAP BLTIN_SEARCHLOCATION BLTIN_GETROADSPEED BLTIN_ADD  BLTIN_REMOVE BLTIN_GETLOCATION BLTIN_SHOWTARGET 
%token BLTIN_CALCULATE_ROTATE BLTIN_CONNECT  BLTIN_3D BLTIN_INPUT
%token LESSEQ_OPT GREATEREQ_OPT NEQ_OPT EQ_OPT LESS_OPT GREATER_OPT
%token ASSIGNMENT_OPT MULTIPLY_ASSIGNMENT_OPT DIVIDE_ASSIGNMENT_OPT MODE_ASSIGNMENT_OPT ADD_ASSIGNMENT_OPT SUB_ASSIGNMENT_OPT POW_ASSIGNMENT_OPT
%token INCREMENT_OPT DECREMENT_OPT NOT_OPT
%token MULTIPLY_OPT DIVIDE_OPT MODE_OPT ADD_OPT SUB_OPT POW_OPT
%token INT_LTRL FLT_LTRL STR_LTRL CHR_LTRL IDNTF
%token SEMICOLON LEFT_BRACKET RIGHT_BRACKET COMMA COLON LEFT_PARANTHESIS RIGHT_PARANTHESIS LEFT_SQUARE_BRACKET RIGHT_SQUARE_BRACKET DOT
%start statement_list
%%


block :   LEFT_BRACKET statement_list RIGHT_BRACKET
		| LEFT_BRACKET RIGHT_BRACKET
		;

statement_list:   statement 
				| statement_list statement
				;

statement :   if_structure
			| for_structure
			| while_structure
			| declarations SEMICOLON
			| function_call SEMICOLON
			| bltin_function_call SEMICOLON
			| BREAK SEMICOLON
			| CONTINUE SEMICOLON
			| RETURN SEMICOLON
			| RETURN argument_list SEMICOLON
			| function
			| calculations SEMICOLON
			| struct_definition SEMICOLON
			| struct_object_assignment SEMICOLON

			;

identifier :  IDNTF LEFT_SQUARE_BRACKET INT_LTRL RIGHT_SQUARE_BRACKET
			| INT_LTRL
			| FLT_LTRL
			| STR_LTRL
			| CHR_LTRL
			| IDNTF
			| bltin_function_call
			| function_call
			| struct_object_using
			;

increment_decrement : INCREMENT_OPT
					| DECREMENT_OPT
					;

condition_operators : LESSEQ_OPT
					| GREATEREQ_OPT
					| NEQ_OPT
					| EQ_OPT
					| LESS_OPT
					| GREATER_OPT
					| AND_OPT
					| OR_OPT
					;

parameter_elements : STRING
					| CHAR
					| INT
					| FLOAT
					| BOOL
					| LONGITUDE 
					| LATITUDE 
					| ROAD
					| ARRAY
					;

return_type : VOID
			| STRING
			| CHAR
			| INT
			| FLOAT
			| BOOL
			| LONGITUDE 
			| LATITUDE 
			| ROAD
			| ARRAY
			;

returns_types :   return_type
				| return_type COMMA returns_types
				;


logic_value_specifier :   BLN_FALSE
						| BLN_TRUE
						;
						
operands :   ASSIGNMENT_OPT 
		   | MULTIPLY_ASSIGNMENT_OPT
		   | DIVIDE_ASSIGNMENT_OPT 
		   | MODE_ASSIGNMENT_OPT 
		   | ADD_ASSIGNMENT_OPT 
		   | SUB_ASSIGNMENT_OPT 
		   | POW_ASSIGNMENT_OPT
		   ;

islemler :   MULTIPLY_OPT 
		   | DIVIDE_OPT 
		   | MODE_OPT 
		   | ADD_OPT 
		   | SUB_OPT 
		   | POW_OPT
		   ;

bltin_function_call : bltin_print
					| bltin_showonmap
					| bltin_searchlocation
					| bltin_getroadspeed
					| bltin_getlocation
					| bltin_showtarget
					| bltin_threed_object_definition
					| bltin_calculate_route
					| bltin_connect
					| bltin_input
					| bltin_add
					| bltin_remove 
					;


function :    FUNCTION IDNTF LEFT_PARANTHESIS parameter_list RIGHT_PARANTHESIS returns_types block
			| FUNCTION IDNTF LEFT_PARANTHESIS RIGHT_PARANTHESIS returns_types block
			;


parameter_list :  parameter_elements identifier
 				| parameter_elements identifier COMMA parameter_list
 				;

argument_list:    identifier
				| identifier COMMA argument_list
				;


bltin_print:		BLTIN_PRINT LEFT_PARANTHESIS argument_list RIGHT_PARANTHESIS
					;


bltin_showonmap:  BLTIN_SHOWONMAP LEFT_PARANTHESIS IDNTF COMMA IDNTF RIGHT_PARANTHESIS
				| BLTIN_SHOWONMAP LEFT_PARANTHESIS INT_LTRL COMMA INT_LTRL RIGHT_PARANTHESIS
				;
				
bltin_searchlocation: BLTIN_SEARCHLOCATION LEFT_PARANTHESIS IDNTF RIGHT_PARANTHESIS
					| BLTIN_SEARCHLOCATION LEFT_PARANTHESIS STR_LTRL RIGHT_PARANTHESIS
					;
					
bltin_getroadspeed :  BLTIN_GETROADSPEED LEFT_PARANTHESIS IDNTF RIGHT_PARANTHESIS
					| BLTIN_GETROADSPEED LEFT_PARANTHESIS STR_LTRL RIGHT_PARANTHESIS
					;
					
bltin_getlocation :	 BLTIN_GETLOCATION LEFT_PARANTHESIS IDNTF  RIGHT_PARANTHESIS
					;
					
bltin_showtarget :  BLTIN_SHOWTARGET LEFT_PARANTHESIS IDNTF RIGHT_PARANTHESIS
				  | BLTIN_SHOWTARGET LEFT_PARANTHESIS STR_LTRL RIGHT_PARANTHESIS
				 ;
				 
bltin_threed_object_definition : BLTIN_3D LEFT_PARANTHESIS INT_LTRL COMMA INT_LTRL COMMA INT_LTRL RIGHT_PARANTHESIS
						 ;
					 
bltin_calculate_route: BLTIN_CALCULATE_ROTATE LEFT_PARANTHESIS IDNTF RIGHT_PARANTHESIS
					 ;
					 
bltin_connect: BLTIN_CONNECT LEFT_PARANTHESIS IDNTF RIGHT_PARANTHESIS
			 ;
			 
bltin_input : BLTIN_INPUT LEFT_PARANTHESIS RIGHT_PARANTHESIS
			;

bltin_add :   IDNTF DOT ROAD DOT BLTIN_ADD LEFT_PARANTHESIS identifier RIGHT_PARANTHESIS
			| IDNTF DOT CROSSROAD DOT BLTIN_ADD LEFT_PARANTHESIS identifier RIGHT_PARANTHESIS
			
			;

bltin_remove : IDNTF DOT ROAD DOT BLTIN_REMOVE LEFT_PARANTHESIS identifier RIGHT_PARANTHESIS
			 | IDNTF DOT CROSSROAD DOT BLTIN_REMOVE LEFT_PARANTHESIS identifier RIGHT_PARANTHESIS
				;


function_call :  IDNTF LEFT_PARANTHESIS argument_list RIGHT_PARANTHESIS 
				|IDNTF LEFT_PARANTHESIS RIGHT_PARANTHESIS 
				;

declarations : parameter_elements IDNTF 
			|  parameter_elements IDNTF ASSIGNMENT_OPT identifier 
			|  IDNTF operands identifier  
			|  array_assignment
			|  graph_data_type
			|  struct_object_using ASSIGNMENT_OPT identifier
			
			;
			
calculations :  IDNTF operands identifier islemler calculations_devam
			   |IDNTF increment_decrement
			   
			  ;
			  
calculations_devam :  identifier islemler calculations_devam
					| identifier
					;

if_structure :    IF LEFT_PARANTHESIS inside_condition_if RIGHT_PARANTHESIS block
				| IF LEFT_PARANTHESIS inside_condition_if RIGHT_PARANTHESIS block ifelse_structure
				;

ifelse_structure :    IFELSE LEFT_PARANTHESIS inside_condition_if RIGHT_PARANTHESIS block
					| IFELSE LEFT_PARANTHESIS inside_condition_if RIGHT_PARANTHESIS block ifelse_structure
					| ELSE block
					;

inside_condition_if : identifier condition_operators identifier
					| identifier condition_operators inside_condition_if
					| logic_value_specifier
					;

for_structure : FOR LEFT_PARANTHESIS INT IDNTF ASSIGNMENT_OPT INT_LTRL SEMICOLON IDNTF condition_operators identifier SEMICOLON IDNTF increment_decrement RIGHT_PARANTHESIS block
				;

while_structure : WHILE LEFT_PARANTHESIS inside_condition_if RIGHT_PARANTHESIS block
				;


array_assignment : IDNTF LEFT_SQUARE_BRACKET INT_LTRL RIGHT_SQUARE_BRACKET ASSIGNMENT_OPT identifier
				;



struct_object_assignment : IDNTF IDNTF ASSIGNMENT_OPT NEW IDNTF LEFT_PARANTHESIS RIGHT_PARANTHESIS
				;

struct_object_using : IDNTF DOT struct_object_using
					| IDNTF DOT IDNTF
					;


struct_definition : STRUCT IDNTF LEFT_BRACKET parameter_list RIGHT_BRACKET
					;

graph_data_type : GRAPH IDNTF ASSIGNMENT_OPT LEFT_BRACKET CROSSROAD COLON LEFT_SQUARE_BRACKET graph_data_type_recursion RIGHT_SQUARE_BRACKET COMMA ROAD COLON LEFT_SQUARE_BRACKET graph_data_type_recursion RIGHT_SQUARE_BRACKET RIGHT_BRACKET
					;

graph_data_type_recursion : identifier COMMA graph_data_type_recursion
						  | identifier
						  ;

%%
#include "lex.yy.c"
int yyerror(char *s){
	printf("\nParse error in line:%d\n",yylineno);	
	yylval=1;
}
int main(int argc, char *argv[]) {
 
  if (argc == 1)
    yyparse();

  if (argc == 2) {
    yyin = fopen(argv[1], "r");
    yyparse();
  }

if(yylval==0){
			printf("parse successful\n");
	
	
}
  return 0;
}

	
	