procedure(LowerToUpper_V2(bb)
let((cv objs objText)
cv = geGetEditCellView()
objs = setof(x cv ~> shapes x ~> objType == "label")
foreach(obj objs
        objText = ""
        objText = obj ~> theLabel
        if(bb == 1
        then
        objText = stringToLower(objText)
        else
        objText = stringToUpper(objText)
        );if
        obj ~> theLabel = objText
);foreach
);let
);proc

;hiSetBindKey("Layout" "CTRL<Key>U" "LowerToUpper_V2(0)");LowerToUpper
;hiSetBindKey("Layout" "CTRL<Key>L" "LowerToUpper_V2(1)")  ;UpperToLower
;hiSetBindKey("Schematics" "CTRL<Key>U" "LowerToUpper_V2(0)");LowerToUpper
;hiSetBindKey("Schematics" "CTRL<Key>L" "LowerToUpper_V2(1)");UpperToLower