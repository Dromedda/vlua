local scene_test = {}
    
    scene_test.init = function()
    	local a = 2
    	if a ~= 1 then 
    		print("A IS NOT 1")
    	end
    
    	local var1 = 12312
    	print(var1 * 2)
    	print("HI MOM!")
    end
    
    function scream() 
    	print("AHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
    end
    
    scene_test.init()
    scream()
    return scene_test
    