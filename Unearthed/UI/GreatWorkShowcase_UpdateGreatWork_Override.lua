include("GreatWorkShowcase.lua");

-- ===========================================================================
--	Called every time screen is shown
-- ===========================================================================
function UpdateGreatWork()

	Controls.MusicDetails:SetHide(true);
	Controls.WritingDetails:SetHide(true);
	Controls.GreatWorkBanner:SetHide(true);
	Controls.GalleryBG:SetHide(true);

	local greatWorkInfo:table = GameInfo.GreatWorks[m_GreatWorkType];
	local greatWorkType:string = greatWorkInfo.GreatWorkType;
	local greatWorkCreator:string = Locale.Lookup(m_CityBldgs:GetCreatorNameFromIndex(m_GreatWorkIndex));
	local greatWorkCreationDate:string = Calendar.MakeDateStr(m_CityBldgs:GetTurnFromIndex(m_GreatWorkIndex), GameConfiguration.GetCalendarType(), GameConfiguration.GetGameSpeedType(), false);
	local greatWorkCreationCity:string = m_City:GetName();
	local greatWorkCreationBuilding:string = GameInfo.Buildings[m_BuildingID].Name;
	local greatWorkObjectType:string = greatWorkInfo.GreatWorkObjectType;

	local greatWorkTypeName:string;
	if greatWorkInfo.EraType ~= nil then
		greatWorkTypeName = Locale.Lookup("LOC_" .. greatWorkInfo.GreatWorkObjectType .. "_" .. greatWorkInfo.EraType);
	else
		greatWorkTypeName = Locale.Lookup("LOC_" .. greatWorkInfo.GreatWorkObjectType);
	end

	if greatWorkInfo.Audio then
		UI.PlaySound("Play_" .. greatWorkInfo.Audio );
	end

	local heightAdjustment:number = 0;
	local detailsOffset:number = DETAILS_OFFSET_DEFAULT;
	if greatWorkObjectType == GREAT_WORK_MUSIC_TYPE then
		detailsOffset = DETAILS_OFFSET_MUSIC;
		Controls.GreatWorkImage:SetOffsetY(95);
		Controls.GreatWorkImage:SetTexture(GREAT_WORK_MUSIC_TEXTURE);
		Controls.MusicName:SetText(Locale.ToUpper(Locale.Lookup(greatWorkInfo.Name)));
		Controls.MusicAuthor:SetText("-" .. greatWorkCreator);
		Controls.MusicDetails:SetHide(false);
	elseif greatWorkObjectType == GREAT_WORK_WRITING_TYPE then
		detailsOffset = DETAILS_OFFSET_WRITING;
		Controls.GreatWorkImage:SetOffsetY(0);
		Controls.GreatWorkImage:SetTexture(GREAT_WORK_WRITING_TEXTURE);
		Controls.WritingName:SetText(Locale.ToUpper(Locale.Lookup(greatWorkInfo.Name)));
		local quoteKey:string = greatWorkInfo.Quote;
		if (quoteKey ~= nil) then
			Controls.WritingLine:SetHide(false);
			Controls.WritingQuote:SetText(Locale.Lookup(quoteKey));
			Controls.WritingQuote:SetHide(false);
			Controls.WritingAuthor:SetText("-" .. greatWorkCreator);
			Controls.WritingAuthor:SetHide(false);
			Controls.WritingDeco:SetHide(true);
		else
			local titleOffset:number = -45;
			Controls.WritingName:SetOffsetY(titleOffset);
			Controls.WritingLine:SetHide(true);
			Controls.WritingQuote:SetHide(true);
			Controls.WritingAuthor:SetHide(true);
			Controls.WritingDeco:SetHide(false);
			Controls.WritingDeco:SetOffsetY(Controls.WritingName:GetSizeY() + -20);
		end
		Controls.WritingDetails:SetHide(false);
    else
        -- Unearthed - start
		local greatWorkTexture:string = greatWorkType:gsub("GREATWORK_", "");
		if greatWorkObjectType == GREAT_WORK_ARTIFACT_TYPE or greatWorkObjectType == GREAT_WORK_RELIC_TYPE then
			Controls.GreatWorkImage:SetOffsetY(0);
		else
			Controls.GreatWorkImage:SetOffsetY(-40);
        end

        print("DEBUG greatWorkTexture " .. greatWorkTexture);
        -- Unearthed - end

		Controls.GreatWorkImage:SetTexture(greatWorkTexture);
		Controls.GreatWorkName:SetText(Locale.ToUpper(Locale.Lookup(greatWorkInfo.Name)));
		local nameSize:number = Controls.GreatWorkName:GetSizeX() + PADDING_BANNER;
		local bannerSize:number = math.max(nameSize, SIZE_BANNER_MIN);
		Controls.GreatWorkBanner:SetSizeX(bannerSize);
		Controls.GreatWorkBanner:SetHide(false);

		local imageHeight:number = Controls.GreatWorkImage:GetSizeY();
		if imageHeight > SIZE_MAX_IMAGE_HEIGHT then
			heightAdjustment = SIZE_MAX_IMAGE_HEIGHT - imageHeight;
		end
	end

	Controls.CreatedBy:SetText(Locale.Lookup("LOC_GREAT_WORKS_CREATED_BY", greatWorkCreator));
	Controls.CreatedDate:SetText(Locale.Lookup("LOC_GREAT_WORKS_CREATED_TIME", greatWorkTypeName, greatWorkCreationDate));
	Controls.CreatedPlace:SetText(Locale.Lookup("LOC_GREAT_WORKS_CREATED_PLACE", greatWorkCreationBuilding, greatWorkCreationCity));

	Controls.GreatWorkHeader:SetText(m_isGallery and "" or LOC_NEW_GREAT_WORK);
	Controls.ViewGreatWorks:SetText(m_isGallery and LOC_BACK_TO_GREAT_WORKS or LOC_VIEW_GREAT_WORKS);

	-- Ensure image is repositioned in case its size changed
	if not Controls.GreatWorkImage:IsHidden() then
		Controls.GreatWorkImage:ReprocessAnchoring();
		Controls.DetailsContainer:ReprocessAnchoring();
	end

	Controls.DetailsContainer:SetOffsetY(detailsOffset + heightAdjustment);
end