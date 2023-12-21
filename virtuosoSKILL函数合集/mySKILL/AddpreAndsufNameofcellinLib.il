procedure(AddpreAndsufNameofcellinLib(lib_name @optional (prefix "")(suffix ""))
let((old_des new_des newname )
foreach(cell_list ddGetObj(lib_name)~>cells
newname=strcat(prefix cell_list~>name suffix)
old_des=gdmCreateSpec(lib_name cell_list~>name "" "" "CDBA")
new_des=gdmCreateSpec(lib_name newname "" "" "CDBA")
ccpRename(old_des new_des t 'CCP_EXPAND_COMANAGED 'CCP_UPDATE_DESTLIB_ONLY)
);endforeach
);endlet
);endprocedure
;AddpreAndsufNameofcellinLib("lib_name" "" "asd")
;AddpreAndsufNameofcellinLib("lib_name" "qwe")
;AddpreAndsufNameofcellinLib("lib_name" "qwe" "asd")