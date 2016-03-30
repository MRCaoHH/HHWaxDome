require "wax"

local  vc = HHTestWaxViewController:init()
local  nav = UIApplication:sharedApplication():keyWindow():rootViewController()
nav:pushViewController_animated(vc,true)