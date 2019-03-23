local GameScene = class("GameScene", function() return cc.Scene:create() end)

function GameScene:create()
	local scene = GameScene:new()
	scene:addChild(scene:createLayer())
	return scene
end

function GameScene:ctor()
	local function onEvent(eventType)
		if eventType == "enter" then
			print("====GameScene=======enter")
		elseif eventType == "enterTransitionFinish" then
			print("====GameScene=======enterTransitionFinish")
			if cc.UserDefault:getInstance():getBoolForKey(MUSICKEY, true) then
				AudioEngine.playMusic(homeMusic)
			end
		elseif eventType == "exit" then
			print("====GameScene=======exit")
		elseif eventType == "exitTransitionStart" then
			print("====GameScene=======exitTransitionStart")
		elseif eventType == "cleanup" then
			print("====GameScene=======cleanup")
		end
	end
	self:registerScriptHandler(onEvent)
end
function GameScene:createLayer() 
	local layer = cc.LayerColor:create(cc.BLUE)
	local map = cc.TMXTiledMap:create("map/red_bg.tmx")
	layer:addChild(map)

	frameCache:addSpriteFrames(LostRoutes_plist)
	local top = cc.Sprite:createWithSpriteFrameName("home-top.png")
	top:setPosition(cc.p(winSize.width/2, winSize.height - top:getContentSize().height/2))
	layer:addChild(top)

	local bottom = cc.Sprite:createWithSpriteFrameName("home-end.png")
	bottom:setPosition(cc.p(winSize.width/2, bottom:getContentSize().height/2))
	layer:addChild(bottom)

	local function onClick(sender, eventType)
		if cc.UserDefault:getInstance():getBoolForKey(SOUNDKEY, true) then
			AudioEngine.playEffect(sound1)
		end
		local scene
		local director = cc.Director:getInstance()
		if sender:getTag() == HomeBtnType.start then
			scene = require("GamePlayScene"):create()
		elseif sender:getTag() == HomeBtnType.setting then
			scene = require("setScene"):create()
		elseif sender:getTag() == HomeBtnType.help then
			scene = require("helpScene"):create()
		end
		director:pushScene(scene)
	end

	local startBtn = ccui.Button:create()
	startBtn:loadTextures("button.start.png", "button.start-on.png", "", ccui.TextureResType.plistType)
	startBtn:setPosition(cc.p(winSize.width/2, winSize.height/2 + 60))
	startBtn:setTag(HomeBtnType.start)
	layer:addChild(startBtn)

	local settingBtn = ccui.Button:create()
	settingBtn:loadTextures("button.setting.png", "button.setting-on.png", "", ccui.TextureResType.plistType)
	settingBtn:setPosition(cc.p(winSize.width/2, winSize.height/2))
	settingBtn:setTag(HomeBtnType.setting)
	layer:addChild(settingBtn)

	local helpBtn = ccui.Button:create()
	helpBtn:loadTextures("button.help.png", "button.help-on.png", "", ccui.TextureResType.plistType)
	helpBtn:setPosition(cc.p(winSize.width/2, winSize.height/2 - 60))
	helpBtn:setTag(HomeBtnType.help)
	layer:addChild(helpBtn)

	startBtn:addClickEventListener(onClick)
	settingBtn:addClickEventListener(onClick)
	helpBtn:addClickEventListener(onClick)

	return layer
end
return GameScene