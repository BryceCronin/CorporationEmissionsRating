
// Project: EmissionRatingGenerator 
// Created: 23-08-19

// show all errors

SetErrorMode(2)

// set window properties
SetWindowTitle( "EmissionRatingGenerator" )
SetWindowSize( 1080, 1080, 0 )
SetWindowAllowResize( 0 ) 

// set display properties
SetVirtualResolution( 1080, 1080 ) 
SetSyncRate( 30, 0 ) 
SetScissor( 0,0,0,0 )
UseNewDefaultFonts( 1 )
SetClearColor(255,255,255)
SetPrintColor(255,0,0)

OpenToRead (1, "data.csv" )
data$ = ReadString(1)

background1 = loadImage("Background1.png")
background2 = loadImage("Background2.png")
background3 = loadImage("Background3.png")
background4 = loadImage("Background4.png")
background5 = loadImage("Background5.png")
background6 = loadImage("Background5.png")
backgroundSprite = createSprite(background1)

stars1 = loadImage("Stars1.png")
stars2 = loadImage("Stars2.png")
stars3 = loadImage("Stars3.png")
stars4 = loadImage("Stars4.png")
stars5 = loadImage("Stars5.png")
stars6 = loadImage("Stars5.png")
starsSprite = createSprite(stars1)

more1 = loadImage("More1.png")
more2 = loadImage("More2.png")
more3 = loadImage("More3.png")
more4 = loadImage("More4.png")
more5 = loadImage("More5.png")
more6 = loadImage("More6.png")
emissionsSprite = createSprite(more1)
energySprite = createSprite(more1)
SetSpritePosition(energySprite,472-144,0)

createSprite(loadImage("Title.png"))

nameText = createText("Corporation Name")
SetTextSize(nameText,50)
SetTextAlignment(nameText,1)
SetTextPosition(nameText,1080/2,700)
LoadFont(1,"ProductSans.ttf")
SetTextFont(nameText,1)

trendUp = loadImage("TrendUp.png")
trendDown = loadImage("TrendDown.png")
trendSteady = loadImage("TrendSteady.png")
trendSprite = createSprite(trendUp)

OrgNumber=1
PrevOrgNumber = 0

do
    
    if GetRawKeyPressed(39) //next
    		PrevOrgNumber = OrgNumber
    		OrgNumber = OrgNumber + 10
    	elseif GetRawKeyPressed(37) //previous
    		PrevOrgNumber = OrgNumber
    		OrgNumber = OrgNumber - 10
    	elseif GetRawKeyState(38) //skip forward
    		PrevOrgNumber = OrgNumber
    		OrgNumber = OrgNumber + 10
    	elseif GetRawKeyState(40) //skip back
    		PrevOrgNumber = OrgNumber
    		OrgNumber = OrgNumber - 10
    	endif
    	
    	if PrevOrgNumber <> OrgNumber //prevents excessive updates
    		overallRating = val(GetStringToken( data$, ",", OrgNumber+7 ))
    		if overallRating = 6
    			setSpriteImage(backgroundSprite,background6)
    			setSpriteImage(starsSprite,stars6)
    		elseif overallRating = 5
    			setSpriteImage(backgroundSprite,background5)
    			setSpriteImage(starsSprite,stars5)
    		elseif overallRating = 4
    			setSpriteImage(backgroundSprite,background4)
    			setSpriteImage(starsSprite,stars4)
    		elseif overallRating = 3
    			setSpriteImage(backgroundSprite,background3)
    			setSpriteImage(starsSprite,stars3)
    		elseif overallRating = 2
    			setSpriteImage(backgroundSprite,background2)	
    			setSpriteImage(starsSprite,stars2)
    		elseif overallRating = 1
    			setSpriteImage(backgroundSprite,background1)
    			setSpriteImage(starsSprite,stars1)
    		endif
    		
    		emissionsRating = val(GetStringToken( data$, ",", OrgNumber+5 ))
    		if emissionsRating = 6
    			setSpriteImage(emissionsSprite,more6)
    		elseif emissionsRating = 5
    			setSpriteImage(emissionsSprite,more5)
    		elseif emissionsRating = 4
    			setSpriteImage(emissionsSprite,more4)
    		elseif emissionsRating = 3
    			setSpriteImage(emissionsSprite,more3)
    		elseif emissionsRating = 2
    			setSpriteImage(emissionsSprite,more2)
    		elseif emissionsRating = 1
    			setSpriteImage(emissionsSprite,more1)
    		endif
    			
    		energyRating = val(GetStringToken( data$, ",", OrgNumber+6 ))
    		if energyRating = 6
    			setSpriteImage(energySprite,more6)
    		elseif energyRating = 5
    			setSpriteImage(energySprite,more5)
    		elseif energyRating = 4
    			setSpriteImage(energySprite,more4)
    		elseif energyRating = 3
    			setSpriteImage(energySprite,more3)
    		elseif energyRating = 2
    			setSpriteImage(energySprite,more2)
    		elseif energyRating = 1
    			setSpriteImage(energySprite,more1)
    		endif
    		
    		trendStr$ = (GetStringToken( data$, ",", OrgNumber+9))
    		if CompareString(trendStr$,"Getting Worse")
    			setSpriteImage(trendSprite,trendDown)
    		elseif CompareString(trendStr$,"Getting Better")
    			setSpriteImage(trendSprite,trendUp)
    		else
    			setSpriteImage(trendSprite,trendSteady)
    		endif
    		
    		SetTextString(nameText, GetStringToken( data$, ",", OrgNumber ))
    		  		
    	endif
    	
    	if GetRawKeyPressed(13) //Enter
    		Render()
    		getImage(OrgNumber,0,0,1080,1080)
    		saveImage(OrgNumber,(GetStringToken( data$, ",", OrgNumber )+".png"))
    	endif
    	
    	/*
    Render()
    getImage(OrgNumber,0,0,1080,1080)
    saveImage(OrgNumber,(GetStringToken( data$, ",", OrgNumber )+".png"))
    OrgNumber = OrgNumber + 10
    
    if OrgNumber > 4180
    		exit
    endif
    */
    
    Sync()
loop
