// Project: EmissionRatingGenerator 
// Created: 23-08-19

SetErrorMode(0) // Hide all errors

// Set window properties
SetWindowTitle( "Corporation Energy Rating - Generator" )
SetWindowSize( 1080, 1080, 0 )
SetWindowAllowResize( 0 ) 

// Setup
SetVirtualResolution( 1080, 1080 ) 
SetSyncRate( 30, 0 ) 
SetScissor( 0,0,0,0 )
UseNewDefaultFonts( 1 )
SetPrintColor(255,0,0)
if GetDeviceBaseName() <> "html5"
	SetClearColor(255,255,255)
else
	SetClearColor(229,229,229)
endif

// Open data
OpenToRead (1, "data.csv" )
data$ = ReadString(1)

// Load images
background1 = loadImage("Background1.png")
background2 = loadImage("Background2.png")
background3 = loadImage("Background3.png")
background4 = loadImage("Background4.png")
background5 = loadImage("Background5.png")
background6 = loadImage("Background5.png")
stars1 = loadImage("Stars1.png")
stars2 = loadImage("Stars2.png")
stars3 = loadImage("Stars3.png")
stars4 = loadImage("Stars4.png")
stars5 = loadImage("Stars5.png")
stars6 = loadImage("Stars5.png")
more1 = loadImage("More1.png")
more2 = loadImage("More2.png")
more3 = loadImage("More3.png")
more4 = loadImage("More4.png")
more5 = loadImage("More5.png")
more6 = loadImage("More6.png")
trendUp = loadImage("TrendUp.png")
trendDown = loadImage("TrendDown.png")
trendSteady = loadImage("TrendSteady.png")

// Create sprites
backgroundSprite = createSprite(background1)
starsSprite = createSprite(stars1)
emissionsSprite = createSprite(more1)
energySprite = createSprite(more1)
trendSprite = createSprite(trendUp)
SetSpritePosition(energySprite,472-144,0)
createSprite(loadImage("Title.png"))

// Create text
nameText = createText("Corporation Name")
SetTextSize(nameText,50)
SetTextAlignment(nameText,1)
SetTextPosition(nameText,1080/2,700)
LoadFont(1,"ProductSans.ttf")
SetTextFont(nameText,1)

// Variables
global OrgNumber = 1 // Current org/corp being shown
global PrevOrgNumber = 0
OutputAll = 0 

// Set output
setFolder("")

// Basic functions
function nextOrg()
	PrevOrgNumber = OrgNumber
    OrgNumber = OrgNumber + 10
    if OrgNumber = 4171
    		OrgNumber = 4161
    	endif
endfunction

function prevOrg()
	PrevOrgNumber = OrgNumber
    	OrgNumber = OrgNumber - 10
    	if OrgNumber = -9
    		OrgNumber = 1
    	endif
endFunction

// Main loop
do
	// Arrow keys - Navigation  	
    	if (GetRawKeyPressed(39)) or (GetRawKeyState(38)) // Next
    		nextOrg()
    	elseif (GetRawKeyPressed(37)) or (GetRawKeyState(40)) //Prev
    		prevOrg()
    	endif
    	
    	if PrevOrgNumber <> OrgNumber // Prevents excessive updates
    		// Update background and stars
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
    		
    		// Update small emissions box
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
    			
    		// Update small energy usage box
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
    		
    		// Update small trend box
    		trendStr$ = (GetStringToken( data$, ",", OrgNumber+9))
    		if CompareString(trendStr$,"Getting Worse")
    			setSpriteImage(trendSprite,trendDown)
    		elseif CompareString(trendStr$,"Getting Better")
    			setSpriteImage(trendSprite,trendUp)
    		else
    			setSpriteImage(trendSprite,trendSteady)
    		endif
    		
    		// Update corporation name
    		SetTextString(nameText, GetStringToken( data$, ",", OrgNumber ))
    	endif
    	
    	// S key - Screenshot current badge
    	if GetRawKeyPressed(83) 
    		Render()
    		getImage(OrgNumber,0,0,1080,1080)
    		saveImage(OrgNumber,(GetStringToken( data$, ",", OrgNumber )+".png"))
    	endif
    	
    	// Enter key - Output all badges to default write location (AppData on Windows)
    	
    	if GetDeviceBaseName() <> "html5" // Disable when running in browser
	    	if GetRawKeyPressed(13)
	    		OrgNumber = 1
	    		OutputAll = 1
	    	endif
	    	if OutputAll = 1
		    Render()
		    getImage(OrgNumber,0,0,1080,1080)
		    saveImage(OrgNumber,(GetStringToken( data$, ",", OrgNumber )+".png"))
		    OrgNumber = OrgNumber + 10
		    
		    if OrgNumber > 4170 // Open output location and close app when complete
		    		a$ = GetWritePath()
				a$ = ReplaceString(a$,"/","\",-1)
				RunApp("explorer.exe",a$)
		    		exit
		    endif
   		endif
   	endif
   	   
    Sync()
loop
