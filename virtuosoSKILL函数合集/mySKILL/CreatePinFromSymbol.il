procedure(ccsCreatePin(cv pinname pincross iotype protate)
	prog((io inputCVId pinId)
	protate1 = protate
	if(iotype == "input" then io="ipin"
		if(protate == "R0" then protate1="R180")
		if(protate == "R90" then protate1="R270")
		if(protate == "R180" then protate1="R0")
		if(protate == "R270" then protate1="R90")
)
	if(iotype == "output" then io="opin")
	if(iotype == "inputOutput" then io="iopin")
	inputCVId = dbOpenCellViewByType("basic" io "symbol" "" 'r)
	pinId = schCreatePin(cv inputCVId pinname iotype nil pincross protate1)
	;printf("%L %L %L\n" pinname protate protate1)
);prog
);procedure

;ccsCreatePin(geGetEditCellView() "mypin" "inputOutput" list(0 0))

procedure(llindex(element list)
	prog((flag)
	flag = nil
	foreach(ll list
		if(ll == element then flag = t)
	);foreach	
	return(flag)
	)	
)

procedure(adjustbox(inst point)
	prog(()
		pointoffset = list()
		ori_pt = inst~>xy
		x1 = xCoord(point)
		y1 = yCoord(point)
		orix = xCoord(ori_pt)
		oriy = yCoord(ori_pt)
		case(inst~>orient
			("R0" pointoffset = list(x1+orix y1+oriy))	
			("R270" pointoffset = list(y1+orix x1+oriy))
			("R180" pointoffset = list(-x1+orix -y1+oriy))
			("R90" pointoffset = list(-y1+orix x1+oriy))
			("MX" pointoffset = list(x1+orix -y1+oriy))
			("MY" pointoffset = list(-x1+orix y1+orix))
			("MXR90" pointoffset = list(y1+orix x1+oriy))
			("MYR90" pointoffset = list(-y1+orix -x1+oriy))
		);case
		return(pointoffset)
	)
)

procedure(ccsGenSymbolPin(repeat)
	prog((cv sel sels pt ptl ls)
	cv = geGetEditCellView()
	sels = geGetSelSet()
	sw = list()
	foreach(sel sels
			schHiCreateWireStubs()
			xybox = sel~>bBox
			rdpt1 = car(xybox)
			rdpt2 = cadr(xybox)
			xleft = car(rdpt1)
			ylow = cadr(rdpt1)
			xright = car(rdpt2)
			yup = cadr(rdpt2) 
			pbox = caaar(sel~>instTerms~>term~>pins~>figs~>bBox)
			pt1 = car(pbox) pt2 = cadr(pbox)
			pt1 = adjustbox(sel pt1) pt2 = adjustbox(sel pt2)
			pbox = list(pt1 pt2)
			pt1 = car(pbox) pt2 = cadr(pbox)
			minx = maxx = (car(pt1)+car(pt2))*0.5
			miny = maxy = (cadr(pt1)+cadr(pt2))*0.5
			foreach(pin sel~>instTerms
			ptl = caar(pin~>term~>pins~>figs~>bBox)
			pt1 = car(ptl) pt2 = cadr(ptl)
			x = (car(pt1)+car(pt2))*0.5
			y = (cadr(pt1)+cadr(pt2))*0.5
			pt = adjustbox(sel list(x y))
			x = car(pt)
			y = cadr(pt)
			if(x<minx then minx=x)
			if(x>maxx then maxx=x)
			if(y<miny then miny=y)
			if(y>maxy then maxy=y)
)
			minpt = list(minx miny)
			maxpt = list(maxx maxy)
			foreach(pin sel~>instTerms
			ptl = caar(pin~>term~>pins~>figs~>bBox)
			pt1 = car(ptl) pt2 = cadr(ptl)
			x = (car(pt1)+car(pt2))*0.5
			y = (cadr(pt1)+cadr(pt2))*0.5
			pt = adjustbox(sel list(x y))
			x = car(pt)
			y = cadr(pt)
			if((llindex(pin~>name cv~>terminals~>name)==nil)||(repeat==t) then
			;;printf("%L %L\n" pin~>name cv~>terminals~>name)
			if(x==minx then x-=0.45 ccsCreatePin(cv pin~>name list(x y) pin~>direction "R180")
			else if(x==maxx then x+=0.45 ccsCreatePin(cv pin~>name list(x y) pin~>direction "R0")
			else if(y==miny then y-=0.45 ccsCreatePin(cv pin~>name list(x y) pin~>direction "R270")
			else if(y==maxy then y+=0.45 ccsCreatePin(cv pin~>name list(x y) pin~>direction "R90")))))
			)
			;printf("%L %L\n %L\n" pin~>direction pin~>name pt)
			;sw = append1(sw pt)
			;label = schCreateNoteLabel(cv list(x y) pin~>name "centerCenter" "R0" "roman" 0.125 "normalLabel")
)
	;printf("%L \n" sw)
	box = sel~>bBox
	pt1 = car(box) pt2 = cadr(box)
	;label = schCreateNoteLabel(cv pt1 "corner1" "centerCenter" "R0" "roman" 0.125 "normalLabel")
	;label = schCreateNoteLabel(cv pt2 "corner2" "centerCenter" "R0" "roman" 0.125 "normalLabel")
	;label = schCreateNoteLabel(cv minpt "corner3" "centerCenter" "R0" "roman" 0.125 "normalLabel")
	;label = schCreateNoteLabel(cv maxpt "corner4" "centerCenter" "R0" "roman" 0.125 "normalLabel")
);foreach
);prog
);proceure


hiSetBindKey("Schematics" "Shift<Key>P" "ccsGenSymbolPin(t)")
hiSetBindKey("Schematics" "Ctrl<Key>P" "ccsGenSymbolPin(nil)")
hiSetBindKey("Schematics" "<Key>space" "schHiCreateWireStubs()")

