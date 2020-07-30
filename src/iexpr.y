%parse-param {float *result}
%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%union {
      int intValue;
      float floatValue;
}


%token <intValue> INT POSINT ZERO
%token <floatValue> FLOAT
%token PLUS MINUS TIMES DIVIDE LB RB

%type <floatValue> expr term factor syntax number

%left PLUS MINUS TIMES DIVIDE

%start syntax

%%
syntax: expr {printf("\n Inner Result=%f\n",$1);*result= $1;}
;

expr: expr PLUS term  {$$=$1+$3;}
| expr MINUS term  {$$=$1-$3;}
| term {$$=$1;}
;


term: term TIMES factor {$$= $1 * $3;}    
| term DIVIDE factor { $$= $1 / $3;if($3==0) wwerror("Dividing by zero is not allowed");}
| factor {$$= $1;}    
;

factor: LB expr RB      {$$=$2;}
| FLOAT                 {$$=$1;}
| MINUS FLOAT           {$$=-$2;} 
| number                {$$=$1;}
;

number: POSINT      {$$=$1;}
| MINUS POSINT      {$$=-$2;}
| ZERO              {$$=$1;}
;