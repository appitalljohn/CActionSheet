CActionSheet
============

Corona Action sheet created by John Hamilton.

You can use modify redistribute this anyway you want.

Credits/Comments/Updates are always welcome.


=== HOW TO INSTALL

1) copy actionsheet.lua to your main project folder.
2) copy the actionsheet folder into your project folder.

== HOW TO USE

1) add this to the top of your lua file

	 local actionsheet = require("actionsheet")
	 
	 -- action sheet delegates
	local onActionSheetShown = nil
	local onActionSheetDissmissed = nil
	 
2) Create your action sheet button group (Paramaters listed below)
	
	 local buttons = { 
        { id = 0, label = "Cancel", buttonUpImage="actionsheet/actionBlackButton.png",
        buttonLabelColor={ default={ 255,255,255,255 }, over={ 255,255,255,255 }}, buttonDownImage="actionsheet/actionBlackButton.png"},
        { id = 1, label="OK", buttonOverColor=colorsRGB.blue } } 

	