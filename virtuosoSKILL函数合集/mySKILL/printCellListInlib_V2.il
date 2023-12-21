procedure(printCellListInlib_V2(libName)
	let(()
		libId=ddGetObj(libName)
		cellNameList=libId~>cells~>name
		count1=1
		outport=outfile("./cellName.txt")
		foreach(cellName cellNameList
			fprintf(outport "%d %s\n" count1,cellName)
			count1=count1+1
		)
		close(outport)

	)
)
