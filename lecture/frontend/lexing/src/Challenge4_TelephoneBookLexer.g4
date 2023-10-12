grammar Challenge4_TelephoneBookLexer;

/* Test
Heinz 030 5346 983
Kalle +49 30 1234 567
Lina +49.571.8385-255
Rosi (0571) 8385-268
*/
/* Output
Heinz length: 5
030 5346 983 PlusAndDigitlength: 10
now 1 entries
Kalle length: 5
+49 30 1234 567 PlusAndDigitlength: 12
now 2 entries
Lina length: 4
+49.571.8385-255 PlusAndDigitlength: 13
now 3 entries
Rosi length: 4
(0571) 8385-268 PlusAndDigitlength: 11
now 4 entries
[@0,0:4='Heinz',<NAME>,1:0]
[@1,6:17='030 5346 983',<TELEPHONE_NUMBER>,1:6]
[@2,19:23='Kalle',<NAME>,2:0]
[@3,25:39='+49 30 1234 567',<TELEPHONE_NUMBER>,2:6]
[@4,41:44='Lina',<NAME>,3:0]
[@5,46:61='+49.571.8385-255',<TELEPHONE_NUMBER>,3:5]
[@6,63:66='Rosi',<NAME>,4:0]
[@7,68:82='(0571) 8385-268',<TELEPHONE_NUMBER>,4:5]
[@8,84:83='<EOF>',<EOF>,5:0]
*/

@header {
import java.util.*;
import java.util.regex.*;
}

@members {
    Pattern nonPlusOrDigitPattern = Pattern.compile("[^+0-9]");
    int entryCount = 0;
}

start   : (NAME | TELEPHONE_NUMBER)+ ;

NAME: [a-zA-Z]+{
    System.out.println(getText() + " length: " +  getText().length());
};
TELEPHONE_NUMBER: [+]? [(]? DIGIT+ [)]? (WHITESPACE? DIGIT_OR_DOT)* [-]? DIGIT* {
    System.out.println(getText() + " PlusAndDigitlength: " +  nonPlusOrDigitPattern.matcher(getText()).replaceAll("").length());
    entryCount++;
    System.out.println("now " + entryCount + " entries");
};

WHITESPACE_SKIP  : WHITESPACE+ -> skip ;

fragment
WHITESPACE  : [ \t\n];
fragment
DIGIT_OR_DOT: [0-9.];
fragment
DIGIT: [0-9];
