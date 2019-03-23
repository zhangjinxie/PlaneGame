local helpScene = class("helpScene", function() return cc.Scene:create() end)

function helpScene:create()
	local scene = helpScene:new()
	scene:addChild(scene:createLayer())
	return scene
end

function helpScene:createLayer()
	local layer = cc.Layer:create()

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

	local map = cc.TMXTiledMap:create("map/red_bg.tmx")
	layer:addChild(map, -1)

	local top = cc.Sprite:createWithSpriteFrameName("help.page.png")
	top:setPosition(cc.p(winSize.width/2, winSize.height - top:getContentSize().height/2))
	layer:addChild(top)
	return layer
end

return helpScene