--create watermark frame
mainFrame = CreateFrame("Frame", "mainFrame", UIParent);
mainFrame:SetSize(36, 36);
mainFrame:SetPoint("BOTTOMRIGHT");

--register Battle.net whispers
events:RegisterEvent("CHAT_MSG_BN_WHISPER");

--set up slash command, initialize addon
SLASH_LIVE1 = "/live"
SlashCmdList["LIVE"] = function(msg)
	local msg = msg:lower();
	local msgPrint = 0;
	if (msg == "" or msg == nil) then
	    print("Please choose between /live on & /live off");
		msgPrint = 1;
	end
	--if option on typed
	if (msg == "on") then 
		--set volume levels
		SetCVar( "Sound_MasterVolume", 0.5 );
		SetCVar( "Sound_SFXVolume", 0.5 );
		SetCVar( "Sound_MusicVolume", 0 );
		
		--set watermark and display
		mainFrame:SetBackdrop( { 
		bgFile = "Interface\\AddOns\\Live\\Img\\test.tga",
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
		});
		
		--set DND message
		SendChatMessage("I am currently recording or streaming and may not reply. :)", "DND");
		
		--set DND message to Battle.net whispers
		function events:CHAT_MSG_BN_WHISPER(...)
			local friend = select(14, ...)
			BNSendWhisper(friend, "I am currently recording or streaming and may not reply. :)")
		end
		msgPrint = 1;
	end
	--if option off typed
	if (msg == "off") then
		--set volume levels
		SetCVar( "Sound_MusicVolume", 0.5 );
		
		--remove backdrop
		mainFrame:Hide()
		
		--clear DND, reset status to Online
		SendChatMessage("", "DND");
		msgPrint = 1;		
	end
	--error handling
	if (msgPrint == 0) then
		print("Invalid argument for command /live");
	end
end


