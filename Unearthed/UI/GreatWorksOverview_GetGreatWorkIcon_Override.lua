local SIZE_GREAT_WORK_ICON:number = 64;

function GetGreatWorkIcon(greatWorkInfo:table)

	print("GreatWorksOverview_GetGreatWorkIcon_Override - GetGreatWorkIcon");

	-- Unearthed - start
    local greatWorkIcon  = "ICON_" .. greatWorkInfo.GreatWorkType;

	print("DEBUG greatWorkIcon " .. greatWorkIcon);
	-- Unearthed - end

	local textureOffsetX:number, textureOffsetY:number, textureSheet:string = IconManager:FindIconAtlas(greatWorkIcon, SIZE_GREAT_WORK_ICON);
	if(textureSheet == nil or textureSheet == "") then
		UI.DataError("Could not find slot type icon in GetGreatWorkIcon: icon=\""..greatWorkIcon.."\", iconSize="..tostring(SIZE_GREAT_WORK_ICON));
	end

	return textureOffsetX, textureOffsetY, textureSheet;
end
