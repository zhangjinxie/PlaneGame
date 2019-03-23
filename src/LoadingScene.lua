require "GameConstant"
require "cocos.cocosdenshion.AudioEngine"
local LoadingScene = class("LoadingScene", function() return cc.Scene:create() end)

function LoadingScene:create()
	local scene = LoadingScene:new()
	scene:addChild(scene:createLayer())
	return scene
end

function LoadingScene:createLayer()
	local layer = cc.Layer:create()
	frameCache:addSpriteFrames(loading_texture_plist)
	local animation = cc.Animation:create()
	for i = 1, 4 do
		local name = string.format("loding%d.png", i)
		local frame = frameCache:getSpriteFrameByName(name)
		animation:addSpriteFrame(frame)
	end
	animation:setDelayPerUnit(0.2)
	animation:setRestoreOriginalFrame(true)
	local loadingSprite = cc.Sprite:createWithSpriteFrameName("loding1.png")
	loadingSprite:setPosition(cc.p(winSize.width/2, winSize.height/4))
	layer:addChild(loadingSprite)
	loadingSprite:runAction(cc.RepeatForever:create(cc.Animate:create(animation)))

	local logo = cc.Sprite:createWithSpriteFrameName("logo.png")	
	logo:setPosition(cc.p(winSize.width/2, winSize.height - logo:getContentSize().height/2))
	dump(winSize)
	layer:addChild(logo)

	local map = cc.TMXTiledMap:create("map/red_bg.tmx")
	layer:addChild(map, -1)

	local function gotoGameScene(texture)
		AudioEngine.preloadMusic(homeMusic)
		AudioEngine.preloadMusic(gameMusic)
		AudioEngine.preloadEffect(sound1)
		AudioEngine.preloadEffect(sound2)
		local scene = require("GameScene"):create()
		cc.Director:getInstance():pushScene(scene)
	end
	local texture = cc.Director:getInstance():getTextureCache()
	texture:addImageAsync(LostRoutes_res, gotoGameScene)
	return layer
end
return LoadingScene