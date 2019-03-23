local setScene = class("setScene", function() return cc.Scene:create() end)

function setScene:create()
	local scene = setScene:new()
	scene:addChild(scene:createLayer())
	return scene
end

function setScene:createLayer()
	local layer = cc.Layer:create()

	local map = cc.TMXTiledMap:create("map/red_bg.tmx")
	layer:addChild(map, -1)

	local closeBtn = ccui.Button:create()
	closeBtn:loadTextures("button.back.png", "button.back-on.png", "", ccui.TextureResType.plistType)
	local closeSize = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(winSize.width/2, winSize.height/4))
	layer:addChild(closeBtn)

	local function onClick(sender, eventType)
		if cc.UserDefault:getInstance():getBoolForKey(SOUNDKEY, true) then
			AudioEngine.playEffect(sound1)
		end
		cc.Director:getInstance():popScene()
	end
	closeBtn:addClickEventListener(onClick)

	local top = cc.Sprite:createWithSpriteFrameName("setting.page.png")
	top:setPosition(cc.p(winSize.width/2, winSize.height - top:getContentSize().height/2))
	layer:addChild(top)

	local userDefault = cc.UserDefault:getInstance()

	local soundSP1 = cc.Sprite:createWithSpriteFrameName("check-on.png")
	local soundSP2 = cc.Sprite:createWithSpriteFrameName("check-off.png")
	local soundOnItem = cc.MenuItemSprite:create(soundSP1, soundSP1)
	local soundOffItem = cc.MenuItemSprite:create(soundSP2, soundSP2)
	local soundToggleItem = cc.MenuItemToggle:create(soundOnItem, soundOffItem)
	soundToggleItem:setSelectedIndex(userDefault:getBoolForKey(SOUNDKEY, true) and 0 or 1)
	soundToggleItem:registerScriptTapHandler(function(sender, eventType) 
		if userDefault:getBoolForKey(SOUNDKEY, true) then
			userDefault:setBoolForKey(SOUNDKEY, false)
		else
			AudioEngine.playEffect(sound1)
			userDefault:setBoolForKey(SOUNDKEY, true)
		end
	 end)

	local musicSP1 = cc.Sprite:createWithSpriteFrameName("check-on.png")
	local musicSP2 = cc.Sprite:createWithSpriteFrameName("check-off.png")
	local musicOnItem = cc.MenuItemSprite:create(musicSP1, musicSP1)
	local musicOffItem = cc.MenuItemSprite:create(musicSP2, musicSP2)
	local musicToggleItem = cc.MenuItemToggle:create(musicOnItem, musicOffItem)
	musicToggleItem:setSelectedIndex(userDefault:getBoolForKey(MUSICKEY, true) and 0 or 1)
	musicToggleItem:registerScriptTapHandler(function(sender, eventType) 
		if userDefault:getBoolForKey(MUSICKEY, true) then
			userDefault:setBoolForKey(MUSICKEY, false)
			AudioEngine.stopMusic()
		else
			AudioEngine.playMusic(homeMusic, true)
			userDefault:setBoolForKey(MUSICKEY, true)
		end
	 end)


	local mn = cc.Menu:create(soundToggleItem, musicToggleItem)
	local x, y = mn:getPosition()
	mn:setPosition(cc.p(x + 40, y + 100))
	mn:alignItemsVerticallyWithPadding(12)
	layer:addChild(mn)

	return layer
end

return setScene