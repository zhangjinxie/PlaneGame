local GameOver = class("GameOver", function() return cc.Scene:create() end)

function GameOver:create()
	local scene = GameOver:new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameOver:ctor()
	local function onEvent(eventType)
		if eventType == "enter" then
			print("====GameOver=======enter")
		elseif eventType == "enterTransitionFinish" then
			print("====GameOver=======enterTransitionFinish")
		elseif eventType == "exitTransitionStart" then
			print("====GameOver=======exitTransitionStart")
		elseif eventType == "exit" then
			print("====GameOver=======exit")
		elseif eventType == "cleanup" then
			print("====GameOver=======cleanup")
		end
	end
	self:registerScriptHandler(onEvent)
end
function GameOver:createLayer()
	local layer = cc.Layer:create()
	local map = cc.TMXTiledMap:create("map/blue_bg.tmx")
	layer:addChild(map)

	local bg = cc.Sprite:createWithSpriteFrameName("gameover.page.png")
	bg:setPosition(cc.p(winSize.width/2, winSize.height*0.75))
	layer:addChild(bg)

	local tap = cc.Sprite:createWithSpriteFrameName("Tap.png")
	tap:setPosition(cc.p(winSize.width/2, winSize.height/4))
	layer:addChild(tap)

	local record = cc.UserDefault:getInstance():getIntegerForKey("record", 0)
	local scoreTxt = ccui.Text:create("最高记录：" .. record, "fonts/hanyi.ttf", 30)
	scoreTxt:setPosition(cc.p(winSize.width/2, winSize.height * 0.4))
	layer:addChild(scoreTxt)

	local function closeHd()
		cc.Director:getInstance():popScene()
	end

	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(closeHd, cc.Handler.EVENT_TOUCH_BEGAN)
	local dispatcher = layer:getEventDispatcher()
	dispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

	return layer
end

return GameOver