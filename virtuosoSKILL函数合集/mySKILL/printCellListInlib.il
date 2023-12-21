procedure(printCellListInlib(libName)
	let(()
		libId=ddGetObj(libName)
		cellNameList=libId~>cells~>name
		foreach(cellName cellNameList
			printf("cellname:%s\n" cellName)
		)

	)
)