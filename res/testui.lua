--------------------------------------------------------------
-- This file was automatically generated by Cocos Studio.
-- Do not make changes to this file.
-- All changes will be lost.
--------------------------------------------------------------

local luaExtend = require "LuaExtend"

-- using for layout to decrease count of local variables
local layout = nil
local localLuaFile = nil
local innerCSD = nil
local innerProject = nil
local localFrame = nil

local Result = {}
------------------------------------------------------------
-- function call description
-- create function caller should provide a function to 
-- get a callback function in creating scene process.
-- the returned callback function will be registered to 
-- the callback event of the control.
-- the function provider is as below :
-- Callback callBackProvider(luaFileName, node, callbackName)
-- parameter description:
-- luaFileName  : a string, lua file name
-- node         : a Node, event source
-- callbackName : a string, callback function name
-- the return value is a callback function
------------------------------------------------------------
function Result.create(callBackProvider)

local result={}
setmetatable(result, luaExtend)

--Create Node
local Node=cc.Node:create()
Node:setName("Node")

--Create box
local box=cc.Node:create()
box:setName("box")
box:setTag(32)
box:setCascadeColorEnabled(true)
box:setCascadeOpacityEnabled(true)
layout = ccui.LayoutComponent:bindLayoutComponent(box)
Node:addChild(box)

--Create t1
local t1 = ccui.Layout:create()
t1:ignoreContentAdaptWithSize(false)
t1:setClippingEnabled(false)
t1:setBackGroundColorType(1)
t1:setBackGroundColor({r = 150, g = 200, b = 255})
t1:setTouchEnabled(true);
t1:setLayoutComponentEnabled(true)
t1:setName("t1")
t1:setTag(34)
t1:setCascadeColorEnabled(true)
t1:setCascadeOpacityEnabled(true)
t1:setPosition(-48.9012, 168.5061)
t1:setColor({r = 255, g = 0, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(t1)
layout:setSize({width = 100.0000, height = 100.0000})
layout:setLeftMargin(-48.9012)
layout:setRightMargin(-51.0988)
layout:setTopMargin(-268.5061)
layout:setBottomMargin(168.5061)
box:addChild(t1)

--Create Text_10
local Text_10 = ccui.Text:create()
Text_10:ignoreContentAdaptWithSize(true)
Text_10:setTextAreaSize({width = 0, height = 0})
Text_10:setFontSize(20)
Text_10:setString([[1]])
Text_10:setLayoutComponentEnabled(true)
Text_10:setName("Text_10")
Text_10:setTag(909)
Text_10:setCascadeColorEnabled(true)
Text_10:setCascadeOpacityEnabled(true)
Text_10:setPosition(46.6228, 53.4050)
Text_10:setTextColor({r = 0, g = 0, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(Text_10)
layout:setPositionPercentX(0.4662)
layout:setPositionPercentY(0.5340)
layout:setPercentWidth(0.1000)
layout:setPercentHeight(0.2000)
layout:setSize({width = 10.0000, height = 20.0000})
layout:setLeftMargin(41.6228)
layout:setRightMargin(48.3772)
layout:setTopMargin(36.5950)
layout:setBottomMargin(43.4050)
t1:addChild(Text_10)

--Create t2
local t2 = ccui.Layout:create()
t2:ignoreContentAdaptWithSize(false)
t2:setClippingEnabled(false)
t2:setBackGroundColorType(1)
t2:setBackGroundColor({r = 150, g = 200, b = 255})
t2:setTouchEnabled(true);
t2:setLayoutComponentEnabled(true)
t2:setName("t2")
t2:setTag(35)
t2:setCascadeColorEnabled(true)
t2:setCascadeOpacityEnabled(true)
t2:setPosition(-48.9012, 58.3120)
t2:setColor({r = 0, g = 128, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(t2)
layout:setSize({width = 100.0000, height = 100.0000})
layout:setLeftMargin(-48.9012)
layout:setRightMargin(-51.0988)
layout:setTopMargin(-158.3120)
layout:setBottomMargin(58.3120)
box:addChild(t2)

--Create Text_11
local Text_11 = ccui.Text:create()
Text_11:ignoreContentAdaptWithSize(true)
Text_11:setTextAreaSize({width = 0, height = 0})
Text_11:setFontSize(20)
Text_11:setString([[2]])
Text_11:setLayoutComponentEnabled(true)
Text_11:setName("Text_11")
Text_11:setTag(910)
Text_11:setCascadeColorEnabled(true)
Text_11:setCascadeOpacityEnabled(true)
Text_11:setPosition(46.6228, 53.4036)
Text_11:setTextColor({r = 0, g = 0, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(Text_11)
layout:setPositionPercentX(0.4662)
layout:setPositionPercentY(0.5340)
layout:setPercentWidth(0.1000)
layout:setPercentHeight(0.2000)
layout:setSize({width = 10.0000, height = 20.0000})
layout:setLeftMargin(41.6228)
layout:setRightMargin(48.3772)
layout:setTopMargin(36.5964)
layout:setBottomMargin(43.4036)
t2:addChild(Text_11)

--Create t3
local t3 = ccui.Layout:create()
t3:ignoreContentAdaptWithSize(false)
t3:setClippingEnabled(false)
t3:setBackGroundColorType(1)
t3:setBackGroundColor({r = 150, g = 200, b = 255})
t3:setTouchEnabled(true);
t3:setLayoutComponentEnabled(true)
t3:setName("t3")
t3:setTag(36)
t3:setCascadeColorEnabled(true)
t3:setCascadeOpacityEnabled(true)
t3:setPosition(-48.9012, -51.8822)
t3:setColor({r = 255, g = 255, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(t3)
layout:setSize({width = 100.0000, height = 100.0000})
layout:setLeftMargin(-48.9012)
layout:setRightMargin(-51.0988)
layout:setTopMargin(-48.1178)
layout:setBottomMargin(-51.8822)
box:addChild(t3)

--Create Text_12
local Text_12 = ccui.Text:create()
Text_12:ignoreContentAdaptWithSize(true)
Text_12:setTextAreaSize({width = 0, height = 0})
Text_12:setFontSize(20)
Text_12:setString([[3]])
Text_12:setLayoutComponentEnabled(true)
Text_12:setName("Text_12")
Text_12:setTag(911)
Text_12:setCascadeColorEnabled(true)
Text_12:setCascadeOpacityEnabled(true)
Text_12:setPosition(46.6228, 53.4051)
Text_12:setTextColor({r = 0, g = 0, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(Text_12)
layout:setPositionPercentX(0.4662)
layout:setPositionPercentY(0.5341)
layout:setPercentWidth(0.1000)
layout:setPercentHeight(0.2000)
layout:setSize({width = 10.0000, height = 20.0000})
layout:setLeftMargin(41.6228)
layout:setRightMargin(48.3772)
layout:setTopMargin(36.5949)
layout:setBottomMargin(43.4051)
t3:addChild(Text_12)

--Create t4
local t4 = ccui.Layout:create()
t4:ignoreContentAdaptWithSize(false)
t4:setClippingEnabled(false)
t4:setBackGroundColorType(1)
t4:setBackGroundColor({r = 150, g = 200, b = 255})
t4:setTouchEnabled(true);
t4:setLayoutComponentEnabled(true)
t4:setName("t4")
t4:setTag(37)
t4:setCascadeColorEnabled(true)
t4:setCascadeOpacityEnabled(true)
t4:setPosition(-48.9012, -162.0768)
layout = ccui.LayoutComponent:bindLayoutComponent(t4)
layout:setSize({width = 100.0000, height = 100.0000})
layout:setLeftMargin(-48.9012)
layout:setRightMargin(-51.0988)
layout:setTopMargin(62.0768)
layout:setBottomMargin(-162.0768)
box:addChild(t4)

--Create Text_13
local Text_13 = ccui.Text:create()
Text_13:ignoreContentAdaptWithSize(true)
Text_13:setTextAreaSize({width = 0, height = 0})
Text_13:setFontSize(20)
Text_13:setString([[4]])
Text_13:setLayoutComponentEnabled(true)
Text_13:setName("Text_13")
Text_13:setTag(912)
Text_13:setCascadeColorEnabled(true)
Text_13:setCascadeOpacityEnabled(true)
Text_13:setPosition(46.6228, 53.4058)
Text_13:setTextColor({r = 0, g = 0, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(Text_13)
layout:setPositionPercentX(0.4662)
layout:setPositionPercentY(0.5341)
layout:setPercentWidth(0.1000)
layout:setPercentHeight(0.2000)
layout:setSize({width = 10.0000, height = 20.0000})
layout:setLeftMargin(41.6228)
layout:setRightMargin(48.3772)
layout:setTopMargin(36.5942)
layout:setBottomMargin(43.4058)
t4:addChild(Text_13)

--Create t5
local t5 = ccui.Layout:create()
t5:ignoreContentAdaptWithSize(false)
t5:setClippingEnabled(false)
t5:setBackGroundColorType(1)
t5:setBackGroundColor({r = 150, g = 200, b = 255})
t5:setTouchEnabled(true);
t5:setLayoutComponentEnabled(true)
t5:setName("t5")
t5:setTag(38)
t5:setCascadeColorEnabled(true)
t5:setCascadeOpacityEnabled(true)
t5:setPosition(-48.9012, -272.2709)
t5:setColor({r = 128, g = 0, b = 128})
layout = ccui.LayoutComponent:bindLayoutComponent(t5)
layout:setSize({width = 100.0000, height = 100.0000})
layout:setLeftMargin(-48.9012)
layout:setRightMargin(-51.0988)
layout:setTopMargin(172.2709)
layout:setBottomMargin(-272.2709)
box:addChild(t5)

--Create Text_14
local Text_14 = ccui.Text:create()
Text_14:ignoreContentAdaptWithSize(true)
Text_14:setTextAreaSize({width = 0, height = 0})
Text_14:setFontSize(20)
Text_14:setString([[5]])
Text_14:setLayoutComponentEnabled(true)
Text_14:setName("Text_14")
Text_14:setTag(913)
Text_14:setCascadeColorEnabled(true)
Text_14:setCascadeOpacityEnabled(true)
Text_14:setPosition(46.6211, 53.4056)
Text_14:setTextColor({r = 0, g = 0, b = 0})
layout = ccui.LayoutComponent:bindLayoutComponent(Text_14)
layout:setPositionPercentX(0.4662)
layout:setPositionPercentY(0.5341)
layout:setPercentWidth(0.1000)
layout:setPercentHeight(0.2000)
layout:setSize({width = 10.0000, height = 20.0000})
layout:setLeftMargin(41.6211)
layout:setRightMargin(48.3789)
layout:setTopMargin(36.5944)
layout:setBottomMargin(43.4056)
t5:addChild(Text_14)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Node
return result;
end

return Result

