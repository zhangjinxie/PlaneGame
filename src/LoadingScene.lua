require "GameConstant"
local LoadingScene = class("LoadingScene", function() return cc.Scene:create() end)

function LoadingScene:create()
	local scene = LoadingScene:new()
	scene:addChild(scene:createLayer())
	return scene
end

function LoadingScene:createLayer()
	local layer = cc.Layer:create()
	local winSize = cc.Director:getInstance():getWinSize()
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
	loadingSprite:setPosition(cc.p(winSize.width/2, 300))
	layer:addChild(loadingSprite)
	loadingSprite:runAction(cc.RepeatForever:create(cc.Animate:create(animation)))
	return layer
end
return LoadingScene