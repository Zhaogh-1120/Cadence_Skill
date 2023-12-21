procedure( ddCreateMenuAllSkill()
	if( boundp( 'ddLayoutPulldownMenu )
     	then ddLayoutPulldownMenu
	else
    	hiCreatePulldownMenu(
       	'ddLayoutPulldownMenu
       	"allskill_hlq"  ; The munu name, U can named by your company name.
       	list(
;;;delete_cdslck_file();;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         	hiCreateMenuItem( ; list of menu items
             	?name 'Item1
             	?itemText "delete_cdslck_file"
             	?callback   "delete_cdslck_file()"   ; F12 ,Use you own function to define callback 
          	)
;;;changeMode();;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          	hiCreateMenuItem( ; list of menu items
             	?name 'Item2
             	?itemText "changeMode"
             	?callback   "changeMode()"  ;F11
            	)
;;;ccsGenSymbolPin();;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 	sliderMenuItem_A=hiCreateSliderMenuItem(     ;;;;;create 2nd submenu
		?name 'menu_A
		?itemText "CreatePinfromSymbol"
		?subMenu hiCreatePulldownMenu(     ;;;;create 2nd pulldownmenu
		'trSubMenu
		""
		list(
          		menuItem_1=hiCreateMenuItem( ; list of menu items
             		?name 'Item3
             		?itemText "Create_Pin_Net"
            		 ?callback   "ccsGenSymbolPin(t)" 
            		)
         		menuItem_2=hiCreateMenuItem( ; list of menu items
             		?name 'Item4
            		?itemText "Create_Net"
             		?callback   "ccsGenSymbolPin(nil)" 
            		)
		);list
		);hiCreatePulldownMenu
		)
;;;abAddPinToFloatingWire();;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		sliderMenuItem_E=hiCreateSliderMenuItem(     
		?name 'menu_E
		?itemText "abAddPinToFloatingWire"
		?subMenu hiCreatePulldownMenu(   
		'trSubMenu
		""
		list(
          		menuItem_3=hiCreateMenuItem( 
             		?name 'Item9
            		?itemText "abAddPinToFloatingWire_Input"
             		?callback   "abAddPinToFloatingWire(?direction \"input\" ?orientation \"R0\")" ;
            		)
          		
			menuItem_3=hiCreateMenuItem( 
             		?name 'Item10
            		?itemText "abAddPinToFloatingWire_Output"
             		?callback   "abAddPinToFloatingWire(?direction \"output\" ?orientation \"R0\")" ;
            		)
			menuItem_3=hiCreateMenuItem( 
             		?name 'Item11
            		?itemText "abAddPinToFloatingWire_InputOutput"
             		?callback   "abAddPinToFloatingWire(?direction \"inputOutput\" ?orientation \"R270\")" ;
            		)
		);list
		);hiCreatePulldownMenu
		)
;;;LowerToUpper();;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		sliderMenuItem_B=hiCreateSliderMenuItem(     
		?name 'menu_B
		?itemText "LowerToUpper"
		?subMenu hiCreatePulldownMenu(   
		'trSubMenu
		""
		list(
          		menuItem_1=hiCreateMenuItem( ; list of menu items
             		?name 'Item5
             		?itemText "LowerToUpper_onlyselect"
            		 ?callback   "LowerToUpper(1)" 
            		)
          		menuItem_1=hiCreateMenuItem( ; list of menu items
             		?name 'Item6
             		?itemText "UpperToLower_onlyselect"
            		 ?callback   "LowerToUpper(2)" 
            		)
         		menuItem_2=hiCreateMenuItem( ; list of menu items
             		?name 'Item7
            		?itemText "LowerToUpper"
             		?callback   "LowerToUpper_V2(0)" 
            		)
			menuItem_3=hiCreateMenuItem( ; list of menu items
             		?name 'Item8
            		?itemText "UpperToLower"
             		?callback   "LowerToUpper_V2(1)" 
            		)
		);list
		);hiCreatePulldownMenu
		)
;;;changeBrackets();;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		sliderMenuItem_C=hiCreateSliderMenuItem(     
		?name 'menu_C
		?itemText "changeBrackets"
		?subMenu hiCreatePulldownMenu(   
		'trSubMenu
		""
		list(
          		menuItem_1=hiCreateMenuItem( ; list of menu items
             		?name 'Item5
             		?itemText "Change [ ] to < >"
            		 ?callback   "abChangeBrackets(1)" 
            		)
         		menuItem_2=hiCreateMenuItem( ; list of menu items
             		?name 'Item6
            		?itemText "Change < > to [ ]"
             		?callback   "abChangeBrackets(2) " 
            		)
		);list
		);hiCreatePulldownMenu
		)
;;;abHighlightNetInSchematic();;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SKILL7;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         	hiCreateMenuItem( ; list of menu items
             	?name 'Item7
             	?itemText "abHighlightNetInSchematic"
             	?callback   "abHighlightNetInSchematic()"   ; 
          	)       	

;;;selectPin();;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		sliderMenuItem_D=hiCreateSliderMenuItem(     
		?name 'menu_D
		?itemText "selectPin"
		?subMenu hiCreatePulldownMenu(   
		'trSubMenu
		""
		list(
          		menuItem_3=hiCreateMenuItem( 
             		?name 'Item9
            		?itemText "selectAllPinInput"
             		?callback   "abSelectPinsByDir(?direction \"input\")" ;
            		)
          		
			menuItem_3=hiCreateMenuItem( 
             		?name 'Item10
            		?itemText "selectAllPinOutput"
             		?callback   "abSelectPinsByDir(?direction \"output\")" ;
            		)
			menuItem_3=hiCreateMenuItem( 
             		?name 'Item11
            		?itemText "selectAllPinInputOutput"
             		?callback   "abSelectPinsByDir(?direction \"inputOutput\")" ;
            		)
		);list
		);hiCreatePulldownMenu
		)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





       ) ; list
    ) ; hiCreatePulldownMenu
  ) ; if
) ; procedure

procedure( ddUserPostInstallTrigger(args)
   hiInsertBannerMenu(
        args->window
        ddCreateMenuAllSkill()
        length( hiGetBannerMenus( args->window))
   )
) ; procedure

;; Triggers for adding it to layout and VXL window
deRegUserTriggers("maskLayout" nil nil 'ddUserPostInstallTrigger)
deRegUserTriggers("maskLayoutXL" nil nil 'ddUserPostInstallTrigger)

;; Triggers for adding it to schematic window
deRegUserTriggers("schematic" nil nil 'ddUserPostInstallTrigger)

;; Trigger for adding it to schematic window in case of VXL mode
;deRegUserTriggers( "schSynthesisXL" nil nil 'ddUserPostInstallTrigger)
