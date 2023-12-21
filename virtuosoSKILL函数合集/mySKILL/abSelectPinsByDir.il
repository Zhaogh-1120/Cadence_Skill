;If you just call abSelectPinsByDir() it will select all input pins
;if you use abSelectPinsByDir(?direction "output") it will select all output pins. 

procedure(abSelectPinsByDir(@key (cellView geGetEditCellView()) 
    (direction "input"))
  foreach(term cellView~>terminals
    when(term~>direction==direction
      foreach(pin term~>pins
        foreach(fig pin~>figs
          geSelectFig(fig)
        )
      )
    )
  )
  t
)

;hiSetBindKey("Schematics" "<Key>n" "abSelectPinsByDir()")
;hiSetBindKey("Schematics" "<Key>n" "abSelectPinsByDir(direction "output")")
;hiSetBindKey("Schematics" "<Key>n" "abSelectPinsByDir(direction "inputOutput")")

