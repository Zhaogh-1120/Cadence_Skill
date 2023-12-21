procedure(delete_cdslck_file()   
  cvId = geGetEditCellView(getCurrentWindow())   
  sh(strcat("clsAdminTool -are ./ " cvId ~> fileName)) 
); procedure
hiSetBindKey("Layout" "<Key>F12" "delete_cdslck_file()")
hiSetBindKey("Schematics" "<Key>F12" "delete_cdslck_file()")

