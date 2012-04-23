-- [[ Action sheet created by John Hamilton
-- www.appitall.com
-- ]]


local widget = require "widget"
widget.setTheme( "theme_ios" )

local modname = ...
local actionSheet = {}
package.loaded[modname] = actionSheet



function onButtonPressed(event)
    
    -- hide our parent
    --event.target.parent:hide( 500 )
    
    id = event.target.id
    event.target.parent:didCloseWithButtonID(id, 500)
end


function actionSheet.new( buttons, params )
    
    local folder = "actionsheet/"
    
    local assetTable = {
		upText = { 255, 255, 255 },
		fontEmboss = false,
		fontFamily = "HelveticaNeue-Bold",
		fontSize = 12,
                buttonColor = "white",
                buttonUpImage = folder .. "actionWhiteButton.png",
                buttonDownImage = folder .. "actionWhiteButton.png",
		buttonWidth = 278,
                buttonHeight = 45,
                overlayImage = folder .. "overlayImage.png",
                background = folder .. "sheetBG.png",
		labelPadding = 20,
                buttonOverlayColor = {128, 128, 128, 255},
                buttonLabelColor = { default={ 255, 255, 255, 255 }, over={ 128, 255, 96, 255 } },
                buttonOnRelease = nil,
                message="Which option would you like?",
                onShowEvent=nil,
                onHideEvent=nil,
                messageSize=14,
                messageColor= {0,255,255,0}
	}
        
        
        -- params
	local params = params or {}
	local id = params.id or ""
	local x = params.x or 0
	local y = params.y or 0
        local background = params.background or folder .. "overlayImage.png"
        local actionBackground = params.actionBackground or folder .. "sheetBG.png"
	local textColor = params.labelColor or assetTable.upText
	local fontSize = params.fontSize or assetTable.fontSize
	local fontFamily = params.font or assetTable.fontFamily
	local isEmbossed = params.emboss or assetTable.fontEmboss
	local baseDir = params.baseDir or system.ResourceDirectory
        local default = params.message or assetTable.message
        local onShowEvent = params.onShowEvent or nil
        local onHideEvent = params.onHideEvent or nil
        local messageSize = params.messageSize or assetTable.messageSize
        local messageColor = params.messageColor or assetTable.messageColor
        -- set up default buttons
	if not buttons then
		
		buttons = { { id="Ok" }, { id="Cancel" } }
	end
	

        -- set up a display group
	local actionSheetGroup = display.newGroup()
        actionSheetGroup:setReferencePoint( display.CenterLeftReferencePoint )
	actionSheetGroup.id = id
        
        local H = display.contentHeight;
        local W = display.contentWidth;
        
        -- set up our background image
        local overlayImage = display.newImageRect(background, W, H )
        overlayImage.isFullResolution = true;
        overlayImage.x = W / 2
        overlayImage.y = H / 2
        overlayImage:setReferencePoint( display.CenterReferencePoint )
        actionSheetGroup:insert(overlayImage)
        
     
        
        local numRows = #buttons
        -- height of the display minus the buttons height, and some padding
	local nextY = H - 55	 
        
        -- set up our action sheet bg
        actionSheetBG = display.newImageRect(actionBackground, W, H)
        actionSheetBG.isFullResolution = true
        actionSheetBG.x = (display.contentWidth/2)
        actionSheetBG.y = H + (actionSheetBG.height / 2) -  ((45 * #buttons) + 75)
        actionSheetBG:setReferencePoint(display.TopLeftReferencePoint)
        actionSheetGroup:insert(actionSheetBG)
        
        -- set up our label
        local actionLabel = display.newText( actionSheetGroup, 
            default, 10, actionSheetBG.y+30, W, 0, fontFamily, messageSize )
       actionLabel.x = (W/2)
       --actionLabel:setTextColor( {0} )
        actionSheetGroup:insert(actionLabel )
        
        
        
        
        for i=1,numRows,1 do
		
		
		local buttonRow = buttons[i]
		
		-- Define some button-specific variables
		local buttonID, buttonLabel, onPress, onRelease, 
                onEvent, width, isDown, height, buttonUpImage, buttonDownImage, buttonTop, buttonOverColor, 
                buttonLabelColor, buttonOnRelease, buttonLabelColor, buttonFont, buttonFontSize =
                
			tostring(i), "Label", nil, nil, nil, 250, false, 45, "actionsheet/actionWhiteButton.png", 
                        "actionsheet/actionWhiteButton.png", 10, {128, 128, 128, 255}, { default={ 255, 255, 255, 255 }, 
                        over={ 128, 255, 96, 255 } }, nil, { default={ 0 }, over={ 255, 255, 255, 255 }},
                        "HelveticaNeue-Bold", 18
                        
		
		buttonID = buttonRow.id or id
		buttonLabel = buttonRow.label or buttonLabel
		onPress = buttonRow.onPress or onPress
		onRelease = buttonRow.onRelease or onRelease
		onEvent = buttonRow.onEvent or onEvent
		width = buttonRow.width or width
                height = buttonRow.height or height
		isDown = buttonRow.isDown or isDown
                buttonUpImage = buttonRow.buttonUpImage or buttonUpImage
                buttonDownImage = buttonRow.buttonDownImage or buttonDownImage
                buttonOverColor = buttonRow.buttonOverColor or buttonOverColor
                buttonOnRelease = buttonRow.buttonOnRelease or buttonOnRelease
                buttonLabelColor = buttonRow.buttonLabelColor or buttonLabelColor
                buttonFont = buttonRow.buttonFont or buttonFont
                buttonFontSize = buttonRow.buttonFontSize or buttonFontSize
                
                local b = widget.newButton {
			id = buttonID,
			left =  35,
			top = nextY,
			default = buttonUpImage,
			over = buttonDownImage,
			overColor = buttonOverColor,
			width = width, height = height,
			cornerRadius = 0,
                        label = buttonLabel,
                        fontSize = buttonFontSize,
                        font = buttonFont,
                        emboss = false,
                        labelColor = buttonLabelColor,
			onRelease = onButtonPressed
		}
                
                
                b.releaseEvent = buttonOnRelease
                 
                actionSheetGroup:insert(b) 
                
                nextY = nextY - 50
            end
            
            
         -- Add a .view property (for consistency)
	actionSheetGroup.view = actionSheetGroup
        
        -- PATCH removeSelf() to ensure all children "buttons" are removed
	
	actionSheetGroup.oldRemoveSelf = actionSheetGroup.removeSelf
	
	function actionSheetGroup:removeSelf()
		
		-- Go through and remove all buttons from the control
		for i=actionSheetGroup.numChildren,1,-1 do
			actionSheetGroup[i]:removeSelf()
			actionSheetGroup[i] = nil
		end
		
		-- remove the group finally
		actionSheetGroup:oldRemoveSelf()
		actionSheetGroup = nil
            end
            
     
          function actionSheetGroup:show(speed)

                if speed < 500 then
                speed = 500
                end
                
               if self.shown == false then
                transition.to( self, { time=speed, y=self.y - self.height, onComplete=self.onShowEvent } )
                self.shown = true
               end
           end
           
           function actionSheetGroup:hide(speed)
               
               if speed < 500 then
                   speed = 500
               end
               
               if self.shown == true then
                   transition.to( self, {time=speed, y=self.y + self.height, onComplete=self.onHideEvent} )
                   self.shown = false
               end
           end
           
           function actionSheetGroup:didCloseWithButtonID(buttonID, speed)
           
                if self.shown == true then
                 self:hide(speed)
                 self.onHideEvent(buttonID)
                end
           
                 
           end
           
	
	
	
	
        
        -- position 
	actionSheetGroup:setReferencePoint( display.CenterReferencePoint)
	--actionSheetGroup.x = x
	actionSheetGroup.y = actionSheetGroup.y + actionSheetGroup.height
        
        
       -- default settings
       actionSheetGroup.shown = false
       actionSheetGroup.onShowEvent = onShowEvent
       actionSheetGroup.onHideEvent = onHideEvent
        
	
	
	-- return the group
	return actionSheetGroup
            
            
        end
        
return actionSheet
        