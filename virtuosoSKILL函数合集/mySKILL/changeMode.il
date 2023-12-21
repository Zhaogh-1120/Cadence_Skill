procedure(changeMode()
    let((cvId)
        cvId = geGetEditCellView()
        if(cvId~>mode=="a" then
            geChangeEditMode("r")
        else
            geChangeEditMode("a")
        )
    )
)
hiSetBindKey("Schematics" "<Key>F11"  "changeMode()")
hiSetBindKey("Layout" "<Key>F11"  "changeMode()")