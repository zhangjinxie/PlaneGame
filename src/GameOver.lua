local GameOver = class("GameOver", function() return cc.Scene:create() end)

function GameOver:create()
	local scene = GameOver:new()
	scene:addChild(scene:createLayer())
	return scene
end

function GameOver:createLayer()
	local layer = cc.Layer:create()
	local map = cc.TMXTiledMap:create("map/blue_bg.tmx")
	layer:addChild(map)

	local bg = cc.Sprite:createWithSpriteFrameName("gameover.page.png")
	bg:setPosition(cc.p(winSize.width/2, winSize.height/2))
	layer:addChild(bg)

	local tap = cc.Sprite:createWithSpriteFrameName("Tap.png")
	tap:setPosition(cc.p(winSize.width/2, winSize.height/4))
	layer:addChild(tap)

	local function closeHd()
		cc.Director:getInstance():popScene()
	end

	self:addClickEventListener(closeHd)
	return layer
end

return GameOver