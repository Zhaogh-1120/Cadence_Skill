procedure(abHighlightNetInSchematic()
prog((cv win objs nets)
	cv=geGetEditCellView()
	unless(cv~>cellViewType=="schematic"
	warn("not a schematic view\n")
	return(nil)
	)
	win=getCurrentWindow()
	objs=setof(x geGetSelSet() x~>conns)
	nets list()
	if(objs then
	foreach(x objs~>conns~>net~>name
		nets=append(nets x)
	)
	else
	nets=cv~>nets~>name
	)
	foreach(net nets
	geAddNetProbe(win nil net)
	)
))
hiSetBindKey("Schematics" "<Key>F8" "abHighlightNetInSchematic()")

