local GameScene = class("GameScene", function() return cc.Scene:createWithPhysics() end)
local userDefault = cc.UserDefault:getInstance()
local scheduler = cc.Director:getInstance():getScheduler()

local sumScore
local lifeScore
function GameScene:create()
	local scene = GameScene:new()
	scene:setTag(99999)
	scene:getPhysicsWorld():setGravity(cc.p(0,0))
	-- scene:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
	return scene
end

function GameScene:ctor()
	local function onNodeEvent(eventType)
		if eventType == "enter" then
			dump(self:getPhysicsWorld():getAllBodies())
			print("======GameScene======enter")
			sumScore = 0
			lifeScore = 0
			self:addChild(self:createLayer())
		elseif eventType == "enterTransitionFinish" then
			print("======GameScene======enterTransitionFinish")
			if userDefault:getBoolForKey(MUSICKEY, true) then
				AudioEngine.playMusic(gameMusic, true)
			end
		elseif eventType == "exitTransitionStart" then
			print("======GameScene======exitTransitionStart")
			scheduler:unscheduleScriptEntry(self.scheduleId)
			local dispatcher = director:getEventDispatcher()
			dispatcher:removeEventListener(self.touchListener)
			dispatcher:removeEventListener(self.contactListener)
			self.layer:removeAllChildren()
			self.layer:removeFromParentAndCleanup(true)
			self.layer = nil
		elseif eventType == "exit" then
			print("======GameScene======exit")
		elseif eventType == "cleanup" then
			print("======GameScene======cleanup")
		end
	end
	self:registerScriptHandler(onNodeEvent)
end

function GameScene:createLayer()
	local layer = cc.Layer:create()
	self.layer = layer
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

	self.hero = myHero

	self.heroLifeTxt = ccui.Text:create("HP:" .. self.hero.HP, "fonts/hanyi.ttf", 30)
	self.heroLifeTxt:setPosition(cc.p(winSize.width, winSize.height - self.heroLifeTxt:getContentSize().height/2))
	self.heroLifeTxt:setAnchorPoint(1, 0.5)
	layer:addChild(self.heroLifeTxt)

	self.sumScoreTxt = ccui.Text:create(sumScore, "fonts/hanyi.ttf", 30)
	self.sumScoreTxt:setPosition(cc.p(winSize.width/2, winSize.height - self.sumScoreTxt:getContentSize().height/2))
	layer:addChild(self.sumScoreTxt)

	local bulletObj = require("sprite.Bullet")
	local function shootBullet(delta)
		local bullet = bulletObj:create(BulletAtt.bullet1)
		bullet:setPosition(cc.p(myHero:getPosition()))
		layer:addChild(bullet)

		bullet:shootBulletFromMyHero()
	end

	self.scheduleId = scheduler:scheduleScriptFunc(shootBullet, 0.1, false)


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

	local touchListener = cc.EventListenerTouchOneByOne:create()
	touchListener:setSwallowTouches(true)
	touchListener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	touchListener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
	self.touchListener = touchListener

	local function onContact(contact)
		local spa = contact:getShapeA():getBody():getNode()
		local spb = contact:getShapeB():getBody():getNode()
		local tmpTable = {}
		table.insert(tmpTable, spa)
		table.insert(tmpTable, spb)
		local enemy = spa.nodeType == NodeType.enemy and spa or spb

		for i, v in pairs(tmpTable) do
			if v == enemy then
				table.remove(tmpTable, i)
				break
			end
		end

		if tmpTable[1].nodeType == NodeType.hero then
			self:enemyContactHero(enemy)
		else
			self:enemyContactBullet(enemy, tmpTable[1])
		end
		
		return false
	end

	local contactListener = cc.EventListenerPhysicsContact:create()
	contactListener:registerScriptHandler(onContact, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
	self.contactListener = contactListener

	local dispatcher = cc.Director:getInstance():getEventDispatcher()
	dispatcher:addEventListenerWithSceneGraphPriority(touchListener, myHero)
	dispatcher:addEventListenerWithSceneGraphPriority(contactListener, self)

	local function onPause()
		if cc.UserDefault:getInstance():getBoolForKey(SOUNDKEY, true) then
			AudioEngine.playEffect(sound1)
		end
		for i, v in pairs(layer:getChildren()) do
			v:pause()
		end
		scheduler:unscheduleScriptEntry(self.scheduleId)

		local function onClick(sender)
		if cc.UserDefault:getInstance():getBoolForKey(SOUNDKEY, true) then
			AudioEngine.playEffect(sound1)
		end
			if sender:getTag() == GameBtnType.resume then
				layer:removeChildByTag(GameBtnType.resume)
				layer:removeChildByTag(GameBtnType.backHome)
				for i, v in pairs(layer:getChildren()) do
					v:resume()
				end
				self.scheduleId = scheduler:scheduleScriptFunc(shootBullet, 0.1, false)
			else
				director:popScene()
			end
		end
		local resumeBtn = ccui.Button:create()
		resumeBtn:loadTextures("button.resume.png", "button.resume-on.png", "", ccui.TextureResType.plistType)
		resumeBtn:setPosition(cc.p(winSize.width/2, winSize.height/2 + 30))
		resumeBtn:setTag(GameBtnType.resume)
		resumeBtn:addClickEventListener(onClick)
		layer:addChild(resumeBtn)

		local backHomeBtn = ccui.Button:create()
		backHomeBtn:loadTextures("button.back.png", "button.back-on.png", "", ccui.TextureResType.plistType)
		backHomeBtn:setPosition(cc.p(winSize.width/2, winSize.height/2 - 30))
		backHomeBtn:setTag(GameBtnType.backHome)
		backHomeBtn:addClickEventListener(onClick)
		layer:addChild(backHomeBtn)
	end

	local pauseBtn = ccui.Button:create()
	pauseBtn:loadTextures("button.pause.png", "button.pause.png", "", ccui.TextureResType.plistType)
	pauseBtn:setPosition(cc.p(pauseBtn:getContentSize().width/2, winSize.height - pauseBtn:getContentSize().height/2))
	pauseBtn:addClickEventListener(onPause)
	layer:addChild(pauseBtn)

	return layer
end

function GameScene:createExplosion(node)
	if self:getChildByTag(NodeType.explosion) then
		self:removeChildByTag(NodeType.explosion)
	end
	local explosion = cc.ParticleSystemQuad:create("particle/explosion.plist")
	explosion:setPosition(cc.p(node:getPosition()))
	explosion:setTag(NodeType.explosion)
	self:addChild(explosion)
end

function GameScene:enemyContactHero(enemy)
	self:createExplosion(self.hero)
	enemy:spawn()
	self.hero:spawn()
	self.hero.HP = self.hero.HP - 1
	if self.hero.HP <= 0 then
		if cc.FileUtils:getInstance():isFileExist("GameOver.lua") then
			local record = cc.UserDefault:getInstance():getIntegerForKey("record", 0)
			if sumScore > record then
				cc.UserDefault:getInstance():setIntegerForKey("record", sumScore)
			end
			cc.Director:getInstance():pushScene(require("GameOver"):create())
		end
	end
	self.heroLifeTxt:setString("HP:" .. self.hero.HP)
end

function GameScene:enemyContactBullet(enemy, bullet)
	bullet:removeFromWorld()
	enemy.initHP = enemy.initHP - 1
	enemy.hpLoadingBar:setPercent(enemy.initHP / enemy.HP * 100)
	if enemy.initHP <= 0 then
		self:createExplosion(enemy)
		self:updateScoreAndLife(enemy)
		enemy:spawn()
	end
end

function GameScene:updateScoreAndLife(enemy)
	sumScore = sumScore + enemy.score
	lifeScore = lifeScore + enemy.score
	if lifeScore >= 100 then
		self.hero.HP = self.hero.HP + 1
		lifeScore = lifeScore % 100
		self.heroLifeTxt:setString("HP:" .. self.hero.HP)
	end
	self.sumScoreTxt:setString(sumScore)

	local scoreTxt = ccui.Text:create("+" .. enemy.score, "fonts/hanyi.ttf", 30)
	scoreTxt:setPosition(cc.p(enemy:getPosition()))
	self:addChild(scoreTxt)
	local function destroySelf(node) node:removeFromParentAndCleanup() end
	local seq = cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.5, cc.p(0, 30)), cc.FadeOut:create(1)), cc.CallFunc:create(destroySelf))
	scoreTxt:runAction(seq)
end
return GameScene