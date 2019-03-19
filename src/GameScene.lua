local GameScene = class("GameScene", function() return cc.Scene:create() end)

function GameScene:create()
	local scene = GameScene:new()
	scene:addChild(scene:createLayer())
	return scene
end

function GameScene:createLayer() 
	local layer = cc.LayerColor:create(cc.BLUE)
	return layer
end
return GameScene