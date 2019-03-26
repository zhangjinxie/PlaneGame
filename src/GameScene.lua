local GameScene = class("GameScene", function() return cc.Scene:createWithPhysics() end)
local userDefault = cc.UserDefault:getInstance()
local scheduler = cc.Director:getInstance():getScheduler()
function GameScene:create()
	local scene = GameScene:new()
	scene:getPhysicsWorld():setGravity(cc.p(0,0))
	-- scene:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
	return scene
end

function GameScene:ctor()
	local function onNodeEvent(eventType)
		if eventType == "enter" then
			print("======GameScene======enter")
			self:addChild(self:createLayer())
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
	layer:addChild(enemy1)

	local enemy2 = require("sprite.Enemy"):create(EnemyAtt.plane2)
	layer:addChild(enemy2)

	local enemy3 = require("sprite.Enemy"):create(EnemyAtt.planet1)
	layer:addChild(enemy3)

	local enemy4 = require("sprite.Enemy"):create(EnemyAtt.planet2)
	layer:addChild(enemy4)

	local myHero = require("sprite.MyHero"):create(FightAtt.hero1)
	layer:addChild(myHero)

	local bulletObj = require("sprite.Bullet")
	local function shootBullet(delta)
		local bullet = bulletObj:create(BulletAtt.bullet1)
		bullet:setPosition(cc.p(myHero:getPosition()))
		layer:addChild(bullet, 10)

		bullet:shootBulletFromMyHero()
	end

	self.scheduleId = scheduler:scheduleScriptFunc(shootBullet, 2, false)


	local function onTouchBegan(touch, eventType)
		local node = eventType:getCurrentTarget()
		local poTmp = touch:getLocation()
		local po = node:convertToNodeSpace(poTmp)
		local nodeSize = node:getContentSize()
		local rect = cc.rect(0, 0, nodeSize.width, nodeSize.height)
		if cc.rectContainsPoint(rect, po) then
			return true
		end
		return false
	end

	local function onTouchMoved(touch, eventType)
		local node = eventType:getCurrentTarget()
		local x, y = node:getPosition() 
		local diff = touch:getDelta()
		node:setPo(x + diff.x, y + diff.y)
	end

	local listener = cc.EventListenerTouchOneByOne:create()
	listener:setSwallowTouches(true)
	listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)

	local function onContact(contact)
		local spa = contact:getShapeA():getBody():getNode()
		local spb = contact:getShapeB():getBody():getNode()

		local enemy = spa.nodeType == NodeType.enemy and spa or spb
		local hero = spa.nodeType == NodeType.hero or spb.nodeType == NodeType.hero
		local bullet = spa.nodeType == NodeType.bullet or spb.nodeType == NodeType.bullet

		if bullet and not bullet:isVisible() then
			enemy:spawn()
		end
		if hero then
			print("--------heroheroheroheroherohero")
			-- self:updateHero()
		else
			print("--------bulletbulletbulletbulletbullet")
			-- self:updateScore()
		end
		return false
	end

	local contactListener = cc.EventListenerPhysicsContact:create()
	contactListener:registerScriptHandler(onContact, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)

	local dispatcher = cc.Director:getInstance():getEventDispatcher()
	dispatcher:addEventListenerWithSceneGraphPriority(listener, myHero)
	dispatcher:addEventListenerWithSceneGraphPriority(contactListener, self)


	return layer
end

return GameScene