-- cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("/src")
cc.FileUtils:getInstance():addSearchPath("/res")
-- require "config"
require "cocos.init"
-- local print = release_print

local function main()
    collectgarbage("collect")
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    local director = cc.Director:getInstance()
    local glView = director:getOpenGLView()
    local designSize = {width = 320, height = 568}
    local smallResSize = {width = 640, height = 1136}
    local largeResSize = {width = 750, height = 1334}
    local frameSize = glView:getFrameSize()

    local searchPaths = cc.FileUtils:getInstance():getSearchPaths()
    if frameSize.height > smallResSize.height then
        table.insert(searchPaths, "res/large")
        director:setContentScaleFactor(math.min(largeResSize.height / designSize.height, largeResSize.width / designSize.width))
    else
        table.insert(searchPaths, "res/small")
        director:setContentScaleFactor(math.min(smallResSize.height / designSize.height, smallResSize.width / designSize.width))
    end 

    cc.FileUtils:getInstance():setSearchPaths(searchPaths)
    director:getOpenGLView():setDesignResolutionSize(designSize.width, designSize.height, cc.ResolutionPolicy.FIXED_WIDTH)
    director:setDisplayStats(true)
    director:setAnimationInterval(1.0 / 60)
    local scene = require("LoadingScene")
    local LoadingScene = scene.create()
    if cc.Director:getInstance():getRunningScene() then
    	cc.Director:getInstance():replaceScene(LoadingScene)
    else
    	cc.Director:getInstance():runWithScene(LoadingScene)
    end
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
