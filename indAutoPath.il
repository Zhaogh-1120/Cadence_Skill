procedure(ind_autoPath(route_length route_width turn spacing);

cvId = dbOpenCellViewByType("GM5395_VCO_zhaogh" "octagon" "layout")

			route_layer="TM1"

			route_width = 10.0

			route_length = 100.0

			route_turn = 5
 
			spacing = 50.0

/*

;///////////////////////////////////////////////////////////////////////////////////////////////////

        leCreatePath(cvId list(layer) list(0:0 route_length:0 route_length:route_length 0:route_length 0:0) 5);

;///////////////////////////////////////////////////////////////////////////////////////////////////


*/





/*

;///////////////////////////////////////////////////////////////////////////////////////////////////

       leCreatePath(
                     cvId;ID of the cellview in which route
                     list("TM2");layer of the route
                    list(
                           0:0 )
                           0:(route_length/2) 
                           route_length*0.7071068:route_length*1.207107 
                           route_length*1.707107:route_length*1.207107 
                           route_length*2.414214:route_length/2 
                           route_length*2.414214:0 
                           route_length*2.414214:-route_length/2 
                           route_length*1.707107:-route_length*1.207107 
                           route_length*0.7071068:-route_length*1.207107 
                           0:-route_length/2
                           0:0);coordinate of the route
                           route_width;width of the route
      ) ;end of creating path not in the center

;///////////////////////////////////////////////////////////////////////////////////////////////////

*/




;///////////////////////////////////////////////////////////////////////////////////////////////////

	for(i 1 route_turn

			route_length=route_length+0.828426*(spacing+route_width)

			leCreatePath(

                     cvId;ID of the cellview in which route

                     list(route_layer);layer of the route

                     list(
                           -1.207107*route_length:0 
                           -1.207107*route_length:route_length/2 
                           -route_length/2:1.207107*route_length 
                           route_length/2:1.207107*route_length 
                           1.207107*route_length:route_length/2
                           1.207107*route_length:-route_length/2 
                           route_length/2:-1.207107*route_length 
                           -route_length/2:-1.207107*route_length
                          -1.207107*route_length:-route_length/2
                           -1.207107*route_length:0 
                           );coordinate of the route

                          route_width;width of the route

		) ;end of creating path in the center

;///////////////////////////////////////////////////////////////////////////////////////////////////
	);end of for loop

);end of procedure
