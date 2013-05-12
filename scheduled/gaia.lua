require("base.common")

module("scheduled.gaia", package.seeall)

-- INSERT INTO scheduledscripts VALUES('scheduled.gaia', 10, 10, 'plantdrop');


function Init()
    
	RarePlantByGround = {}
	NormalPlantByGround = {}
    
	local gt = base.common.GroundType
	
	-- normal herbs; collectable with sickle
	AddPlant(144, {gt.rocks},false)                         -- virgins weed
    AddPlant(137, {gt.sand},false)                          -- flamegoblet blossom
    AddPlant(135, {gt.grass},false)                         -- yellow weed
    AddPlant(148, {gt.forest},false)                        -- firnis blossom
    AddPlant(763, {gt.dirt},false)                          -- mash flower
    AddPlant(767, {gt.water},false)                          -- water blossom
	AddPlant(140, {gt.forest},false)                        -- donf blade
    AddPlant(156, {gt.sand},false)                          -- steppe fern
    AddPlant(153, {gt.grass},false)                         -- foot leaf
    AddPlant(752, {gt.rock},false)                         -- mandrake
	AddPlant(147, {gt.forest},false)                       -- blackberry
    AddPlant(142, {gt.sand},false)                         -- sandberry
    AddPlant(143, {gt.grass},false)                         -- red elder
    AddPlant(136, {gt.dirt},false)                          -- anger berry
    AddPlant(134, {gt.grass},false)                         -- fourleafed oneberry
    AddPlant(155, {gt.water},false)                         -- sibanac leaf
    AddPlant(151, {gt.forest},false)                        -- strawberry
    AddPlant(141, {gt.rocks},false)                         -- black thistle
    AddPlant(145, {gt.grass},false)                         -- heath flower
    AddPlant(151, {gt.forest},false)                        -- strawberry
    AddPlant(141, {gt.rocks},false)                         -- black thistle
    AddPlant(133, {gt.grass},false)                         -- sun herb
    AddPlant(753, {gt.grass,gt.forest},false)              -- blue bird's berry
    AddPlant(159, {gt.forest},false)						-- toadstool
    AddPlant(160, {gt.forest},false)						-- red head
    AddPlant(161, {gt.grass},false)						-- herder's mushroom
    AddPlant(162, {gt.grass},false)						-- birth mushroom
    AddPlant(163, {gt.forest},false)						-- champignon
	
	-- rar herbs; not collectable with sickle
    AddPlant(138, {gt.dirt},true)                        -- night angels blossom
	AddPlant(146, {gt.sand},true)                        -- deser sky capsule
	AddPlant(152, {gt.forest},true)                      -- life root
	AddPlant(754, {gt.grass},true)                          -- oneleaved fourberry
	AddPlant(755, {gt.rocks},true)                        -- fire root
	AddPlant(756, {gt.grass},true)                       -- pious berry
	AddPlant(757, {gt.forest},true)                        -- tybalt star
	AddPlant(758, {gt.rocks},true)                        -- heart blood
	AddPlant(760, {gt.snow},true)                        -- ice leaf
	AddPlant(761, {gt.grass},true)                        -- rain weed
	AddPlant(762, {gt.rocks},true)                        -- gold crack herb
	AddPlant(764, {gt.forest},true)                        -- dark moos
	AddPlant(765, {gt.forest},true)                        -- day tream
	AddPlant(766, {gt.forest},true)                        -- con blossom
	AddPlant(768, {gt.forest},true)                        -- wolverine fern
	AddPlant(769, {gt.sand},true)                         -- desert berry
end

function AddPlant(ItemID, Grounds, rare)
    if rare then
        for i=1, #Grounds do
            if RarePlantByGround[Grounds[i]] == nil then
				RarePlantByGround[Grounds[i]] = {}
			end
            table.insert(RarePlantByGround[Grounds[i]], ItemID);
		end
    else
        for i=1, #Grounds do
			if NormalPlantByGround[Grounds[i]] == nil then
				NormalPlantByGround[Grounds[i]] = {}
			end
            table.insert(NormalPlantByGround[Grounds[i]], ItemID);
		end
    end
end

function plantdrop()
    if ( RarePlantByGround==nil ) then
        Init();
    end

	local herbCounter = 0 -- for testing
	local normal = 0; local cool = 0
	for i=1,35 do -- normal plants
	   PutPlantOnField(false)
	end
    
	for i=1,10 do -- rare plants
	   PutPlantOnField(true)
	end
end

function PutPlantOnField(rare)

    local myPos = position( math.random(0,1024), math.random(0,1024), 0 )
	local theTile=world:getField(myPos);
	local myList
	if rare then -- rare herb
	    myList = RarePlantByGround
	else -- normal herb
        myList = NormalPlantByGround
    end	
	if theTile then
		local groundType = base.common.GetGroundType( theTile:tile() )
		local gt = base.common.GroundType
		
		if theTile:countItems() > 0 then -- check if no item is on that field
		    return
		end	
		if myList[groundType] == nil then -- check if this ground has any herbs
		    return
		end
		if (groundType == gt.sand) then
		    if not math.random(3)==1 then -- "Frickelfactor" for sand herbs (we have too many sand fields!)
			    return
			end	
        elseif (groundType == gt.grass or groundType == gt.forest) then
		    if not math.random(2)==1 then -- "Frickelfactor" for grass and forest herbs (we have slightly too many fields of those)
			    return
			end	
        end
		
		myPlant = myList[groundType][math.random(1,#myList[groundType])]
		world:createItemFromId(myPlant,1,myPos,false,333,nil)
		return true
	end
end