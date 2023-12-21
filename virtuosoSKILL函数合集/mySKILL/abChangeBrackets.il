procedure(abChangeBrackets(i)
let((cv objs objText)
objs = geGetSelSet()
foreach(obj objs
        objText = ""
        objText = obj ~> theLabel
        if(i == 1
        then
        rexCompile("\\[")
        objText = rexReplace(objText "<" 0)
        rexCompile("\\]")
        objText = rexReplace(objText ">" 0)
        else
        rexCompile("<")
        objText = rexReplace(objText "\\[" 0)
        rexCompile(">")
        objText = rexReplace(objText "\\]" 0)
        );end if
        obj ~> theLabel = objText
);end foreach
);end let
);end procedure
;hiSetBindKey( "Layout" "<Key>F12" "abChangeBrackets(1)")
;hiSetBindKey( "Layout" "<Key>F12" "abChangeBrackets(2)")
;hiSetBindKey( "Schematics" "<Key>F12" "abChangeBrackets(1)")
;hiSetBindKey( "Schematics" "<Key>F12" "abChangeBrackets(2)")