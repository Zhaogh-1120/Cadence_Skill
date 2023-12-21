procedure(LowerToUpper(args)

    let((cv labels)
        cv=geGetEditCellView()
        labels=setof(x geGetSelSet() x~>objType=="label")
        foreach(label labels
            case(args
                (1 label~>theLabel=upperCase(label~>theLabel))
                (2 label~>theLabel=lowerCase(label~>theLabel))
            );end case
        );end foreach
    );end let
);end procedure

hiSetBindKey("Layout" "CTRL<Key>U" "LowerToUpper(1)");LowerToUpper
hiSetBindKey("Layout" "CTRL<Key>L" "LowerToUpper(2)")  ;UpperTolower
hiSetBindKey("Schematics" "CTRL<Key>U" "LowerToUpper(1)");LowerToUpper
hiSetBindKey("Schematics" "CTRL<Key>L" "LowerToUpper(2)");UpperTolower