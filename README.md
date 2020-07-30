# CALCULATOR LANGUAGE
This Repository includes a YACC/LEX compiler for a simple calculator including some special function. A testfile with some testing data is also included.
## Features
- substraction and division
- negative and decimal numbers
- sum and prod function: e.g. sum1to10(i) = 1+2+3+4+5+6+7+8+9+10 (∑)
- Eulersche phi function which returns a count of all numbers whose greatest 
 common diviser is 1: e.g phi(6) = 2 because 1 and 5 are the numbers which no common divisors with 6.
- Greatest common divisor like used in the phi function

## Usage
- Compile using makefile (make all)
- Execute the calc.exe: You can execute with a testfile or just input via console.
- Program execution stops when any error occurs
- Any input should be terminated using an 'E'-Token