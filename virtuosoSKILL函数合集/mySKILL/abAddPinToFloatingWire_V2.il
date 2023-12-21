/* abAddPinToFloatingWire.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Dec 02, 2020 
Modified   
By         

Add a pin to any selected floating wire. Usage:

abAddPinToFloatingWire()
abAddPinToFloatingWire(?direction "input")

The default is to add inputOutput pins unless the ?direction
is specified

***************************************************

SCCS Info: @(#) abAddPinToFloatingWire.il 12/02/20.10:59:59 1.1

*/

/********************************************************************
*                                                                   *
*         abAddPinToFloatingWire([?direction "inputOutput"]         *
*                      [?pinUsage "schematic"]                      *
*                      [?wires geGetSelSet()]                       *
*                                 )                                 *
*                                                                   *
*   Take the selected wires (or wires passed in) and add pins to    *
*  the floating end of that wire, based on the net information on   *
*   the wire. The pin direction can be specified as an argument,    *
*  and the pins to use are looked up using schPinMasters (the same  *
* as the schematic editor create pin command uses to seed the form) *
*                                                                   *
********************************************************************/

procedure(abAddPinToFloatingWire(@key (direction "input") (orientation "R90")
        (pinUsage "schematic")
        (wires geGetSelSet()))
    let((netName cvId pinUnderneath pinOptions pinMasterInfo offsheet
            pinMaster wireUnderneath)
        ;----------------------------------------------------------------
        ; Determine the pin master to use given the direction
        ; and pinUsage (normally schematic)
        ;----------------------------------------------------------------
        offsheet=cadr(assoc(pinUsage car(schPinMasters)))
        pinOptions=foreach(mapcar (usageInfo pinInfo)
                car(schPinMasters)
                cddr(assoc(direction schPinMasters))
            cons(car(usageInfo) pinInfo)
        )
        pinMasterInfo=cdr(assoc(pinUsage pinOptions))
        if(pinMasterInfo then
            pinMaster=dbOpenCellViewByType(
                car(pinMasterInfo) cadr(pinMasterInfo) caddr(pinMasterInfo)
            )
            unless(pinMaster
                error("Could not open pin master %L\n" pinMasterInfo)
            )
        else
            error("Could not find pin master for direction %L usage %L\n"
                direction pinUsage)
        )
        ;----------------------------------------------------------------
        ; Determine cellView to create in from one of the wires
        ;----------------------------------------------------------------
        cvId=car(wires)~>cellView
        ;----------------------------------------------------------------
        ; Visit each wire and check that it's actually a wire (in case you
        ; have selected other things on the schematic
        ;----------------------------------------------------------------
        foreach(wire wires
            when(wire~>objType=="line" || wire~>objType=="path"
                netName=wire~>net~>name
                if(netName then
                    foreach(point wire~>points
                        pinUnderneath=dbShapeQuery(
                            cvId
                            "pin"
                            list(point point)
                        )
                        ;------------------------------------------------
                        ; Find any wires underneath that aren't this wire
                        ;------------------------------------------------
                        wireUnderneath=setof(
                            shapeUnderneath
                            dbShapeQuery(
                                cvId
                                "wire"
                                list(point point)
                                0
                                0
                            )
                            shapeUnderneath!=wire
                        )
                        unless(pinUnderneath || wireUnderneath
                            schCreatePin(
                                cvId
                                pinMaster
                                netName
                                direction
                                offsheet
                                point
                                orientation
                            )
                        )
                    )
                else
                    warn("Selected wire does not have net name yet\n")
                )
            )
        )
        dbClose(pinMaster)

        t
    )
)
hiSetBindKey( "Schematics" "<Key>F7" "abAddPinToFloatingWire()")








