grammar Challenge1_LexerRules;

/* Test Code:
if then else < > <= >= == <> myName1 MyName3 4.354E+16
*/
/* Output
[@0,0:1='if',<'if'>,1:0]
[@1,3:6='then',<'then'>,1:3]
[@2,8:11='else',<'else'>,1:8]
[@3,13:13='<',<'<'>,1:13]
[@4,15:15='>',<'>'>,1:15]
[@5,17:18='<=',<'<='>,1:17]
[@6,20:21='>=',<'>='>,1:20]
[@7,23:24='==',<'=='>,1:23]
[@8,26:27='<>',<'<>'>,1:26]
[@9,29:35='myName1',<NAME>,1:29]
[@10,37:43='MyName3',<NAME>,1:37]
[@11,45:53='4.354E+16',<NUMERIC_CONSTANT>,1:45]
[@12,55:54='<EOF>',<EOF>,2:0]
*/

start   : (IF | THEN | ELSE | LESS_THAN | MORE_THAN | LESS_OR_EQUAL | MORE_OR_EQUAL | EQUALS | IS_DIFFERENT | NAME | NUMERIC_CONSTANT)+ ;


// comparison operators
LESS_THAN : '<';
MORE_THAN : '>';
LESS_OR_EQUAL : '<=';
MORE_OR_EQUAL : '>=';
EQUALS : '==';
IS_DIFFERENT : '<>';

// keywords
IF: 'if';
THEN: 'then';
ELSE: 'else';

//others
NAME: CHAR [a-zA-Z0-9]+;
NUMERIC_CONSTANT: DIGIT ('.' DIGIT+)? ('E' ( '+' | '-') DIGIT+)?  ;

WHITESPACE  : [ \t\n]+ -> skip ;

fragment
CHAR   : [a-zA-Z] ;
fragment
DIGIT  : [0-9] ;
