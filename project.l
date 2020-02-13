%{
#include <stdio.h>
#include <string.h>

%}
Digit [0-9]
Letter [a-zA-Z]
%%
"//"([a-z]|[0-9]|[A-Z]|" ")*	{}
[\/][*][^*]*[*][\/]		{}


crossroad								return(CROSSROAD);	
graph									return(GRAPH);
longitude								return(LONGITUDE);
latitude								return(LATITUDE);
road									return(ROAD);
int										return(INT);
float									return(FLOAT);
bool									return(BOOL);
void									return(VOID);
char									return(CHAR);
string									return(STRING);
image									return(IMAGE);
struct									return(STRUCT);
array									return(ARRAY);
new										return(NEW);
									
false									return(BLN_FALSE);
true									return(BLN_TRUE);

"&&"									return(AND_OPT);
"||"									return(OR_OPT);

if 										return(IF);
else									return(ELSE);
ifelse									return(IFELSE);
while									return(WHILE);
break									return(BREAK);
continue								return(CONTINUE);
for										return(FOR);

function								return(FUNCTION);
return									return(RETURN);

"remove"								return(BLTIN_REMOVE);
"add"									return(BLTIN_ADD);
"calculate_rotate"						return(BLTIN_CALCULATE_ROTATE);
"connect"								return(BLTIN_CONNECT);
"3D_object"								return(BLTIN_3D);
"print"									return(BLTIN_PRINT);
"showonmap"								return(BLTIN_SHOWONMAP);
"searchlocation"						return(BLTIN_SEARCHLOCATION);
"getroadspeed"							return(BLTIN_GETROADSPEED);
"getlocation"							return(BLTIN_GETLOCATION);
"showtarget"							return(BLTIN_SHOWTARGET);

"<="									return(LESSEQ_OPT);
">="									return(GREATEREQ_OPT);
"!="									return(NEQ_OPT);
"=="									return(EQ_OPT);
"<"										return(LESS_OPT);
">"										return(GREATER_OPT);

"="										return(ASSIGNMENT_OPT);
"=*"									return(MULTIPLY_ASSIGNMENT_OPT);					
"=/"									return(DIVIDE_ASSIGNMENT_OPT);
"=%"									return(MODE_ASSIGNMENT_OPT);
"=+"									return(ADD_ASSIGNMENT_OPT);
"=-"									return(SUB_ASSIGNMENT_OPT);
"=^"									return(POW_ASSIGNMENT_OPT);

"++"									return(INCREMENT_OPT);
"--"									return(DECREMENT_OPT);
"!"										return(NOT_OPT);

"*"										return(MULTIPLY_OPT);
"/"										return(DIVIDE_OPT);
"%"										return(MODE_OPT);
"+"										return(ADD_OPT);
"-"										return(SUB_OPT);
"^"										return(POW_OPT);

(\([-+]\))?{Digit}+						return(INT_LTRL);
									
[-+]?{Digit}*"."{Digit}+			return(FLT_LTRL);
												
\"(\\.|[^\\"])*\"					return(STR_LTRL);						
\'(\\.|[^\\'])+\'					return(CHR_LTRL);
{Letter}({Digit}|{Letter})*			return(IDNTF);


"."									return(DOT);
";"									return(SEMICOLON);
"{"									return(LEFT_BRACKET);
"}"									return(RIGHT_BRACKET);
","									return(COMMA);
":"									return(COLON);
"("									return(LEFT_PARANTHESIS);
")"									return(RIGHT_PARANTHESIS);
"["									return(LEFT_SQUARE_BRACKET);
"]"									return(RIGHT_SQUARE_BRACKET);


(\r|\n|\r\n)						yylineno++;
[\t]+								{}
[ ]+								{}
.									{printf("\nSyntax error in line:%d\n",yylineno);yylval=1;}

%%
int yywrap(void) { return 1; }