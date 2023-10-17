grammar Challenge3_PigLatinLexer;

/* Test
    loser
    button
    star
    three
    question
    happy
    Pig Latin

    eagle
    America
*/
/* Output:
[@0,0:4='oser-lay',<STARTING_WITH_CONSONANT>,1:0]
[@1,10:15='utton-bay',<STARTING_WITH_CONSONANT>,2:4]
[@2,21:24='ar-stay',<STARTING_WITH_CONSONANT>,3:4]
[@3,30:34='ee-thray',<STARTING_WITH_CONSONANT>,4:4]
[@4,40:47='uestion-qay',<STARTING_WITH_CONSONANT>,5:4]
[@5,53:57='appy-hay',<STARTING_WITH_CONSONANT>,6:4]
[@6,63:65='ig-Pay',<STARTING_WITH_CONSONANT>,7:4]
[@7,67:71='atin-Lay',<STARTING_WITH_CONSONANT>,7:8]
[@8,78:82='eagle-ay',<STARTING_WITH_VOCAL>,9:4]
[@9,88:94='America-ay',<STARTING_WITH_VOCAL>,10:4]
[@10,96:95='<EOF>',<EOF>,11:0]
*/
@header {
    import java.util.*;
    import java.util.regex.*;
}

@members {
    Pattern pattern = Pattern.compile("^([bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]+).*$");
}

start   : (STARTING_WITH_CONSONANT | STARTING_WITH_VOCAL)+ ;

STARTING_WITH_CONSONANT: CONSONANTS OPTIONAL_CHARS {
    Matcher matcher = pattern.matcher(getText());
    matcher.find();
    String prefixConstants = matcher.group(1);
    setText(getText().substring(prefixConstants.length()) + "-" + prefixConstants + "ay");
 };
STARTING_WITH_VOCAL: VOCAL OPTIONAL_CHARS {setText(getText() + "-ay"); };


WHITESPACE  : [ \t\n]+ -> skip ;

fragment
OPTIONAL_CHARS: [a-zA-Z]*;
fragment
VOCAL: [aeiouAEIOU];
fragment
CONSONANTS: [bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]+;
