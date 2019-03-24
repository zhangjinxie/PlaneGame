local GameScene = class("GameScene", function() return cc.Scene:create() end)
local userDefault = cc.UserDefault:getInstance()
function GameScene:create()
	local scene = GameScene:new()
	scene:addChild(scene:createLayer())
	return scene
end

function GameScene:ctor()
	local function onNodeEvent(eventType)
		if eventType == "enter" then
			print("======GameScene======enter")
		elseif eventType == "enterTransitionFinish" then
			print("======GameScene======enterTransitionFinish")
			if userDefault:getBoolForKey(MUSICKEY, true) then
				AudioEngine.playMusic(gameMusic, true)
			end
		elseif eventType == "exit" then
			print("======GameScene======exit")
		elseif eventType == "exitTransitionStart" then
			print("======GameScene======exitTransitionStart")
		elseif eventType == "cleanup" then
			print("======GameScene======cleanup")
		end
	end
	self:registerScriptHandler(onNodeEvent)
end

function GameScene:createLayer()
	local layer = cc.Layer:create()
	local map = cc.TMXTiledMap:create("map/blue_bg.tmx")
	layer:addChild(map)

	local enemy1 = require("sprite.Enemy"):create(EnemyAtt.plane1)
	-- layer:addChild(enemy1)

	return layer
end

return GameScene