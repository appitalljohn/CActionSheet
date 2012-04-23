CActionSheet
============

Corona Action sheet created by John Hamilton (john@appitall.com).

        http://www.appitall.com


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
	
	-- button table
	 local buttons = { 
        { id = 0, label = "Cancel", buttonUpImage="actionsheet/actionBlackButton.png",
        buttonLabelColor={ default={ 255,255,255,255 }, over={ 255,255,255,255 }}, buttonDownImage="actionsheet/actionBlackButton.png"},
        { id = 1, label="OK", buttonOverColor=colorsRGB.blue } } 
        
        -- create the action sheet object
        actionSheet = actionsheet.new (buttons, {_W /2, 0,labelColor=colorsRGB.blue, message="Choose an option", messageSize=18,
        font="HelveticaNeue-Bold", onShowEvent=onActionSheetShown, onHideEvent=onActionSheetDismissed} 
        
        -- insert into your group if you'd like
        mygroup:insert(actionSheet)
        
That will create this

![Screenshot of CActionSheet](http://s17.postimage.org/jz44a9jbj/image.png)


3) Parameters for buttons

	1)id (use a number it's easier.)\n\r
	2)label - string (the text the button displays)
	3)width/height - number (should be obvious, although you should stick with 45 for height button padding is based on this)
	4)buttonUpImage - string (image to use for the up state, list of images it comes with below)
	4)buttonDownImage - string (image to use for when user taps button)
	5)buttonOverColor - color set: {128, 128, 128, 255} - (buttons color that changes when held down)
	6)buttonLabelColor - color set: ex - { default={ 255, 255, 255, 255 }, over={ 128, 255, 96, 255 } - (color of buttons label :P)
	7)buttonFontSize - number (size of font for buttons label)
	8)buttonFont - string (which font to use for the button, eg Arial)
        
Button Colors 

        Black - "actionsheet/actionBlackButton.png"
![Screenshot of actionBlackButton](http://s17.postimage.org/8hxetnz0v/action_Black_Button_2x.png)

        Red - "actionsheet/actionRedButton.png"
        
![Screenshot of actionRedButton](http://s16.postimage.org/i3u8p3idh/action_Red_Button_2x.png)

        White - "actionsheet/actionWhiteButton.png"
        
![Screenshot of actionWhiteButton](http://s18.postimage.org/tigkc031l/action_White_Button_2x.png)
	
4) Parameters for the action sheet

        1)background - string (the overlay image you would like to use)
        2)actionBackground - string (the background behind the buttons)
        3)message - string (the string to use for the message ex: choose an option)
        4)fontFamily - string (font family for the message)
        5)messageSize - number (font size for message string)
        6)messageColor - currently not working (defaults to white)
        7)onShowEvent - the function to call when the action sheet was shown
        8)onHideEvent - the function to call when the action sheet was hidden after a button press
        
5) Functions for action sheet
        1)actionSheet:hide(speed) -- just hides the action sheet (speed can't be lower then 500ms)
        2)actionSheet:show(speed) -- shows the action sheet (speed can't be lower then 500ms)
        
6) action sheet call back

Your action sheet call back function should accept a variable we will call - buttonID
heres an example

        function onActionSheetDismissed(buttonID) 
    
                if buttonID == 0 then
                 print("action sheet closed with cancel button")
                end

        end
        
NOETS - The buttons will be created from bottom to top. 
So your first button in table will be the bottom button on the action sheet

        

	