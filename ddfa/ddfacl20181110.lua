
--require "defines.lua"
-- Citizen.CreateThread(function()

    -- local mht=1;
    -- local coordinatearray[mht]={
    -- {x=-119.616,y=-1576.976,z=34.1848,sprite=351,name="Steal drugs",wanted=2,money=2500,enemies=3},
    -- {x=-334.763,y=-1317.364,z=31.4004,sprite=351,name="Steal drugs",wanted=2,money=9000,enemies=5},
    -- {x=271.251,y=-1737.183,z=35.2965,sprite=351,name="Steal diamonds",wanted=4,money=25000,enemies=1}
    -- {x=-129.715,y=-1421.568,z=31.3002,sprite=351,name="Steal documents",wanted=3,money=15000,enemies=7}
    -- };
    -- local blip=0;
    
    -- while true do
      -- ---create new heist
        -- local heisttype=math.random(mht);
        -- local heist_pos=coordinatearray[heisttype];
        -- local heist_money=9000;
        
        -- if blip==0 then
         -- blip=AddBlipForCoord(heist_pos.x,heist_pos.y,heist_pos.z);
        -- else
         -- SetBlipCoords(blip,heist_pos.x,heist_pos.y,heist_pos.z);
         
        -- SetBlipSprite(blip, heist_pos.sprite);
        -- SetBlipDisplay(blip, 2);
        -- SetBlipScale(blip, 1.0)
        -- SetBlipAsShortRange(info.blip, false)
        -- SetBlipColour(blip, 2);
        -- BeginTextCommandSetBlipName("STRING")
        -- AddTextComponentString(heist_pos.name)
        -- EndTextCommandSetBlipName(blip)
      -- ---heist in progress
        -- while heist_money>0 do
            -- for i = 0, 31 do
             -- if NetworkIsPlayerActive(i) then
                    -- SetNotificationTextEntry("STRING");
                    -- AddTextComponentString("testmessage");
                    -- SetNotificationMessage("CHAR_STRIPPER_CHEETAH", "CHAR_STRIPPER_INFERNUS", false, 1, "test", "coords");
                    -- DrawNotification(false, false);
             -- end
            -- end
            -- heist_money=heist_money-1000;
            -- Wait(1000);
        -- end
      -- ---heist ended
        -- SetBlipSprite(blip, 406);
        -- Wait(30000);
    -- end
    
-- end);

local forced_max_health=200

local special_abilities={
    none=function() Wait(3000) end,
}
local player={
    civilian=false,
    is_cop=false,
    surrendering=true,
    money=0,
    wanted=0,
    is_dead=false,
    inside=false,
    in_apartment=false,
    special_ability=special_abilities.none,
    special_ability_amount=0,
    special_ability_timeleft=0,
    showbusmenu=false,
    callingpolice=false,
}
local vehiclewhitelist=nil
local basecoords={x=441.19030761719,y=-981.13079833984,z=30.689605712891}
local debug_mode=false
local money_drops={}
local money_blips={}
local money_bags={}
local pos
local relationship_enemy=GetHashKey("PRISONER")
local relationship_friend=GetHashKey("PLAYER")

local decor={}
decor.corpseremovaltimestamp="CorpseRemovalTimestamp"
decor.dontchangemodel="DontChangeModel"
decor.customdispatchtimestamp="CustomDispatchTimestamp"
decor.civilianbecamecriminal="CivBecameCriminal"
decor.teamkiller_punished="TeamkillerPunished"
decor.garbage_bag="GarbageBagHash"
DecorRegister(decor.customdispatchtimestamp,5)
DecorRegister(decor.dontchangemodel,2)
DecorRegister(decor.corpseremovaltimestamp,5)
DecorRegister("interiorhash",3)
DecorRegister("partynumber",3)
DecorRegister("partycolor",3)
DecorRegister("party_x",3)
DecorRegister("party_y",3)
DecorRegister("party_z",3)
DecorRegister(decor.civilianbecamecriminal,2)
DecorRegister(decor.teamkiller_punished,2)
DecorRegister("cpr",3)
DecorRegister("time_of_death_recorded",3)
DecorRegister(decor.garbage_bag,3)

--NetworkEarnFromNotBadsport(2000)
 -- NetworkSetFriendlyFireOption(true)
 -- SetCanAttackFriendly(PlayerPedId(), true, false)
 
      -- SetNotificationTextEntry("STRING");
      -- AddTextComponentString(GetRelationshipBetweenGroups(relationship_friend, relationship_friend));
      -- SetNotificationMessage("CHAR_LESTER", "CHAR_LESTER", false, 1, "Relationship", "Before");
      -- DrawNotification(false, false);
--Citizen.Wait(1000)
--TriggerServerEvent('_chat:messageEntered', "Rel before", {255,128,128}, "ationship="..GetRelationshipBetweenGroups(relationship_friend, relationship_friend))
--ClearRelationshipBetweenGroups(0, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(1, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(2, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(3, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(4, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(5, relationship_friend, relationship_friend)
--ClearRelationshipBetweenGroups(255, relationship_friend, relationship_friend)
--SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), relationship_friend)
--SetRelationshipBetweenGroups(5, relationship_friend, GetHashKey('PLAYER'))
      -- SetNotificationTextEntry("STRING");
      -- AddTextComponentString(GetRelationshipBetweenGroups(relationship_friend, relationship_friend));
      -- SetNotificationMessage("CHAR_LESTER", "CHAR_LESTER", false, 1, "Relationship", "After");
      -- DrawNotification(false, false);
--TriggerServerEvent('_chat:messageEntered', "Rel after", {255,128,128}, "ationship="..GetRelationshipBetweenGroups(relationship_friend, relationship_friend))
    --int GET_RELATIONSHIP_BETWEEN_GROUPS(Hash group1, Hash group2);
    --void SET_RELATIONSHIP_BETWEEN_GROUPS(int relationship, Hash group1, Hash group2);
local mycar={}
local mycar_old={}
local rentcar={}
local enemies={}
local friends={}
--local jail_pos={x=1655.9542236328,y=2544.7395019531,z=45.564891815186}
local spawn_point=nil

local garages_enabled=true
local garages={
    {x=-1039.685546,y=-412.2041320800,z=33.27317810058,angle=21.64019203186,radius=16},
    {x=-1043.722778,y=-403.6976623535,z=33.27317810058,angle=205.1398315429,radius=16},
    {x=-1037.418823,y=-399.1575927734,z=33.27317810058,angle=204.7279205322,radius=16},
    {x=-1033.457275,y=-406.8182678222,z=33.27318191528,angle=26.94477653503,radius=16},
    {x=-1398.044555,y=-461.5809326171,z=34.47920227050,angle=11.11164569854,radius=16},
    {x=-1409.498413,y=-459.4078063964,z=34.48365020752,angle=213.3029479980,radius=16},
    {x=-1443.468017,y=-523.6984863281,z=31.58182525634,angle=31.02633476257,radius=16},
    {x=-1446.421875,y=-519.0927124023,z=31.58182525634,angle=33.07036972045,radius=16},
    {x=-1449.182861,y=-514.4866333007,z=31.58182525634,angle=30.47829246521,radius=16},
    {x=-1538.055541,y=-576.7301635742,z=25.70781898498,angle=31.74063491821,radius=16},
    {x=-833.9008789,y=-400.1473693847,z=30.70482826232,angle=294.7731933593,radius=16},
    {x=-835.4608764,y=-395.6582946777,z=30.70537567138,angle=295.4821166992,radius=16},
    {x=-839.2616577,y=-391.5639343261,z=30.70547485351,angle=295.3235778808,radius=16},
    {x=-185.8487701,y=166.23648071289,z=69.70829772949,angle=84.55401611328,radius=16},
    {x=-184.9401092,y=171.38264465332,z=69.70859527587,angle=86.48316955566,radius=16},
    {x=-187.4133300,y=144.57749938965,z=69.70964813232,angle=163.0818023681,radius=16},
    {x=-144.5423736,y=-577.6981201171,z=31.80375671386,angle=161.1910552978,radius=16},
    {x=-20.22202682,y=-705.7244262695,z=31.71716499328,angle=342.9769287109,radius=16},
    {x=-36.26410675,y=-700.7737426757,z=31.71798515319,angle=341.0366210937,radius=16},
    {x=-4.271838188,y=-711.8181762695,z=31.71798896789,angle=338.9836120605,radius=16},
    {x=255.88787841,y=-751.6263427734,z=30.20108985900,angle=71.71109771728,radius=16},
    {x=155.72358703,y=-692.1958618164,z=32.50947189331,angle=158.1769714355,radius=16},
    {x=168.42227172,y=-698.0588989257,z=32.50762939453,angle=163.1546478271,radius=16},
    {x=371.42916870,y=-1651.860839843,z=26.67752075195,angle=138.9389038085,radius=16},
    {x=364.21832275,y=-1683.089599609,z=26.68415260314,angle=138.7008514404,radius=16},
    {x=393.04489135,y=-1670.743286132,z=26.69096946716,angle=137.1209716796,radius=16},
    {x=520.65783691,y=168.94683837891,z=98.74963378906,angle=250.6946868896,radius=16},
    {x=-1379.385498,y=-474.6076660156,z=31.28181838989,angle=99.054794311523,radius=16},
    {x=-29.67472458,y=3.541065454483,z=70.656951904297,angle=159.71878051758,radius=16}, 
    {x=79.461723327637,y=-2533.6181640625,z=6.2260570526123,angle=209.33934020996,radius=9}, --truck 1 , 2 , 3 not 4 and 5
    {x=75.011390686035,y=-2539.6477050781,z=6.2269997596741,angle=209.05969238281,radius=9},
    {x=77.192329406738,y=-2536.3874511719,z=6.2266731262207,angle=209.86859130859,radius=9},
    {x=139.22319030762,y=-2536.3791503906,z=6.2258954048157,angle=205.90068054199,radius=9},
    {x=143.77529907227,y=-2498.9580078125,z=6.2272624969482,angle=235.09417724609,radius=9},
    {x=139.51182556152,y=-2448.6220703125,z=6.2255501747131,angle=300.40008544922,radius=9}, --truck1
    {x=146.34170532227,y=-2496.169921875,z=6.2246561050415,angle=234.27124023438,radius=9}, --truck2
    {x=148.25201416016,y=-2492.4084472656,z=6.2231516838074,angle=234.32827758789,radius=9},    --truck3
    {x=-1269.5834960938,y=-3377.4714355469,z=14.0,angle=330,radius=36}, --hangar1
    {x=-1647.2069091797,y=-3134.2456054688,z=14.0,angle=330,radius=36}, --hangar2
    {x=-1644.7590332031,y=-3148.1198730469,z=14.0,angle=330,radius=36}, --hangar2.1
    {x=-1660.5771484375,y=-3139.12109375,z=14.0,angle=330,radius=36}, --hangar2.2
    {x=-1181.6462402344,y=-2379.2512207031,z=14.0,angle=50,radius=64}, --open 1
    {x=-797.32495117188,y=-1501.8538818359,z=-0.47531151771545,angle=109,radius=25}, --boats 1
    {x=-804.322265625,y=-1485.7386474609,z=-0.475227445364,angle=109,radius=25}, --boats 2
    {x=1733.7906494141,y=3301.3681640625,z=41.22350692749,angle=191.01606750488,radius=36}, --sandyshores
    {x=2131.849609375,y=4786.2827148438,z=40.970283508301,angle=29.885553359985,radius=36}, --makenzie
    {x=-1593.8843994141,y=5259.2700195313,z=1.5794897079468,angle=19.289232254028,radius=36}, --morthwest coast
    {x=3851.8952636719,y=4477.4018554688,z=3.0,angle=273.72241210938,radius=36}, --northeast coast
    {x=3091.7487792969,y=2188.46875,z=3.0,angle=181.06353759766,radius=36}, --cave
    {x=-1729.671875,y=-3066.1174316406,z=15.0,angle=319.92343,radius=64}, --lsia open 2
    {x=283.40374755859,y=75.906845092773,z=93.987991333008,angle=67.80687713623,radius=36},
    {x=146.83709716797,y=320.70883178711,z=111.76653289795,angle=114.86211395264,radius=36},
    {x=963.53662109375,y=-1856.3601074219,z=30.903295516968,angle=82.497917175293,radius=16}, -- vagos
    {x=-811.22631835938,y=187.62747192383,z=72.478698730469,angle=115.2571105957,radius=16}, -- michael
    {x=21.811386108398,y=544.36962890625,z=175.88871765137,angle=61.470844268799,radius=16}, -- franklin
    {x=-930.38836669922,y=-2921.7431640625,z=13.615657806396,angle=240.09352111816,radius=16}, -- airport
    {x=-291.75354003906,y=-990.86596679688,z=23.756319046021,angle=246.95065307617,radius=16}, -- alta hotel
    {x=-37.639461517334,y=-620.03393554688,z=34.392356872559,angle=250.35893249512,radius=16}, -- intergrity way
    {x=135.24867248535,y=-1050.9699707031,z=28.656225204468,angle=161.41242980957,radius=16}, -- dno apartments (humane labs keys)
    {x=-643.00457763672,y=-1133.5006103516,z=11.48632144928,radius=16}, -- norm apartments
    {x=-142.05001831055,y=183.90573120117,z=84.913269042969,radius=16}, -- norm 3
    {x=-1555.3081054688,y=-401.65844726563,z=41.473136901855,angle=230.83497619629,radius=16}, -- dno 3
    {x=-623.48303222656,y=56.5837059021,z=43.729766845703,angle=88.815956115723,radius=16}, -- north from elite
    {x=-3073.5834960938,y=394.77331542969,z=6.9685225486755,angle=246.80639648438,radius=16}, --banham
    {x=-2980.826171875,y=612.38665771484,z=20.210779190063,angle=108.04837799072,radius=16}, --banham norm
    {x=-3181.7841796875,y=1277.0294189453,z=12.7034740448,angle=253.86938476563,radius=16}, --chumash dno free guns
    {x=1668.3345947266,y=4768.8784179688,z=41.67684173584,angle=277.49353027344,radius=16}, --near bomjatnya grapeseed
    {x=1977.3643798828,y=5170.48828125,z=47.63907623291,angle=133.93835449219,radius=16}, -- Avi mission end
}
for k,v in pairs(garages) do
--v.name="Garage"
 v.sprite=357
 v.color=4
end

local clothesskinsshops={
 binco={1077785853,-2077764712,-771835772,2021631368,600300561,-408329255,-1382092357,436345731,-37334073,-459818001,766375082,-106498753,-173013091,-1656894598,
  -1538846349,1674107025,70821038,-1806291497,-88831029,1641152947,951767867,1165780219,331645324,330231874,-1386944600,2111372120,-1444213182,-685776591,813893651,
  1358380044,1312913862,1746653202,-1445349730,-2088436577,-640198516,1767892582,-1044093321,-1342520604,193817059,1750583735,718836251,-215821512,-1519524074,
  1519319503,-1620232223,1082572151,-1398552374,-2018356203,-1948675910,238213328,-1007618204,-1023672578,-812470807,-1731772337,-2039163396,-1029146878,-48477765,
  228715206,-1837161693,-829353047,919005580,-1222037748,-356333586,-929103484,1347814329,1446741360,},
 suburban={2114544056,-900269486,-1106743555,1146800212,1423699487,
  1982350912,-1606864033,1546450936,1068876755,1720428295,549978415,920595805,131961260,377976310,1371553700,115168927,793439294,1640504453,-1736970383,
  891398354,815693290,-2109222095,587703123,-1745486195,349505262,-1514497514,429425116,321657486,921110016,-417940021,-1976105999,-840346158,605602864,
  -1047300121,435429221,1264851357,-625565461,1561705728,933092024,534725268,-85696186,835315305,-1800524916,},
 ponsonbys={-1697435671,664399832,2120901815,-912318012,532905404,
  826475330,-1280051738,-1366884940,-1589423867,-1211756494},
}

local SKINS={
LSFD={-1229853272},
MEDICS={-1286380898,-1420211530,-730659924},
LSPD={1581098148,368603149},
DETECTIVES={GetHashKey("s_m_m_dick_01")},
NAVY={1925237458},
MILITARY={-220552467,1702441027,1490458366},
NOOSE={-1920001264},
SAHP={1939545845},
SSPD={1096929346,-1320879687},
SAPR={-1614285257,-277793362},
FBISWAT={2072724299,-1145735340},
FBI={-306416314,653289389},
LOST={1032073858,1330042375,850468060,-44746786},
MERCS={-1275859404,2047212121,1349953339},
ANARCHY={-1105135100},
BALLAS={-198252413,588969535,599294057,361513884},
FAMILIES={-398748745,-613248456,-2077218039,1309468115},
VAGOS={653210662,832784782,-1773333796,1520708641},
SALVA={-1872961334,663522487,846439045,62440720},
TRIADS={891945583,611648169,-1880237687,2093736314,-1176698112,275618457,2119136831,-9308122},
MOBS={-236444766,-39239064,-984709238,-412008429},
HEISTERS={1822283721},
CARTEL={1329576454,-1561829034},
ELITE={-245247470,691061163},
CRIMINAL={
GetHashKey("A_M_M_MexLabor_01"),
GetHashKey("S_M_M_AutoShop_01"),
GetHashKey("A_M_Y_Beach_02"),
GetHashKey("A_M_Y_BeachVesp_01"),
GetHashKey("A_M_Y_BeachVesp_02"),
GetHashKey("A_M_M_BevHills_01"),
GetHashKey("A_M_Y_BevHills_01"),
GetHashKey("A_M_M_BevHills_02"),
GetHashKey("A_M_Y_BevHills_02"),
GetHashKey("A_M_Y_BusiCas_01"),
GetHashKey("A_M_Y_Business_02"),
GetHashKey("A_M_Y_Business_03"),
GetHashKey("S_M_O_Busker_01"),
GetHashKey("A_M_Y_Cyclist_01"),
GetHashKey("S_M_Y_Dealer_01"),
GetHashKey("A_M_Y_Downtown_01"),
GetHashKey("A_M_M_EastSA_01"),
GetHashKey("A_M_Y_EastSA_01"),
GetHashKey("A_M_M_EastSA_02"),
GetHashKey("A_M_Y_EastSA_02"),
GetHashKey("U_M_M_Edtoh"),
GetHashKey("A_M_Y_Gay_01"),
GetHashKey("A_M_M_GenFat_01"),
GetHashKey("A_M_M_GenFat_02"),
GetHashKey("A_M_Y_GenStreet_01"),
GetHashKey("A_M_Y_GenStreet_02"),
GetHashKey("A_M_Y_Golfer_01"),
GetHashKey("S_M_Y_Grip_01"),
GetHashKey("A_M_Y_Indian_01"),
GetHashKey("A_M_M_KTown_01"),
GetHashKey("A_M_O_KTown_01"),
GetHashKey("A_M_Y_KTown_01"),
GetHashKey("A_M_Y_KTown_02"),
GetHashKey("A_M_Y_Latino_01"),
GetHashKey("U_M_Y_Party_01"),
GetHashKey("A_M_M_Polynesian_01"),
GetHashKey("A_M_Y_Polynesian_01"),
GetHashKey("S_M_Y_Robber_01"),
GetHashKey("A_M_Y_Runner_02"),
GetHashKey("A_M_M_Skater_01"),
GetHashKey("A_M_Y_Skater_01"),
GetHashKey("A_M_Y_Skater_02"),
GetHashKey("A_M_M_Skidrow_01"),
GetHashKey("A_M_M_SoCenLat_01"),
GetHashKey("A_M_M_SouCent_01"),
GetHashKey("A_M_M_SouCent_02"),
GetHashKey("A_M_M_SouCent_03"),
GetHashKey("A_M_M_SouCent_04"),
GetHashKey("A_M_O_SouCent_01"),
GetHashKey("A_M_O_SouCent_02"),
GetHashKey("A_M_O_SouCent_03"),
GetHashKey("A_M_Y_SouCent_01"),
GetHashKey("A_M_Y_SouCent_02"),
GetHashKey("A_M_Y_SouCent_03"),
GetHashKey("A_M_Y_SouCent_04"),
GetHashKey("A_M_Y_StBla_01"),
GetHashKey("A_M_Y_StBla_02"),
GetHashKey("A_M_Y_StLat_01"),
GetHashKey("A_M_M_StLat_02"),
GetHashKey("G_M_Y_StrPunk_01"),
GetHashKey("G_M_Y_StrPunk_02"),
GetHashKey("S_M_Y_StrVend_01"),
GetHashKey("A_M_Y_StWhi_01"),
GetHashKey("A_M_Y_StWhi_02"),
GetHashKey("A_M_Y_Sunbathe_01"),
GetHashKey("U_M_Y_Tattoo_01"),
GetHashKey("A_M_Y_VinDouche_01")}
}

-- Citizen.CreateThread(function()
    -- local blip=AddBlipForCoord(money_drops[-1].x, money_drops[-1].y, money_drops[-1].z)
    -- SetBlipSprite(blip, 27) --heist.sprite
    -- SetBlipDisplay(blip, 2)
    -- SetBlipScale(blip, 0.9)
    -- --SetBlipColour(money_blips[id].blip, info.colour)
    -- --SetBlipAsShortRange(money_blips[id].blip, true)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString("test")
    -- EndTextCommandSetBlipName(blip)
    -- --SetPedMoney(PlayerPedId(), 50000);
    -- money_blips[-1]=blip
-- end)

-- function showmoney()
	-- N_0xc2d15bef167e27bc()
	-- SetPlayerCashChange(1, 0)
	-- Citizen.InvokeNative(0x170F541E1CADD1DE, true)
	-- SetPlayerCashChange(player.money, 0)
-- end

--Entity NETWORK_GET_ENTITY_FROM_NETWORK_ID(int netId);
--BOOL NETWORK_GET_ENTITY_IS_LOCAL(Entity entity);
--BOOL NETWORK_GET_ENTITY_IS_NETWORKED(Entity entity);
--int NETWORK_GET_NETWORK_ID_FROM_ENTITY(Entity entity);
--void NETWORK_REGISTER_ENTITY_AS_NETWORKED(Entity entity);
--void NETWORK_SET_ENTITY_CAN_BLEND(Entity entity, BOOL toggle);
--void NETWORK_UNREGISTER_NETWORKED_ENTITY(Entity entity);
--void _SET_NETWORK_VEHICLE_NON_CONTACT(Vehicle vehicle, BOOL toggle);

local function refresh_stars(player,wanted)
    SetPlayerWantedLevel(player, 0, false)
    SetPlayerWantedLevelNow(player,false)
    ReportCrime(player,8,GetWantedLevelThreshold(wanted)+40)
    SetPlayerWantedLevel(player, wanted, false)
    SetPlayerWantedLevelNow(player,false)
end

local function one_decimal_digit(a)
    local b=math.floor(a)
    local c=math.floor((a-b)*10+.5)
    if c>9 then
        return ""..(b+1)
    elseif c==0 then
        return b
    else
        return b.."."..c
    end
end
local function two_decimal_digits(a)
    local b=math.floor(a)
    local c=math.floor((a-b)*100+.5)
    if c>99 then
        return ""..(b+1)
    elseif c>9 then
        return b.."."..c
    elseif c==0 then
        return b
    else
        return b..".0"..c
    end
end
local function WriteText(font,text,scale,r,g,b,a,posx,posy)
    SetTextOutline()
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r,g,b,a)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(posx,posy)
end

--local function WriteTextRighToLeft(font,text,scale,r,g,b,a,posx,posy)
--    SetTextRightJustify(true)
--    SetTextWrap(.0,posx)
--    WriteText(font,text,scale,r,g,b,a,posx,posy)
--end

local function get_vehicle_from_plate(plate)
    for veh in EnumerateVehicles() do
        if GetVehicleNumberPlateText(veh)==plate then
            return veh
        end
    end
    return 0
end

local function addcarblip(veh)
    local carblip=AddBlipForEntity(veh)
    SetBlipSprite(carblip, 326)
    SetBlipDisplay(carblip, 2)
    SetBlipScale(carblip, 0.6)
    SetBlipColour(carblip, 3)
end

-- local function NetworkUnregisterNetworkedEntity(entity)
    -- return Citizen.InvokeNative(0x7368E683BB9038D6,entity)
-- end

-- local function NetworkRegisterEntityAsNetworked(entity)
    -- return Citizen.InvokeNative(0x06FAACD625D80CAA,entity)
-- end

-- local function NetworkSetNetworkIdDynamic(netID,toggle)
    -- return Citizen.InvokeNative(0x2B1813ABA29016C5,netID,toggle)
-- end

local function networkingshit(entity)
    --while not 
    SetEntityAsMissionEntity(entity,true,true)
    local netID=NetworkGetNetworkIdFromEntity(entity)
    if netID==0 then
        NetworkRegisterEntityAsNetworked(entity)
        Wait(0)
        netID=NetworkGetNetworkIdFromEntity(entity)
    end
    SetNetworkIdExistsOnAllMachines(netID, true)
    NetworkSetNetworkIdDynamic(netID,true)
    Wait(0)
    netID=NetworkGetNetworkIdFromEntity(entity)
    return netID
end

local function fix_vehicles_using_plates()
    local lost_cars={}
    local something_lost=false
    local i=0
    if mycar.plate and mycar.net~=NetworkGetNetworkIdFromEntity(mycar.veh) then
        i=i+1
        lost_cars[i]=mycar
        something_lost=true
    end
    if mycar_old.plate and mycar_old.net~=NetworkGetNetworkIdFromEntity(mycar_old.veh) then
        i=i+1
        lost_cars[i]=mycar_old
        something_lost=true
    end
    if rentcar.plate and rentcar.net~=NetworkGetNetworkIdFromEntity(rentcar.veh) then
        i=i+1
        lost_cars[i]=rentcar
        something_lost=true
    end
    if something_lost then
        for veh in EnumerateVehicles() do
            for key,car in pairs(lost_cars) do
                if GetVehicleNumberPlateText(veh)==car.plate then
                    local hash=GetEntityModel(veh)
                    -- if not car.hash then
                        -- car.hash=hash
                    -- end
                    if car.hash==hash then
                        car.veh=veh
                        NetworkUnregisterNetworkedEntity(veh)
                        car.net=networkingshit(veh)
                        addcarblip(veh)
                        if car.gps and car.gps.blip then
                            RemoveBlip(car.gps.blip)
                            car.gps.blip=nil
                        end
                        lost_cars[key]={}
                        lost_cars[key]=nil
                        break
                    end
                end
            end
        end
    end
end

local function forgetgps(car)
    if car.gps then
        if car.gps.blip then
            RemoveBlip(car.gps.blip)
            car.gps.blip=nil
        end
        car.gps.x=nil
        car.gps.y=nil
        car.gps.z=nil
        car.gps.name=nil
    end
end

local function rotategps(car1,car2)
    if car1.gps then
        if not car2.gps then
            car2.gps={}
        end
        car2.gps.x=car1.gps.x
        car2.gps.y=car1.gps.y
        car2.gps.z=car1.gps.z
        car2.gps.blip=car1.gps.blip
        car2.gps.name=car1.gps.name
    else
        car2.gps={}
    end
end

local function sendcarplates()
    TriggerServerEvent(event.plates,mycar.plate,mycar.hash,mycar_old.plate,mycar_old.hash,rentcar.plate,rentcar.hash)
end

local function abandoncar_plate(plate)
    TriggerServerEvent(event.abandoncar,plate)
end

local function abandoncar(car)
    if car.veh~=nil and car.net~=nil and car.net~=0 and car.plate then
        if car.net~=NetworkGetNetworkIdFromEntity(car.veh) then
            abandoncar_plate(car.plate)
        else
            SetVehicleAsNoLongerNeeded(car.veh)
        end
    end
end

local function trytofixvehid(car)
    if car.plate then
        if car.veh~=nil and car.net~=nil and car.net~=0 then
            if car.net~=NetworkGetNetworkIdFromEntity(car.veh) then
                car.veh=nil
            else
                local pos=GetEntityCoords(car.veh)
                if not car.gps then
                    car.gps={}
                end
                car.gps.x,car.gps.y,car.gps.z=pos.x,pos.y,pos.z
                if not car.gps.name then
                    car.gps.name=GetDisplayNameFromVehicleModel(GetEntityModel(car.veh))
                end
            end
        end
        if car.veh==nil then
            if car.gps and not car.gps.blip then
                local carblip=AddBlipForCoord(car.gps.x, car.gps.y, car.gps.z)
                local name
                local text
                if car.gps.name then
                    name="GPS signal lost:"..car.gps.name.."("..car.plate..")"
                    text="~r~GPS signal lost:\n"..car.gps.name.."("..car.plate..")"
                else
                    name="GPS signal lost:"..car.plate
                    text="~r~"..name
                end
                SetBlipSprite(carblip, 326)
                SetBlipDisplay(carblip, 2)
                SetBlipScale(carblip, 0.6)
                SetBlipColour(carblip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(name);
                EndTextCommandSetBlipName(carblip)
                car.gps.blip=carblip
                SetNotificationTextEntry("STRING");
                AddTextComponentString(text)
                DrawNotification(false, false);
            end
            if IsPedInAnyVehicle(PlayerPedId(),false) then
                vehnew=GetVehiclePedIsUsing(PlayerPedId())
                local platenew=GetVehicleNumberPlateText(vehnew)
                --SetNotificationTextEntry("STRING")
                --AddTextComponentString(plate.." "..platenew.." "..NetworkHasControlOfEntity(vehnew))
                --DrawNotification(false, false);
                if platenew==car.plate then
                    NetworkUnregisterNetworkedEntity(vehnew)
                    local netnew=networkingshit(vehnew)
                    addcarblip(vehnew)
                    if car.gps and car.gps.blip then
                        RemoveBlip(car.gps.blip)
                        car.gps.blip=nil
                    end
                    car.veh=vehnew
                    car.net=netnew
                end
            end
        end
    end
end

-- local function trytofixvehid(veh,net,plate)
    -- if veh~=nil and net~=nil and net~=0 and plate~="" then
        -- local vehnew=NetworkGetEntityFromNetworkId(net)
        -- if veh~=vehnew then
            -- if vehnew~=nil and vehnew~=0 then
                -- addcarblip(vehnew)
                -- return vehnew,net
            -- elseif IsPedInAnyVehicle(PlayerPedId(),false) then
                -- vehnew=GetVehiclePedIsUsing(PlayerPedId())
                -- local netnew=NetworkGetNetworkIdFromEntity(vehnew)
                -- if netnew==net then
                    -- addcarblip(vehnew)
                    -- return vehnew,net
                -- else
                    -- local platenew=GetVehicleNumberPlateText(vehnew)
                    -- if platenew==plate then
                        -- return vehnew,netnew
                    -- end
                -- end
            -- end
        -- end
    -- end
    -- return veh,net
-- end

Citizen.CreateThread(function()
Wait(5000)
    local classes={
    [0]=1, --Compacts
    [1]=1, --Sedans
    [2]=1, --SUVs
    [3]=1, --Coupes
    [4]=2, --Muscle
    [5]=2, --Sports Classics
    [6]=2, --Sports
    [7]=4, --Super
    [8]=1, --Motorcycles
    [9]=1, --Off-road
    [10]=2, --Industrial
    [11]=1, --Utility
    [12]=1, --Vans
    [13]=1, --Cycles
    [14]=1, --Boats
    [15]=3, --Helicopters
    [16]=3, --Planes
    [17]=1, --Service
    [18]=3, --Emergency
    [19]=5, --Military
    [20]=2, --Commercial
    [21]=2 --Trains
    }
    while true do
        Citizen.Wait(300000)
        local playerid=PlayerId()
        local ped=PlayerPedId()
        if IsPedInAnyVehicle(ped, false) and not player.is_cop then
            local veh=GetVehiclePedIsUsing(ped)
            trytofixvehid(mycar)
            trytofixvehid(mycar_old)
            trytofixvehid(rentcar)
            fix_vehicles_using_plates()
            if (veh~=mycar.veh) and (veh~=mycar_old.veh) and (veh~=rentcar.veh) and ped==GetPedInVehicleSeat(veh,-1) then
                local my_skin=GetEntityModel(ped)
                if my_skin~=1329576454 and my_skin~=-1561829034 then --проверка на скины картеля
                    local wanted=classes[GetVehicleClass(veh)]
                    if GetPlayerWantedLevel(playerid)<wanted then
                        SetPlayerWantedLevel(playerid,wanted,false)
                        SetNotificationTextEntry("STRING");
                        AddTextComponentString("This vehicle is ~r~stolen~s~. Police is searching for it.")
                        DrawNotification(false, false) 
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
Wait(5000)
    while true do
        Wait(1000)
        if debug_mode then
            local test="debug:m="
            if mycar.veh then
             test=test..mycar.veh
            else
             test=test.."nil"
            end
            test=test.." o="
            if mycar_old.veh then
             test=test..mycar_old.veh
            else
             test=test.."nil"
            end
            test=test.." r="
            if rentcar.veh then
             test=test..rentcar.veh
            else
             test=test.."nil"
            end
            if IsPedInAnyVehicle(PlayerPedId(), false) then
             test=test.." "..GetVehiclePedIsUsing(PlayerPedId())
            end
            SetNotificationTextEntry("STRING");
            AddTextComponentString(test)
            DrawNotification(false, false);
            Wait(1000)
            test="ent2n:m="
            if mycar.veh then
             test=test..NetworkGetNetworkIdFromEntity(mycar.veh)
            else
             test=test.."nil"
            end
            test=test.." o="
            if mycar_old.veh then
             test=test..NetworkGetNetworkIdFromEntity(mycar_old.veh)
            else
             test=test.."nil"
            end
            test=test.." r="
            if rentcar.veh then
             test=test..NetworkGetNetworkIdFromEntity(rentcar.veh)
            else
             test=test.."nil"
            end
            if IsPedInAnyVehicle(PlayerPedId(), false) then
             test=test.." "..NetworkGetNetworkIdFromEntity(GetVehiclePedIsUsing(PlayerPedId()))
            end
            SetNotificationTextEntry("STRING");
            AddTextComponentString(test)
            DrawNotification(false, false)
            Wait(1000)
            test="net2e:m="
            if mycar.net then
             test=test..NetworkGetEntityFromNetworkId(mycar.net)
            else
             test=test.."nil"
            end
            test=test.." o="
            if mycar_old.net then
             test=test..NetworkGetEntityFromNetworkId(mycar_old.net)
            else
             test=test.."nil"
            end
            test=test.." r="
            if rentcar.net then
             test=test..NetworkGetEntityFromNetworkId(rentcar.net)
            else
             test=test.."nil"
            end
            SetNotificationTextEntry("STRING");
            AddTextComponentString(test)
            DrawNotification(false, false);
            Wait(1000)
            test="netdb:m="
            if mycar.net then
             test=test..mycar.net
            else
             test=test.."nil"
            end
            test=test.." o="
            if mycar_old.net then
             test=test..mycar_old.net
            else
             test=test.."nil"
            end
            test=test.." r="
            if rentcar.net then
             test=test..rentcar.net
            else
             test=test.."nil"
            end
            SetNotificationTextEntry("STRING");
            AddTextComponentString(test)
            DrawNotification(false, false);
            Wait(1000)
            test="plate:m="
            if mycar.plate then
             test=test..mycar.plate
            else
             test=test.."nil"
            end
            test=test.." o="
            if mycar_old.plate then
             test=test..mycar_old.plate
            else
             test=test.."nil"
            end
            test=test.." r="
            if rentcar.plate then
             test=test..rentcar.plate
            else
             test=test.."nil"
            end
            SetNotificationTextEntry("STRING");
            AddTextComponentString(test)
            DrawNotification(false, false);
            Wait(1000)
            -- if IsPedInAnyVehicle(PlayerPedId(), false) then
            -- SetNotificationTextEntry("STRING")
            -- AddTextComponentString("bhp="..GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId())).." Your ID: "..PlayerId())
            -- DrawNotification(false, false)
            -- end
        end
    end
end)

-- RegisterNUICallback('chatResult', function(data, cb)
    -- if data.message:sub(1, 6) == '/debug' then
        -- debug_mode=~debug_mode
    -- end
-- end)

local function getvehhp(enginehp,bodyhp,tankhp,fuellevel)
    SendNUIMessage({
        enginehp = enginehp,
        bodyhp = bodyhp,
        tankhp = tankhp
    })
end

-- Citizen.CreateThread(function()
    -- while true do
        -- Citizen.Wait(10)
        -- local ped=PlayerPedId()
        -- if IsPedInAnyVehicle(ped, false) then
            -- local veh = GetVehiclePedIsUsing(ped)
            -- getvehhp(GetVehicleEngineHealth(veh),GetVehicleBodyHealth(veh),GetVehiclePetrolTankHealth(veh))
        -- else
            -- local health = GetEntityHealth(ped)
            -- getvehhp(0,health,0)
        -- end
    -- end
-- end)

--local native_money_hash_key=GetHashKey('MP0_WALLET_BALANCE')

local function setmoney(new)
    SendNUIMessage({
    showmoney = true,
	setmoney = new
	})
    --if new==nil then new=0 end
    --SetSingleplayerHudCash(new,0)
    --StatSetInt(native_money_hash_key,new,1)
end

local function addmoney(new,change)
    SendNUIMessage({
    showmoney = true,
    setmoney = new,
	addcash = change
	})
    --if new==nil then new=0 end
    --StatSetInt(native_money_hash_key,new,1)
end

local function removemoney(new,change)
    SendNUIMessage({
    showmoney = true,
	setmoney = new,
	removecash = change
	})
    --if new==nil then new=0 end
    --StatSetInt(native_money_hash_key,new,1)
end
    
RegisterNetEvent(event.money)
AddEventHandler(event.money, function(money)
    --SetPedMoney(PlayerPedId(), money);
      --SetNotificationTextEntry("STRING");
      if money==nil then money=0 end
      
      if player.money and money<player.money then
        removemoney(money,player.money-money)
     -- AddTextComponentString("~r~-$"..(player.money-money));
      else
        addmoney(money,money-player.money)
     -- AddTextComponentString("~g~+$"..(money-player.money));
      end
      player.money=money;
      --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, "Your money", "$"..player.money);
      --DrawNotification(false, false);
end)

RegisterNetEvent(event.notification)
AddEventHandler(event.notification, function(text)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is BURRIED.");
    DrawNotification(false, false);
end)

RegisterNetEvent("fragile-alliance:subtitles")
AddEventHandler("fragile-alliance:subtitles", function(text,duration,now)
    BeginTextCommandPrint("STRING");
    AddTextComponentString(text)
    EndTextCommandPrint(duration, now);
end)

RegisterNetEvent("fragile-alliance:helptext")
AddEventHandler("fragile-alliance:helptext", function(text)
    SetTextComponentFormat("STRING");
    AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0,0,1,-1)
end)

Citizen.CreateThread(function()
Wait(5000)
    while true do
        while player.is_cop do Wait(5000) end
        if not player.is_cop then
            SetTextComponentFormat("STRING")
            AddTextComponentString("Press ~INPUT_PHONE~ to use your phone.")
            DisplayHelpTextFromStringLabel(0,0,1,-1)
            Wait(600000)
        end
            SetTextComponentFormat("STRING")
            AddTextComponentString("Press ~INPUT_CELLPHONE_CAMERA_FOCUS_LOCK~ to use ~g~special ability~s~.")
            DisplayHelpTextFromStringLabel(0,0,1,-1)
            Wait(600000)
		if not player.is_cop then
	        SetTextComponentFormat("STRING")
	        AddTextComponentString("Money:\n~INPUT_REPLAY_START_STOP_RECORDING~ hide\n~INPUT_REPLAY_START_STOP_RECORDING_SECONDARY~ take")
	        DisplayHelpTextFromStringLabel(0,0,1,-1)
	        Wait(600000)
		end
		if not player.is_cop then
	        SetTextComponentFormat("STRING")
	        AddTextComponentString("~INPUT_REPLAY_START_STOP_RECORDING~ to hide money in any place.")
	        DisplayHelpTextFromStringLabel(0,0,1,-1)
	        Wait(600000)
		end
		if not player.is_cop then
	        SetTextComponentFormat("STRING")
	        AddTextComponentString("~INPUT_REPLAY_START_STOP_RECORDING_SECONDARY~ to take money from hideout.")
	        DisplayHelpTextFromStringLabel(0,0,1,-1)
	        Wait(600000)
		end
		if not player.is_cop then
	        SetTextComponentFormat("STRING")
	        AddTextComponentString("Press ~INPUT_REPLAY_SCREENSHOT~ to blend in.")
	        DisplayHelpTextFromStringLabel(0,0,1,-1)
	        Wait(600000)
		end
		if player.is_cop then
	        SetTextComponentFormat("STRING")
	        AddTextComponentString("Press ~INPUT_VEH_HEADLIGHT~ to arrest surrendering player.")
	        DisplayHelpTextFromStringLabel(0,0,1,-1)
	        Wait(600000)
		else
	        SetTextComponentFormat("STRING")
	        AddTextComponentString("Press ~INPUT_VEH_HEADLIGHT~ to surrender.")
	        DisplayHelpTextFromStringLabel(0,0,1,-1)
	        Wait(600000)
		end
		Wait(0)
    end
end)

-- Citizen.CreateThread(function()
    -- local show=false
    -- while true do
        -- if (money_drops[-1]~=nil) and show then
            -- show=nil
            -- SetTextComponentFormat("STRING")
            -- AddTextComponentString("Press ~INPUT_VEH_ROOF~ to start ~g~heist~s~.")
            -- DisplayHelpTextFromStringLabel(0,0,1,-1)
        -- elseif (money_drops[-1]==nil) and (not show) then
            -- show=true
            -- SetTextComponentFormat("STRING")
            -- AddTextComponentString("Press ~INPUT_VEH_ROOF~ to start ~g~heist~s~.")
            -- DisplayHelpTextFromStringLabel(0,0,1,-1)
        -- end
        -- Wait(1000)
    -- end
-- end)

RegisterNetEvent(event.startheist)
AddEventHandler(event.startheist, function(id,heist)
    if id<0 and not money_drops[id] then
      SetNotificationTextEntry("STRING");
      AddTextComponentString(heist.name.." ~g~$"..heist.money.."~s~");
      --SetNotificationMessage("CHAR_LESTER", "CHAR_LESTER", false, 1, "Heist", "$"..heist.money);
      DrawNotification(false, false);
      
        BeginTextCommandPrint("STRING");
        AddTextComponentString("~g~"..heist.name)
        EndTextCommandPrint(5000, false);
      --SetBlipRoute(money_blips[id], true)
      --SetBlipRouteColour(money_blips[id], wantcolors[heist.wanted])
    end
    money_drops[id]=heist;
    if money_blips[id]~=nil then
        SetBlipCoords(money_blips[id], heist.x, heist.y, heist.z)
    else
        money_blips[id]=AddBlipForCoord(heist.x, heist.y, heist.z)
    end
    SetBlipSprite(money_blips[id], heist.sprite) --heist.sprite
    SetBlipDisplay(money_blips[id], 2)
    SetBlipScale(money_blips[id], heist.bs)
    local wantcolors={[0]=4,[1]=2,[2]=2,[3]=46,[4]=51,[5]=1}
    SetBlipColour(money_blips[id], wantcolors[heist.wanted])
    --SetBlipAsShortRange(money_blips[id].blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(heist.name)
    EndTextCommandSetBlipName(money_blips[id])
end)

local function remove_local_object(obj)
    SetEntityAsNoLongerNeeded(obj)
    SetEntityAsMissionEntity(obj)
    DeleteObject(obj)
end

local function remove_tree_of_local_objects(tree)
    for k,v in pairs(tree) do
        if type(v)=='table' then
            remove_tree_of_local_objects(v)
        else
            remove_local_object(v)
        end
    end
end

RegisterNetEvent(event.stopheist)
AddEventHandler(event.stopheist, function(id)
    money_drops[id]=nil
    if money_blips[id] then
        SetBlipSprite(money_blips[id], 406)
        SetBlipDisplay(money_blips[id], 2)
        -- if id==-1 then
            -- SetBlipRoute(money_blips[id], false)
        -- end
    end
    if money_bags[id]~=nil then
        if type(money_bags[id])=='table' then
            remove_tree_of_local_objects(money_bags[id])
            money_bags[id]=nil
        else
            remove_local_object(money_bags[id])
            money_bags[id]=nil
        end
    end
end)

local function set_ped_components(ped,components)
    if components~=nil then
        for comp,variation in pairs(components) do
            if type(variation)=='table' then
                SetPedComponentVariation(ped,comp,variation[1],variation[2],0)
            else
                local texture=GetNumberOfPedTextureVariations(ped,comp,variation)
                if texture>0 then texture=math.random(0,texture-1) end
                SetPedComponentVariation(ped,comp,variation,texture,0)
            end
        end
    end
end

local function removeenemycorpse(milliseconds,ped)
    Wait(milliseconds)
    SetPedAsNoLongerNeeded(ped)
end

local function removefriendcorpse(milliseconds,ped)
    local name="Friend"
    --SetNotificationTextEntry("STRING");
    --AddTextComponentString(name.." ~r~died~s~.");
   -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
    --DrawNotification(false, false);
    local coords=GetEntityCoords(ped)
    local blip=AddBlipForCoord(coords.x,coords.y,coords.z)
    SetBlipSprite(blip, 310)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name);
    EndTextCommandSetBlipName(blip)
    Wait(milliseconds)
    RemoveBlip(blip)
    SetPedAsNoLongerNeeded(ped)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(name.." corpse removed.");
    --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is BURRIED.");
    DrawNotification(false, false);
end

Citizen.CreateThread(function()
Wait(5000)
    while true do
        Wait(500)
        for key, v in pairs(friends) do
            if IsPedFatallyInjured(v) then
                Citizen.CreateThread(function() removefriendcorpse(120000,v) end)
                friends[key]=nil
            end
        end
        for key, v in pairs(enemies) do
            if IsPedFatallyInjured(v) then
                Citizen.CreateThread(function() removeenemycorpse(120000,v) end)
                enemies[key]=nil
            end
        end
        Wait(500)
        trytofixvehid(mycar)
        trytofixvehid(mycar_old)
        trytofixvehid(rentcar)
        fix_vehicles_using_plates()
        if rentcar.veh and (GetVehicleEngineHealth(rentcar.veh)<-3999) then
            local name=GetDisplayNameFromVehicleModel(GetEntityModel(rentcar.veh))
            SetVehicleAsNoLongerNeeded(rentcar.veh)
            rentcar.veh=nil
            rentcar.net=nil
            forgetgps(rentcar)
            rentcar.plate=nil
            rentcar.hash=nil
            sendcarplates()
            SetNotificationTextEntry("STRING")
            AddTextComponentString("Rented ~r~"..name.."~s~ destroyed, shame on you!")
           -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
            DrawNotification(false, false);
        end
        if mycar.veh and (GetVehicleEngineHealth(mycar.veh)<-3999) then
            local name=GetDisplayNameFromVehicleModel(GetEntityModel(mycar.veh))
            SetVehicleAsNoLongerNeeded(mycar.veh)
            mycar.veh=nil
            mycar.net=nil
            forgetgps(mycar)
            mycar.plate=nil
            mycar.hash=nil
            sendcarplates()
            SetNotificationTextEntry("STRING")
            AddTextComponentString("Your last bought vehicle(~r~"..name.."~s~) is destroyed.")
           -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
            DrawNotification(false, false);
        end
        if mycar_old.veh and (GetVehicleEngineHealth(mycar_old.veh)<-3999) then
            local name=GetDisplayNameFromVehicleModel(GetEntityModel(mycar_old.veh))
            SetVehicleAsNoLongerNeeded(mycar_old.veh)
            mycar_old.veh=nil
            mycar_old.net=nil
            forgetgps(mycar_old)
            mycar_old.plate=nil
            mycar_old.hash=nil
            sendcarplates()
            SetNotificationTextEntry("STRING")
            AddTextComponentString("Your previously bought vehicle(~r~"..name.."~s~) is destroyed.")
           -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, name, "is DEAD.");
            DrawNotification(false, false);
        end
    end
end)

local function makepedcombatreadydriver(ped)
   SetPedCombatAbility(ped,2)
   --SetPedConfigFlag(ped,42,false)
   SetPedCombatRange(ped, 2);
   SetPedCombatMovement(ped, 1);
   SetPedCombatAttributes(ped, 0, true)
   SetPedCombatAttributes(ped, 1, true)
   SetPedCombatAttributes(ped, 2, true)
   SetPedCombatAttributes(ped, 3, false)
   SetPedCombatAttributes(ped, 5, true)
   SetPedCombatAttributes(ped, 46, true)
   SetPedCombatAttributes(ped, 1424, true)
   SetPedFleeAttributes(ped, 1, false)
   SetPedFleeAttributes(ped, 2, false)
   SetPedFleeAttributes(ped, 4, false)
   SetPedFleeAttributes(ped, 8, false)
   SetPedFleeAttributes(ped, 16, false)
   SetPedFleeAttributes(ped, 32, false)
   SetPedFleeAttributes(ped, 64, false)
   SetDriverAbility(ped, 1.0);
   -- SetPedConfigFlag(ped,75,false)
   -- SetPedConfigFlag(ped,78,false)
   -- SetPedConfigFlag(ped,190,false)
   -- SetPedConfigFlag(ped,200,false)
   -- SetPedConfigFlag(ped,271,false)
   -- SetPedConfigFlag(ped,310,false)
   -- SetPedConfigFlag(ped,325,false)
   -- SetPedConfigFlag(ped,62,true)
   -- SetPedConfigFlag(ped,265,true)
   -- SetPedConfigFlag(ped,439,true)
end

local function makepedcombatready(ped)
   SetPedCombatAbility(ped,2)
   SetPedCombatAttributes(ped, 0, true)
   SetPedCombatAttributes(ped, 1, true)
   SetPedCombatAttributes(ped, 2, true)
   SetPedCombatAttributes(ped, 3, true)
   SetPedCombatAttributes(ped, 5, true)
   SetPedCombatAttributes(ped, 46, true)
   SetPedCombatAttributes(ped, 1424, true)
   SetPedFleeAttributes(ped, 1, false)
   SetPedFleeAttributes(ped, 2, false)
   SetPedFleeAttributes(ped, 4, false)
   SetPedFleeAttributes(ped, 8, false)
   SetPedFleeAttributes(ped, 16, false)
   SetPedFleeAttributes(ped, 32, false)
   SetPedFleeAttributes(ped, 64, false)
   SetDriverAbility(ped, 1.0);
end

local function spawnped(hash,x,y,z,weapon,pedlist)
   RequestModel(hash)
   while not HasModelLoaded(hash) do Wait(10) end
   local ped =  CreatePed(4, hash, x, y, z, 0.0, true, false)
   --SetBlockingOfNonTemporaryEvents(ped, true)
   makepedcombatready(ped)
   SetPedRandomComponentVariation(ped, false)
   if weapon then
    GiveWeaponToPed(ped, weapon, 1000, false, true)
   end
   SetModelAsNoLongerNeeded(hash)
   table.insert(pedlist,ped)
   return ped
end



local function createpedgroup(x,y,z,n,skins,weapons,pedlist)
    local ped
    local group=CreateGroup()
    for i=1,n do
       ped=spawnped(skins[math.random(#skins)],x,y,z,weapons[math.random(#weapons)],pedlist)
       SetPedAsGroupMember(ped, group);
       SetPedAsEnemy(ped, true);
       SetPedRelationshipGroupHash(ped, relationship_enemy)
       TaskWanderInArea(ped,x,y,z,10.0,5.0,5.0)
       SetEntityAsMissionEntity(ped,true,true)
       Wait(500)
    end
    SetPedAsGroupLeader(ped, group);
    SetGroupFormation(group, 1);
end

RegisterNetEvent(event.spawnpeds)
AddEventHandler(event.spawnpeds, function(x,y,z,n,skins,weapons)
       --GetHashKey( "g_m_y_famca_01") --a_c_mtlion" ) --"mp_m_shopkeep_01" )
    ReserveNetworkMissionPeds(n)
    while n>8 do
       createpedgroup(x,y,z,8,skins,weapons,enemies)
       n=n-8
    end
    if n>1 then
       createpedgroup(x,y,z,n,skins,weapons,enemies)
    elseif n>0 then
       local ped=spawnped(skins[math.random(#skins)],x,y,z,weapons[math.random(#weapons)],enemies)
       SetPedAsEnemy(ped, true);
       SetPedRelationshipGroupHash(ped, relationship_enemy)
       SetEntityAsMissionEntity(ped,true,true)
    end
    --int GET_PLAYER_GROUP(Player playerid);
    --SET_PED_AS_GROUP_LEADER(ped, groupId);
    --SET_PED_CAN_TELEPORT_TO_GROUP_LEADER(Ped pedHandle, int groupHandle, BOOL toggle);
    --void SET_PED_NEVER_LEAVES_GROUP(Ped ped, BOOL toggle);
    --void SET_PED_DEFENSIVE_AREA_DIRECTION(Ped ped, float p1, float p2, float p3, BOOL p4);
    --Hash GET_PED_RELATIONSHIP_GROUP_DEFAULT_HASH(Ped ped);
    --void SET_PED_RELATIONSHIP_GROUP_DEFAULT_HASH(Ped ped, Hash hash);
    --Ped GET_PED_AS_GROUP_MEMBER(int groupID, int memberNumber);
    --BOOL IS_PED_IN_GROUP(Ped ped);
    --BOOL IS_PED_GROUP_MEMBER(Ped ped, int groupId);
    --Ped _GET_PED_AS_GROUP_LEADER(int groupID);
    --BOOL DOES_GROUP_EXIST(int groupId);
    --void GET_GROUP_SIZE(int groupID, Any* unknown, int* sizeInMembers); p1 may be a BOOL representing whether or not the group even exists
    --void REMOVE_GROUP(int groupId);
    --void REMOVE_PED_FROM_GROUP(Ped ped);
    --int CREATE_GROUP(int unused); Groups can contain up to 8 peds.
    --void CLEAR_RELATIONSHIP_BETWEEN_GROUPS(int relationship, Hash group1, Hash group2); This should be called twice (once for each group).
    --int GET_RELATIONSHIP_BETWEEN_GROUPS(Hash group1, Hash group2);
    --void SET_RELATIONSHIP_BETWEEN_GROUPS(int relationship, Hash group1, Hash group2);
    -- 0 = Companion
    -- 1 = Respect
    -- 2 = Like
    -- 3 = Neutral
    -- 4 = Dislike
    -- 5 = Hate
    -- 255 = Pedestrians
    --void SET_PED_AS_GROUP_MEMBER(Ped ped, int groupId);
    --int GET_PED_GROUP_INDEX(Ped ped);
    --Any ADD_RELATIONSHIP_GROUP(char* name, Hash* groupHash);
    --void REMOVE_PED_ELEGANTLY(Ped* ped);
    --void REMOVE_RELATIONSHIP_GROUP(Hash groupHash);
    --void SET_PED_RELATIONSHIP_GROUP_HASH(Ped ped, Hash hash);
    --void SET_GROUP_FORMATION(int groupId, int formationType);
    --Hash GET_PED_RELATIONSHIP_GROUP_HASH(Ped ped);
    --int GET_RELATIONSHIP_BETWEEN_PEDS(Ped ped1, Ped ped2);
    
    --void SET_ENTITY_ONLY_DAMAGED_BY_RELATIONSHIP_GROUP(Entity entity, BOOL p1, Any p2);
    --void SET_ENTITY_CAN_BE_DAMAGED_BY_RELATIONSHIP_GROUP(Entity entity, BOOL bCanBeDamaged, int relGroup);
end)

local civplayermodels={}
for k,v in pairs(SKINS.LSFD) do
    civplayermodels[v]=true
end
for k,v in pairs(SKINS.MEDICS) do
    civplayermodels[v]=true
end

local function IsPlayerCopOrCiv(ped)
    return IsPedCop(ped) or civplayermodels[GetEntityModel(ped)]
end

-- Citizen.CreateThread(function()
    -- while true do
      -- Wait(500)
      -- if #friends>0 then
        -- local playerid = PlayerPedId()
        -- if IsPedInAnyVehicle(playerid, false) then
          -- local myveh=GetVehiclePedIsUsing(playerid)
          -- local maxpas=0
          -- local free=Citizen.InvokeNative(0x2D34FC3BC4ADB780,veh);
          -- if not free then
            -- local style=6 --1+4+16+32+4194304
            -- local idiots=0
            -- local lost={}
            -- for key, v in pairs(friends) do
              -- if not IsPedInAnyVehicle(v,false) then
                -- lost[key]=v
                -- idiots=idiots+1
              -- end
            -- end
            -- local banned={}
            -- banned[myveh]=myveh
            -- local veh=nil
            -- while idiots>0 do
                -- for key, v in pairs(lost) do
                  -- if IsPedInAnyVehicle(v,false) then
                    -- lost[key]=nil
                    -- idiots=idiots-1
                  -- else
                    -- if not veh then
                      -- local p=GetEntityCoords(v)
                      -- veh=GetClosestVehicle(p.x,p.y,p.z,20.0,0,4)
                      -- if banned[veh]==nil then
                        -- TaskEnterVehicle(v,veh,5000,-1,2.0,1,0)
                        -- TaskVehicleEscort(v,veh,myveh,-1,50.0,style,5.0, 0, 20.0)
                        -- maxpas=GetVehicleMaxNumberOfPassengers(veh)
                        -- lost[key]=nil
                        -- idiots=idiots-1
                        -- p=GetEntityCoords(veh)
                        -- DrawMarker(2, p.x, p.y, p.z-.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 255, 0, 64, false, true, 2, false, false, false, false)
                      -- else
                        -- veh=nil
                      -- end
                    -- elseif maxpas>0 then
                        -- TaskEnterVehicle(v,veh,5000,0,2.0,1,0)
                        -- maxpas=maxpas-1
                        -- lost[key]=nil
                        -- idiots=idiots-1
                    -- else
                        -- banned[veh]=veh
                        -- veh=nil
                    -- end
                  -- end
                -- end
                -- if idiots>0 then
                  -- SetNotificationTextEntry("STRING");
                  -- AddTextComponentString(idiots.." friends didnt find a seat.");
                  -- SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, "Shame on", "you idiots!");
                  -- DrawNotification(false, false);
                  -- Wait(5000)
                -- end
            -- end
          -- end
        -- end
      -- end
    -- end
-- end)

local hash2fac={}
    hash2fac[GetHashKey("COP")]="COP"
    hash2fac[GetHashKey("PLAYER")]="PLAYER"
    hash2fac[GetHashKey("AMBIENT_GANG_LOST")]="AMBIENT_GANG_LOST"
    hash2fac[GetHashKey("PRIVATE_SECURITY")]="PRIVATE_SECURITY"
    hash2fac[GetHashKey("CIVMALE")]="CIVMALE"
    hash2fac[GetHashKey("CIVFEMALE")]="CIVFEMALE"	
    hash2fac[GetHashKey("SECURITY_GUARD")]="SECURITY_GUARD"
    hash2fac[GetHashKey("FIREMAN")]="FIREMAN"
    hash2fac[GetHashKey("GANG_1")]="GANG_1"
    hash2fac[GetHashKey("GANG_2")]="GANG_2"
    hash2fac[GetHashKey("GANG_9")]="GANG_9"
    hash2fac[GetHashKey("GANG_10")]="GANG_10"
    hash2fac[GetHashKey("AMBIENT_GANG_LOST")]="AMBIENT_GANG_LOST"
    hash2fac[GetHashKey("AMBIENT_GANG_MEXICAN")]="AMBIENT_GANG_MEXICAN"
    hash2fac[GetHashKey("AMBIENT_GANG_FAMILY")]="AMBIENT_GANG_FAMILY"
    hash2fac[GetHashKey("AMBIENT_GANG_BALLAS")]="AMBIENT_GANG_BALLAS"
    hash2fac[GetHashKey("AMBIENT_GANG_MARABUNTE")]="AMBIENT_GANG_MARABUNTE"
    hash2fac[GetHashKey("AMBIENT_GANG_CULT")]="AMBIENT_GANG_CULT"
    hash2fac[GetHashKey("AMBIENT_GANG_SALVA")]="AMBIENT_GANG_SALVA"
    hash2fac[GetHashKey("AMBIENT_GANG_WEICHENG")]="AMBIENT_GANG_WEICHENG"
    hash2fac[GetHashKey("AMBIENT_GANG_HILLBILLY")]="AMBIENT_GANG_HILLBILLY"
    hash2fac[GetHashKey("DEALER")]="DEALER"
    hash2fac[GetHashKey("HATES_PLAYER")]="HATES_PLAYER"
    hash2fac[GetHashKey("HEN")]="HEN"
    hash2fac[GetHashKey("WILD_ANIMAL")]="WILD_ANIMAL"
    hash2fac[GetHashKey("SHARK")]="SHARK"
    hash2fac[GetHashKey("COUGAR")]="COUGAR"
    hash2fac[GetHashKey("NO_RELATIONSHIP")]="NO_RELATIONSHIP"
    hash2fac[GetHashKey("SPECIAL")]="SPECIAL"
    hash2fac[GetHashKey("MISSION2")]="MISSION2"
    hash2fac[GetHashKey("MISSION3")]="MISSION3"
    hash2fac[GetHashKey("MISSION4")]="MISSION4"
    hash2fac[GetHashKey("MISSION5")]="MISSION5"
    hash2fac[GetHashKey("MISSION6")]="MISSION6"
    hash2fac[GetHashKey("MISSION7")]="MISSION7"
    hash2fac[GetHashKey("MISSION8")]="MISSION8"
    hash2fac[GetHashKey("ARMY")]="ARMY"
    hash2fac[GetHashKey("GUARD_DOG")]="GUARD_DOG"
    hash2fac[GetHashKey("AGGRESSIVE_INVESTIGATE")]="AGGRESSIVE_INVESTIGATE"
    hash2fac[GetHashKey("MEDIC")]="MEDIC"
    hash2fac[GetHashKey("PRISONER")]="PRISONER"
    hash2fac[GetHashKey("CAT")]="CAT"
    hash2fac[GetHashKey("DEER")]="DEER"

local function copy_relationship_group(source,dest)
    for k,v in pairs(hash2fac) do
        if k==source then
            local a=GetRelationshipBetweenGroups(source,source)
            SetRelationshipBetweenGroups(a, dest, dest)
        elseif k==dest then
            local a=GetRelationshipBetweenGroups(source,dest)
            --local b=GetRelationshipBetweenGroups(dest,source)
            SetRelationshipBetweenGroups(a, dest, source)
            --SetRelationshipBetweenGroups(b, source, dest)
        else
            local a=GetRelationshipBetweenGroups(source,k)
            local b=GetRelationshipBetweenGroups(k,source)
            SetRelationshipBetweenGroups(a, dest, k)
            SetRelationshipBetweenGroups(b, k, dest)
        end
    end
end

local function relationship_mutual(rel,a,b)
   SetRelationshipBetweenGroups(rel, a, b)
   SetRelationshipBetweenGroups(rel, b, a)
end

local function relationship_self(rel,a)
   SetRelationshipBetweenGroups(rel,a,a)
end

Citizen.CreateThread(function()
    Wait(1000)
    --DisplayCash(false)
    while not NetworkIsSessionStarted() do Wait(100) end
    ReserveNetworkMissionVehicles(5) -- 3 personal + 1 carjacked + 1 trailer
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_LOST"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AGGRESSIVE_INVESTIGATE"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_BALLAS"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_FAMILY"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_MEXICAN"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_MARABUNTE"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_WEICHENG"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("AMBIENT_GANG_SALVA"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("MISSION3"))
    relationship_mutual(5, GetHashKey("PRISONER"), GetHashKey("MISSION4"))
    
    relationship_self(0, GetHashKey("AMBIENT_GANG_LOST"))
    relationship_self(0, GetHashKey("AGGRESSIVE_INVESTIGATE"))
    relationship_self(0, GetHashKey("AMBIENT_GANG_BALLAS"))
    relationship_self(0, GetHashKey("AMBIENT_GANG_FAMILY"))
    relationship_self(0, GetHashKey("AMBIENT_GANG_MEXICAN"))
    relationship_self(0, GetHashKey("AMBIENT_GANG_MARABUNTE"))
    relationship_self(0, GetHashKey("AMBIENT_GANG_WEICHENG"))
    relationship_self(0, GetHashKey("AMBIENT_GANG_SALVA"))
    relationship_self(0, GetHashKey("MISSION3"))
    relationship_self(0, GetHashKey("MISSION4"))
    relationship_mutual(2, GetHashKey("PLAYER"), GetHashKey("MISSION3"))
    relationship_mutual(2, GetHashKey("PLAYER"), GetHashKey("MISSION4"))
    
    
    relationship_mutual(4, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey("AMBIENT_GANG_FAMILY"))
    relationship_mutual(4, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey("AMBIENT_GANG_SALVA"))
    relationship_mutual(4, GetHashKey("AMBIENT_GANG_WEICHENG"), GetHashKey("AMBIENT_GANG_LOST"))
    -- SetNotificationTextEntry("STRING");
    -- local new=AddRelationshipGroup("ANARCHY")
    -- if hash2fac[new] then
    -- AddTextComponentString(new.." "..GetHashKey("ANARCHY").." "..hash2fac[new])
    -- else
    -- AddTextComponentString(new.." "..GetHashKey("ANARCHY"))
    -- end
    -- DrawNotification(false, false);
    copy_relationship_group(GetHashKey("PLAYER"),GetHashKey("MISSION2"))
    relationship_mutual(GetRelationshipBetweenGroups(GetHashKey("PLAYER"),GetHashKey("PLAYER")),GetHashKey("PLAYER"),GetHashKey("MISSION2"))
    copy_relationship_group(GetHashKey("PLAYER"),GetHashKey("MISSION3"))
    relationship_mutual(GetRelationshipBetweenGroups(GetHashKey("PLAYER"),GetHashKey("PLAYER")),GetHashKey("PLAYER"),GetHashKey("MISSION3"))
    copy_relationship_group(GetHashKey("PLAYER"),GetHashKey("MISSION4"))
    relationship_mutual(GetRelationshipBetweenGroups(GetHashKey("PLAYER"),GetHashKey("PLAYER")),GetHashKey("PLAYER"),GetHashKey("MISSION4"))
    Wait(1000)
    TriggerServerEvent(event.connected)
    Wait(1000)
    TriggerServerEvent(event.gangwarscore)
    TriggerEvent('fragile-alliance:playerspawn',PlayerPedId())
    SetNotificationTextEntry("STRING");
    AddTextComponentString("PvP is on, don't trust anyone. You can cooperate or betray players. Use ~g~phone~s~ to start.");
    DrawNotification(false, false);
    Wait(5000)
    SetNotificationTextEntry("STRING");
    AddTextComponentString("When you die - you lose everything, don't be greedy. Good luck.");
    DrawNotification(false, false);
    for i=1,3 do
        Wait(5000)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~b~discord.gg/VZG5Nvk~s~");
        DrawNotification(false, false);
    end
end)

local world={
maxx=8000.0-10,
maxy=9000.0-10,
minx=-8000.0+10,
miny=-8000.0+10,
universe_x=0,
universe_y=0,
farblips={}
}
world.minx,world.maxx=-10000.0,10000.0
world.miny,world.maxy=-9500.0,10500.0
local autopilot={
 cars_with_ai={
  [-1622444098]={786603,70.0},--voltic
  [989294410]={786603,70.0},--voltic
  [941494461]={1074528293,70.0},--ruiner2000
  [-1860900134]={262656,70.0},--insurgent pickup
  [2071877360]={262656,70.0},--insurgent
  [-1924433270]={262656,70.0},--insurgent gunrunning
  [-1894894188]={786603,60.0}, --surge
  [-884690486]={786603,50.0} --docktug
 }
}
autopilot.think=function()
    local ped=PlayerPedId()
    if IsPedInAnyPlane(ped) then
        ClearPedTasks(ped)
        local pos=GetEntityCoords(ped)
        local veh=GetVehiclePedIsUsing(ped)
        local angle=GetHeadingFromVector_2d(autopilot.x-pos.x,autopilot.y-pos.y)
        TaskPlaneMission(ped,veh,0,0,autopilot.x,autopilot.y,999.0,4,100.0,-1.0,angle,2200.0,800.0)
        --TaskPlaneLand(ped,veh,autopilot.x-dx,autopilot.y-dy,autopilot.z,autopilot.x+dx,autopilot.y+dy,autopilot.z)
    elseif IsPedInAnyHeli(ped) then
        ClearPedTasks(ped)
        local pos=GetEntityCoords(ped)
        local veh=GetVehiclePedIsUsing(ped)
        local angle=GetHeadingFromVector_2d(autopilot.x-pos.x,autopilot.y-pos.y)
        TaskHeliMission(ped,veh,0,0,autopilot.x,autopilot.y,999.0,4,80.0,-1.0,angle,0,10,5.0,32)
    --elseif IsPedInAnyBoat(ped) then
        --local veh=GetVehiclePedIsUsing(ped)
        --local speed=GetVehicleModelMaxSpeed(GetEntityModel(veh))
        --TaskBoatMission(ped,veh,0,0,autopilot.x,autopilot.y,0.0,4,speed,786469,-1.0,7)
    elseif IsPedInAnyVehicle(ped) then
        local veh=GetVehiclePedIsUsing(ped)
        local model=GetEntityModel(veh)
        local ai_type=autopilot.cars_with_ai[model]
        if ai_type then
            ClearPedTasks(ped)
            TaskVehicleDriveToCoord(ped,veh,autopilot.x,autopilot.y,autopilot.z, ai_type[2], 1.0, model, ai_type[1], 1.0, true)
        end
    end
end
autopilot.setblip=function(blip)
    local farblip=world.farblips[blip]
    if farblip then
        autopilot.blip=blip
        autopilot.farblip=true
        autopilot.x=farblip.fx
        autopilot.y=farblip.fy
        autopilot.z=farblip.z
        autopilot.think()
        return true
    elseif DoesBlipExist(blip) then
        local coords=GetBlipCoords(blip)
        autopilot.blip=blip
        autopilot.farblip=false
        autopilot.x=coords.x
        autopilot.y=coords.y
        autopilot.z=coords.z
        autopilot.think()
        return true
    end
    return false
end
autopilot.off=function(blip)
    if autopilot.blip then
        ClearPedTasks(PlayerPedId())
    end
    autopilot.blip=nil
    autopilot.farblip=false
end
local function CalculateFarCoords(x,y,ux,uy)
    return x+(ux-world.universe_x)*20000.0,y+(uy-world.universe_y)*20000.0
end
local function GetFarBlipCoords(blip)
    local v=world.farblips[blip]
    --return CalculateFarCoords(v.x,v.y,v.ux,v.uy)
    return v.fx,v.fy
end
local function UpdateFarBlips()
    for k,v in pairs(world.farblips) do
        local fx,fy=CalculateFarCoords(v.x,v.y,v.ux,v.uy)
        SetBlipCoords(k,fx,fy,v.z)
        v.fx,v.fy=fx,fy
    end
    if autopilot.farblip then
        local farblip=world.farblips[autopilot.blip]
        autopilot.x,autopilot.y=farblip.fx,farblip.fy
        autopilot.think()
    end
end
local function CreateFarBlip(x,y,z,ux,uy)
    local fx,fy=CalculateFarCoords(x,y,ux,uy)
    local blip=AddBlipForCoord(fx,fy,z)
    world.farblips[blip]={blip=blip,x=x,y=y,z=z,ux=ux,uy=uy,fx=fx,fy=fy}
    return blip
end
local function RemoveFarBlip(blip)
    if blip and type(blip)=='table' and blip.blip then
        RemoveBlip(blip.blip)
        blip=nil
    elseif world.farblips[blip] and world.farblips[blip].blip==blip then
        RemoveBlip(blip)
        world.farblips[blip]=nil
    end
end
Citizen.CreateThread(function()
Wait(5000)
 ExpandWorldLimits(world.maxx+66.6,world.maxy+66.6,0.0)
 ExpandWorldLimits(world.minx-66.6,world.miny-66.6,0.0)
 -- world.maxx=8000.0-10
 -- world.maxy=9000.0-10
 -- world.minx=-8000.0+10
 -- world.miny=-8000.0+10
 local repair=0
 while true do
  Wait(20)
  local playerid=PlayerId()
  local ped=PlayerPedId()
  local teleport=false
  local v3=GetEntityCoords(ped)
  local pos={x=v3.x,y=v3.y,z=v3.z}
  if pos.x>world.maxx then
   pos.x=(pos.x+world.minx-world.maxx)
   teleport=true
   world.universe_x=world.universe_x+1
  elseif pos.x<world.minx then
   pos.x=(pos.x+world.maxx-world.minx)
   teleport=true
   world.universe_x=world.universe_x-1
  end
  if pos.y>world.maxy then
   pos.y=(pos.y+world.miny-world.maxy)
   teleport=true
   world.universe_y=world.universe_y+1
  elseif pos.y<world.miny then
   pos.y=(pos.y+world.maxy-world.miny)
   teleport=true
   world.universe_y=world.universe_y-1
  end
  if pos.x>world.maxx-600.0 or pos.x<world.minx+600.0 or pos.y>world.maxy-600.0 or pos.y<world.miny+600.0 then
   if GetPlayerWantedLevel(playerid)>0 then
    SetPlayerWantedLevel(playerid, 0, false);
    SetPlayerWantedLevelNow(playerid, false);
    player.wanted=0
    TriggerServerEvent(event.wanted, 0)
   end
  end
  if teleport then
   local heading=GetGameplayCamRelativeHeading()
   local pitch=GetGameplayCamRelativePitch()
   if IsPedInAnyVehicle(ped) then
    local veh=GetVehiclePedIsUsing(ped)
    local vel=GetEntityVelocity(veh)
    local engine = GetVehicleEngineHealth(veh)
    SetPedCoordsKeepVehicle(ped,pos.x,pos.y,pos.z)
    if engine<1000 then
     SetVehicleEngineHealth(veh,1000.0)
     SetVehicleFixed(veh)
     repair=repair+1
     SetNotificationTextEntry("STRING");
     AddTextComponentString("Vehicle repaired "..repair.." times");
     DrawNotification(false, false);
    end
    SetEntityVelocity(veh,vel.x,vel.y,vel.z)
   else
    SetPedCoordsKeepVehicle(ped,pos.x,pos.y,pos.z)
   end
   --Wait(0)
   SetGameplayCamRelativeHeading(heading)
   SetGameplayCamRelativePitch(pitch,1.0)
   UpdateFarBlips()
  elseif player.is_cop or player.civilian then
    local veh=GetVehiclePedIsUsing(ped)
    local criminal_in_car=false
    if veh~=0 then
        for i=playerid-1,0,-1 do
            if NetworkIsPlayerActive(i) then
                local otherped=GetPlayerPed(i)
                if GetVehiclePedIsUsing(otherped)==veh and not IsPlayerCopOrCiv(otherped) then
                    criminal_in_car=true
                    break
                end
            end
        end
        for i=playerid+1,31 do
            if NetworkIsPlayerActive(i) then
                local otherped=GetPlayerPed(i)
                if GetVehiclePedIsUsing(otherped)==veh and not IsPlayerCopOrCiv(otherped) then
                    criminal_in_car=true
                    break
                end
            end
        end
    end
    if criminal_in_car then
        if GetMaxWantedLevel()~=5 then SetMaxWantedLevel(5) end
    elseif player.callingpolice then
        local loop=true
        local handle,cop=FindFirstPed()
        while loop do
            if IsPedInCombat(cop,ped) and not IsPedAPlayer(cop) and IsPedCop(cop) then
                player.callingpolice=false
                loop=false
            else
                loop,cop=FindNextPed(handle)
            end
        end
        EndFindPed(handle)
        if player.callingpolice then
            if GetMaxWantedLevel()~=3 then SetMaxWantedLevel(3) end
            if GetPlayerWantedLevel()~=3 then
                SetPlayerWantedLevel(playerid,3,false)
                SetPlayerWantedLevelNow(playerid,false)
            end
            if GetGameTimer()>player.callingpolice then player.callingpolice=false end
        end
    else
        if GetPlayerWantedLevel(playerid)~=0 then ClearPlayerWantedLevel(playerid) end
        if GetMaxWantedLevel()~=0 then SetMaxWantedLevel(0) end
    end
  elseif player.wanted==5 then
   if player.is_dead then
    --SetPlayerWantedLevel(playerid, 0, false)
    --SetPlayerWantedLevelNow(playerid, false)
    Wait(0)
    while player.is_dead do Wait(0) end
    Wait(0)
    Wait(0)
    Wait(0)
    Wait(0)
    Wait(0)
    Wait(0)
    Wait(0)
    Wait(0)
    TriggerServerEvent(event.wanted,0)
    Wait(0)
    Wait(0)
    player.wanted=0
   elseif GetPlayerWantedLevel(playerid)~=5 then
    SetPlayerWantedLevel(playerid, 5, false)
    SetPlayerWantedLevelNow(playerid, false)
   elseif ArePlayerStarsGreyedOut(playerid) then
    refresh_stars(playerid,5)
   end
   TriggerServerEvent(event.pos,pos.x,pos.y,pos.z)
  else
   local wanted_now=GetPlayerWantedLevel(playerid)
   if wanted_now~=player.wanted then
    player.wanted=wanted_now
    --if wanted_now==5 then
     --SetPlayerWantedLevelNoDrop(playerid, 5, false);
    --end
    TriggerServerEvent(event.wanted, wanted_now)
   end
   if player.wanted>0 then
    TriggerServerEvent(event.pos,pos.x,pos.y,pos.z)
   end
  end
 end
end)

RegisterNetEvent(event.top)
AddEventHandler(event.top, function(data)
    --local top="test<br>test"
    local i=1
    while true do
        local maximum=0
        local key
        for k,v in pairs(data) do
         if v.money>maximum then
          maximum=v.money
          key=k
         end
        end
        if maximum>0 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString(i..". ~g~$"..maximum.." ~s~"..data[key].name)
            DrawNotification(false, false)
            data[key]=nil
            Wait(50)
            i=i+1
        else
            break
        end
    end
    --SendNUIMessage({top_players='test'})
end)

Citizen.CreateThread(function()
Wait(5000)
    while true do 
        Citizen.Wait(5000)
        if player.is_cop and player.wanted~=nil and player.wanted~=0 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("If you will force player to surrender, you will ~g~instantly ~s~get half of their money.")
            DrawNotification(false, false);
        elseif player.wanted == 1 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("You have 1 wanted level! Press ~g~H ~s~to surrender. You will save ~g~60% ~s~of your money.")
            DrawNotification(false, false);
        elseif player.wanted == 2 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("You have 2 wanted level! Press ~g~H ~s~to surrender. You will save ~g~40% ~s~of your money.")
            DrawNotification(false, false);
        elseif player.wanted == 3 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("You have 3 wanted level! Press ~g~H ~s~to surrender. You will save ~g~30% ~s~of your money.")
            DrawNotification(false, false);
        elseif player.wanted == 4 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("You have 4 wanted level! Press ~g~H ~s~to surrender. You will save ~g~20% ~s~of your money.")
            DrawNotification(false, false);
        elseif player.wanted == 5 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("~r~You have 5 wanted level! Leave San-Andreas state to lose it.")
            DrawNotification(false, false);
            SetNotificationTextEntry("STRING");
            AddTextComponentString("You have 5 wanted level! Press ~g~H ~s~to surrender. You will save ~g~5% ~s~of your money.")
            DrawNotification(false, false);
        end
        Citizen.Wait(5000)
        if player.wanted > 0 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("~r~If you would leave server - all your current money would be dropped.")
            DrawNotification(false, false);
        end 
    end
end)

Citizen.CreateThread(function()
    Wait(6000)
    while true do
        Wait(0)
        if player.is_dead or player.in_apartment then
            player.inside=false
        else
            local ignored,h
            pos=GetEntityCoords(PlayerPedId())
            --if pos.y>150.0 then
                --if pos.x>3030.0 and pos.x<3162.0 and pos.y>2106.0 and pos.y<2260.0 and pos.z<26.0 then
                ----    h=666
                --    goto test
                --elseif pos.x<-421.0 and pos.x>-598.0 and pos.y>1885.0 and pos.y<2092.0 and pos.z<135.0 then
                --    h=666
                --    goto test
                ----else
                ----    h=45.0
                --end
            --else
            --    h=16.0
            --end
            h=350.0
            ignored,h=GetGroundZFor_3dCoord(pos.x,pos.y,pos.z+h,false)
            h=h-pos.z
            ::test::
            if h>0 then
                player.inside=true
                TriggerServerEvent(event.punishment,3,pos.x,pos.y,pos.z)
                Wait(2000)
            else
                player.inside=false
            end
        end
    end
end)

local moved_last_time=0
local save_and_quit_timeleft=0
local save_and_quit_delayed=false

Citizen.CreateThread(function()
    Wait(6000)
    local pos_old=GetEntityCoords(PlayerPedId())
    local pos
    while true do
        Wait(1000)
        local timestamp=GetGameTimer()
        if player.wanted~=0 then
            moved_last_time=timestamp
            save_and_quit_timeleft=20
        else
            pos=GetEntityCoords(PlayerPedId())
            if math.abs(pos.x-pos_old.x)+math.abs(pos.y-pos_old.y)+math.abs(pos.z-pos_old.z)>2.0 then
                moved_last_time=timestamp
                save_and_quit_timeleft=20
                pos_old=pos
                if not player.inside then
                    TriggerServerEvent(event.punishment,3,pos.x,pos.y,pos.z)
                end
            else
                local left=20000+moved_last_time-timestamp
                if left>0 then
                    save_and_quit_timeleft=math.floor(left/1000)
                else
                    save_and_quit_timeleft=0
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if player.inside then
            WriteText(0,"You can't leave server here.",0.25,255,255,255,255,0.185,0.900)
        elseif save_and_quit_delayed then
            WriteText(0,"Leaving server in "..save_and_quit_timeleft.." seconds.",0.25,255,255,255,255,0.185,0.900)
        elseif save_and_quit_timeleft>18 then
            WriteText(0,"You can't leave server while wanted or moving.",0.25,255,255,255,255,0.185,0.900)
        elseif save_and_quit_timeleft>0 then
            WriteText(0,"Wait "..save_and_quit_timeleft.." seconds to leave server.",0.25,255,255,255,255,0.185,0.900)
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
Wait(5000)
    local hasBeenDead = false
	local diedAt
    local function recalculate_height(ped,repack,height)
        while math.abs(height)>5.0 and not IsEntityInWater(ped) do
            --repack.z=repack.z-height*.5
            --SetEntityCoords(ped,repack.x,repack.y,repack.z)
            TriggerServerEvent(event.punishment,2,pos.x,pos.y,pos.z)
            Wait(1000)
            while not HasCollisionLoadedAroundEntity(ped) do
                Wait(0)
            end
            local pos=GetEntityCoords(ped)
            local delta=math.abs(pos.x-repack.x)+math.abs(pos.y-repack.y)+math.abs(pos.z-repack.z)
            repack.x,repack.y,repack.z=pos.x,pos.y,pos.z
            height=GetEntityHeightAboveGround(ped)
            if delta<0.2 then break end
        end
        return height
    end
    while true do
        Wait(0)

        local playerid = PlayerId()

        if NetworkIsPlayerActive(playerid) then
            local ped = PlayerPedId()

            if IsPedFatallyInjured(ped) and not player.is_dead then
                player.is_dead = true
                if not diedAt then
                	diedAt = GetGameTimer()
                end
                --ondeath1 vvv
                removemoney(0,player.money)
                player.money=0
                local repack={}
                repack.x=pos.x
                repack.y=pos.y
                repack.z=pos.z
                local height=GetEntityHeightAboveGround(ped)
                height=recalculate_height(ped,repack,height)
                repack.z=repack.z-height+1.0
                print("final height="..repack.z)
                TriggerEvent(event.playerdied,repack)
                TriggerServerEvent(event.playerdied,repack)
                --ondeath1 ^^^
                hasBeenDead = true
                Citizen.CreateThread(function()
                    Wait(2000)
                    player.money=0
                    Wait(2000)
                    player.money=0
                    Wait(2000)
                    player.money=0
                end)
            elseif not IsPedFatallyInjured(ped) then
                if player.is_dead then --onspawn1 vvv
                  TriggerEvent('fragile-alliance:playerspawn',ped)
                  SetNotificationTextEntry("STRING");
                  AddTextComponentString("You lost everything, but you can pick up your money back; search skull icon on map.");
                  --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 8, "Respawned", "PVP IS NOW ON");
                  DrawNotification(false, false);
                end --onspawn1 ^^^
                player.is_dead = false
                diedAt = nil
            end

            -- check if the player has to respawn in order to trigger an event
            if not hasBeenDead and diedAt ~= nil and diedAt > 0 then
                --ondeath2 vvv
                removemoney(0,player.money)
                player.money=0
                local repack={}
                repack.x=pos.x
                repack.y=pos.y
                repack.z=pos.z
                local height=GetEntityHeightAboveGround(ped)
                height=recalculate_height(ped,repack,height)
                repack.z=repack.z-height+1.0
                print("final height="..repack.z)
                TriggerEvent(event.wasted, repack)
                TriggerServerEvent(event.wasted, repack)
                --ondeath2 ^^^
                hasBeenDead = true
                Citizen.CreateThread(function()
                    Wait(2000)
                    player.money=0
                    Wait(2000)
                    player.money=0
                    Wait(2000)
                    player.money=0
                end)
            elseif hasBeenDead and diedAt ~= nil and diedAt <= 0 then
                --onspawn2 vvv
                TriggerEvent('fragile-alliance:playerspawn',ped)
                SetNotificationTextEntry("STRING");
                AddTextComponentString("respawn2");
                SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, "test", "message");
                DrawNotification(false, false);
                --onspawn2 ^^^
                hasBeenDead = false
            end
            
            -- local wanted_now=GetPlayerWantedLevel(playerid)
            -- if wanted_now~=player.wanted then
                -- player.wanted=wanted_now
                -- TriggerServerEvent(event.wanted, wanted_now)
            -- end
        end
    end
end)

RegisterNetEvent(event.wanted)
AddEventHandler(event.wanted,function(level)
    local playerid=PlayerId()
    if GetPlayerWantedLevel(playerid)<level then
        SetPlayerWantedLevel(playerid,level,false)
        SetPlayerWantedLevelNow(playerid,false)
    end
end)

--Hash GET_SELECTED_PED_WEAPON(Ped ped);
--GET_CURRENT_PED_WEAPON(Ped ped, Hash* weaponHash, BOOL p2);
--SET_CURRENT_PED_WEAPON(Ped ped, Hash weaponHash, BOOL equipNow);
--GET_PED_WEAPONTYPE_IN_SLOT(Ped ped, Hash weaponSlot);
--GET_PED_AMMO_BY_TYPE(Ped ped, Any ammoType);
--GET_PED_AMMO_TYPE_FROM_WEAPON(Ped ped, Hash weaponHash);

local join_faction={},switch_to_criminal,switch_to_firefighters,switch_to_paramedics,switch_to_fbi,switch_to_fbiswat,switch_to_detectives,switch_to_lspd,switch_to_lspdheavy,switch_to_sspd,switch_to_sahp,switch_to_sapr,switch_to_noose,switch_to_military,switch_to_navy,switch_to_lost,switch_to_merc,switch_to_anarchy,switch_to_ballas,switch_to_fams,switch_to_vagos,switch_to_salva,switch_to_triads,switch_to_armmob,switch_to_heister,switch_to_cartel,switch_to_elite
local allies_government={}
local allies_lost={}
local allies_mercs={}
local allies_anarchy={}
local allies_ballas={}
local allies_fams={}
local allies_vagos={}
local allies_salva={}
local allies_triads={}
local allies_armmob={}
local allies_heister={}
local allies_cartel={}
local allies_elite={}

AddEventHandler('playerSpawned',function()
    player.surrendering=false
    local ped=PlayerPedId()
    --NetworkSetFriendlyFireOption(true)
    --SetCanAttackFriendly(ped, true, false)
    --SetPedDropsWeaponsWhenDead(ped, true);
end)

AddEventHandler("fragile-alliance:playerspawn",function(ped)
    --local ped = PlayerPedId()
        Wait(100)
        local melee={WEAPON.KNIFE,WEAPON.NIGHTSTICK,WEAPON.HAMMER,WEAPON.BAT,WEAPON.GOLFCLUB,WEAPON.CROWBAR,WEAPON.BOTTLE,WEAPON.DAGGER,WEAPON.KNUCKLE,WEAPON.HATCHET,WEAPON.MACHETE,WEAPON.SWITCHBLADE,WEAPON.BATTLEAXE,WEAPON.POOLCUE,WEAPON.WRENCH}
        local guns={WEAPON.SNSPISTOL,WEAPON.VINTAGEPISTOL}
        local ammo={                42,           35}
        local i=math.random(#guns)
        GiveWeaponToPed(ped, guns[i], ammo[i], false, true)
        i=math.random(#melee)
        GiveWeaponToPed(ped, melee[i], 0, false, true)
        SetPedRandomComponentVariation(ped, false)
        --if garages then
        if spawn_point then
            player.propertyname=spawn_point.propertyname
            player.property=spawn_point.property
            DecorSetInt(ped,"interiorhash",GetHashKey(player.propertyname))
            SetEntityCoords(ped,spawn_point.x,spawn_point.y,spawn_point.z)
        elseif relationship_friend==GetHashKey("COP") then
            SetEntityCoords(ped,basecoords.x,basecoords.y,basecoords.z)
        elseif relationship_friend==GetHashKey("AMBIENT_GANG_LOST") then
            SetEntityCoords(ped,984.76843261719,-91.682571411133,74.848892211914)
        elseif relationship_friend==GetHashKey("AGGRESSIVE_INVESTIGATE") then
            SetEntityCoords(ped,484.337890625,-3052.2468261719,6.2286891937256)
        elseif relationship_friend==GetHashKey("MISSION2") then
            SetEntityCoords(ped,707.38952636719,-967.00140380859,30.412853240967)
        elseif relationship_friend==GetHashKey("AMBIENT_GANG_BALLAS") then
            SetEntityCoords(ped,78.277633666992,-1974.7937011719,20.911375045776)
        elseif relationship_friend==GetHashKey("AMBIENT_GANG_FAMILY") then
            SetEntityCoords(ped,-11.148657798767,-1433.2587890625,31.116823196411)
        elseif relationship_friend==GetHashKey("AMBIENT_GANG_MEXICAN") then
            SetEntityCoords(ped,967.79791259766,-1828.583984375,31.236526489258)
        elseif relationship_friend==GetHashKey("AMBIENT_GANG_SALVA") then
            SetEntityCoords(ped,1230.8974609375,-1591.1851806641,53.820705413818)
        elseif relationship_friend==GetHashKey("AMBIENT_GANG_WEICHENG") then
            SetEntityCoords(ped,-775.37646484375,-890.73687744141,21.605070114136)
        elseif relationship_friend==GetHashKey("AMBIENT_GANG_MARABUNTE") then
            SetEntityCoords(ped,-429.05123901367,-1728.0805664063,19.783840179443)
        elseif relationship_friend==GetHashKey("MISSION3") then
            SetEntityCoords(ped,134.90467834473,323.68109130859,116.72046661377)
        elseif relationship_friend==GetHashKey("MISSION4") then
            SetEntityCoords(ped,-70.679946899414,359.08154296875,112.44521331787)
        -- elseif relationship_friend==GetHashKey("AMBIENT_GANG_MEXICAN") then      -- cartel
            -- SetEntityCoords(ped,1394.7595214844,1141.8107910156,114.61865997314)
        -- else
            -- if spawn_garage then
                -- if not spawn_garage.car then
                    -- spawn_garage={}
                    -- spawn_garage=nil
                -- end
            -- end
            -- if not spawn_garage then
                -- local spawnpoints={}
                -- local i=0
                -- for k,v in pairs(garages) do
                    -- if v.car then
                        -- i=i+1
                        -- spawnpoints[i]=k
                    -- end
                -- end
                -- if i>1 then
                    -- spawn_garage=garages[spawnpoints[math.random(i)]]
                -- elseif i==1 then
                    -- spawn_garage=garages[spawnpoints[1]]
                -- end
            -- end
            -- if spawn_garage then
                -- SetEntityCoords(ped,spawn_garage.x,spawn_garage.y,spawn_garage.z)
            -- end
        end
        player.surrendering=false
        switch_to_criminal()
end)

-- AddEventHandler("fragile-alliance:playerwasted",function(pos)
    -- player.money=0
    -- TriggerServerEvent('fragile-alliance:drop_money',pos)
-- end)
-- AddEventHandler(event.playerdied,function(pos)
    -- player.money=0
    -- TriggerServerEvent('fragile-alliance:drop_money',pos)
-- end)

local function WaitWithMarker(delay,int0,x,y,z,float1,float2,float3,float4,float5,float6,float7r,float8r,float9h,red,green,blue,alpha,int1,bool1,bool2,int2,bool3,bool4,bool5,bool6)
    local fin=GetGameTimer()+delay
    repeat
        DrawMarker(int0,x,y,z,float1,float2,float3,float4,float5,float6,float7r,float8r,float9h,red,green,blue,alpha,int1,bool1,bool2,int2,bool3,bool4,bool5,bool6)
        Wait(0)
    until GetGameTimer()>fin
end

local function WaitWithBox(delay,x1,y1,z1,x2,y2,z2,r,g,b,a)
    local fin=GetGameTimer()+delay
    repeat
        DrawBox(x1,y1,z1,x2,y2,z2,r,g,b,a)
        Wait(0)
    until GetGameTimer()>fin
end

Citizen.CreateThread(function()
    local bkr_prop_money_unsorted_01=GetHashKey("bkr_prop_money_unsorted_01") --змотанные деньги (<1000)
    local bkr_prop_bkr_cash_roll_01=GetHashKey("bkr_prop_bkr_cash_roll_01") -- 4 свернутых рулона (1000-5000)
    local prop_poly_bag_money=GetHashKey("prop_poly_bag_money") --прозрачный пакет (5000-20000)
    local bkr_prop_duffel_bag_01a=GetHashKey("bkr_prop_duffel_bag_01a") --черная маленькая сумка (20000-40000)
    local prop_cash_case_01=GetHashKey("prop_cash_case_01") --черный открытый кейс (40000-60000)
    local prop_cash_case_02=GetHashKey("prop_cash_case_02") --белый открытый кейс (60000-80000)
    local prop_cs_heist_bag_02=GetHashKey("prop_cs_heist_bag_02") --средняя сумка (10000-100000)
    local prop_big_bag_01=GetHashKey("prop_big_bag_01") --большая черная спортивная сумка (100000-500000)
    local prop_hockey_bag_01=GetHashKey("prop_hockey_bag_01") --огромная сумка (500000+)

    local bkr_prop_moneypack_02a=GetHashKey("bkr_prop_moneypack_02a") --лист пачек метр на метр, в сумме 25к (становятся ввысоту до 15 пачек, то есть 375.000, после чего смещяются на метр и строят вторую колонну, потом поварачиваются в квадрат)
    local bkr_prop_moneypack_03a=GetHashKey("bkr_prop_moneypack_03a") --лист пачек, в сумме 9к
    local bkr_prop_moneypack_01a=GetHashKey("bkr_prop_moneypack_01a") --пачка, в сумме 1к
    
    local bkr_prop_weed_bigbag_03a=GetHashKey("bkr_prop_weed_bigbag_03a") -- мешок с виид  (10к, стакаться до 4)
    local bkr_prop_weed_bigbag_02a=GetHashKey("bkr_prop_weed_bigbag_02a") -- мешок с виид  
    local bkr_prop_weed_bigbag_01a=GetHashKey("bkr_prop_weed_bigbag_01a") -- мешок с виид  
    local bkr_prop_weed_smallbag_01a=GetHashKey("bkr_prop_weed_smallbag_01a") -- большйо пакет с виид (1к)
    
    local hei_p_attache_case_shut=GetHashKey("hei_p_attache_case_shut") -- кейс с оружием
    
    local ex_prop_adv_case_sm_02=GetHashKey("ex_prop_adv_case_sm_02") -- ящик (25к), стакается по 3
    local ex_office_swag_jewelwatch3=GetHashKey("ex_office_swag_jewelwatch3") -- драгоценности 20к
    local ex_office_swag_jewelwatch2=GetHashKey("ex_office_swag_jewelwatch2") -- драгоценности 10к
    
    local v_res_paperfolders=GetHashKey("v_res_paperfolders") -- 2к стакается до 6
    local prop_cd_folder_pile4=GetHashKey("prop_cd_folder_pile4") -- 2к
    local prop_cs_documents_01=GetHashKey("prop_cs_documents_01") --2к
    local prop_laptop_02_closed=GetHashKey("prop_laptop_02_closed")
    
    local bkr_prop_coke_cutblock_01=GetHashKey("bkr_prop_coke_cutblock_01") --кокаинум
    
    local prop_gold_bar=GetHashKey("prop_gold_bar") --золото
    
    local hei_prop_hei_drug_pack_02=GetHashKey("hei_prop_hei_drug_pack_02") --хероин
    local hei_prop_hei_drug_pack_01b=GetHashKey("hei_prop_hei_drug_pack_01b")
    local hei_prop_hei_drug_case=GetHashKey("hei_prop_hei_drug_case")
    local prop_drug_package=GetHashKey("prop_drug_package")
    
    local v_ind_cs_chemcan=GetHashKey("v_ind_cs_chemcan") --chemicals
    
    local currently_used_models={}
    local all_loaded_models={}
    local cant_load_some_models=false
    
    local boxes={}
    boxes[hei_p_attache_case_shut]={c=4000,h=0.11}
    local boxes_pile={
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    hei_p_attache_case_shut,
    }
    local chemicals={}
    chemicals[v_ind_cs_chemcan]={c=2000,h=0.38}
    local chemicals_pile={
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,{y=.15,h=0},
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,{y=-.15,h=0},
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,{y=.30,h=0},
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,{y=-.30,h=0},
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,{y=.45,h=0},
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,{y=-.45,h=0},
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,{y=.60,h=0},
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,
    v_ind_cs_chemcan,{y=-.60,h=0},
    }
    local heroin={}
    heroin[hei_prop_hei_drug_case]={c=10000,h=2.5}
    heroin[hei_prop_hei_drug_pack_01b]={c=2000,h=0.14}
    heroin[hei_prop_hei_drug_pack_02]={c=1000,h=2.5}
    heroin[prop_drug_package]={c=10000,h=0.27}
    local heroin_pile={
    hei_prop_hei_drug_case,{x=.54,h=0},
    hei_prop_hei_drug_pack_01b,
    hei_prop_hei_drug_pack_01b,
    hei_prop_hei_drug_pack_01b,
    hei_prop_hei_drug_pack_01b,
    hei_prop_hei_drug_pack_01b,
    hei_prop_hei_drug_pack_02,{x=-.64,h=0},
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,{y=0.40,h=0},
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    prop_drug_package,
    }
    local coke={}
    coke[bkr_prop_coke_cutblock_01]={c=30000,h=0.05}
    local coke_pile={
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,{x=0.14,h=0},
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,{x=0.28,h=0},
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,{x=0.42,h=0},
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,{x=0.56,h=0},
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,
    bkr_prop_coke_cutblock_01,{x=0.70,h=0},
    }
    local gold={}
    gold[prop_gold_bar]={c=40000,h=0.06}
    local gold_pile={
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09,h=0}, --200000
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09*2,h=0}, --400000
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09*3,h=0}, --600000
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09*4,h=0}, --800000
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09*5,h=0}, --1000000
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09*6,h=0}, --1200000
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09*7,h=0}, --1400000
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09*8,h=0}, --1600000
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09*9,h=0}, --1800000
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,
    prop_gold_bar,{x=0.09*10,h=0}, --2000000
    }
    
    local documents={}
    documents[prop_cs_documents_01]={c=1000,h=.01}
    documents[prop_cd_folder_pile4]={c=2000,h=.11}
    documents[v_res_paperfolders]={c=4000,h=.22}
    documents[prop_laptop_02_closed]={c=50000,h=.04,y=.12}
    local documents_pile={
    prop_cs_documents_01,
    prop_cd_folder_pile4,
    v_res_paperfolders,
    prop_cd_folder_pile4,
    prop_cd_folder_pile4,
    prop_laptop_02_closed,
    prop_cd_folder_pile4,
    prop_cd_folder_pile4,
    prop_cs_documents_01,
    prop_cd_folder_pile4,
    v_res_paperfolders,
    prop_cd_folder_pile4,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_cs_documents_01,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    prop_laptop_02_closed,
    }

    local function universal_pile(v,key,props,pile)
        local cant_load_important_models=false
        local construction
        --local need_to_free_models=false
        for k,v in pairs(props) do
            currently_used_models[k]=true
            RequestModel(k)
            if not HasModelLoaded(k) then
                cant_load_important_models=true
            end
        end
        if cant_load_important_models then
            cant_load_some_models=true
        elseif money_bags[key]==nil then
            
            if money_drops[key] then
                construction={}
                money_bags[key]=construction
            end
            --need_to_free_models=true
        elseif type(money_bags[key])=='table' then
            construction=money_bags[key]
        end
        if construction~=nil then
            local money=v.money
            local h=-1.0
            local x=.0
            local y=.0
            local i=1
            while money>0 do
                local model=pile[i]
                if type(model)=='table' then
                    if model.x~=nil then x=model.x end
                    if model.y~=nil then y=model.y end
                    if model.h~=nil then h=model.h-1.0 end
                else
                    local prop=props[model]
                    if model==nil then break end
                    local obj=construction[i]
                    if obj==nil then
                        local fx,fy,fz=v.x+x,v.y+y,v.z+h
                        if prop.x~=nil then fx=fx+prop.x end
                        if prop.y~=nil then fy=fy+prop.y end
                        obj=CreateObject(model, fx, fy, fz, false, false, false)
                        FreezeEntityPosition(obj,true)
                        construction[i]=obj
                    end
                    h=h+prop.h
                    money=money-prop.c
                end
                i=i+1
            end
            while i<50 do
                local obj=construction[i]
                if obj~=nil then
                    remove_local_object(obj)
                    construction[i]=nil
                end
                i=i+1
            end
        end
        --if need_to_free_models then
        --    for k,v in pairs(props) do
        --        SetModelAsNoLongerNeeded(k)
        --    end
        --end
    end
    
    local function simple_pile(v,key,props,pile,x_step,max_height)
        local cant_load_important_models=false
        local construction
        --local need_to_free_models=false
        for k,v in pairs(props) do
            currently_used_models[k]=true
            RequestModel(k)
            if not HasModelLoaded(k) then
                cant_load_important_models=true
            end
        end
        if cant_load_important_models then
            cant_load_some_models=true
        elseif money_bags[key]==nil then
            
            if money_drops[key] then
                construction={}
                money_bags[key]=construction
            end
            --need_to_free_models=true
        elseif type(money_bags[key])=='table' then
            construction=money_bags[key]
        end
        if construction~=nil then
            local money=v.money
            local h=-1.0
            local x=.0
            local i=1
            max_height=max_height-1.0
            while money>0 do
                local model=pile[i]
                local prop=props[model]
                if model==nil then break end
                local obj=construction[i]
                if obj==nil then
                    local fx,fy,fz=v.x+x,v.y,v.z+h
                    if prop.x~=nil then fx=fx+prop.x end
                    if prop.y~=nil then fy=fy+prop.y end
                    obj=CreateObject(model, fx, fy, fz, false, false, false)
                    FreezeEntityPosition(obj,true)
                    construction[i]=obj
                end
                h=h+prop.h
                if h>max_height then
                    h=-1.0
                    x=x+x_step
                    if x>x_step+.001 then
                        x=-x_step
                    end
                end
                money=money-prop.c
                i=i+1
            end
            while i<50 do
                local obj=construction[i]
                if obj~=nil then
                    remove_local_object(obj)
                    construction[i]=nil
                end
                i=i+1
            end
        end
        --if need_to_free_models then
        --    for k,v in pairs(props) do
        --        SetModelAsNoLongerNeeded(k)
        --    end
        --end
    end
--=GetHashKey("")

    Wait(5000)
    while true do
        local distance=9.0
        local closest=nil
        Wait(0)
        pos=GetEntityCoords(PlayerPedId())
        cant_load_some_models=false
        for key, v in pairs(money_drops) do
            if v then
                local dx,dy,dz=v.x-pos.x,v.y-pos.y,v.z-pos.z
                local square=dx*dx+dy*dy+dz*dz
                if square<2500.0 then
                    --local r_color=51*v.wanted
                    --local g_color=255-r_color
                    --DrawMarker(1, v.x, v.y, v.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.r, v.r, 1.0, r_color, g_color, 0, 128, false, true, 2, false, false, false, false)
                    if not player.is_dead then
                        if square<distance then
                            distance=square
                            closest=key
                        elseif key<0 and square<100.0 and not (player.is_cop or player.civilian) then
                            local playerid=PlayerId()
                            local current_wanted=GetPlayerWantedLevel(playerid)
                            if v.wanted>current_wanted then
                                SetPlayerWantedLevel(playerid, v.wanted, false)
                                SetPlayerWantedLevelNow(playerid,false)
                            elseif v.wanted==current_wanted and ArePlayerStarsGreyedOut(playerid) then
                                refresh_stars(playerid, v.wanted)
                            end
                        end
                    end
                    if key<0 then --heist
                        if v.sprite==408 then -- jewelry

                            local construction_big
                            local construction_medium
                            local construction_small
                            --local need_to_free_models=false
                                
                            currently_used_models[ex_prop_adv_case_sm_02]=true
                            currently_used_models[ex_office_swag_jewelwatch3]=true
                            currently_used_models[ex_office_swag_jewelwatch2]=true
                            RequestModel(ex_prop_adv_case_sm_02)
                            RequestModel(ex_office_swag_jewelwatch3)
                            RequestModel(ex_office_swag_jewelwatch2)
                            if not HasModelLoaded(ex_prop_adv_case_sm_02) or
                               not HasModelLoaded(ex_office_swag_jewelwatch3) or
                               not HasModelLoaded(ex_office_swag_jewelwatch2) then
                               cant_load_some_models=true
                            elseif money_bags[key]==nil then
                                if money_drops[key] then
                                --it's important check, because heist could end while we were waiting for models to load
                                    construction_big={}
                                    construction_medium={}
                                    construction_small={}
                                    money_bags[key]={[1]=construction_big,[2]=construction_medium,[3]=construction_small}
                                end
                                --need_to_free_models=true
                            elseif type(money_bags[key])=='table' then
                                construction_big=money_bags[key][1]
                                construction_medium=money_bags[key][2]
                                construction_small=money_bags[key][3]
                            end
                            if construction_big~=nil and construction_medium~=nil and construction_small~=nil then
                                local big_things=math.floor(v.money/25000.0)
                                local small_things=math.floor(v.money-big_things*25000)
                                
                                local model=ex_prop_adv_case_sm_02
                                for i=1,big_things do
                                    local obj=construction_big[i]
                                    if obj==nil then
                                        obj=CreateObject(model, v.x, v.y, v.z-1.44+i*.44, false, false, false)
                                        FreezeEntityPosition(obj,true)
                                        construction_big[i]=obj
                                    end
                                end
                                for i=big_things+1,50 do
                                    local obj=construction_big[i]
                                    if obj~=nil then
                                        remove_local_object(obj)
                                        construction_big[i]=nil
                                    end
                                end
                                
                                local obj
                                if small_things>18000 then
                                    --normal+small
                                    obj=construction_medium[1]
                                    if obj==nil then
                                        obj=CreateObject(ex_office_swag_jewelwatch3, v.x, v.y, v.z-.995+big_things*.44, false, false, false)
                                        FreezeEntityPosition(obj,true)
                                        construction_medium[1]=obj
                                    else
                                        SetEntityCoords(obj, v.x, v.y, v.z-.985+big_things*.44)
                                    end
                                    obj=construction_small[1]
                                    if obj==nil then
                                        obj=CreateObject(ex_office_swag_jewelwatch2, v.x+.13, v.y-.03, v.z-.935+big_things*.44, false, false, false)
                                        FreezeEntityPosition(obj,true)
                                        construction_small[1]=obj
                                    else
                                        SetEntityCoords(obj, v.x+.13, v.y-.03, v.z-.925+big_things*.44)
                                    end
                                elseif small_things>10000 then
                                    --normal
                                    obj=construction_medium[1]
                                    if obj==nil then
                                        obj=CreateObject(ex_office_swag_jewelwatch3, v.x, v.y, v.z-.995+big_things*.44, false, false, false)
                                        FreezeEntityPosition(obj,true)
                                        construction_medium[1]=obj
                                    else
                                        SetEntityCoords(obj, v.x, v.y, v.z-.985+big_things*.44)
                                    end
                                    obj=construction_small[1]
                                    if obj~=nil then
                                        remove_local_object(obj)
                                        construction_small[1]=nil
                                    end
                                elseif small_things>2000 then
                                    --small
                                    obj=construction_medium[1]
                                    if obj~=nil then
                                        remove_local_object(obj)
                                        construction_medium[1]=nil
                                    end
                                    obj=construction_small[1]
                                    if obj==nil then
                                        obj=CreateObject(ex_office_swag_jewelwatch2, v.x, v.y, v.z-1.0+big_things*.44, false, false, false)
                                        FreezeEntityPosition(obj,true)
                                        construction_small[1]=obj
                                    else
                                        SetEntityCoords(obj, v.x, v.y, v.z-.99+big_things*.44)
                                    end
                                else
                                    --empty
                                    obj=construction_medium[1]
                                    if obj~=nil then
                                        remove_local_object(obj)
                                        construction_medium[1]=nil
                                    end
                                    obj=construction_small[1]
                                    if obj~=nil then
                                        remove_local_object(obj)
                                        construction_small[1]=nil
                                    end
                                end
                                
                            end
                            --if need_to_free_models then
                            --    SetModelAsNoLongerNeeded(ex_prop_adv_case_sm_02)
                            --    --SetModelAsNoLongerNeeded(ex_office_swag_jewelwatch3) --can reappear
                            --    --SetModelAsNoLongerNeeded(ex_office_swag_jewelwatch2) --can reappear
                            --end
                        
                        elseif v.sprite==478 then -- crate
                            universal_pile(v,key,boxes,boxes_pile)
                        elseif v.sprite==496 then -- weed
                            local construction_big
                            local construction_small
                            --local need_to_free_models=false
                            currently_used_models[bkr_prop_weed_bigbag_03a]=true
                            currently_used_models[bkr_prop_weed_smallbag_01a]=true
                                
                            RequestModel(bkr_prop_weed_bigbag_03a) --52x70x29
                            RequestModel(bkr_prop_weed_smallbag_01a) --63x68x21
                            if not HasModelLoaded(bkr_prop_weed_bigbag_03a) or
                               not HasModelLoaded(bkr_prop_weed_smallbag_01a) then
                               cant_load_some_models=true
                            elseif money_bags[key]==nil then
                                
                                if money_drops[key] then
                                --it's important check, because heist could end while we were waiting for models to load
                                    construction_big={}
                                    construction_small={}
                                    money_bags[key]={[1]=construction_big,[2]=construction_small}
                                end
                                --need_to_free_models=true
                            elseif type(money_bags[key])=='table' then
                                construction_big=money_bags[key][1]
                                construction_small=money_bags[key][2]
                            end
                            if construction_big~=nil and construction_small~=nil then
                                local big_things=math.floor((v.money-1000)/2000)
                                local small_things=math.floor(v.money/2000)
                                local model
                                
                                model=bkr_prop_weed_bigbag_03a
                                for i=1,big_things do
                                    local obj=construction_big[i]
                                    if obj==nil then
                                        obj=CreateObject(model, v.x, v.y-.36, v.z-1.29+i*.29, false, false, false)
                                        FreezeEntityPosition(obj,true)
                                        construction_big[i]=obj
                                    end
                                end
                                for i=big_things+1,50 do
                                    local obj=construction_big[i]
                                    if obj~=nil then
                                        remove_local_object(obj)
                                        construction_big[i]=nil
                                    end
                                end
                                
                                model=bkr_prop_weed_smallbag_01a
                                for i=1,small_things do
                                    local obj=construction_small[i]
                                    if obj==nil then
                                        obj=CreateObject(model, v.x, v.y+.36, v.z-1.15+i*0.15, false, false, false)
                                        FreezeEntityPosition(obj,true)
                                        construction_small[i]=obj
                                    end
                                end
                                for i=small_things+1,50 do
                                    local obj=construction_small[i]
                                    if obj~=nil then
                                        remove_local_object(obj)
                                        construction_small[i]=nil
                                    end
                                end
                            end
                            --if need_to_free_models then
                            --    SetModelAsNoLongerNeeded(bkr_prop_weed_bigbag_03a)
                            --    SetModelAsNoLongerNeeded(bkr_prop_weed_smallbag_01a)
                            --end
                        elseif v.sprite==498 then -- documents?
                            simple_pile(v,key,documents,documents_pile,.46,0.9)
                        elseif v.sprite==499 then -- chemicals
                            universal_pile(v,key,chemicals,chemicals_pile)
                        elseif v.sprite==500 then -- money
                            local construction_big
                            local construction_small
                            --local need_to_free_models=false
                            currently_used_models[bkr_prop_moneypack_02a]=true
                            currently_used_models[bkr_prop_moneypack_01a]=true
                            RequestModel(bkr_prop_moneypack_02a)
                            RequestModel(bkr_prop_moneypack_01a)
                            if not HasModelLoaded(bkr_prop_moneypack_02a) or
                               not HasModelLoaded(bkr_prop_moneypack_01a) then
                               cant_load_some_models=true
                            elseif money_bags[key]==nil then
                                
                                
                                if money_drops[key] then
                                --it's important check, because heist could end while we were waiting for models to load
                                    construction_big={}
                                    construction_small={}
                                    money_bags[key]={[1]=construction_big,[2]=construction_small}
                                end
                                --need_to_free_models=true
                            elseif type(money_bags[key])=='table' then
                                construction_big=money_bags[key][1]
                                construction_small=money_bags[key][2]
                            end
                            if construction_big~=nil and construction_small~=nil then
                                
                                local big_things=math.floor(v.money/25000)
                                local small_things=math.floor(v.money/1000)-big_things*25
                                local model
                                
                                model=bkr_prop_moneypack_02a
                                for i=1,big_things do
                                    local obj=construction_big[i]
                                    if obj==nil then
                                        obj=CreateObject(model, v.x, v.y, v.z-1.07+i*.07, false, false, false)
                                        FreezeEntityPosition(obj,true)
                                        construction_big[i]=obj
                                    end
                                end
                                for i=big_things+1,50 do
                                    local obj=construction_big[i]
                                    if obj~=nil then
                                        remove_local_object(obj)
                                        construction_big[i]=nil
                                    end
                                end
                                
                                model=bkr_prop_moneypack_01a
                                local x=-.304 --32
                                local y=-.288 --28
                                for i=1,small_things do
                                    local obj=construction_small[i]
                                    if obj==nil then
                                        obj=CreateObject(model, v.x+x, v.y+y, v.z-1.00+big_things*0.07, false, false, false)
                                        FreezeEntityPosition(obj,true)
                                        construction_small[i]=obj
                                    else
                                        SetEntityCoords(obj,v.x+x, v.y+y, v.z-1.00+big_things*0.07)
                                    end
                                    x=x+.152 --16
                                    if x>.304 then --32
                                        y=y+.144 --14
                                        x=-.304 --32
                                    end
                                end
                                for i=small_things+1,26 do
                                    local obj=construction_small[i]
                                    if obj~=nil then
                                        remove_local_object(obj)
                                        construction_small[i]=nil
                                    end
                                end
                            end
                            --if need_to_free_models then
                            --    SetModelAsNoLongerNeeded(bkr_prop_moneypack_02a)
                                -- --SetModelAsNoLongerNeeded(bkr_prop_moneypack_01a) --can reappear
                            --end
                        elseif v.sprite==501 then -- heroin
                            universal_pile(v,key,heroin,heroin_pile)
                        elseif v.sprite==514 then -- coke
                            universal_pile(v,key,coke,coke_pile)
                        elseif v.sprite==269 then -- gold
                            universal_pile(v,key,gold,gold_pile)
                        elseif v.sprite==440 then -- meth
                            universal_pile(v,key,coke,coke_pile)
                        elseif v.sprite==521 then -- laptop
                            simple_pile(v,key,documents,documents_pile,.46,1.7)
                        end
                    elseif money_bags[key]==nil then
                        local model
                        if v.money<=1000 then
                            model=bkr_prop_money_unsorted_01 --змотанные деньги (<1000)
                        elseif v.money<=5000 then
                            model=bkr_prop_bkr_cash_roll_01 -- 4 свернутых рулона (1000-5000)
                        elseif v.money<=20000 then
                            model=prop_poly_bag_money --прозрачный пакет (5000-20000)
                        elseif v.money<=40000 then
                            model=bkr_prop_duffel_bag_01a --черная маленькая сумка (20000-40000)
                        elseif v.money<=60000 then
                            model=prop_cash_case_01 --черный открытый кейс (40000-60000)
                        elseif v.money<=80000 then
                            model=prop_cash_case_02 --белый открытый кейс (60000-80000)
                        elseif v.money<=100000 then
                            model=prop_cs_heist_bag_02 --средняя сумка (10000-100000)
                        elseif v.money<=500000 then
                            model=prop_big_bag_01 --большая черная спортивная сумка (100000-500000)
                        else
                            model=prop_hockey_bag_01 --огромная сумка (500000+)
                        end
                        currently_used_models[model]=true
                        RequestModel(model)
                        if not HasModelLoaded(model) then
                            cant_load_some_models=true
                        else
                            local obj
                            if model==prop_hockey_bag_01 then
                                obj=CreateObject(model, v.x+.6, v.y, v.z-1.8, false, false, false)
                                SetEntityRotation(obj,0.0,48.0,0.0,1,true)
                            else
                                obj=CreateObject(model, v.x, v.y, v.z-1.0, false, false, false)
                            end
                            FreezeEntityPosition(obj,true)
                            SetEntityCollision(obj,false,false)
                            SetModelAsNoLongerNeeded(model)
                            money_bags[key]=obj
                        end
                    end
                end
            end
        end
        for k,v in pairs(all_loaded_models) do
            if v and not currently_used_models[k] then
                SetModelAsNoLongerNeeded(k)
                all_loaded_models[k]=false
            end
        end
        for k,v in pairs(currently_used_models) do
            if v then
                all_loaded_models[k]=true
            end
            currently_used_models[k]=false
        end
        if cant_load_some_models then
            WriteText(0,"Trying to load models",0.25,25,255,100,255,0.95,0.5)
        end
        if not player.civilian and closest~=nil then
            local v=money_drops[closest]
            if v then
                --local r_color=51*v.wanted
                --local g_color=255-r_color
                TriggerServerEvent('fragile-alliance:take_money',closest)
                local delay=2000
                if player.is_cop then
                    if closest<0 then
                        delay=20000 --heist
                    else
                        if GetEntityModel(PlayerPedId())==-362977881 then --dick
                            delay=10000 --skull dick
                        else
                            delay=16000 --skull cops
                        end
                    end
                else
                    local playerid=PlayerId()
                    local current_wanted=GetPlayerWantedLevel(playerid)
                    if v.wanted>current_wanted then
                        SetPlayerWantedLevel(playerid, v.wanted, false)
                        SetPlayerWantedLevelNow(playerid,false)
                    elseif v.wanted==current_wanted and ArePlayerStarsGreyedOut(playerid) then
                        refresh_stars(playerid, v.wanted)
                    end
                end
                Wait(delay)
                --WaitWithMarker(delay,1,v.x,v.y,v.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.r, v.r, 1.0, r_color, g_color, 0, 32, false, true, 2, false, false, false, false)
            end
        end
    end
end)

Citizen.CreateThread(function()
Wait(5000)
  while true do
    while player.civilian or player.is_cop do --or GetPedRelationshipGroupHash(PlayerdPed(-1))==GetHashKey("AGGRESSIVE_INVESTIGATE")  do
        if IsControlPressed(0,288) or IsControlPressed(0,289) then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("This faction can't find or make money stashes.")
            DrawNotification(false, false);
            Wait(5000)
        else
            Wait(0)
        end
    end
    if IsControlPressed(0,288) and IsInputDisabled(2) then
        if player.money==nil or player.money<5000 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("You need at least $5000 to hide money.")
            DrawNotification(false, false);
        end
        pos=GetEntityCoords(PlayerPedId())
        local x,y,z=math.floor(pos.x),math.floor(pos.y),math.floor(pos.z)
        TriggerServerEvent(event.stash_hide,x,y,z)
        WaitWithBox(1000,x-.0,y-.0,z-.0,x+1.0,y+1.0,z+1.0,255,255,255,64)
    elseif IsControlPressed(0,289) and IsInputDisabled(2) then
        pos=GetEntityCoords(PlayerPedId())
        local x,y,z=math.floor(pos.x),math.floor(pos.y),math.floor(pos.z)
        TriggerServerEvent(event.stash_take,x,y,z)
        WaitWithBox(1000,x-.0,y-.0,z-.0,x+1.0,y+1.0,z+1.0,255,255,255,64)
    else
        Wait(0)
    end
  end
end)

local function createcar(hash,x,y,z,angle)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(10) end
    local car=CreateVehicle(hash,x,y,z-.99,angle,true,false)
    SetModelAsNoLongerNeeded(hash)
    SetVehicleDoorsLocked(car,0)
    SetVehicleHasBeenOwnedByPlayer(car,true)
    SetVehicleNeedsToBeHotwired(car,false)
    return car
end

local function createmycar(hash,x,y,z,angle)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(10) end
    if mycar.plate then
     if mycar_old.plate then
      forgetgps(mycar_old)
      abandoncar(mycar_old)
     end
     -- mycar_old.veh=mycar.veh
     -- mycar_old.net=mycar.net
     -- rotategps(mycar,mycar_old)
     -- mycar_old.plate=mycar.plate
     mycar_old,mycar=mycar,mycar_old
    end
    mycar.hash=hash
    mycar.veh=CreateVehicle(hash,x,y,z-.99,angle,true,false)
    SetModelAsNoLongerNeeded(hash)
    local carblip=AddBlipForEntity(mycar.veh)
    SetBlipSprite(carblip, 326)
    SetBlipDisplay(carblip, 2)
    SetBlipScale(carblip, 0.6)
    SetBlipColour(carblip, 3)
    mycar.net=networkingshit(mycar.veh)
    mycar.plate=GetVehicleNumberPlateText(mycar.veh)
    SetVehicleDoorsLocked(mycar.veh,0)
    SetVehicleHasBeenOwnedByPlayer(mycar.veh,true)
    SetVehicleNeedsToBeHotwired(mycar.veh,false)
    sendcarplates()
    return mycar.veh
end

local function savecar(veh)
    local car={}
    car.wanted=1
    if veh==mycar.veh then
     mycar.veh=nil
     mycar.net=nil
     forgetgps(mycar)
     mycar.plate=nil
     mycar.hash=nil
     car.wanted=0
     sendcarplates()
    end
    if veh==mycar_old.veh then
     mycar_old.veh=nil
     mycar_old.net=nil
     forgetgps(mycar_old)
     mycar_old.plate=nil
     mycar_old.hash=nil
     car.wanted=0
     sendcarplates()
    end
    if veh==rentcar.veh then
     rentcar.veh=nil
     rentcar.net=nil
     forgetgps(rentcar)
     rentcar.plate=nil
     rentcar.hash=nil
     sendcarplates()
    end
    car.hash=GetEntityModel(veh)
    car.body=GetVehicleBodyHealth(veh)
    car.engine=GetVehicleEngineHealth(veh)
    car.tank=GetVehiclePetrolTankHealth(veh)
    car.color1,car.color2=GetVehicleColours(veh)
    local flags=0
    local f=1
    flags=GetVehicleWindows(veh,car.hash)
    car.windows=flags
    flags=0
    if IsVehicleTyreBurst(veh, 0, false) then flags=flags+1 end
    if IsVehicleTyreBurst(veh, 1, false) then flags=flags+2 end
    if IsVehicleTyreBurst(veh, 2, false) then flags=flags+4 end
    if IsVehicleTyreBurst(veh, 3, false) then flags=flags+8 end
    if IsVehicleTyreBurst(veh, 4, false) then flags=flags+16 end
    if IsVehicleTyreBurst(veh, 5, false) then flags=flags+32 end
    if IsVehicleTyreBurst(veh, 6, false) then flags=flags+64 end
    if IsVehicleTyreBurst(veh, 7, false) then flags=flags+128 end
    if IsVehicleTyreBurst(veh, 45, false) then flags=flags+256 end
    if IsVehicleTyreBurst(veh, 47, false) then flags=flags+512 end
    f=1024
    for i=0,6 do
     if IsVehicleDoorDamaged(veh,i) then
      flags=flags+f
     end
     f=f+f
    end
    car.tyresdoors=flags
    SetEntityAsMissionEntity(veh,true,true)
    SetVehicleUndriveable(veh,true)
    DeleteVehicle(veh)
    return car
end

local function loadcar(x,y,z,angle,car)
    local veh
    if car.wanted>0 then
     veh=createcar(car.hash,x,y,z,angle)
    else
     veh=createmycar(car.hash,x,y,z,angle)
    end
    SetVehicleBodyHealth(veh, car.body)
    SetVehicleEngineHealth(veh, car.engine)
    SetVehiclePetrolTankHealth(veh, car.tank)
    SetVehicleColours(veh,car.color1,car.color2)
    local flags=tonumber(car.windows)
    local f=1
    SmashVehicleWindows(veh,flags,car.hash)
    flags=tonumber(car.tyresdoors)
    if (flags&1)==1 then SetVehicleTyreBurst(veh, 0, false, 1000.0) end
    if (flags&2)==2 then SetVehicleTyreBurst(veh, 1, false, 1000.0) end
    if (flags&4)==4 then SetVehicleTyreBurst(veh, 2, false, 1000.0) end
    if (flags&8)==8 then SetVehicleTyreBurst(veh, 3, false, 1000.0) end
    if (flags&16)==16 then SetVehicleTyreBurst(veh, 4, false, 1000.0) end
    if (flags&32)==32 then SetVehicleTyreBurst(veh, 5, false, 1000.0) end
    if (flags&64)==64 then SetVehicleTyreBurst(veh, 6, false, 1000.0) end
    if (flags&128)==128 then SetVehicleTyreBurst(veh, 7, false, 1000.0) end
    if (flags&256)==256 then SetVehicleTyreBurst(veh, 45, false, 1000.0) end
    if (flags&512)==512 then SetVehicleTyreBurst(veh, 47, false, 1000.0) end
    f=1024
    for i=0,6 do
     if (flags&f)==f then
      SetVehicleDoorBroken(veh,i,true)
     end
     f=f+f
    end
    if car.wanted>0 then
     SetVehicleAsNoLongerNeeded(veh)
    end
    return veh
end

local function makeblips(shops)
    -- for k,v in pairs(shops) do
        -- if v.sprite~=nil then
            -- local blip=v.blip
            -- if not blip then
                -- blip=AddBlipForCoord(v.x,v.y,v.z)
            -- end
            -- SetBlipAsShortRange(blip, true)
            -- SetBlipSprite(blip, v.sprite)
            -- SetBlipDisplay(blip, 2)
            -- SetBlipScale(blip, 1.0)
            -- SetBlipColour(blip, v.color)
            -- if v.name then
                -- BeginTextCommandSetBlipName("STRING")
                -- AddTextComponentString(v.name)
                -- EndTextCommandSetBlipName(blip)
            -- end
            -- v.blip=blip
            -- Wait(20)
        -- end
    -- end
end

local function showblips(shops)
    for k,v in pairs(shops) do
        local blip=v.blip
        if blip then
            SetBlipAsShortRange(blip, true)
            SetBlipSprite(blip, v.sprite)
            SetBlipDisplay(blip, 2)
            SetBlipScale(blip, 1.0)
            SetBlipColour(blip, v.color)
            if v.name then
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.name)
                EndTextCommandSetBlipName(blip)
            end
        elseif v.sprite~=nil then
            blip=AddBlipForCoord(v.x,v.y,v.z)
            SetBlipAsShortRange(blip, true)
            SetBlipSprite(blip, v.sprite)
            SetBlipDisplay(blip, 2)
            SetBlipScale(blip, 1.0)
            SetBlipColour(blip, v.color)
            if v.name then
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.name)
                EndTextCommandSetBlipName(blip)
            end
            v.blip=blip
        end
    end
end

local function hideblips(shops)
    for k,v in pairs(shops) do
        local blip=v.blip
        if blip then
            --SetBlipSprite(blip, 406)
            --SetBlipDisplay(blip, 0)
            RemoveBlip(blip)
            v.blip=nil
        end
    end
end

local FACTION={
FBI=1,
LOST=2,
MERCS=3,
ANARCHY=4,
BALLAS=5,
FAMILIES=6,
VAGOS=7,
SALVA=8,
TRIADS=9,
MOBS=10,
HEISTERS=11,
CARTEL=12,
ELITE=13}
local gangwar={
    top={
        [FACTION.FBI]={color={30,119,166},name="Federals",score=0},
        [FACTION.LOST]={color={105,101,105},name="Lost",score=0},
        [FACTION.MERCS]={color={135,125,142},name="Mercs",score=0},
        [FACTION.ANARCHY]={color={12,123,86},name="Anarchy",score=0},
        [FACTION.BALLAS]={color={164,76,242},name="Ballas",score=0},
        [FACTION.FAMILIES]={color={114,204,114},name="Families",score=0},
        [FACTION.VAGOS]={color={235,239,30},name="Vagos",score=0},
        [FACTION.SALVA]={color={152,203,234},name="Salva",score=0},
        [FACTION.TRIADS]={color={224,50,50},name="Triads",score=0},
        [FACTION.MOBS]={color={159,159,159},name="Mobs",score=0},
        [FACTION.HEISTERS]={color={241,241,241},name="Heisters",score=0},
        [FACTION.CARTEL]={color={255,149,14},name="Cartel",score=0},
        [FACTION.ELITE]={color={255,255,255},name="Elite",score=0}
    },sort={1,2,3,4,5,6,7,8,9,10,11,12,13}
}
RegisterNetEvent(event.gangwarscore)
AddEventHandler(event.gangwarscore, function(data)
    for i=1,13 do
        gangwar.top[i].score=data[i]
    end
end)

local faction={}
faction.criminal={}
faction.detectives={}
local lsfd={}
local paramedics={}
local lspdheavy={}
local lspd={}
local sspd={}
local sahp={}
local sapr={}
local noose={}
local military={}
local navy={}
faction.fbi={}
local fbiswat={}
local merc={}
local lost={}
local anarchy={}
local ballas={}
local fams={}
local vagos={}
local salva={}
local triads={}
local mobs={}
local heisters={}
local cartel={}
local elite={}

faction.criminal.weaponshops={
{x=157.82005310059,y=-2205.0988769531,z=4.6880240440369,name="Cheap pipe bomb",sprite=152,color=62,cost=300,weapon={WEAPON.PIPEBOMB}, --torture
                                                                                                       ammo={      1}},
{x=151.8684387207,y=-2202.1157226563,z=4.6880221366882,name="Free grenade",sprite=152,color=0,cost=0,weapon={WEAPON.MOLOTOV}, -- torture
                                                                                                                   ammo={1}},
{x=715.25738525391,y=-962.3818359375,z=30.395311355591,name="Molotov",sprite=152,color=25,cost=20,weapon={WEAPON.MOLOTOV}, -- anarchy
                                                                                                                ammo={1}},
{x=140.86126708984,y=-2204.3400878906,z=4.6880211830139,name="Cheap proxmine",sprite=152,color=0,cost=800,weapon={WEAPON.PROXMINE}, --torture
                                                                                   ammo={           1}},
{x=-935.54614257813,y=-2935.3081054688,z=13.945076942444,name="Hunting pistol",sprite=156,color=2,cost=400,weapon={WEAPON.MARKSMANPISTOL}, 
                                                                                                                ammo={          10}},
{x=-937.58233642578,y=-2929.734375,z=13.955521583557,name="Cheap proxmine",sprite=152,color=0,cost=800,weapon={WEAPON.PROXMINE}, --airport
                                                                                   ammo={           1}},
{x=-937.78387451172,y=-2932.7416992188,z=13.945076942444,name="Cheap pipe bomb",sprite=152,color=62,cost=300,weapon={WEAPON.PIPEBOMB}, --airport
                                                                                                       ammo={      1}},
{x=9.4354467391968,y=534.94451904297,z=170.61724853516,name="Free shotgun",sprite=158,color=0,cost=0,weapon={WEAPON.DBSHOTGUN}, -- franklin
                                                                                   ammo={         2}},
{x=-10.283187866211,y=530.92907714844,z=170.61711120605,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, --franklin
                                                                                   ammo={           7}},
{x=-1150.7872314453,y=-1513.6318359375,z=10.632724761963,name="Free shotgun",sprite=158,color=0,cost=0,weapon={WEAPON.DBSHOTGUN}, -- floyd
                                                                                   ammo={         2}},
{x=-802.09649658203,y=180.21856689453,z=76.740783691406,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.SNSPISTOL}, --michael
                                                                                   ammo={           6}},
{x=1268.5604248047,y=-1710.0904541016,z=54.771492004395,name="Cheap proxmine",sprite=152,color=0,cost=800,weapon={WEAPON.PROXMINE}, --lester
                                                                                   ammo={           1}},
{x=1272.1934814453,y=-1712.5251464844,z=54.77144241333,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.SNSPISTOL}, --lester
                                                                                   ammo={           6}},
{x=-110.65621185303,y=-14.741222381592,z=70.519645690918,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, --janitor
                                                                                   ammo={           7}},
{x=-112.1911315918,y=-7.8896160125732,z=70.519638061523,name="Cheap pipe bomb",sprite=152,color=62,cost=300,weapon={WEAPON.PIPEBOMB}, --janitor
                                                                                                       ammo={      1}},
{x=35.239,y=-1459.373,z=29.3116,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL},
                                                                                   ammo={           7}},
{x=85.802757263184,y=-1959.5242919922,z=21.121673583984,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- ballas
                                                                                                               ammo={           7}},
{x=-16.671392440796,y=-1430.4289550781,z=31.101531982422,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- grove
                                                                                                                ammo={           7}},
{x=971.63922119141,y=-1811.396484375,z=31.256795883179,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- vagos
                                                                                                                ammo={           7}},
{x=1205.7526855469,y=-1607.6594238281,z=50.736503601074,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- salva
                                                                                                                ammo={           7}},
{x=-728.63909912109,y=-879.87927246094,z=22.710916519165,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- triad
                                                                                                            ammo={           7}},
{x=-456.61401367188,y=-1734.1893310547,z=16.763284683228,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.VINTAGEPISTOL}, -- armenian
                                                                                                            ammo={           7}},
{x=485.409,y=-1529.096,z=29.2950,name="Pistol shop",sprite=156,color=2,cost=500,weapon={WEAPON.COMBATPISTOL},
                                                                                   ammo={             72}},
{x=49.747,y=-1453.323,z=29.3116,name="Free shotgun",sprite=158,color=0,cost=0,weapon={WEAPON.DBSHOTGUN},
                                                                                   ammo={         2}},
{x=583.83941650391,y=137.73428344727,z=99.47477722168,name="Automatic shotguns shop",sprite=158,color=1,cost=3350,weapon={WEAPON.ASSAULTSHOTGUN,WEAPON.AUTOSHOTGUN},
                                                                                                                        ammo={        16,         20}},   
--{x=350.215,y=-995.235,z=29.4194,name="Revolver shop",sprite=156,color=2,cost=650,weapon={WEAPON.REVOLVER},
--                                                                                  ammo={       60}},
{x=709.479,y=-886.535,z=23.3898,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.SNSPISTOL},
                                                                                   ammo={        6}},
{x=896.422,y=-1035.682,z=35.1090,name="Hunting pistol",sprite=156,color=2,cost=400,weapon={WEAPON.MARKSMANPISTOL},
                                                                                        ammo={        10}},
{x=-794.145,y=-726.691,z=27.2788,name="Free shotgun",sprite=158,color=0,cost=0,weapon={WEAPON.MUSKET},
                                                                                  ammo={        3}},
{x=-1382.847,y=-640.499,z=28.6733,name="Shotguns shop",sprite=158,color=2,cost=1200,weapon={WEAPON.BULLPUPSHOTGUN},
                                                                                               ammo={       40}},
{x=-683.299,y=-172.938,z=37.8213,name="PDW shop",sprite=159,color=2,cost=1300,weapon={WEAPON.MINISMG},
                                                                                     ammo={     100}}, 
{x=-783.47930908203,y=-916.70172119141,z=18.979768753052,name="SMG shop",sprite=159,color=49,cost=1400,factionreq={FACTION.TRIADS,50000},weapon={WEAPON.MINISMG},
                                                                                                                ammo={     100}}, 
{x=488.65438842773,y=-1524.8050537109,z=29.29439163208,name="PDW shop",sprite=159,color=2,cost=700,weapon={WEAPON.MICROSMG},
                                                                                                    ammo={      48}}, 
{x=117.80283355713,y=-1920.7237548828,z=21.323402404785,name="SMG shop",sprite=159,color=83,cost=800,factionreq={FACTION.BALLAS,50000},weapon={WEAPON.MICROSMG},
                                                                                                                                    ammo={      48}}, 
{x=-1502.926,y=130.437,z=55.6528,name="Assault shop",sprite=150,color=1,cost=3500,weapon={WEAPON.SMG,WEAPON.ASSAULTRIFLE},
                                                                                   ammo={      150,         150}},
{x=1193.2449951172,y=-1655.9456787109,z=43.02844619751,name="Assault shop",sprite=150,color=18,cost=4100,factionreq={FACTION.SALVA,30000},weapon={WEAPON.ASSAULTRIFLE},
                                                                                                                                        ammo={         150}},
{x=-482.87887573242,y=-1712.533203125,z=18.714572906494,name="Assault shop",sprite=150,color=39,cost=2800,factionreq={FACTION.MOBS,20000},luxe=true,weapon={WEAPON.ASSAULTRIFLE},
                                                                                                                                                    ammo={         120}},
{x=159.92948913574,y=293.42489624023,z=110.85254669189,name="Assault shop",sprite=150,color=45,cost=4300,factionreq={FACTION.HEISTERS,90000},weapon={WEAPON.CARBINERIFLE},
                                                                                                                                                ammo={         150}},
{x=166.04174804688,y=293.57894897461,z=110.82971191406,name="Gas grenades shop",sprite=152,color=45,cost=700,factionreq={FACTION.HEISTERS,180000},weapon={WEAPON.BZGAS},
                                                                                                                                                    ammo={         1}},
{x=711.17749023438,y=-966.92742919922,z=30.395320892334,name="Sticky bomb shop",sprite=152,color=25,cost=1750,factionreq={FACTION.ANARCHY,1000000},weapon={WEAPON.STICKYBOMB},
                                                                                                                                                    ammo={         1}},
{x=1184.642578125,y=-1620.568359375,z=44.8532371521,name="Grenade shop",sprite=152,color=18,cost=1000,factionreq={FACTION.SALVA,100000},weapon={WEAPON.GRENADE},
                                                                                                                                            ammo={         1}},
{x=720.58721923828,y=-969.23455810547,z=30.395324707031,name="Assault shop",sprite=150,color=25,cost=2700,factionreq={FACTION.ANARCHY,350000},weapon={WEAPON.SMG},
                                                                                                                        ammo={       120}},
{x=-425.912,y=535.400,z=122.2750,name="Automatic snipers shop",sprite=150,color=1,cost=5000,weapon={WEAPON.MARKSMANRIFLE},
                                                                                                              ammo={36}},
{x=189.880,y=308.841,z=105.390,name="Snipers shop",sprite=160,color=2,cost=3000,weapon={WEAPON.SNIPERRIFLE},
                                                                                                ammo={45}},  
{x=218.93112182617,y=-6.5031986236572,z=73.833969116211,name="Machine pistol shop",sprite=159,color=2,cost=1800,weapon={WEAPON.MACHINEPISTOL},
                                                                                                                              ammo={72}}, 
{x=-1.8107196092606,y=-1442.7502441406,z=30.969940185547,name="Machine pistol shop",sprite=159,color=69,cost=1900,factionreq={FACTION.FAMILIES,30000},weapon={WEAPON.MACHINEPISTOL},
                                                                                                                              ammo={72}}, 
{x=223.21469116211,y=-7.9395785331726,z=73.768821716309,name="Assault rifle shop",sprite=150,color=2,cost=4000,weapon={WEAPON.BULLPUPRIFLE},
                                                                                                                              ammo={60}}, 
{x=-1023.0432128906,y=-998.20416259766,z=2.1501922607422,name="Assault rifle shop",sprite=150,color=2,cost=3500,luxe=true,weapon={WEAPON.ASSAULTRIFLE},
                                                                                                                                  ammo={150}}, 
{x=230.89967346191,y=-10.898548126221,z=73.775741577148,name="Pipe bomb shop",sprite=152,color=2,cost=850,weapon={WEAPON.PIPEBOMB},
                                                                                                                       ammo={1}},
{x=260.4328918457,y=-15.770009040833,z=73.676902770996,name="Automatic pistol shop",sprite=159,color=1,cost=2500,weapon={WEAPON.APPISTOL},
                                                                                                                              ammo={36}},
{x=-718.22180175781,y=-1119.5183105469,z=10.652349472046,name="Grenade shop",sprite=152,color=2,cost=500,weapon={WEAPON.GRENADE},
                                                                                                                     ammo={1}},
{x=-723.23449707031,y=-1112.4810791016,z=10.652400970459,name="RPG shop",sprite=157,color=2,cost=5000,weapon={WEAPON.RPG},
                                                                                                                ammo={1}},
{x=239.01609802246,y=-14.013869285583,z=73.715599060059,name="Pistol shop",sprite=156,color=1,cost=2000,weapon={WEAPON.PISTOL50},
                                                                                                                     ammo={36}},
{x=1002.2705078125,y=-2160.6635742188,z=30.551578521729,name="Hunting shotgun shop",sprite=158,color=1,cost=1000,weapon={WEAPON.HEAVYSHOTGUN},
                                                                                                                                  ammo={36}},
{x=1013.5016479492,y=-2150.90234375,z=31.533716201782,name="Machinegun shop",sprite=173,color=2,cost=4200,weapon={WEAPON.MG},
                                                                                                                ammo={108}},
{x=257.08120727539,y=-1981.6202392578,z=21.430465698242,name="Free grenade",sprite=152,color=0,cost=0,weapon={WEAPON.MOLOTOV},
                                                                                                                   ammo={1}},
{x=268.04974365234,y=-1979.8137207031,z=21.466508865356,name="Free pistol",sprite=156,color=0,cost=0,weapon={WEAPON.SNSPISTOL},
                                                                                                            ammo={        6}},
{x=-325.39294433594,y=-1348.5595703125,z=31.349042892456,name="Shotgun shop",sprite=158,color=2,cost=900,weapon={WEAPON.SAWNOFFSHOTGUN},
                                                                                                                    ammo={       40}},
{x=139.07206726074,y=324.00939941406,z=112.13865661621,name="Shotgun shop",sprite=158,color=2,cost=400,weapon={WEAPON.SAWNOFFSHOTGUN}, -- profs
                                                                                                                    ammo={       20}},
{x=990.14862060547,y=-1853.1624755859,z=31.039821624756,name="Shotgun shop",sprite=158,color=46,cost=1200,factionreq={FACTION.VAGOS,120000},weapon={WEAPON.PUMPSHOTGUN},
                                                                                                                    ammo={       40}},
{x=-324.84808349609,y=-1356.3480224609,z=31.295696258545,name="Pistol shop",sprite=156,color=2,cost=300,weapon={WEAPON.PISTOL},
                                                                                                               ammo={    60}},
{x=-1017.3052368164,y=-2864.7678222656,z=13.951531410217,name="Parachute shop",sprite=377,color=0,cost=100,weapon={WEAPON.PARACHUTE}, --lsia
                                                                                                               ammo={    1}},
{x=-164.8800201416,y=-154.01473999023,z=93.702476501465,name="Parachute shop",sprite=377,color=0,cost=100,weapon={WEAPON.PARACHUTE}, --heli shop
                                                                                                               ammo={    1}},
{x=-1323.4295654297,y=-252.41923522949,z=42.303611755371,name="Special carbine shop",sprite=150,color=1,cost=5000,weapon={WEAPON.SPECIALCARBINE},
                                                                                                                            ammo={        150}},
{x=-1327.7211914063,y=-237.49154663086,z=42.703685760498,name="Rare special carbine shop",sprite=150,color=1,cost=5000,luxe=true,weapon={WEAPON.SPECIALCARBINE},
                                                                                                                                        ammo={        150}},
{x=-3101.9689941406,y=345.99591064453,z=14.440872192383,name="Free rifle",sprite=150,color=0,cost=0,weapon={WEAPON.CARBINERIFLE}, --beard
                                                                                                            ammo={          30}},
{x=-3193.9914550781,y=1275.5086669922,z=12.668712615967,name="Free shotgun",sprite=158,color=0,cost=0,weapon={WEAPON.DBSHOTGUN}, -- chumash house
                                                                                                        ammo={         2}},
{x=1986.3071289063,y=3055.0681152344,z=47.215240478516,name="Pump shotgun",sprite=158,color=0,cost=1500,weapon={WEAPON.PUMPSHOTGUN}, -- yellow jack
                                                                                                                ammo={        32}},
{x=-576.06091308594,y=291.23370361328,z=79.176666259766,name="SMG shop",sprite=150,color=45,cost=4500,weapon={WEAPON.SMG},
                                                                                                           ammo={         150}},
}
lspdheavy.weaponshops={
{x=452.37139892578,y=-980.0517578125,z=30.689596176147,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.PISTOL,WEAPON.PUMPSHOTGUN,WEAPON.SMG,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                       ammo={          36,                  8,        30,               1,            1}},
}
faction.detectives.weaponshops={
{x=452.3713684082,y=-980.02044677734,z=30.689594268799,fbi=true,name="Detective weapons",sprite=156,color=3,cost=0,weapon={WEAPON.PISTOL},
                                                                                                                      ammo={          36}},
}
lspd.weaponshops={
{x=452.3713684082,y=-980.02044677734,z=30.689594268799,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={                36,                1,            1}},
{x=849.65454101563,y=-1284.3083496094,z=28.004722595215,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={                36,                1,            1}},
{x=-1106.8883056641,y=-845.83972167969,z=19.316970825195,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={                36,                1,            1}},
{x=535.39477539063,y=-22.057580947876,z=70.629531860352,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={                36,                1,            1}},
{x=-1057.9964599609,y=-840.76361083984,z=5.04252576828,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={                36,                1,            1}},
{x=369.66665649414,y=-1607.6519775391,z=29.29193687439,fbi=true,name="Free police weapons",sprite=156,color=3,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.NIGHTSTICK,WEAPON.STUNGUN},
                                                                                                                        ammo={                36,                1,            1}},
}
sspd.weaponshops={
{x=1848.4913330078,y=3690.1921386719,z=34.267066955566,fbi=true,name="SSPD weapons",sprite=150,color=5,cost=0,weapon={WEAPON.PISTOL,WEAPON.REVOLVER,WEAPON.STUNGUN},
                                                                                                                 ammo={          36,              6,             1}},
}
sahp.weaponshops={
{x=-448.39389038086,y=6007.970703125,z=31.716371536255,fbi=true,name="SAHP weapons",sprite=150,color=39,cost=0,weapon={WEAPON.MARKSMANRIFLE,WEAPON.COMBATPISTOL,WEAPON.STUNGUN},
                                                                                                                 ammo={                  16,                 36,             1}},
}
sapr.weaponshops={
{x=379.2825012207,y=792.05242919922,z=190.40751647949,fbi=true,name="SAPR weapons",sprite=150,color=2,cost=0,weapon={WEAPON.CARBINERIFLE,WEAPON.PISTOL,WEAPON.STUNGUN},
                                                                                                                ammo={               30,            36,             1}},
}
noose.weaponshops={
{x=2477.2534179688,y=-401.64010620117,z=94.816162109375,fbi=true,name="SWAT weapons",sprite=150,color=29,cost=0,weapon={WEAPON.PISTOLMK2,WEAPON.PUMPSHOTGUNMK2,WEAPON.BULLPUPSHOTGUN,WEAPON.ASSAULTSMG,WEAPON.SMG,WEAPON.ADVANCEDRIFLE,WEAPON.CARBINERIFLE,WEAPON.SPECIALCARBINE,WEAPON.BZGAS},
                                                                                                                 ammo={               36,                    8,                   10,               50,        60,                 60,                  60,                  60,           1}},
}
navy.weaponshops={
{x=3089.9643554688,y=-4691.5776367188,z=27.252153396606,fbi=true,name="Parachute",sprite=377,color=26,cost=0,weapon={WEAPON.PARACHUTE}, --carrier
                                                                                                               ammo={               1}},
{x=-2353.7114257813,y=3264.1015625,z=32.810745239258,fbi=true,name="Parachute",sprite=377,color=26,cost=0,weapon={WEAPON.PARACHUTE},
                                                                                                            ammo={               1}},
{x=3083.6398925781,y=-4796.09375,z=2.0332415103912,fbi=true,name="Navy weapons",sprite=150,color=26,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.ASSAULTSHOTGUN,WEAPON.SMG,WEAPON.CARBINERIFLE,WEAPON.COMBATMG,WEAPON.HEAVYSNIPER},
                                                                                                                     ammo={                  36,                8,        60,            60,            50,               30}},
{x=3038.7687988281,y=-4685.9775390625,z=10.74206829071,fbi=true,name="Navy weapons",sprite=157,color=26,cost=0,weapon={WEAPON.HOMINGLAUNCHER,WEAPON.RPG},
                                                                                                                    ammo={                 1,         1}},
{x=3095.1481933594,y=-4710.6293945313,z=15.262321472168,fbi=true,name="Navy weapons",sprite=150,color=26,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.ASSAULTSHOTGUN,WEAPON.SMG,WEAPON.CARBINERIFLE,WEAPON.COMBATMG,WEAPON.HEAVYSNIPER,WEAPON.GRENADE},
                                                                                                                ammo={                  36,                      8,        60,                 60,            50,               30,            1}},
{x=-2350.3439941406,y=3266.0915527344,z=32.810733795166,fbi=true,name="Navy weapons",sprite=150,color=26,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.ASSAULTSHOTGUN,WEAPON.SMG,WEAPON.CARBINERIFLE,WEAPON.COMBATMG,WEAPON.HEAVYSNIPER,WEAPON.GRENADE},
                                                                                                                ammo={                  36,                      8,        60,                 60,            50,               30,            1}},
}
military.weaponshops={
{x=-2350.3439941406,y=3266.0915527344,z=32.810733795166,fbi=true,name="Military weapons",sprite=150,color=52,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.SMG,WEAPON.CARBINERIFLE,WEAPON.GRENADE},
                                                                                                                     ammo={                  36,        60,                 60,             1}},
}
fbiswat.weaponshops={
{x=142.2840423584,y=-769.47924804688,z=242.1520690918,fbi=true,name="Free FBI weapons",sprite=150,color=3,cost=0,weapon={WEAPON.HEAVYPISTOL,WEAPON.CARBINERIFLE,WEAPON.COMBATPDW,WEAPON.SMG,WEAPON.MICROSMG,WEAPON.SNIPERRIFLE,WEAPON.PUMPSHOTGUN,WEAPON.STUNGUN,WEAPON.BZGAS},
                                                                                                                   ammo={                36,                 30,              30,        30,            30,                 10,                 8,            1,            1}}
}
faction.fbi.weaponshops={
{x=142.2840423584,y=-769.47924804688,z=242.1520690918,fbi=true,name="Free FBI weapons",sprite=150,color=3,cost=0,weapon={WEAPON.HEAVYPISTOL,WEAPON.STUNGUN},
                                                                                                                    ammo={               36,            1}}
}
lost.weaponshops={
{x=977.75482177734,y=-101.76627349854,z=74.845115661621,name="Double barrel shotgun",sprite=158,color=62,cost=300,weapon={WEAPON.DBSHOTGUN},
                                                                                                                    ammo={      20}},
{x=977.36364746094,y=-92.444755554199,z=74.84513092041,name="Compact Rifle",sprite=150,color=62,cost=2800,weapon={WEAPON.COMPACTRIFLE},
                                                                                                            ammo={         90}},
{x=975.68902587891,y=-94.825485229492,z=74.84513092041,name="Pipe bomb",sprite=152,color=62,cost=800,weapon={WEAPON.PIPEBOMB},
                                                                                                       ammo={      1}},
{x=994.84680175781,y=-107.53675842285,z=74.07746887207,name="Molotov",sprite=152,color=62,cost=0,weapon={WEAPON.MOLOTOV},
                                                                                                   ammo={     1}},
{x=986.86175537109,y=-144.59301757813,z=74.271423339844,name="Automatic shotgun",sprite=158,color=62,cost=3000,factionreq={FACTION.LOST,50000},weapon={WEAPON.AUTOSHOTGUN},
                                                                                                                 ammo={        40}},
{x=1005.8704833984,y=-114.49364471436,z=73.970039367676,name="SMG shop",sprite=159,color=62,cost=1800,factionreq={FACTION.LOST,100000},weapon={WEAPON.MINISMG},
                                                                                                                                    ammo={     100}} 
}
merc.weaponshops={
{x=581.33917236328,y=-3119.0949707031,z=18.768585205078,name="Free mercenary weapons",sprite=150,color=65,cost=0,weapon={WEAPON.COMBATPISTOL,WEAPON.ADVANCEDRIFLE,WEAPON.ASSAULTSHOTGUN,WEAPON.COMBATMG},
                                                                                                                   ammo={                36,                 60,                     20,            100}}
}
cartel.weaponshops={
{x=1410.2515869141,y=1145.1909179688,z=114.33390045166,name="Assault rifle",sprite=150,color=47,cost=2000,weapon={WEAPON.ASSAULTRIFLE},
                                                                                                                   ammo={      90}},
{x=1410.1848144531,y=1147.421875,z=114.33404541016,name="Shotgun",sprite=158,color=47,cost=800,weapon={WEAPON.PUMPSHOTGUN},
                                                                                                       ammo={      30}},
{x=1410.2707519531,y=1149.6201171875,z=114.33406066895,name="Pistol",sprite=156,color=47,cost=300,weapon={WEAPON.PISTOL},
                                                                                                       ammo={      60}},
{x=1409.2731933594,y=1164.7584228516,z=114.33419799805,name="Sniper rifle",sprite=160,color=47,cost=2000,weapon={WEAPON.SNIPERRIFLE},
                                                                                                                 ammo={      45}}
}
elite.weaponshops={
{x=-2090.7915039063,y=-1010.5755004883,z=8.9711494445801,name="Automatic pistol",sprite=156,color=4,cost=1000,factionreq={FACTION.ELITE,1000000},weapon={WEAPON.APPISTOL},
                                                                                                                   ammo={      72}},
{x=-77.564208984375,y=364.13122558594,z=112.44161987305,name="Elite pistol",sprite=156,color=4,cost=2000,weapon={WEAPON.PISTOLMK2},
                                                                                                                   ammo={      72}},
{x=-68.150436401367,y=346.7080078125,z=142.62060546875,name="Automatic pistol",sprite=156,color=4,cost=2000,weapon={WEAPON.APPISTOL},
                                                                                                                      ammo={      72}},
{x=-85.580963134766,y=357.03894042969,z=112.43988037109,name="Assault rifle",sprite=150,color=4,cost=4000,weapon={WEAPON.SPECIALCARBINE},
                                                                                                                    ammo={      90}},
{x=-92.673233032227,y=330.42544555664,z=142.60330200195,name="Sniper rifle",sprite=160,color=4,cost=5500,weapon={WEAPON.MARKSMANRIFLE},
                                                                                                       ammo={      42}}
}
local weaponshops=faction.criminal.weaponshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.weaponshops)
    makeblips(fbiswat.weaponshops)
    makeblips(faction.fbi.weaponshops)
    makeblips(faction.detectives.weaponshops)
    makeblips(lspd.weaponshops)
    makeblips(lspdheavy.weaponshops)
    makeblips(sspd.weaponshops)
    makeblips(sahp.weaponshops)
    makeblips(sapr.weaponshops)
    makeblips(noose.weaponshops)
    makeblips(military.weaponshops)
    makeblips(navy.weaponshops)
    makeblips(lost.weaponshops)
    makeblips(merc.weaponshops)
    makeblips(cartel.weaponshops)
    makeblips(elite.weaponshops)
    hideblips(fbiswat.weaponshops)
    hideblips(faction.fbi.weaponshops)
    hideblips(faction.detectives.weaponshops)
    hideblips(lspd.weaponshops)
    hideblips(lspdheavy.weaponshops)
    hideblips(sspd.weaponshops)
    hideblips(sahp.weaponshops)
    hideblips(sapr.weaponshops)
    hideblips(noose.weaponshops)
    hideblips(military.weaponshops)
    hideblips(navy.weaponshops)
    hideblips(lost.weaponshops)
    hideblips(merc.weaponshops)
    hideblips(cartel.weaponshops)
    hideblips(elite.weaponshops)
    while true do
        Wait(0)
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(weaponshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 255, 255, 255, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not player.is_dead) then
                    if v.factionreq and gangwar.top[v.factionreq[1]].score<v.factionreq[2] then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~r~"..gangwar.top[v.factionreq[1]].name.." needs ~g~$"..v.factionreq[2].." ~r~to unlock this.")
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    elseif IsControlPressed(0, 86) then
                        if player.money>=v.cost then
                            local ped=PlayerPedId()
                            local i=math.random(#v.weapon)
                            GiveWeaponToPed(ped, v.weapon[i], v.ammo[i], false, true)
                            if v.luxe then
                                GiveWeaponComponentToPed(PlayerPedId(),v.weapon[i],weapon_upgrades.luxe[v.weapon[i]])
                            else
                                RemoveWeaponComponentFromPed(PlayerPedId(),v.weapon[i],weapon_upgrades.luxe[v.weapon[i]]);
                            end
                            player.money=player.money-v.cost
                            removemoney(player.money,v.cost)
                            TriggerServerEvent(event.buy,v.cost)
                            WaitWithMarker(500,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 255, 255, 255, 128, false, true, 2, false, false, false, false)
                            pos=GetEntityCoords(PlayerPedId())
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to buy weapon.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)


        
faction.criminal.weapon_upgrade_shops={
{x=1010.5590209961,y=-2190.1262207031,z=31.533477783203,name="Extended magazine",color=4,sprite=313,cost=200,upgrade=weapon_upgrades.extendedmag},
{x=478.48071289063,y=-1514.2593994141,z=29.291564941406,name="Extended magazine",color=4,sprite=313,cost=200,upgrade=weapon_upgrades.extendedmag},
{x=126.49391174316,y=-1929.5374755859,z=21.382417678833,name="Extended magazine",color=83,sprite=313,cost=300,factionreq={FACTION.BALLAS,75000},upgrade=weapon_upgrades.extendedmag},
{x=-313.05096435547,y=-1332.7655029297,z=31.350290298462,name="Flashlight",color=4,sprite=313,cost=100,upgrade=weapon_upgrades.flashlight},
{x=214.48263549805,y=-1.5807383060455,z=74.25813293457,name="Grip",color=4,sprite=313,cost=50,upgrade=weapon_upgrades.grip},
{x=306.30133056641,y=-141.36608886719,z=67.770805358887,name="Scope",color=4,sprite=313,cost=500,upgrade=weapon_upgrades.scope},
{x=-169.53044128418,y=-1027.6402587891,z=27.27357673645,name="Silencer",color=4,sprite=313,cost=500,upgrade=weapon_upgrades.silencer},
{x=-3103.4780273438,y=346.47964477539,z=14.440871238708,name="Scope",color=4,sprite=313,cost=0,upgrade=weapon_upgrades.scope}, --beard
{x=-562.33068847656,y=281.79348754883,z=85.676361083984,name="Silencer",color=4,sprite=313,cost=600,upgrade=weapon_upgrades.silencer}, --tequilala
}
lspd.weapon_upgrade_shops={
{x=464.49899291992,y=-983.98010253906,z=39.891845703125,name="Flashlight",color=4,sprite=313,cost=0,upgrade=weapon_upgrades.flashlight},
{x=464.65417480469,y=-983.98345947266,z=35.891902923584,name="Scope",color=4,sprite=313,cost=0,upgrade=weapon_upgrades.scope},
}
sapr.weapon_upgrade_shops={
{x=381.34396362305,y=792.29223632813,z=190.40689086914,name="Flashlight",color=4,sprite=313,cost=0,upgrade=weapon_upgrades.flashlight},
{x=389.00573730469,y=798.01898193359,z=187.67132568359,name="Scope",color=4,sprite=313,cost=0,upgrade=weapon_upgrades.scope},
}
noose.weapon_upgrade_shops={
{x=2477.154296875,y=-347.35385131836,z=93.73494720459,name="Supressor",color=29,sprite=313,cost=0,upgrade=weapon_upgrades.silencer}, --noose
{x=2484.6081542969,y=-350.64505004883,z=93.736419677734,name="Grip",color=29,sprite=313,cost=0,upgrade=weapon_upgrades.grip}, --noose
{x=2477.2258300781,y=-366.3522644043,z=94.816375732422,name="Scope",color=29,sprite=313,cost=0,upgrade=weapon_upgrades.scope}, --noose
{x=2488.3552246094,y=-364.04937744141,z=93.735282897949,name="Flashlight",color=29,sprite=313,cost=0,upgrade=weapon_upgrades.flashlight}, --noose
}
faction.fbi.weapon_upgrade_shops={
}
fbiswat.weapon_upgrade_shops={
{x=144.97364807129,y=-761.15582275391,z=242.15205383301,name="Supressor",color=3,sprite=313,cost=0,upgrade=weapon_upgrades.silencer}, 
{x=144.34698486328,y=-762.68933105469,z=242.15205383301,name="Scope",color=3,sprite=313,cost=0,upgrade=weapon_upgrades.scope}, 
{x=143.67152404785,y=-764.49200439453,z=242.15205383301,name="Extended magazine",color=3,sprite=313,cost=0,upgrade=weapon_upgrades.extendedmag}, 
}
elite.weapon_upgrade_shops={
{x=-97.513252258301,y=323.93173217773,z=136.89273071289,name="Silencer",color=4,sprite=313,cost=1000,upgrade=weapon_upgrades.silencer}, --balcony
}
cartel.weapon_upgrade_shops={
}
merc.weapon_upgrade_shops={
{x=467.82974243164,y=-3205.7380371094,z=6.0695605278015,name="Scope",color=65,sprite=313,cost=0,factionreq={FACTION.MERCS,800000},upgrade=weapon_upgrades.scope}, 
{x=467.18151855469,y=-3212.3337402344,z=7.0569653511047,name="Grip",color=65,sprite=313,cost=0,factionreq={FACTION.MERCS,20000},upgrade=weapon_upgrades.grip}, 
{x=467.84606933594,y=-3205.6779785156,z=9.7939443588257,name="Flashlight",color=65,sprite=313,cost=0,factionreq={FACTION.MERCS,50000},upgrade=weapon_upgrades.flashlight}, 
{x=467.82974243164,y=-3205.7380371094,z=6.0695605278015,name="Supressor",color=65,sprite=313,cost=0,factionreq={FACTION.MERCS,1000000},upgrade=weapon_upgrades.silencer}, 
}
lost.weapon_upgrade_shops={
}

local weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.weapon_upgrade_shops)
    makeblips(faction.fbi.weapon_upgrade_shops)
    makeblips(fbiswat.weapon_upgrade_shops)
    makeblips(noose.weapon_upgrade_shops)
    makeblips(lspd.weapon_upgrade_shops)
    makeblips(sapr.weapon_upgrade_shops)
    makeblips(merc.weapon_upgrade_shops)
    makeblips(lost.weapon_upgrade_shops)
    makeblips(cartel.weapon_upgrade_shops)
    makeblips(elite.weapon_upgrade_shops)
    
    hideblips(faction.fbi.weapon_upgrade_shops)
    hideblips(fbiswat.weapon_upgrade_shops)
    hideblips(noose.weapon_upgrade_shops)
    hideblips(lspd.weapon_upgrade_shops)
    hideblips(sapr.weapon_upgrade_shops)
    hideblips(lost.weapon_upgrade_shops)
    hideblips(merc.weapon_upgrade_shops)
    hideblips(cartel.weapon_upgrade_shops)
    hideblips(elite.weapon_upgrade_shops)
    while true do
        Wait(0)
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(weapon_upgrade_shops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 255, 128, false, true, 2, false, false, false, false)
                if (square<1) and (not player.is_dead) then
                    if v.factionreq and gangwar.top[v.factionreq[1]].score<v.factionreq[2] then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~r~"..gangwar.top[v.factionreq[1]].name.." needs ~g~$"..v.factionreq[2].." ~r~to unlock this.")
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    elseif IsControlPressed(0, 86) then
                        if player.money>=v.cost then
                            local ped=PlayerPedId()
                            local curweap=GetSelectedPedWeapon(ped);
                            local upgradehash=v.upgrade[curweap]
                            if upgradehash then
                                if HasPedGotWeaponComponent(ped,curweap,upgradehash) then
                                    GiveWeaponComponentToPed(ped,curweap,upgradehash)
                                    SetNotificationTextEntry("STRING")
                                    AddTextComponentString("You already have "..v.name.." on this weapon.")
                                    DrawNotification(false, false)
                                    Wait(800)
                                else
                                    GiveWeaponComponentToPed(ped,curweap,upgradehash)
                                    player.money=player.money-v.cost
                                    removemoney(player.money,v.cost)
                                    TriggerServerEvent(event.buy,v.cost)
                                    SetBlipColour(v.blip, 20)
                                    WaitWithMarker(5000,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                    SetBlipColour(v.blip, v.color)
                                    pos=GetEntityCoords(PlayerPedId())
                                end
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You can't attach "..v.name.." to this weapon.")
                                DrawNotification(false, false);
                                Wait(800)
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to buy weapon upgrade.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

faction.criminal.armorshops={
{x=145.78712463379,y=-2199.318359375,z=4.6880211830139,name="Free armor",color=32,sprite=175,cost=0,amount=25}, --torture
{x=-932.357421875,y=-2936.1462402344,z=13.945066452026,name="Free armor",color=32,sprite=175,cost=0,amount=25}, --airport
{x=-5.679844379425,y=530.17016601563,z=170.61711120605,name="Free armor",color=32,sprite=175,cost=0,amount=25}, --franklin
{x=-1144.1650390625,y=-1515.8909912109,z=10.63272857666,name="Free armor",color=32,sprite=175,cost=0,amount=25}, --floyd
{x=-808.39215087891,y=175.24224853516,z=76.740783691406,name="Free armor",color=32,sprite=175,cost=0,amount=25}, --michael
{x=1274.2954101563,y=-1708.5482177734,z=54.771492004395,name="Free armor",color=32,sprite=175,cost=0,amount=25}, --lester
{x=-113.41641235352,y=-13.630139350891,z=70.51863861084,name="Free armor",color=32,sprite=175,cost=0,amount=25}, --janitor
{x=29.81608581543,y=-1019.036315918,z=29.435953140259,name="Armor shop",color=3,sprite=175,cost=1000},
{x=225.98530578613,y=-9.1169500350952,z=73.777046203613,name="Armor shop",color=3,sprite=175,cost=1400},
{x=1004.0308837891,y=-2140.5986328125,z=30.551580429077,name="Armor shop",color=3,sprite=175,cost=1200},
{x=-1335.9992675781,y=-226.25630187988,z=42.981540679932,name="Armor shop",color=3,sprite=175,cost=1500},
{x=-778.97601318359,y=-916.24353027344,z=18.988374710083,name="Armor shop",color=49,sprite=175,cost=1100,factionreq={FACTION.TRIADS,100000}},
{x=979.28149414063,y=-1864.966796875,z=31.349632263184,name="Armor shop",color=46,sprite=175,cost=1100,factionreq={FACTION.VAGOS,150000}},
{x=153.57276916504,y=292.99710083008,z=110.8408203125,name="Armor shop",color=45,sprite=175,cost=1100,factionreq={FACTION.HEISTERS,50000}},
{x=-3097.3046875,y=347.89349365234,z=14.440871238708,name="Free Armor",color=3,sprite=175,cost=0}, --beard
{x=-3198.1364746094,y=1274.4821777344,z=12.667650222778,name="Free armor",color=32,sprite=175,cost=0,amount=25}, --chumash house
{x=1981.5084228516,y=3051.3054199219,z=47.215007781982,name="Armor shop",color=32,sprite=175,cost=500},
}
noose.armorshops={
{x=2488.3266601563,y=-404.13980102539,z=93.735198974609,name="Armor",color=29,sprite=175,cost=0}, --noose
}
navy.armorshops={
{x=3080.2497558594,y=-4796.998046875,z=2.0332436561584,name="Armor",color=26,sprite=175,cost=0}, --carrier
{x=3091.8764648438,y=-4711.5063476563,z=15.262619018555,name="Armor",color=26,sprite=175,cost=0}, --carrier
{x=-2355.4753417969,y=3259.1435546875,z=92.90372467041,name="Armor",color=26,sprite=175,cost=0}, --navy
}
military.armorshops={
--{x=-2355.4753417969,y=3259.1435546875,z=92.90372467041,name="Armor",color=52,sprite=175,cost=0}, --military
}
lspdheavy.armorshops={
{x=449.82006835938,y=-993.31036376953,z=30.689605712891,name="Armor",color=3,sprite=175,cost=0}, --lspd heavy
}
faction.fbi.armorshops={
{x=147.40942382813,y=-738.14141845703,z=242.15194702148,name="Armor",color=3,sprite=175,cost=0}
}
 lost.armorshops={
{x=984.69683837891,y=-125.75647735596,z=73.957084655762,name="Armor",color=62,sprite=175,cost=1800,factionreq={FACTION.LOST,500000}}
}
 merc.armorshops={
--{x=566.830078125,y=-3117.5048828125,z=18.768550872803,name="Armor",color=65,sprite=175,cost=500}
}
 anarchy.armorshops={
{x=712.4091796875,y=-959.44964599609,z=30.39533996582,name="Armor",color=25,sprite=175,cost=500}
}
 cartel.armorshops={
{x=1409.0297851563,y=1159.9927978516,z=114.33424377441,name="Armor",color=47,sprite=175,cost=900}
}
 elite.armorshops={
{x=-2094.8173828125,y=-1020.3321533203,z=8.9715394973755,name="Armor",color=4,sprite=175,cost=1000,factionreq={FACTION.ELITE,1000000}}, -- yacht
{x=-63.25354385376,y=356.66430664063,z=112.44436645508,name="Armor",color=4,sprite=175,cost=2000}
}
local armorshops=faction.criminal.armorshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.armorshops)
    makeblips(faction.fbi.armorshops)
    makeblips(lspdheavy.armorshops)
    makeblips(noose.armorshops)
    makeblips(military.armorshops)
    makeblips(navy.armorshops)
    makeblips(merc.armorshops)
    makeblips(lost.armorshops)
    makeblips(anarchy.armorshops)
    makeblips(cartel.armorshops)
    makeblips(elite.armorshops)
    hideblips(faction.fbi.armorshops)
    hideblips(lspdheavy.armorshops)
    hideblips(noose.armorshops)
    hideblips(military.armorshops)
    hideblips(navy.armorshops)
    hideblips(lost.armorshops)
    hideblips(merc.armorshops)
    hideblips(anarchy.armorshops)
    hideblips(cartel.armorshops)
    hideblips(elite.armorshops)
    while true do
        Wait(0)
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(armorshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 255, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not player.is_dead) then
                    if v.factionreq and gangwar.top[v.factionreq[1]].score<v.factionreq[2] then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~r~"..gangwar.top[v.factionreq[1]].name.." needs ~g~$"..v.factionreq[2].." ~r~to unlock this.")
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    elseif IsControlPressed(0, 86) then
                        if player.money>=v.cost then
                            local ped=PlayerPedId()
                            local amount=v.amount
                            if amount==nil then amount=100 end
                            if GetPedArmour(ped)<amount then
                                SetPedArmour(ped, amount);
                                player.money=player.money-v.cost
                                removemoney(player.money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                SetBlipColour(v.blip, 20)
                                WaitWithMarker(5000,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(PlayerPedId())
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to buy armor.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

 faction.criminal.medics={
{x=-923.39715576172,y=-2941.6240234375,z=13.990814208984,name="Medkit",color=14,sprite=153,cost=0}, -- airport
{x=-1148.3089599609,y=-1518.8985595703,z=10.643747329712,name="Medkit",color=14,sprite=153,cost=0}, -- floyd
{x=-804.15350341797,y=169.9162902832,z=76.740180969238,name="Medkit",color=14,sprite=153,cost=0}, -- michael
{x=1274.5648193359,y=-1717.8825683594,z=54.771488189697,name="Medkit",color=14,sprite=153,cost=0}, -- lester
{x=-108.96404266357,y=-12.111380577087,z=70.519645690918,name="Medkit",color=14,sprite=153,cost=0}, -- janitor
{x=-17.331335067749,y=-1436.7751464844,z=31.101551055908,name="Medic",color=23,sprite=153,cost=1100}, -- grove
{x=84.54956817627,y=-1966.9985351563,z=20.747440338135,name="Medic",color=23,sprite=153,cost=1100}, -- ballas
{x=962.09649658203,y=-1830.5832519531,z=36.055534362793,name="Medic",color=23,sprite=153,cost=1100}, -- vagos
{x=1211.0631103516,y=-1607.6319580078,z=50.348274230957,name="Medic",color=23,sprite=153,cost=1100}, -- salva
{x=-787.1318359375,y=-911.865234375,z=18.091592788696,name="Medic",color=23,sprite=153,cost=1100}, -- triad
{x=-453.3876953125,y=-1736.9869384766,z=16.763284683228,name="Medic",color=23,sprite=153,cost=1100}, -- armenian
{x=253.44336,y=-1808.50635,z=27.113144,name="Medic",color=23,sprite=153,cost=1000},
{x=245.78915,y=-16.6738986,z=73.757812,name="Medic",color=23,sprite=153,cost=1500},
{x=1003.4803466797,y=-2143.5036621094,z=30.551580429077,name="Medic",color=23,sprite=153,cost=1150},
{x=-1333.8295898438,y=-229.39065551758,z=42.882236480713,name="Medic",color=23,sprite=153,cost=1500},
{x=-3098.7895507813,y=348.39495849609,z=14.440871238708,name="Medic",color=23,sprite=153,cost=0}, --beard
{x=1985.2779541016,y=3048.7067871094,z=47.215042114258,name="Drink",color=23,sprite=93,cost=600}, -- yellow jack
{x=-560.26623535156,y=285.49325561523,z=82.176300048828,name="Drink",color=23,sprite=93,cost=300}, -- tequilala
}
 lsfd.medics={
 {x=208.99238586426,y=-1657.8919677734,z=29.803220748901,name="Medkit",color=75,sprite=153,cost=0},
 {x=1207.4931640625,y=-1476.2899169922,z=34.859550476074,name="Medkit",color=75,sprite=153,cost=0},
}
 military.medics={
{x=3092.6142578125,y=-4721.0063476563,z=27.278636932373,name="Medkit",color=26,sprite=153,cost=0}, -- carrier
{x=3086.4086914063,y=-4795.1791992188,z=2.0335190296173,name="Medkit",color=26,sprite=153,cost=0}, -- carrier
{x=3090.3371582031,y=-4802.5244140625,z=7.0797100067139,name="Medkit",color=26,sprite=153,cost=0}, -- carrier
{x=3088.5026855469,y=-4737.4521484375,z=10.742150306702,name="Medkit",color=26,sprite=153,cost=0}, -- carrier
{x=3035.0034179688,y=-4689.2353515625,z=6.0772891044617,name="Medkit",color=26,sprite=153,cost=0}, -- carrier
{x=3096.7106933594,y=-4702.1611328125,z=12.244046211243,name="Medkit",color=26,sprite=153,cost=0}, -- carrier
{x=3088.6994628906,y=-4711.642578125,z=15.262623786926,name="Medkit",color=26,sprite=153,cost=0}, -- carrier
{x=3087.4506835938,y=-4692.7104492188,z=27.252170562744,name="Medkit",color=26,sprite=153,cost=0}, -- carrier
{x=-3098.8088378906,y=348.12609863281,z=14.440861701965,name="Medic",color=52,sprite=153,cost=0}, -- military
 }
 noose.medics={
{x=2477.2575683594,y=-420.93502807617,z=93.735168457031,name="Medic",color=29,sprite=153,cost=0}, -- noose
 }
 sahp.medics={
{x=-442.30810546875,y=6012.0126953125,z=31.716377258301,name="Medic",color=39,sprite=153,cost=0}, -- sahp
 }
 sspd.medics={
{x=1850.7416992188,y=3683.5285644531,z=34.267040252686,name="Medic",color=5,sprite=153,cost=0}, -- sspd
 }
 sapr.medics={
{x=388.95092773438,y=799.78704833984,z=187.67132568359,name="Medic",color=2,sprite=153,cost=0}, -- sapr
 }
 lspd.medics={
{x=470.98806762695,y=-984.88824462891,z=30.689607620239,name="Medic",color=3,sprite=153,cost=0},
{x=855.63909912109,y=-1285.5286865234,z=26.796737670898,name="Medic",color=3,sprite=153,cost=0},
{x=-1112.6473388672,y=-848.40319824219,z=13.440620422363,name="Medic",color=3,sprite=153,cost=0},
{x=-1078.9779052734,y=-856.30047607422,z=5.0424327850342,name="Medic",color=3,sprite=153,cost=0},
{x=371.49307250977,y=-1612.5402832031,z=29.291933059692,name="Medic",color=3,sprite=153,cost=0}
 }
 faction.fbi.medics={
{x=139.62872314453,y=-747.20422363281,z=242.15194702148,name="Medic",color=3,sprite=153,cost=0},
}
 lost.medics={
{x=980.94506835938,y=-98.249252319336,z=74.845077514648,name="Medic",color=62,sprite=153,cost=2200}
}
 merc.medics={
--{x=562.81048583984,y=-3123.0014648438,z=18.768636703491,name="Medic",color=65,sprite=153,cost=0}
}
 anarchy.medics={
{x=705.71612548828,y=-966.90264892578,z=30.395343780518,name="Medic",color=25,sprite=153,cost=400}
}
 cartel.medics={
{x=1406.9233398438,y=1127.4875488281,z=114.33421325684,name="Medic",color=47,sprite=153,cost=600}
}
 elite.medics={
{x=-2080.41796875,y=-1015.1663818359,z=12.781924247742,name="Medic",color=4,sprite=153,cost=500,factionreq={FACTION.ELITE,1000000}}, --
{x=-73.911170959473,y=334.17614746094,z=142.59918212891,name="Medic",color=4,sprite=153,cost=2000}
}
local medics=faction.criminal.medics

Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.medics)
    makeblips(lsfd.medics)
    makeblips(lspd.medics)
    makeblips(sspd.medics)
    makeblips(sahp.medics)
    makeblips(sapr.medics)
    makeblips(noose.medics)
    makeblips(military.medics)
    makeblips(faction.fbi.medics)
    makeblips(lost.medics)
    makeblips(merc.medics)
    makeblips(anarchy.medics)
    makeblips(cartel.medics)
    makeblips(elite.medics)
    hideblips(lsfd.medics)
    hideblips(faction.fbi.medics)
    hideblips(lspd.medics)
    hideblips(sspd.medics)
    hideblips(sahp.medics)
    hideblips(sapr.medics)
    hideblips(noose.medics)
    hideblips(military.medics)
    hideblips(lost.medics)
    hideblips(merc.medics)
    hideblips(anarchy.medics)
    hideblips(cartel.medics)
    hideblips(elite.medics)
    while true do
        Wait(0)
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(medics) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not player.is_dead) then
                    if v.factionreq and gangwar.top[v.factionreq[1]].score<v.factionreq[2] then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~r~"..gangwar.top[v.factionreq[1]].name.." needs ~g~$"..v.factionreq[2].." ~r~to unlock this.")
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    elseif IsControlPressed(0, 86) then
                        if player.money>=v.cost then
                            local ped=PlayerPedId()
                            local maxhealth=GetPedMaxHealth(ped)
                            if GetEntityHealth(ped)<maxhealth then
                                SetEntityHealth(ped,maxhealth);
                                player.money=player.money-v.cost
                                removemoney(player.money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                SetBlipColour(v.blip, 20)
                                WaitWithMarker(5000,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(PlayerPedId())
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to heal.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local function setpedmodel_noweapons(model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end
    SetPlayerModel(PlayerId(),model)
    SetModelAsNoLongerNeeded(model)
    local ped=PlayerPedId()
    if forced_max_health~=nil then
        SetPedMaxHealth(ped,forced_max_health)
        SetEntityHealth(ped,forced_max_health)
    end
    SetPedRandomComponentVariation(ped, false)
    SetPedRandomProps(ped)
    return ped
end
local function setpedmodel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end
    local ped=PlayerPedId()
    local weapons={}
    local ammo={}
    local health=GetEntityHealth(ped)
    local armor=GetPedArmour(ped)
    for name,w in pairs(WEAPON) do
        if HasPedGotWeapon(ped, w, false) then
            local i=0
            local ammo_type=GetPedAmmoTypeFromWeapon(ped,w)
            weapons[w]={}
            ammo[ammo_type]=GetPedAmmoByType(ped,ammo_type)
            for upgrade_name,upgrade_type in pairs(weapon_upgrades) do
                local upgrade=upgrade_type[w]
                if upgrade and HasPedGotWeaponComponent(ped,w,upgrade) then
                    i=i+1
                    weapons[w][i]=upgrade
                end
            end
        end
    end
    SetPlayerModel(PlayerId(),model)
    SetModelAsNoLongerNeeded(model)
    ped=PlayerPedId()
    if forced_max_health~=nil then SetPedMaxHealth(ped,forced_max_health) end
    SetEntityHealth(ped,health)
    SetPedArmour(ped,armor)
    SetPedRandomComponentVariation(ped, false)
    SetPedRandomProps(ped)
    --Wait(1000)
    for k,v in pairs(weapons) do
        GiveWeaponToPed(ped,k,0,false,true)
        for i,upgrade in pairs(v) do
            GiveWeaponComponentToPed(ped,k,upgrade)
        end
    end
    for k,v in pairs(ammo) do
        SetPedAmmoByType(ped,k,v)
    end
    SetPedRelationshipGroupHash(ped,relationship_friend)
    return ped
end
local function givescubagear(ped)
    SetEnableScuba(ped,true);
    SetPedDiesInWater(ped,false);
    --SetPedMaxTimeInWater(ped,1000000.0)
    --SetPedMaxTimeUnderwater(ped,1000000.0)
end
local function is_model_scuba(model)
    if model==941695432 then
        return true
    elseif model==365775923 then
        return true
    elseif model==225514697 then
        return true
    elseif model==-1686040670 then
        return true
    elseif model==-1692214353 then
        return true
    end
    return false
end
local function havescubagear()
    local model=GetEntityModel(PlayerPedId())
    return is_model_scuba(model)
end
local function removespecial()
    local model=GetEntityModel(PlayerPedId())
    SetEnableScuba(ped,false);
    SetPedDiesInWater(ped,true);
    if model==941695432 then -- агент Хейнс
        setpedmodel(SKINS.FBI[math.random(#SKINS.FBI)]) --fbi
        -- SetPedComponentVariation(ped,8,0,0,0)
        -- SetPedPropIndex(ped,1,0,0,true) --scuba mask
    elseif model==365775923 then -- Дейв Нортон
        setpedmodel(SKINS.CRIMINAL[math.random(#SKINS.CRIMINAL)]) --criminal
        -- SetPedComponentVariation(ped,8,0,0,0)
    elseif model==225514697 then -- Майкл
        setpedmodel(SKINS.MERCS[math.random(#SKINS.MERCS)]) --merc
        -- SetPedComponentVariation(ped,8,0,0,0)
        -- SetPedPropIndex(ped,0,0,0,true) --scuba mask
    elseif model==-1686040670 then -- Тревор
        setpedmodel(SKINS.HEISTERS[math.random(#SKINS.HEISTERS)]) --heister
        -- SetPedComponentVariation(ped,8,0,0,0)
        -- SetPedPropIndex(ped,0,0,0,true) --scuba mask
    elseif model==-1692214353 then -- Франклин
        setpedmodel(SKINS.ELITE[math.random(#SKINS.ELITE)]) --elite
        -- SetPedComponentVariation(ped,8,0,0,0)
        -- SetPedPropIndex(ped,0,0,0,true) --scuba mask
    end
end
local function havespecialskin()
    return havescubagear()
end


local function hideexterior_alta3()
    Citizen.InvokeNative(0x4B5CFC83122DF602)
    HideMapObjectThisFrame(GetHashKey("hei_dt1_20_build2"))
    HideMapObjectThisFrame(GetHashKey("dt1_20_dt1_emissive_dt1_20"))
    Citizen.InvokeNative(0x3669F1B198DCAA4F)
end
local function closebomjdoor()
    local closeDoor = GetClosestObjectOfType(151.36083984375,-1007.8784790039,-98.999984741211, 2.0, -1663022887, false, false, false)
    SetEntityHeading(closeDoor, 179.99987792969)
	FreezeEntityPosition(closeDoor, true)
    SetRadarAsInteriorThisFrame(0,151.36083984375,-1007.8784790039,-98.999984741211,2)
end
--local function zoomradar_interior()
    --SetRadarAsInteriorThisFrame(0,151.36083984375,-1007.8784790039,-98.999984741211,2)
    --SetRadarZoomLevelThisFrame(10.0)
--end



local openarmory,openstash=0,0

local apartments={

stilt_2045nc={cost=5000000,welcome="buy ~b~Stilt House~s~",firsttimecheck=true,
entrance={x=375.02807617188,y=427.56436157227,z=145.6838684082},sprite=374,
interiorid=206337,
exit={x=373.63525390625,y=423.69442749023,z=145.90788269043},
personal=true,
clothes={x=374.38259887695,y=411.42193603516,z=142.10014343262},
heal={x=379.21282958984,y=418.03268432617,z=142.11172485352},
weaponshop={x=378.86877441406,y=430.00305175781,z=138.30014038086},
fasttravel={ x=377.78726196289,y=419.68817138672,z=145.90003967285},
stash={x=371.1350402832,y=426.15432739258,z=138.30014038086},
},
stilt_2044nc={cost=5000000,welcome="buy ~b~Stilt House~s~",firsttimecheck=true,
entrance={x=345.32501220703,y=440.03198242188,z=148.09053039551},sprite=374,
interiorid=206081,
exit={x=342.12084960938,y=437.84649658203,z=149.38078308105},
personal=true,
fasttravel={x=342.5549621582,y=431.20184326172,z=149.38076782227},
clothes={x=334.24087524414,y=428.52578735352,z=145.5708770752},
heal={x=342.2932434082,y=428.94381713867,z=145.57366943359},
weaponshop={x=336.27581787109,y=437.55310058594,z=141.77076721191},
stash={x=328.42395019531,y=430.28875732422,z=148.97131347656},
},
stilt_3677wd={cost=5000000,welcome="buy ~b~Stilt House~s~",firsttimecheck=true,
entrance={x=119.3999710083,y=563.31634521484,z=183.96925354004},sprite=374,
interiorid=206593,
exit={x=117.28005218506,y=560.03479003906,z=184.30487060547},
personal=true,
fasttravel={x=122.26351928711,y=557.47943115234,z=184.29707336426},
clothes={x=122.05478668213,y=548.77655029297,z=180.49726867676},
heal={x=124.4165802002,y=556.51837158203,z=180.50914001465},
stash={x=114.13722991943,y=561.28967285156,z=176.69714355469},
weaponshop={x=120.12516784668,y=567.58624267578,z=176.69714355469},
},
stilt_3655wod={cost=5000000,welcome="buy ~b~Stilt House~s~",firsttimecheck=true,
entrance={x=-173.6223449707,y=502.65237426758,z=137.42335510254},sprite=374,
interiorid=207105,
exit={x=-174.20683288574,y=497.61782836914,z=137.66532897949},
personal=true,
fasttravel={x=-167.85173034668,y=496.53308105469,z=137.65356445313},
clothes={x=-167.37454223633,y=487.67611694336,z=133.84378051758},
heal={x=-165.60696411133,y=495.50799560547,z=133.84576416016},
stash={x=-170.67671203613,y=482.49447631836,z=137.24423217773},
weaponshop={x=-175.81387329102,y=492.22912597656,z=130.0436706543},
},
stilt_2217mr={cost=5000000,welcome="buy ~b~Stilt House~s~",firsttimecheck=true,
entrance={x=-560.11773681641,y=662.74603271484,z=145.48278808594},sprite=374,
interiorid=207873,
exit={x=-571.88372802734,y=661.82110595703,z=145.83985900879},
personal=true,
fasttravel={x=-567.98516845703,y=657.96606445313,z=145.83201599121},
clothes={x=-571.24450683594,y=649.64440917969,z=142.03224182129},
heal={x=-566.34350585938,y=656.14813232422,z=142.03800964355},
stash={x=-574.40173339844,y=664.56158447266,z=138.2322845459},
weaponshop={x=-566.24639892578,y=668.00848388672,z=138.23211669922},
},
stilt_2862ha={cost=5000000,welcome="buy ~b~Stilt House~s~",firsttimecheck=true,
entrance={x=-685.12347412109,y=595.20166015625,z=144.03930664063},sprite=374,
interiorid=208129,
exit={x=-682.48516845703,y=592.6767578125,z=145.37977600098},
personal=true,
fasttravel={x=-676.25286865234,y=594.68115234375,z=145.3797454834},
clothes={x=-671.41027832031,y=587.36248779297,z=141.56985473633},
heal={x=-673.94598388672,y=594.97692871094,z=141.58058166504},
stash={x=-671.76257324219,y=581.18615722656,z=144.97027587891},
weaponshop={x=-681.35693359375,y=586.83587646484,z=137.76974487305},
},
stilt_2868ha={cost=5000000,welcome="buy ~b~Stilt House~s~",firsttimecheck=true,
entrance={x=-754.65661621094,y=619.84906005859,z=142.85665893555},sprite=374,
interiorid=207617,
exit={x=-758.14813232422,y=618.96325683594,z=144.14060974121},
personal=true,
fasttravel={x=-758.68511962891,y=612.52465820313,z=144.140625},
clothes={x=-767.46990966797,y=610.8359375,z=140.33073425293},
heal={x=-759.29760742188,y=610.38983154297,z=140.33882141113},
stash={x=-772.84417724609,y=613.51971435547,z=143.73115539551},
weaponshop={x=-763.96026611328,y=620.2001953125,z=136.53060913086},
},
stilt_2874ha={cost=5000000,welcome="buy ~b~Stilt House~s~",firsttimecheck=true,
entrance={x=-852.91680908203,y=693.86029052734,z=149.04182434082},sprite=374,
interiorid=207361,
exit={x=-859.95843505859,y=691.35089111328,z=152.86073303223},
personal=true,
fasttravel={x=-854.82281494141,y=688.68475341797,z=152.85292053223},
clothes={x=-855.22027587891,y=680.03601074219,z=149.05310058594},
heal={x=-852.74212646484,y=687.57080078125,z=149.05754089355},
stash={x=-863.10284423828,y=692.91369628906,z=145.25325012207},
weaponshop={x=-856.51135253906,y=698.87994384766,z=145.25297546387},
},
stilt_2113mwtd={cost=5000000,welcome="buy ~b~Stilt House~s~",firsttimecheck=true,
entrance={x=-1294.1184082031,y=453.13424682617,z=97.64134979248},sprite=374,
interiorid=208385,
exit={x=-1289.7043457031,y=449.69128417969,z=97.902519226074},
personal=true,
fasttravel={x=-1284.9735107422,y=446.69812011719,z=97.89469909668},
clothes={x=-1286.0578613281,y=438.16497802734,z=94.09481048584},
heal={x=-1283.0115966797,y=445.48590087891,z=94.10213470459},
stash={x=-1292.8470458984,y=451.57983398438,z=90.294700622559},
weaponshop={x=-1285.9479980469,y=456.97134399414,z=90.294700622559},
},

altahotel={cost=1000000,welcome="join ~r~Alta Hotel~s~",firsttimecheck=true,
entrance={x=-266.59945678711,y=-956.03387451172,z=31.223134994507},sprite=475,
zone={x=-277.69100952148,y=-952.26770019531,z=90,r=40,h=5},
interiorid=141569,
weaponshop={x=-272.65017700195,y=-949.73199462891,z=92.519371032715},
stash={x=-283.45257568359,y=-949.39801025391,z=86.303680419922},
clothes={x=-277.66131591797,y=-960.51202392578,z=86.303611755371},
heal={x=-276.41958618164,y=-952.56530761719,z=86.303588867188},
fasttravel={ x=-277.68383789063,y=-936.60827636719,z=92.510887145996},
exit={x=-269.96142578125,y=-941.06811523438,z=92.510902404785},
hideexterior=hideexterior_alta3,
--factions_allowed={}
},

bomjatnya_1={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=-583.03045654297,y=228.09815979004,z=79.428085327148},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_2={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=363.48321533203,y=-711.83111572266,z=29.28723526001},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_3={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=-21.726606369019,y=-1003.1072387695,z=29.295963287354},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_4={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=54.82234954834,y=-916.17828369141,z=29.965997695923},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_paleto={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=-154.59375,y=6433.1518554688,z=31.915904998779},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_sandy={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=1435.7113037109,y=3657.2365722656,z=34.352275848389},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_chumash={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=-3231.7888183594,y=1081.5544433594,z=10.809398651123},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_harmony={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=359.43469238281,y=2623.3625488281,z=44.683723449707},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_senora_hotel={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=1141.2111816406,y=2642.0073242188,z=38.143703460693},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_grapeseed={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=1662.9924316406,y=4776.2939453125,z=42.00756072998},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

bomjatnya_paletoforest={cost=10000,welcome="buy ~b~cheap apartment~s~",firsttimecheck=true,
entrance={x=-693.98712158203,y=5761.7700195313,z=17.511001586914},sprite=40,
zone={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211,r=50,h=5},
interiorid=149505,
weaponshop={x=154.81071472168,y=-1005.8638305664,z=-98.999961853027},
stash={x=151.80364990234,y=-1000.7803955078,z=-98.999961853027},
heal={x=154.1587677002,y=-1000.6638183594,z=-98.999977111816},
fasttravel={x=154.33459472656,y=-1003.2825317383,z=-98.999961853027},
exit={x=151.36083984375,y=-1007.8784790039,z=-98.999984741211},
personal=true,
hideexterior=closebomjdoor
},

dno_1={cost=100000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=156.40596008301,y=-1065.7102050781,z=30.058218002319},sprite=40,
zone={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,r=50,h=5},
interiorid=149761,
weaponshop={x=256.70932006836,y=-997.69555664063,z=-99.008567810059},
clothes={x=259.81680297852,y=-1003.9661865234,z=-99.008651733398},
stash={x=262.83419799805,y=-1003.0643920898,z=-99.008651733398},
heal={x=255.69967651367,y=-1000.602722168,z=-99.009864807129},
fasttravel={x=261.20172119141,y=-1000.5039672852,z=-98.965965270996},
personal=true,
exit={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127}
},

dno_2={cost=100000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=-1348.3575439453,y=-1081.7237548828,z=6.9381980895996},sprite=40,
zone={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,r=50,h=5},
interiorid=149761,
weaponshop={x=256.70932006836,y=-997.69555664063,z=-99.008567810059},
clothes={x=259.81680297852,y=-1003.9661865234,z=-99.008651733398},
stash={x=262.83419799805,y=-1003.0643920898,z=-99.008651733398},
heal={x=255.69967651367,y=-1000.602722168,z=-99.009864807129},
fasttravel={x=261.20172119141,y=-1000.5039672852,z=-98.965965270996},
personal=true,
exit={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127}
},

dno_3={cost=100000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=-1566.5694580078,y=-404.52813720703,z=42.388149261475},sprite=40,
zone={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,r=50,h=5},
interiorid=149761,
weaponshop={x=256.70932006836,y=-997.69555664063,z=-99.008567810059},
clothes={x=259.81680297852,y=-1003.9661865234,z=-99.008651733398},
stash={x=262.83419799805,y=-1003.0643920898,z=-99.008651733398},
heal={x=255.69967651367,y=-1000.602722168,z=-99.009864807129},
fasttravel={x=261.20172119141,y=-1000.5039672852,z=-98.965965270996},
personal=true,
exit={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127}
},

dno_4={cost=100000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=561.39233398438,y=92.825782775879,z=96.08268737793},sprite=40,
zone={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,r=50,h=5},
interiorid=149761,
weaponshop={x=256.70932006836,y=-997.69555664063,z=-99.008567810059},
clothes={x=259.81680297852,y=-1003.9661865234,z=-99.008651733398},
stash={x=262.83419799805,y=-1003.0643920898,z=-99.008651733398},
heal={x=255.69967651367,y=-1000.602722168,z=-99.009864807129},
fasttravel={x=261.20172119141,y=-1000.5039672852,z=-98.965965270996},
personal=true,
exit={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127}
},

dno_banham={cost=100000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=-3088.7939453125,y=392.25863647461,z=11.447541236877},sprite=40,
zone={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,r=50,h=5},
interiorid=149761,
weaponshop={x=256.70932006836,y=-997.69555664063,z=-99.008567810059},
clothes={x=259.81680297852,y=-1003.9661865234,z=-99.008651733398},
stash={x=262.83419799805,y=-1003.0643920898,z=-99.008651733398},
heal={x=255.69967651367,y=-1000.602722168,z=-99.009864807129},
fasttravel={x=261.20172119141,y=-1000.5039672852,z=-98.965965270996},
personal=true,
exit={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127}
},

dno_chumash={cost=100000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=-3196.2893066406,y=1280.7489013672,z=12.66291809082},sprite=40,
zone={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,r=50,h=5},
interiorid=149761,
weaponshop={x=256.70932006836,y=-997.69555664063,z=-99.008567810059},
clothes={x=259.81680297852,y=-1003.9661865234,z=-99.008651733398},
stash={x=262.83419799805,y=-1003.0643920898,z=-99.008651733398},
heal={x=255.69967651367,y=-1000.602722168,z=-99.009864807129},
fasttravel={x=261.20172119141,y=-1000.5039672852,z=-98.965965270996},
personal=true,
exit={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127}
},

dno_paleto={cost=100000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=-109.03810119629,y=6337.2534179688,z=31.576190948486},sprite=40,
zone={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127,r=50,h=5},
interiorid=149761,
weaponshop={x=256.70932006836,y=-997.69555664063,z=-99.008567810059},
clothes={x=259.81680297852,y=-1003.9661865234,z=-99.008651733398},
stash={x=262.83419799805,y=-1003.0643920898,z=-99.008651733398},
heal={x=255.69967651367,y=-1000.602722168,z=-99.009864807129},
fasttravel={x=261.20172119141,y=-1000.5039672852,z=-98.965965270996},
personal=true,
exit={x=266.01358032227,y=-1007.4214477539,z=-101.00855255127}
},

norm_1={cost=300000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=-667.96154785156,y=-1105.8597412109,z=14.626156806946},sprite=40,
zone={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,r=50,h=5},
interiorid=148225,
stash={x=351.88400268555,y=-998.81890869141,z=-99.196250915527},
clothes={x=351.44787597656,y=-993.58483886719,z=-99.196250915527},
heal={x=347.2311706543,y=-994.16827392578,z=-99.196250915527},
fasttravel={x=338.20541381836,y=-995.00994873047,z=-99.196182250977},
weaponshop={x=346.16708374023,y=-1002.3190917969,z=-99.196220397949},
personal=true,
exit={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949}
},

norm_2={cost=300000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=321.11016845703,y=-1627.6629638672,z=32.534008026123},sprite=40,
zone={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,r=50,h=5},
interiorid=148225,
stash={x=351.88400268555,y=-998.81890869141,z=-99.196250915527},
clothes={x=351.44787597656,y=-993.58483886719,z=-99.196250915527},
heal={x=347.2311706543,y=-994.16827392578,z=-99.196250915527},
fasttravel={x=338.20541381836,y=-995.00994873047,z=-99.196182250977},
weaponshop={x=346.16708374023,y=-1002.3190917969,z=-99.196220397949},
personal=true,
exit={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949}
},

norm_3={cost=300000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=-71.021949768066,y=142.28298950195,z=81.699150085449},sprite=40,
zone={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,r=50,h=5},
interiorid=148225,
stash={x=351.88400268555,y=-998.81890869141,z=-99.196250915527},
clothes={x=351.44787597656,y=-993.58483886719,z=-99.196250915527},
heal={x=347.2311706543,y=-994.16827392578,z=-99.196250915527},
fasttravel={x=338.20541381836,y=-995.00994873047,z=-99.196182250977},
weaponshop={x=346.16708374023,y=-1002.3190917969,z=-99.196220397949},
personal=true,
exit={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949}
},

norm_4={cost=300000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=-567.39880371094,y=-442.53005981445,z=34.341484069824},sprite=40,
zone={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,r=50,h=5},
interiorid=148225,
stash={x=351.88400268555,y=-998.81890869141,z=-99.196250915527},
clothes={x=351.44787597656,y=-993.58483886719,z=-99.196250915527},
heal={x=347.2311706543,y=-994.16827392578,z=-99.196250915527},
fasttravel={x=338.20541381836,y=-995.00994873047,z=-99.196182250977},
weaponshop={x=346.16708374023,y=-1002.3190917969,z=-99.196220397949},
personal=true,
exit={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949}
},

norm_banham={cost=300000,welcome="buy ~b~apartment~s~",firsttimecheck=true,
entrance={x=-2972.796875,y=599.11578369141,z=24.246788024902},sprite=40,
zone={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949,r=50,h=5},
interiorid=148225,
stash={x=351.88400268555,y=-998.81890869141,z=-99.196250915527},
clothes={x=351.44787597656,y=-993.58483886719,z=-99.196250915527},
heal={x=347.2311706543,y=-994.16827392578,z=-99.196250915527},
fasttravel={x=338.20541381836,y=-995.00994873047,z=-99.196182250977},
weaponshop={x=346.16708374023,y=-1002.3190917969,z=-99.196220397949},
personal=true,
exit={x=346.53533935547,y=-1012.7813110352,z=-99.196220397949}
},

}--apartments

RegisterNetEvent(event.teleport)
AddEventHandler(event.teleport,function(x,y,z,property_name)
    local ped=PlayerPedId()
    SetEntityCoords(ped,x,y,z)
    player.propertyname=property_name
    player.property=apartments[player.propertyname]
    spawn_point={x=x,y=y,z=z,property=player.property,propertyname=player.propertyname}
    DecorSetInt(ped,"interiorhash",GetHashKey(player.propertyname))
end)
RegisterNetEvent(event.savenquit_load)
AddEventHandler(event.savenquit_load,function(pos,model,components,props,health,armor,weapons,ammo,relationship,textures,property_name)
    player.propertyname=property_name
    player.property=apartments[player.propertyname]
end)
RegisterNetEvent(event.property_owned)
AddEventHandler(event.property_owned,function(property_name)
    local property=apartments[property_name]
    if property then
        property.welcome=nil
        property.cost=nil
    end
end)
RegisterNetEvent(event.property_unlock)
AddEventHandler(event.property_unlock,function(property_name,unlock)
    for k,v in pairs(unlock) do
    --print("Unlocking "..v.."...")
    SendNUIMessage({
    weapon_shop_unlock=v,
    property_name=property_name
    })
    --print("Unlocked "..v)
    end
end)
RegisterNetEvent(event.property_stash)
AddEventHandler(event.property_stash,function(property_name,stash_money)
    local property=apartments[property_name]
    if property then
        property.stash_money=stash_money
        SendNUIMessage({
        stash_money_update = property_name,
        stash_money = stash_money
        })
    end
end)
RegisterNUICallback('stash_deposit', function(data, cb)
    cb('ok')
    local how_much=tonumber(data.deposit)
    TriggerServerEvent(event.property_stash,data.property_name,how_much)
end)
RegisterNUICallback('shop_unlock', function(data, cb)
    cb('ok')
    --SetTextComponentFormat("STRING")
    --AddTextComponentString("Trying to unlock "..data.unlock.." in "..data.property_name.."...")
    --DisplayHelpTextFromStringLabel(0,0,1,-1)
    TriggerServerEvent(event.property_unlock,data.property_name,data.unlock)
end)
RegisterNUICallback('shop_buy_weapon', function(data, cb)
    cb('ok')
    data.cost=tonumber(data.cost)
    if player.money~=nil and player.money>=data.cost then
        player.money=player.money-data.cost
        removemoney(player.money,data.cost)
        TriggerServerEvent(event.buy,data.cost)
        if data.weapon=="bodyarmor" then
            SetPedArmour(PlayerPedId(), 100);
        elseif data.weapon=="parachute" then
            GiveWeaponToPed(ped,WEAPON.PARACHUTE,1,false,true) --parachute
        else
            if (data.count) then
                GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_"..data.weapon), data.count, false, true)
            else
                GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_"..data.weapon), 1000, false, true)
            end
        end
        SetTextComponentFormat("STRING")
        AddTextComponentString("Bought "..data.weapon.." for $"..data.cost)
        DisplayHelpTextFromStringLabel(0,0,1,-1)
    end
end)
RegisterNUICallback('shop_exit', function(data, cb)
    cb('ok')
    openarmory=0
    SetNuiFocus(false,false)
end)
RegisterNUICallback('stash_exit', function(data, cb)
    cb('ok')
    openstash=0
    SetNuiFocus(false,false)
end)

RegisterNetEvent(event.clothes_load)
AddEventHandler(event.clothes_load,function(model,components,textures,props,prop_textures)
    if relationship_friend==GetHashKey("PLAYER") then
        setpedmodel(model)
        local ped=PlayerPedId()
        for i=0,11 do
            SetPedComponentVariation(ped,i,components[i+1],textures[i+1],0)
        end
        ClearAllPedProps(PlayerPedId())
        for i=0,3 do
            SetPedPropIndex(ped,i,props[i+1],prop_textures[i+1],true)
        end
    else
        SetNotificationTextEntry("STRING");
        AddTextComponentString("You cannot load skin when in faction.");
        DrawNotification(false, false);
    end
end)

Citizen.CreateThread(function()
    local elevatorblip
    local armoryblip    
    local changeclothesblip
    local healblip
    local busblip
    local stashblip
    local me_ped
    local function disable_weapons_in_apartments()
        DisableControlAction(0,24,false)
        DisableControlAction(0,47,false)
        DisableControlAction(0,58,false)
        DisableControlAction(0,263,false)
        DisableControlAction(0,264,false)
        DisableControlAction(0,257,false)
        DisableControlAction(0,140,false)
        DisableControlAction(0,141,false)
        DisableControlAction(0,142,false)
        DisableControlAction(0,143,false)
        local playerid=PlayerId()
        DisablePlayerFiring(playerid,true)
        SetDisableAmbientMeleeMove(playerid, true)
    end
    while true do
        Wait(0)
        me_ped=PlayerPedId()
        pos=GetEntityCoords(me_ped)
        player.in_apartment=false
        --for propertyname,v in pairs(apartments) do
        local v=player.property
        --if v~=nil and math.abs(pos.x-v.zone.x)+math.abs(pos.y-v.zone.y)<v.zone.r and math.abs(pos.z-v.zone.z)<v.zone.h -- safe zone
        if v~=nil and GetInteriorFromEntity(me_ped)==v.interiorid
        then
            if v.firsttimecheck then
                TriggerServerEvent(event.property_check,player.propertyname)
                v.firsttimecheck=nil
            end
            if (v.hideexterior) then v.hideexterior() end
            if math.abs(pos.x-v.exit.x)+math.abs(pos.y-v.exit.y)+math.abs(pos.z-v.exit.z)<1 and IsControlJustPressed(0,86) -- лифт вниз
            then
                player.property=nil
                player.propertyname=nil
                --me_ped=PlayerPedId()
                DecorRemove(me_ped,"interiorhash")
                SetEntityCoords(me_ped,v.entrance.x,v.entrance.y,v.entrance.z)
            --{x=-279.24560546875,y=-960.7265625,z=86.303611755371,name="Change clothes",color=3,sprite=366}, -- alta hotel
            --x=-276.41958618164,y=-952.56530761719,z=86.303588867188 -- heal
            --x=-270.77587890625,y=-944.876953125,z=92.510887145996 -- cars
            -- x=-283.45257568359,y=-949.39801025391,z=86.303680419922 -- stash
            else
                player.in_apartment=true
                if player.propertyname~=nil and not DecorExistOn(me_ped,"interiorhash") then
                    DecorSetInt(me_ped,"interiorhash",GetHashKey(player.propertyname))
                end
                if v.fasttravel~=nil then
                    if(busblip==nil) then
                        busblip=AddBlipForCoord(v.fasttravel.x,v.fasttravel.y,v.fasttravel.z) --иконка
                        SetBlipAsShortRange(busblip, true)
                        SetBlipSprite(busblip,67)
                        SetBlipColour(busblip,4)
                    else
                        SetBlipCoords(busblip,v.fasttravel.x,v.fasttravel.y,v.fasttravel.z)
                    end
                    SetBlipDisplay(busblip,8)
                    if math.abs(pos.x-v.fasttravel.x)+math.abs(pos.y-v.fasttravel.y)+math.abs(pos.z-v.fasttravel.z)<1.5
                    then
                        if IsControlJustPressed(0,86)
                        then
                            player.showbusmenu=true
                        end
                    else
                        player.showbusmenu=false
                    end
                end
                if v.heal~=nil then
                    if(healblip==nil) then
                        healblip=AddBlipForCoord(v.heal.x,v.heal.y,v.heal.z) --иконка хилки
                        SetBlipAsShortRange(healblip, true)
                        SetBlipSprite(healblip,153)
                        SetBlipColour(healblip,4)
                    else
                        SetBlipCoords(healblip,v.heal.x,v.heal.y,v.heal.z)
                    end
                    SetBlipDisplay(healblip,8)
                    if math.abs(pos.x-v.heal.x)+math.abs(pos.y-v.heal.y)+math.abs(pos.z-v.heal.z)<1 -- хил
                    then
                        if IsControlJustPressed(0,86)
                        then
                            me_ped=PlayerPedId()
                            local maxhealth=GetPedMaxHealth(me_ped)
                            if GetEntityHealth(me_ped)<maxhealth then
                                SetEntityHealth(me_ped,maxhealth)
                            end
                        end
                    end
                end
                if v.clothes~=nil then
                    if(changeclothesblip==nil) then
                        changeclothesblip=AddBlipForCoord(v.clothes.x,v.clothes.y,v.clothes.z) --иконка смены одежды
                        SetBlipAsShortRange(changeclothesblip, true)
                        SetBlipSprite(changeclothesblip,73)
                        SetBlipColour(changeclothesblip,4)
                    else
                        SetBlipCoords(changeclothesblip,v.clothes.x,v.clothes.y,v.clothes.z)
                    end
                    SetBlipDisplay(changeclothesblip,8)
                    if math.abs(pos.x-v.clothes.x)+math.abs(pos.y-v.clothes.y)+math.abs(pos.z-v.clothes.z)<3 then -- change clothes
                    
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~INPUT_VEH_HORN~ Load clothes\n~INPUT_RELOAD~ Save clothes\n~INPUT_SPECIAL_ABILITY_SECONDARY~ Random")
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                        
                        if IsControlJustPressed(0,29) --pressed B RANDOM
                        then
                            if relationship_friend==GetHashKey("PLAYER") then
                                me_ped=PlayerPedId()
                                SetPedRandomComponentVariation(me_ped, false)
                                if math.random(0,1)==1 then
                                    ClearAllPedProps(PlayerPedId());
                                else
                                    SetPedRandomProps(PlayerPedId())
                                end
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You cannot change faction clothes.");
                                DrawNotification(false, false);
                            end
                        elseif IsControlJustPressed(0,86) --pressed E LOAD
                        then
                            if relationship_friend==GetHashKey("PLAYER") then
                                TriggerServerEvent(event.clothes_load)
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You cannot load clothes when in faction.");
                                DrawNotification(false, false);
                            end
                        elseif IsControlJustPressed(0,45)  --pressed R SAVE
                        then
                            me_ped=PlayerPedId()
                            local model=GetEntityModel(me_ped)
                            local components={}
                            local textures={}
                            local props={}
                            local prop_textures={}
                            
                            local okay_model=false
                            local okay_model_lists={
                                clothesskinsshops.binco,
                                clothesskinsshops.suburban,
                                clothesskinsshops.ponsonbys
                            }
                            
                            for i,list in pairs(okay_model_lists) do
                                for j,model_hash in pairs(list) do
                                    if model_hash==model then
                                        okay_model=true
                                        goto double_break
                                    end
                                end
                            end
                            ::double_break::
                            
                            if okay_model then
                                for i=0,11 do
                                    components[i+1]=GetPedDrawableVariation(me_ped,i)
                                    textures[i+1]=GetPedTextureVariation(me_ped,i)
                                end
                                local props={}
                                for i=0,3 do
                                    props[i+1]=GetPedPropIndex(me_ped,i)
                                    prop_textures[i+1]=GetPedPropTextureIndex(me_ped,i)
                                end
                                
                                TriggerServerEvent(event.clothes_save,
                                model,
                                components,
                                textures,
                                props,
                                prop_textures)
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You cannot save faction skins.");
                                DrawNotification(false, false);
                            end
                        end
                    end
                end
                if v.weaponshop~=nil and not player.civilian and not player.is_cop then
                    if(armoryblip==nil) then
                        armoryblip=AddBlipForCoord(v.weaponshop.x,v.weaponshop.y,v.weaponshop.z) --иконка оружейной
                        SetBlipAsShortRange(armoryblip, true)
                        SetBlipSprite(armoryblip,110)
                        SetBlipColour(armoryblip,4)
                    else
                        SetBlipCoords(armoryblip,v.weaponshop.x,v.weaponshop.y,v.weaponshop.z)
                    end
                    SetBlipDisplay(armoryblip,8)
                    if math.abs(pos.x-v.weaponshop.x)+math.abs(pos.y-v.weaponshop.y)+math.abs(pos.z-v.weaponshop.z)<3 -- оружейная
                    then
                        if openarmory==0 and IsControlPressed(0,86)
                        then  -- открыть оружейную
                            SendNUIMessage({
                            enable_weapon_shop = player.propertyname
                            })
                            SetNuiFocus(true,true)
                            openarmory=1
                        end
                    elseif openarmory==1
                    then
                        SendNUIMessage({
                        disable_weapon_shop = player.propertyname
                        })
                        SetNuiFocus(false,false)
                        openarmory=0
                    end
                end
                if v.stash~=nil then
                    if(stashblip==nil) then
                        stashblip=AddBlipForCoord(v.stash.x,v.stash.y,v.stash.z) --иконка тайника
                        SetBlipAsShortRange(stashblip, true)
                        SetBlipSprite(stashblip,434)
                        SetBlipColour(stashblip,4)
                    else
                        SetBlipCoords(stashblip,v.stash.x,v.stash.y,v.stash.z)
                    end
                    SetBlipDisplay(stashblip,8)
                    if math.abs(pos.x-v.stash.x)+math.abs(pos.y-v.stash.y)+math.abs(pos.z-v.stash.z)<1 -- тайник
                    then
                        if openstash==0 and IsControlPressed(0,86)
                        then 
                            SendNUIMessage({
                            enable_stash = player.propertyname
                            })
                            SetNuiFocus(true,true)
                            openstash=1
                        end
                    elseif openstash==1
                    then
                        SendNUIMessage({
                        disable_stash = player.propertyname
                        })
                        SetNuiFocus(false,false)
                        openstash=0
                    end
                end
            
                if(elevatorblip==nil) then
                    elevatorblip=AddBlipForCoord(v.exit.x,v.exit.y,v.exit.z) --выход вниз
                    SetBlipAsShortRange(elevatorblip, true)
                    SetBlipSprite(elevatorblip,14)
                    SetBlipColour(elevatorblip,4)
                else
                    SetBlipCoords(elevatorblip,v.exit.x,v.exit.y,v.exit.z)
                end
                SetBlipDisplay(elevatorblip,8)
                
                me_ped=PlayerPedId()
                disable_weapons_in_apartments()
                for i=0,31 do
                    local another_player=GetPlayerPed(i)
                    if another_player~=0 and another_player~=me_ped then
                        local pos=GetEntityCoords(another_player)
                        --if v.personal and math.abs(pos.x-v.zone.x)+math.abs(pos.y-v.zone.y)<v.zone.r and math.abs(pos.z-v.zone.z)<v.zone.h 
                        if v.personal and GetInteriorFromEntity(another_player)==v.interiorid
                            and (
                              (not DecorExistOn(me_ped,"interiorhash"))
                              or
                              (not DecorExistOn(another_player,"interiorhash"))
                              or
                              (not DecorExistOn(me_ped,"partynumber"))
                              or
                              (not DecorExistOn(another_player,"partynumber"))
                              or
                              (DecorGetInt(me_ped,"interiorhash")~=DecorGetInt(another_player,"interiorhash"))
                              or
                              ((DecorGetInt(me_ped,"partynumber")&0xFFFFF)~=(DecorGetInt(another_player,"partynumber")&0xFFFFF))
                            )
                        then
                            SetPlayerInvisibleLocally(i, true)
                            SetEntityCollision(another_player,false,false)
                        else
                            SetPlayerVisibleLocally(i, true)
                            SetEntityCollision(another_player,true,true)
                        end
                    end
                end
                
                --break -- we can't be in multiple apartments at the same time
            end
        else --paranoya
            me_ped=PlayerPedId()
            for propertyname,v in pairs(apartments) do
                --if math.abs(pos.x-v.zone.x)+math.abs(pos.y-v.zone.y)<v.zone.r and math.abs(pos.z-v.zone.z)<v.zone.h then -- safe zone
                if GetInteriorFromEntity(me_ped)==v.interiorid then
                    disable_weapons_in_apartments()
                    for i=0,31 do
                        local another_player=GetPlayerPed(i)
                        if another_player~=0 and another_player~=me_ped then
                            local pos=GetEntityCoords(another_player)
                            --if v.personal and math.abs(pos.x-v.zone.x)+math.abs(pos.y-v.zone.y)<v.zone.r and math.abs(pos.z-v.zone.z)<v.zone.h -- safe zone
                            if v.personal and GetInteriorFromEntity(another_player)==v.interiorid
                            then
                                SetPlayerInvisibleLocally(i, true)
                                SetEntityCollision(another_player,false,false)
                            else
                                SetPlayerVisibleLocally(i, true)
                                SetEntityCollision(another_player,true,true)
                            end
                        end
                    end
                    player.in_apartment=true
                    break
                end
            end
        end
        
            
        if player.in_apartment then
            for propertyname,v in pairs(apartments) do
                if v.entranceblip~=nil then
                    SetBlipDisplay(v.entranceblip,0)
                end
            end
        else
            me_ped=PlayerPedId()
            if DecorExistOn(me_ped,"interiorhash") then --player.property~=nil or player.propertyname~=nil then
                --player.property=nil
                --player.propertyname=nil
                DecorRemove(me_ped,"interiorhash")
            end
            for i=0,31 do
                local another_player=GetPlayerPed(i)
                if another_player~=0 and another_player~=me_ped then
                    SetPlayerVisibleLocally(i, true)
                    SetEntityCollision(another_player,true,true)
                end
            end
            if openarmory==1 then
                for k,v in pairs(apartments) do
                    SendNUIMessage({
                    disable_weapon_shop = k
                    })
                end
                SetNuiFocus(false,false)
                openarmory=0
            end
            if openstash==1 then
                for k,v in pairs(apartments) do
                    SendNUIMessage({
                    disable_stash = k
                    })
                end
                SetNuiFocus(false,false)
                openstash=0
            end
            if(elevatorblip)then SetBlipDisplay(elevatorblip,0) end
            if(armoryblip)then SetBlipDisplay(armoryblip,0) end
            if(changeclothesblip)then SetBlipDisplay(changeclothesblip,0) end
            if(busblip)then SetBlipDisplay(busblip,0) end
            if(healblip)then SetBlipDisplay(healblip,0) end
            if(stashblip)then SetBlipDisplay(stashblip,0) end
            for propertyname,v in pairs(apartments) do
                if v.entranceblip==nil then
                    v.entranceblip=AddBlipForCoord(v.entrance.x,v.entrance.y,v.entrance.z)
                    SetBlipAsShortRange(v.entranceblip, true)
                    SetBlipSprite(v.entranceblip,v.sprite)
                end
                SetBlipDisplay(v.entranceblip,8)
                if math.abs(pos.x-v.entrance.x)+math.abs(pos.y-v.entrance.y)+math.abs(pos.z-v.entrance.z)<2
                then
                    --local playerfaction=GetPedRelationshipGroupHash(PlayerPedId())
                    if v.factions_allowed==nil or v.factions_allowed[relationship_friend]
                    then
                        if v.cost~=nil
                        then
                            if v.firsttimecheck then
                                TriggerServerEvent(event.property_check,propertyname)
                                v.firsttimecheck=nil
                            end
                            SetTextComponentFormat("STRING")
                            AddTextComponentString("Press ~INPUT_VEH_HORN~ to "..v.welcome..".\nYou need to pay ~b~$"..v.cost)
                            DisplayHelpTextFromStringLabel(0,0,1,-1)
                            if IsControlJustPressed(0,86)
                            then
                                TriggerServerEvent(event.property_enter,propertyname)
                            end
                        else
                            SetBlipColour(v.entranceblip,69)
                            SetTextComponentFormat("STRING")
                            AddTextComponentString("Press ~INPUT_VEH_HORN~ to enter.")
                            DisplayHelpTextFromStringLabel(0,0,1,-1)
                            if IsControlJustPressed(0,86)
                            then
                                --TriggerServerEvent(event.property_enter,propertyname)
                                if player.wanted>4 then
                                    SetNotificationTextEntry("STRING")
                                    AddTextComponentString("You can't use this with 5 stars.")
                                    DrawNotification(false, false)
                                else
                                    disable_weapons_in_apartments()
                                    if IsPedArmed(me_ped,3) then
                                        SetCurrentPedWeapon(me_ped,WEAPON.UNARMED,true)
                                        Wait(0)
                                        disable_weapons_in_apartments()
                                    end
                                    SetEntityCoords(me_ped,v.exit.x,v.exit.y,v.exit.z)
                                    player.propertyname=propertyname
                                    player.property=v
                                    spawn_point={x=v.exit.x,y=v.exit.y,z=v.exit.z,property=v,propertyname=propertyname}
                                    DecorSetInt(me_ped,"interiorhash",GetHashKey(propertyname))
                                end
                            end
                        end
                    else
                        SetNotificationTextEntry("STRING");
                        AddTextComponentString("Your faction can't join hotel.");
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
            
            
            


    end
    -- -- local blip=AddBlipForRadius(x,y,32.0,170.0)
    -- -- SetBlipDisplay(blip, 2)
    -- -- SetBlipSprite(blip,9)
    -- -- SetBlipColour(blip,4)
    -- -- SetBlipAlpha(blip,100)
    -- while true do
        -- Wait(0)
        -- local pos=GetEntityCoords(PlayerPedId()) 
        -- local dx,dy=pos.x-x,pos.y-y
        -- if dx*dx+dy*dy<170*170
        -- then
        -- SetNotificationTextEntry("STRING");
        -- AddTextComponentString("~r~ALTA Hotel ~s~territory.\nNo crimes allowed.\n~g~/hotel ~s~for help.");
        -- DrawNotification(false, false);
        -- end
    -- end
end)

faction.criminal.clothes={
{x=144.58369445801,y=-2204.07421875,z=4.6880211830139,name="Change clothes",color=3,sprite=366}, -- torture
{x=-927.54608154297,y=-2938.8908691406,z=13.927205085754,name="Change clothes",color=3,sprite=366}, -- airport
{x=10.085947036743,y=527.34838867188,z=170.63502502441,name="Change clothes",color=3,sprite=366}, -- franklin
{x=-1153.2452392578,y=-1516.6706542969,z=10.63272857666,name="Change clothes",color=3,sprite=366}, -- floyd
{x=-811.86138916016,y=175.1138458252,z=76.74536895752,name="Change clothes",color=3,sprite=366}, -- michael
{x=1271.9737548828,y=-1715.3668212891,z=54.818557739258,name="Change clothes",color=3,sprite=366}, -- lester
{x=-108.79178619385,y=-9.4566087722778,z=70.519645690918,name="Change clothes",color=3,sprite=366}, -- janitor
{x=1969.1474609375,y=3814.9558105469,z=33.428737640381,name="Change clothes",color=3,sprite=366}, -- trevor
--{x=71.19051361084,y=-1387.8325195313,z=29.376081466675,name="Change clothes",color=3,sprite=366}, -- binco
{x=64.321250915527,y=-80.226173400879,z=62.507694244385,name="Change clothes",color=3,sprite=366},
{x=-613.09985351563,y=-599.75042724609,z=29.880842208862,name="Change clothes",color=3,sprite=366},
{x=268.81893920898,y=-1985.9591064453,z=20.413900375366,name="Change clothes",color=3,sprite=366},
{x=895.34643554688,y=-896.27484130859,z=27.791017532349,name="Change clothes",color=3,sprite=366},
{x=74.944374084473,y=-1970.9249267578,z=20.76586151123,name="Change clothes",color=3,sprite=366}, -- ballas
{x=938.88885498047,y=-1877.0637207031,z=32.473220825195,name="Change clothes",color=3,sprite=366}, -- vagos
{x=1214.3400878906,y=-1643.9964599609,z=48.64599609375,name="Change clothes",color=3,sprite=366}, -- SALVA
{x=-766.28356933594,y=-917.10601806641,z=21.279684066772,name="Change clothes",color=3,sprite=366}, -- china
{x=153.57015991211,y=306.04556274414,z=112.13385009766,name="Change clothes",color=3,sprite=366}, -- HEISTERS
{x=-1322.9228515625,y=-244.7769317627,z=42.532939910889,name="Change clothes",color=3,sprite=366}
}
faction.detectives.clothes={
 {x=459.09851074219,y=-992.99127197266,z=30.689598083496,sprite=366,color=3,name="Change clothes"},
}
lspdheavy.clothes={
 {x=459.09851074219,y=-992.99127197266,z=30.689598083496,sprite=366,color=3,components={[9]=2},name="Change clothes"},
}
lspd.clothes={
 {x=459.09851074219,y=-992.99127197266,z=30.689598083496,sprite=366,color=3,components={[9]=0},name="Change clothes"},
}
 fbiswat.clothes={
 --{x=149.44277954102,y=-759.59631347656,z=242.1519317627,sprite=366,color=3,name="Change clothes",components={[10]={0,1}}}
}
 faction.fbi.clothes={
 {x=149.44277954102,y=-759.59631347656,z=242.1519317627,sprite=366,color=3,name="Change clothes"}
}
 lost.clothes={
 {x=971.94183349609,y=-98.397148132324,z=74.846138000488,sprite=366,color=62,name="Change clothes"}
}
 merc.clothes={
 {x=503.78283691406,y=-3121.8564453125,z=6.0697917938232,sprite=366,color=65,name="Change clothes"}
}
 anarchy.clothes={
 {x=704.94195556641,y=-962.00787353516,z=30.395341873169,sprite=366,color=25,name="Change clothes"}
}
 cartel.clothes={
 {x=1394.7595214844,y=1141.8107910156,z=114.61865997314,sprite=366,color=47,name="Change clothes"}
}
 elite.clothes={
 {x=-62.156860351563,y=358.76058959961,z=142.61323547363,sprite=366,color=4,name="Change clothes"}
}
local clothes=faction.criminal.clothes

Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.clothes)
    makeblips(faction.fbi.clothes)
    makeblips(fbiswat.clothes)
    makeblips(lspdheavy.clothes)
    makeblips(lspd.clothes)
    makeblips(faction.detectives.clothes)
    makeblips(lost.clothes)
    makeblips(merc.clothes)
    makeblips(anarchy.clothes)
    makeblips(cartel.clothes)
    makeblips(elite.clothes)
    hideblips(faction.fbi.clothes)
    hideblips(fbiswat.clothes)
    hideblips(lspd.clothes)
    hideblips(faction.detectives.clothes)
    hideblips(lspdheavy.clothes)
    hideblips(lost.clothes)
    hideblips(merc.clothes)
    hideblips(anarchy.clothes)
    hideblips(cartel.clothes)
    hideblips(elite.clothes)
    while true do
        Wait(0)
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(clothes) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 255, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not player.is_dead) then
                    if IsControlPressed(0, 86) then
                        if havespecialskin() then
                            removespecial()
                        end
                        local ped=PlayerPedId()
                        SetPedRandomComponentVariation(ped, false)
                        set_ped_components(ped,v.components)
                        if math.random(0,1)==1 then
                            ClearAllPedProps(ped);
                        else
                            SetPedRandomProps(ped)
                        end
                        if GetPlayerWantedLevel(PlayerId())<3 then
                                SetPlayerWantedLevel((PlayerId()),0,false)
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You have changed your clothes and cops now ~b~doesn't recognize ~s~you.")
                                DrawNotification(false, false);
                        else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You have too ~r~high wanted level~s~, you can't change your close to lose cops.")
                                DrawNotification(false, false);
                        end
                        
                        --SetPlayerModel(PlayerId(),GetEntityModel(ped));
                        --SetPedComponentVariation(PlayerId(), 0-11, int drawableId, int textureId, int paletteId) 
                        --GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(playerPed, PED_VARIATION_FACE)
                        --GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(playerPed, PED_VARIATION_FACE, 0), 2);
                        --int GET_PED_PALETTE_VARIATION(Ped ped, int componentId)
                        Wait(100)
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("Press ~INPUT_VEH_HORN~ to change clothes.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

paramedics.skinshops={
  {x=307.17813110352,y=-1434.0729980469,z=29.871404647827,angle=38.052940368652,sprite=73,color=8,name="Change model",models=SKINS.MEDICS},
}
lspd.skinshops={
  {x=456.53814697266,y=-988.49017333984,z=30.689596176147,sprite=73,color=3,components={[9]=0},name="Change model",models=SKINS.LSPD},
}
--faction.detectives.skinshops={
--  {x=456.53814697266,y=-988.49017333984,z=30.689596176147,sprite=73,color=3,name="Change model",models=SKINS.DETECTIVES},
--}
sspd.skinshops={
  {x=1856.8500976563,y=3689.6157226563,z=34.267066955566,sprite=73,color=5,name="Change model",models=SKINS.SSPD},
}
sahp.skinshops={
  {x=-449.91986083984,y=6016.140625,z=31.716375350952,sprite=73,color=39,name="Change model",models=SKINS.SAHP},
}
sapr.skinshops={
  {x=387.04901123047,y=792.2607421875,z=187.69357299805,sprite=73,color=2,name="Change model",models=SKINS.SAPR},
}
noose.skinshops={
  {x=2484.6193847656,y=-417.43368530273,z=93.736221313477,sprite=73,color=29,name="Change model",models=SKINS.NOOSE,components={[10]={0,0}}},
}
navy.skinshops={
  {x=-2357.6635742188,y=3256.2666015625,z=32.81071472168,sprite=73,color=26,name="Change model",models=SKINS.NAVY},
}
military.skinshops={
  {x=-2357.6635742188,y=3256.2666015625,z=32.81071472168,sprite=73,color=52,name="Change model",models=SKINS.MILITARY},
}
fbiswat.skinshops={
  {x=153.76205444336,y=-740.39874267578,z=242.15205383301,sprite=73,color=3,name="Change model",models={2072724299}},
  {x=154.56106567383,y=-746.95574951172,z=242.15199279785,sprite=73,color=3,name="Change model",models={-1145735340}},
--{x=459.09851074219,y=-992.99127197266,z=30.689598083496,sprite=366,color=3,name="Change model",models={2072724299}}
}
faction.fbi.skinshops={
  {x=154.56106567383,y=-746.95574951172,z=242.15199279785,sprite=73,color=3,name="Change model",models=SKINS.FBI},
--{x=459.09851074219,y=-992.99127197266,z=30.689598083496,sprite=366,color=3,name="Change model",models={2072724299}}
}
ballas.skinshops={
    {x=114.19812011719,y=-1960.9425048828,z=21.33332824707,sprite=73,color=83,name="Change model",models=SKINS.BALLAS}
}
fams.skinshops={
    {x=-18.120601654053,y=-1440.4772949219,z=31.101551055908,sprite=73,color=69,name="Change model",models=SKINS.FAMILIES}
}
vagos.skinshops={
    {x=981.54644775391,y=-1805.7006835938,z=35.484573364258,sprite=73,color=46,name="Change model",models=SKINS.VAGOS}
}
salva.skinshops={
    {x=1245.11328125,y=-1626.4176025391,z=53.282234191895,sprite=73,color=18,name="Change model",models=SKINS.SALVA}
}
triads.skinshops={
    {x=-766.77612304688,y=-912.81481933594,z=17.918348312378,sprite=73,color=49,name="Change model",models=SKINS.TRIADS}
}
mobs.skinshops={
    {x=-469.61822509766,y=-1721.7288818359,z=18.686618804932,sprite=73,color=39,name="Change model",models=SKINS.MOBS}
}
cartel.skinshops={
    {x=1389.1291503906,y=1162.4028320313,z=114.33446502686,sprite=73,color=47,name="Change model",models=SKINS.CARTEL}
}
lost.skinshops={
    {x=984.43591308594,y=-100.4217376709,z=74.84546661377,sprite=73,color=62,name="Change model",models=SKINS.LOST}
}
merc.skinshops={

}
anarchy.skinshops={

}
heisters.skinshops={

}
elite.skinshops={

}

faction.criminal.skinshops={
    {x=429.72470092773,y=-811.67272949219,z=29.491130828857,sprite=73,color=2,name="Binco shop",models=clothesskinsshops.binco}, -- BINCO COPS

    {x=71.19051361084,y=-1387.8325195313,z=29.376081466675,sprite=73,color=2,name="Binco shop",models=clothesskinsshops.binco}, -- BINCO families

    {x=-819.857421875,y=-1067.2944335938,z=11.328095436096,sprite=73,color=2,name="Binco shop",models=clothesskinsshops.binco}, -- BINCO NEAR VODNIE MESTO
    
    {x=1698.7023925781,y=4818.2124023438,z=42.063045501709,sprite=73,color=2,name="Binco shop",models=clothesskinsshops.binco}, -- binco grapeseed

    {x=-1182.7510986328,y=-765.20721435547,z=17.32607460022,sprite=73,color=3,name="Suburban shop",models=clothesskinsshops.suburban}, --suburban west
    
    {x=118.49465942383,y=-232.14370727539,z=54.557838439941,sprite=73,color=3,name="Suburban shop",models=clothesskinsshops.suburban}, --suburban center
    
    {x=-3178.4963378906,y=1035.8153076172,z=20.863212585449,sprite=73,color=3,name="Suburban shop",models=clothesskinsshops.suburban}, --suburban chumash
    
    {x=617.63836669922,y=2773.8435058594,z=42.088096618652,sprite=73,color=3,name="Suburban shop",models=clothesskinsshops.suburban}, --suburban harmony
    
    {x=-703.07897949219,y=-151.62242126465,z=37.415138244629,sprite=73,color=4,name="Ponsonbys shop",models=clothesskinsshops.ponsonbys}, -- PONSONBYS mejdu
    
    {x=-1446.6083984375,y=-243.80381774902,z=49.82426071167,sprite=73,color=4,name="Ponsonbys shop",models=clothesskinsshops.ponsonbys}, -- PONSONBYS krai goroda
    
    {x=-169.77130126953,y=-298.50189208984,z=39.73331451416,sprite=73,color=4,name="Ponsonbys shop",models=clothesskinsshops.ponsonbys}, -- PONSONBYS
    
    {x=1596.9545898438,y=-1659.9593505859,z=88.109260559082,sprite=73,color=24,name="Racing clothes",models={1794381917,-12678997,1694362237,2007797722}}, -- RACING
    
    {x=105.31523132324,y=-1303.1232910156,z=28.768798828125,name="secret",models={GetHashKey("s_f_y_hooker_01"),GetHashKey("s_f_y_hooker_02"),GetHashKey("s_f_y_hooker_03"),1381498905,1846523796,1544875514,GetHashKey("a_f_y_genhot_01"),GetHashKey("a_f_y_hiker_01")}},--vanilla unicorn
    {x=-15.803159713745,y=-1241.2241210938,z=29.510906219482,name="secret",models={1191548746,1787764635,1224306523,516505552,390939205,-1935621530,1404403376}}, --hobo
    {x=895.27648925781,y=-179.37484741211,z=74.700248718262,name="secret",models={-2039163396}},--taxi
    {x=882.52136230469,y=-160.11154174805,z=77.11026763916,name="secret",models={-2039163396}},--taxi(hidden)
    
    {x=-321.84967041016,y=-1545.7795410156,z=31.019914627075,sprite=73,color=39,name="Garbage man",models={-294281201}},--garbage
    
--{x=-21.047414779663,y=-215.00874328613,z=46.176471710205,name="Change skin",color=3,sprite=362,models={-781039234,1567728751,1644266841,-252946718,
-- -198252413,588969535,361513884,599294057,-1022961931,-1868718465,-442429178,797459875,2014052797,1380197501,1250841910,189425762,808859815,-945854168,
-- 1077785853,-2077764712,-771835772,2021631368,600300561,-408329255,2114544056,-900269486,-994634286,1464257942,-1113448868,-1106743555,1146800212,
-- 1423699487,1982350912,-1606864033,1546450936,1068876755,1720428295,549978415,920595805,1984382277,-96953009,848542878,-933295480,1004114196,-1613485779,
-- 933205398,1633872967,-1954728090,-654717625,-1697435671,664399832,2120901815,-912318012,532905404,826475330,-1280051738,-1366884940,-1589423867,-1211756494,
-- -1382092357,-2063996617,1975732938,-1932625649,-907676309,261586155,-1176698112,275618457,2119136831,-9308122,-1463670378,610290475,1825562762,-1660909656,
-- -429715051,436345731,-1230338610,-673538407,-973145378,755956971,-37334073,1182012905,365775923,-459818001,-321892375,1952555184,-1688898956,-12678997,
-- 349680864,-2039072303,-730659924,-1674727288,579932932,1699403886,766375082,-628553422,-872673803,1976765073,-175076858,-1656894598,-173013091,-106498753,
-- -1538846349,1674107025,70821038,131961260,377976310,1371553700,712602007,1755064960,2010389054,-1434255461,1161072059,-795819184,-398748745,866411749,
-- -613248456,-2077218039,1309468115,-1806291497,-88831029,1641152947,951767867,373000027,728636342,1189322339,1165780219,331645324,-1313761614,466359675,
-- -2078561997,-294281201,-1453933154,1240094341,-775102410,-1519253631,115168927,330231874,793439294,1640504453,-1386944600,-1736970383,891398354,411102470,
-- 1169888870,2111372120,-1444213182,-685776591,-1001079621,815693290,-20018299,-396800478,-961242577,-1289578670,-1715797768,1099825042,1704428387,1809430156,
-- -512913663,813893651,1358380044,1822107721,2064532783,-264140789,343259175,2097407511,-2109222095,587703123,-1745486195,349505262,-1514497514,1312913862,
-- 429425116,42647445,348382215,51789996,-1768198658,-837606178,-1160266880,153984193,-573920724,706935758,225287241,-1452549652,2050158196,-835930287,
-- 767028979,-254493138,257763003,-422822692,-308279251,1459905209,-1105179493,-518348876,2040438510,-619494093,-1849016788,1530648845,891945583,611648169,
-- -1880237687,2093736314,1388848350,1204772502,-782401935,355916122,452351020,1090617681,696250687,1706635382,-1635724594,321657486,-538688539,1302784073,
-- 1401530684,-570394627,666718676,-610530921,-44746786,1330042375,1032073858,850468060,1985653476,-52653814,-527186490,803106487,-927261102,-46035440,
-- 2124742566,479578891,411185872,-1552967674,1005070462,1768677545,1466037421,1226102803,-578715987,-1109568186,653210662,832784782,-1773333796,-1302522190,
-- 810804565,-715445259,-317922106,1191548746,-886023758,1095737979,1573528872,-1358701087,1694362237,2007797722,-1922568579,1270514905,894928436,587253782,
-- -664900312,1822283721,-304305299,946007720,503621995,1264920838,-920443780,-568861381,-1124046095,-927525251,1746653202,1906124788,-283816889,1625728984,
-- 768005095,648372919,357551935,-322270187,1346941736,-1717894970,921110016,-2114499097,-982642292,1329576454,-1561829034,-1445349730,-2088436577,645279998,
-- 602513566,1681385341,1650036788,1936142927,-756833660,-449965460,1165307954,-554721426,-424905564,1624626906,-178150202,-1067576423,-709209345,-951490775,
-- 623927022,-2076336881,1064866854,1001210244,1024089777,-569505431,-855671414,1328415626,539004493,-681546704,1626646295,-1299428795,-1872961334,663522487,
-- 846439045,62440720,1794381917,-614546432,-1689993,-1371020112,416176080,-1452399100,1846684678,1055701597,1283141381,1767892582,-640198516,-1044093321,
-- -1342520604,-1332260293,32417469,193817059,-2034368986,1951946145,1039800368,744758650,1750583735,718836251,-417940021,-215821512,-1519524074,1519319503,
-- -1620232223,1082572151,-1398552374,-2018356203,-1948675910,238213328,-1007618204,-1023672578,-1976105999,-840346158,-1408326184,1535236204,-1852518909,
-- -812470807,-1731772337,941695432,-2039163396,-1029146878,915948376,469792763,-48477765,228715206,-829353047,-1837161693,605602864,919005580,-1222037748,
-- -356333586,824925120,-2063419726,-409745176,226559113,-597926235,2089096292,-1709285806,-1800524916,1426880966,1416254276,-1573167273,1728056212,847807830,
-- -892841148,-1661836925,1347814329,1446741360,-929103484,-1859912896,-566941131,1461287021,1787764635,1224306523,516505552,390939205,-1935621530,1404403376,
-- -521758348,-150026812,1498487404,1382414087,1614577886,-792862442,-905948951,1520708641,-995747907,-100858228,999748158,-1047300121,435429221,1264851357,
-- -625565461,1561705728,1561705728,933092024,534725268,-85696186,835315305,-1835459726,-1387498932,-1427838341,-1871275377,1426951581,1142162924,-1105135100,
-- -1643617475,233415434,-815646164,-236444766,-39239064,-984709238,-412008429,68070371,-261389155,1752208920,-1004861906,-1425378987,188012277}}
}
local skinshops=faction.criminal.skinshops
    
Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.skinshops)
    makeblips(paramedics.skinshops)
    makeblips(lspd.skinshops)
    makeblips(sspd.skinshops)
    makeblips(sahp.skinshops)
    makeblips(sapr.skinshops)
    makeblips(noose.skinshops)
    makeblips(military.skinshops)
    makeblips(navy.skinshops)
    makeblips(faction.fbi.skinshops)
    makeblips(fbiswat.skinshops)
    makeblips(lost.skinshops)
    makeblips(merc.skinshops)
    makeblips(anarchy.skinshops)
    makeblips(elite.skinshops)
    makeblips(ballas.skinshops)
    makeblips(fams.skinshops)
    makeblips(vagos.skinshops)
    makeblips(salva.skinshops)
    makeblips(triads.skinshops)
    makeblips(heisters.skinshops)
    makeblips(mobs.skinshops)
    makeblips(cartel.skinshops)
    
    hideblips(paramedics.skinshops)
    hideblips(faction.fbi.skinshops)
    hideblips(fbiswat.skinshops)
    hideblips(lspd.skinshops)
    hideblips(sspd.skinshops)
    hideblips(sahp.skinshops)
    hideblips(sapr.skinshops)
    hideblips(noose.skinshops)
    hideblips(military.skinshops)
    hideblips(navy.skinshops)
    hideblips(lost.skinshops)
    hideblips(merc.skinshops)
    hideblips(anarchy.skinshops)
    hideblips(elite.skinshops)
    hideblips(ballas.skinshops)
    hideblips(fams.skinshops)
    hideblips(vagos.skinshops)
    hideblips(salva.skinshops)
    hideblips(triads.skinshops)
    hideblips(heisters.skinshops)
    hideblips(mobs.skinshops)
    hideblips(cartel.skinshops)
    while true do
        Wait(0)
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(skinshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 255, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not player.is_dead) then
                    if IsControlPressed(0, 86) then
                        local model=v.models[math.random(#v.models)]
                        setpedmodel(model)
                        set_ped_components(PlayerPedId(),v.components)
                        if GetPlayerWantedLevel(PlayerId())<3 then
                                SetPlayerWantedLevel((PlayerId()),0,false)
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You have changed your clothes and cops now ~b~doesn't recognize ~s~you.")
                                DrawNotification(false, false);
                        else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You have too ~r~high wanted level~s~, you can't change your close to lose cops.")
                                DrawNotification(false, false);
                        end
                        Wait(100)
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("Press ~INPUT_VEH_HORN~ to change skin. Current "..GetEntityModel(PlayerPedId())) --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

 faction.criminal.mercenaries={
--{x=-44.801700592041,y=-706.75598144531,z=32.727561950684,name="Mercenary",color=2,sprite=280,skins={275618457},weapons={WEAPON.PISTOL,WEAPON.SAWNOFFSHOTGUN,WEAPON.ASSAULTRIFLE,WEAPON.MACHINEPISTOL},cost=9500,armor=20,health=700},
--{x=-1153.6383056641,y=-1249.3861083984,z=7.1956105232239,name="Mercenary",color=2,sprite=280,skins={1746653202,1024089777,1794381917,193817059},weapons={WEAPON.PISTOL,WEAPON.SNSPISTOL,WEAPON.PUMPSHOTGUN},cost=5000,armor=0,health=300},
--{x=373.76196289063,y=-738.09985351563,z=29.269620895386,name="Bodyguard",color=2,sprite=280,skins={-245247470,691061163},weapons={WEAPON.COMBATPISTOL,WEAPON.HEAVYPISTOL,WEAPON.SMG,WEAPON.ADVANCEDRIFLE,WEAPON.BULLPUPSHOTGUN},cost=18000,armor=100,health=1300},
--{x=-1577.1640625,y=2101.6176757813,z=68.072256469727,name="Kisos",color=17,sprite=406,skins={307287994,1462895032},weapons={148160082,2578778090},cost=1000,armor=100}
}
 faction.fbi.mercenaries={
--{x=459.51971435547,y=-989.71301269531,z=24.914873123169,name="Sidekick",color=3,sprite=280,skins={2072724299},weapons={WEAPON.HEAVYPISTOL,WEAPON.SMG,WEAPON.PUMPSHOTGUN},cost=0,armor=100,health=300}
}
 lost.mercenaries={
--{x=459.51971435547,y=-989.71301269531,z=24.914873123169,name="Sidekick",color=3,sprite=280,skins={2072724299},weapons={HEAVYPISTOL,SMG,PUMPSHOTGUN},cost=0,armor=100,health=300}
}
 merc.mercenaries={

}
 cartel.mercenaries={

}
 elite.mercenaries={

}
local mercenaries=faction.criminal.mercenaries

Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.mercenaries)
    makeblips(faction.fbi.mercenaries)
    makeblips(lost.mercenaries)
    makeblips(merc.mercenaries)
    makeblips(cartel.mercenaries)
    makeblips(elite.mercenaries)
    hideblips(faction.fbi.mercenaries)
    hideblips(lost.mercenaries)
    hideblips(merc.mercenaries)
    hideblips(cartel.mercenaries)
    hideblips(elite.mercenaries)
    while true do
        Wait(0)
        --while player.is_cop do Wait(5000) end
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(mercenaries) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not player.is_dead) then
                    if v.factionreq and gangwar.top[v.factionreq[1]].score<v.factionreq[2] then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~r~"..gangwar.top[v.factionreq[1]].name.." needs ~g~$"..v.factionreq[2].." ~r~to unlock this.")
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    elseif IsControlPressed(0, 86) then
                        if player.money>=v.cost then
                            local group=GetPlayerGroup(PlayerId())
                            local ped,groupsize=GetGroupSize(group)
                            if groupsize<7 then
                                ped=spawnped(v.skins[math.random(#v.skins)],v.x,v.y,v.z,v.weapons[math.random(#v.weapons)],friends)
                                SetPedAsGroupMember(ped, group);
                                SetPedCanRagdoll(ped, false);
                                SetPedRelationshipGroupHash(ped, relationship_friend)
                                if v.armor~=nil then
                                  SetPedArmour(ped, v.armor);
                                end
                                if v.health~=nil then
                                  SetPedMaxHealth(ped,v.health)
                                  SetEntityHealth(ped,v.health);
                                end
                                player.money=player.money-v.cost
                                removemoney(player.money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                groupsize=groupsize+1
                                SetBlipColour(v.blip, 20)
                                Wait(500)
                                SetNotificationTextEntry("STRING")
                                AddTextComponentString("New member joined your group.")
                                SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 3, "Group "..group, groupsize.."/7")
                                DrawNotification(false, false)
                                WaitWithMarker(4500,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(PlayerPedId())
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You can't have more guys in your group.");
                                SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 8, v.name, "Sorry.");
                                DrawNotification(false, false);
                                Wait(10)
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You don't have enough money.")
                            --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                            DrawNotification(false, false);
                            Wait(10)
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to hire.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                        Wait(10)
                    end
                end
            end
        end
    end
end)

local VEHICLES={
DETECTIVES={-1973172295},
LSFD={1938952078,353883353,-1693015116},
MEDICS={1171614426,353883353},
FBISWAT={1949211328,1127131465,-1647941228,837858166,1209364519},
LSPDHEAVY={2046537925,1912215274,-34623805,456714581,456714581,353883353,-1693015116,-1973172295},
LSPD={2046537925,1912215274,-34623805,456714581,-1693015116,-1973172295},
NAVY={321739290,-823509173,-1281684762,782665360,970385471,-50547061,-42959138,276773164},
MILITARY={321739290,-823509173},
NOOSE={-1205689942,745926877,353883353,2071877360,-1693015116},
SAPR={741586030,-2128233223},
SSPD={1922257928,-1683328900,-34623805},
SAHP={-34623805,-1627000575,-114291515,1034187331},
}

 faction.criminal.carshops={
 
    {x=887.78521728516,y=-182.7448425293,z=73.222465515137,angle=237.60655212402,sprite=198,color=46,name="Taxicab",cost=200,rent=true,cars={-956048545}},
 
    {x=2964.9196777344,y=2747.6323242188,z=43.310658111572,name="Armored weaponized truck",color=1,sprite=229,cars={2434067162},cost=87500},
    {x=1463.7440185547,y=1128.9432373047,z=114.33376373291,name="Weaponized truck",color=2,sprite=229,cars={2198148358},cost=7000},
    {x=486.37924194336,y=-2159.6452636719,z=5.9258829498291,name="Armored car",color=1,sprite=380,cars={3406724313,1922255844,470404958,666166960,3862958888},cost=15500},
    {x=33.801235198975,y=-2671.1713867188,z=6.0175901794434,name="Armored truck",color=2,sprite=67,cars={1747439474,3089277354},cost=25000},
    {x=21.298585891724,y=-210.41683959961,z=52.857303619385,name="Offroad minivan",color=2,sprite=326,cars={1475773103},cost=8500},
    
    {x=-1798.862,y=2958.326,z=32.987,name="Besra",color=2,sprite=424,cars={1824333165},cost=10000},
    --{x=-1830.172,y=2958.542,z=32.987,name="Hydra",color=2,sprite=424,cars={970385471},cost=8000},
    --{x=-1816.536,y=2980.209,z=32.987,name="Laser",color=2,sprite=424,cars={-1281684762},cost=5000},
    {x=-944.155,y=-2975.342,z=13.954,name="Velum",color=2,sprite=251,cars={-1673356438,1077420264},cost=10000},
    {x=-932.973,y=-2981.526,z=13.954,name="Vestra",color=2,sprite=423,cars={1341619767},cost=10000},
    {x=-947.736,y=-3035.898,z=13.954,name="Mammatus",color=2,sprite=251,cars={-1746576111},cost=10000},
    {x=-955.232,y=-3031.343,z=13.954,name="Shamal",color=2,sprite=423,cars={-1214505995,621481054,-1214293858},cost=10000},
    {x=-970.393,y=-3022.119,z=13.954,name="Miljet",color=2,sprite=423,cars={165154707},cost=10000},
    --{x=-988.169,y=-3011.304,z=13.954,name="Titan",color=2,sprite=423,cars={1981688531},cost=0},
    {x=-931.253,y=-3003.082,z=13.954,name="Cuban",color=2,sprite=251,cars={-644710429},cost=5000},
    {x=-961.615,y=-2966.009,z=13.954,name="Duster",color=2,sprite=251,cars={970356638},cost=5000},
    {x=-916.020,y=-3012.285,z=13.954,name="Dodo",color=2,sprite=251,cars={-901163259},cost=7500},
    {x=-941.129,y=-2997.301,z=13.954,name="Nimbus",color=2,sprite=423,cars={-1295027632},cost=10000},
    --{x=-966.258,y=-2982.929,z=13.954,name="Jet",color=2,sprite=423,cars={1058115860},cost=0},
    {x=-852.734,y=-3322.492,z=13.954,name="Andromada",color=2,sprite=423,cars={368211810},cost=10000},
    {x=-977.706,y=-2999.949,z=13.954,name="Titan",color=2,sprite=423,cars={1981688531},cost=10000},
    {x=-1043.383,y=-3484.475,z=13.954,name="Jet",color=2,sprite=423,cars={1058115860},cost=10000},
    {x=-3335.1613769531,y=948.35125732422,z=.5,angle=106.388,name="Yacht",sprite=410,cars={-1043459709},cost=2000},
    {x=-1514.7365722656,y=-1441.3170166016,z=.5,name="Dinghy",cost=1000,sprite=404,cars={1033245328,276773164,509498602,867467158}},
    {x=-1510.7969970703,y=-1423.6053466797,z=.5,name="Suntrap",cost=1000,sprite=404,cars={-282946103}},
    {x=-1802.4645996094,y=-1236.2015380859,z=.5,angle=226,name="Seashark",cost=1000,sprite=471,cars={-1030275036,-616331036,-311022263}},
    {x=-1784.6004638672,y=-1229.9450683594,z=.5,name="Boat",cost=1000,sprite=404,cars={861409633,231083307,437538602,400514754,1070967343,908897389,290013743,1448677353}},
    {x=-81.586608886719,y=-2753.0405273438,z=.5,angle=181.54084777832,name="Tug",cost=1000,sprite=455,cars={-2100640717}},
    {x=580.20471191406,y=-3254.029296875,z=.5,angle=177.01123046875,name="Rent submarine",cost=500,sprite=308,cars={771711535,-1066334226},rent=true},
    {x=836.14477539063,y=-3192.9958496094,z=14.891183853149,angle=89.570419311523,name="Rent cargobob",cost=500,sprite=481,cars={2025593404},rent=true}, -- bad cargobobs -50547061,1621617168,1394036463,
    {x=-1621.7149658203,y=-3197.1267089844,z=14.0,angle=151.6248626709,name="Rent skylift",color=1,cost=3000,sprite=481,cars={1044954915},rent=true},
    {x=715.37017822266,y=-1398.0233154297,z=26.35880279541,sprite=326,name="Compact car shop",cost=2250,cars={-344943009,1039032026,1549126457,-1130810103,-1177863319,-431692672,-1450650718,841808271}},
    {x=715.02410888672,y=-1392.2175292969,z=26.32643699646,sprite=326,name="Two seat car shop",cost=4500,cars={1830407356,1078682497,-2124201592,330661258,-5153954,-591610296,-89291282,1349725314,873639469,-1122289213,-1193103848,2016857647}},
    {x=714.77362060547,y=-1387.0942382813,z=26.300699234009,sprite=326,name="Four seat car shop",cost=3000,cars={970598228,-391594584,-624529134,1348744438,-511601230,-1930048799,-1809822327,-1903012613,906642318,-2030171296,-685276541,1909141499,75131841,-1289722222,886934177,-1883869285,-1150599089,-1477580979,1723137093,-1894894188,-1008861746,1373123368,1777363799,-310465116,-1255452397,970598228}},
    {x=714.54632568359,y=-1383.0053710938,z=26.310161590576,sprite=326,name="Muscle car shop",cost=4000,cars={464687292,1531094468,-1205801634,-682211828,349605904,80636076,723973206,-2119578145,-1800170043,-1943285540,-2095439403,1507916787,-227741703,-1685021548,1923400478,972671128,-825837129,-498054846,2006667053}},
    {x=714.28350830078,y=-1378.4299316406,z=26.269607543945,sprite=326,name="Off road car shop",cost=3000,cars={914654722,1645267888,-2045594037,-1189015600,989381445,850565707,-808831384,142944341,1878062887,634118882,2006918058,-789894171,683047626,1177543287,-1137532101,-1775728740,-1543762099,884422927,486987393,1269098716,-808457413,-1651067813,2136773105,1221512915,1337041428,1203490606,-16948145,1069929536}},
    {x=713.96661376953,y=-1372.8767089844,z=26.204294204712,sprite=326,name="Vans car shop",cost=2000,cars={-1346687836,1162065741,-119658072,-810318068,65402552,1026149675}},
    {x=831.10375976563,y=-797.18811035156,z=26.256492614746,sprite=326,color=18,name="Used car shop",cost=300,cars={-2033222435,-667151410,523724515,-1435919434,1770332643,-1207771834,-1883002148,-14495224,1762279763,-120287622,-1311240698}},
    {x=186.72326660156,y=-1256.9447021484,z=29.198457717896,sprite=68,name="Rent tow truck",cost=100,cars={-1323100960,-442313018},rent=true},
    {x=-478.01977539063,y=-614.94030761719,z=31.1744556427,sprite=326,name="Sport car shop",cost=15250,cars={-1622444098,1123216662,767087018,-1041692462,1274868363,736902334,2072687711,-1045541610,108773431,196747873,-566387422,-1995326987,-1089039904,499169875,-1297672541,544021352,-1372848492,482197771,-142942670,-1461482751,-777172681,-377465520,-1934452204,1737773231,1032823388,719660200,-746882698,-1757836725,1886268224,384071873,-295689028}},
    {x=-1792.1674804688,y=458.46810913086,z=128.30819702148,sprite=326,name="Classic sport car shop",cost=40000,cars={-982130927,-1566741232,-1405937764,1887331236,941800958,223240013,1011753235,784565758,1051415893,-1660945322,-433375717,1545842587,-2098947590,1504306544}},
    {x=-64.245101928711,y=886.47015380859,z=235.82223510742,sprite=326,name="Super car shop",cost=200000,cars={-1216765807,-1696146015,-1311154784,-1291952903,1426219628,1234311532,418536135,-1232836011,1034187331,1093792632,1987142870,-1758137366,-1829802492,2123327359,234062309,819197656,1663218586,272929391,408192225,2067820283,338562499,1939284556,-1403128555,-2048333973,-482719877,917809321}},
    {x=-866.72729492188,y=-1122.9127197266,z=6.6089086532593,sprite=348,name="Motorcycle shop",cost=1500,cars={627535535,-757735410,1672195559,-2140431165,86520421,1753414259,627535535,640818791,-1523428744,-634879114,-909201658,-893578776,-1453280962,788045382,1836027715,-140902153,-1353081087}},
    {x=103.67114257813,y=-2189.1770019531,z=5.9722423553467,sprite=477,name="Truck shop",cost=10000,cars={1518533038,569305213,-2137348917}},
    {x=845.18511962891,y=-2358.1569824219,z=30.337574005127,sprite=477,color=1,name="Upgraded Truck shop",cost=45000,cars={387748548,177270108}},
    {x=2380.8640136719,y=3039.5324707031,z=47.689258575439,angle=0.3908,sprite=477,color=1,name="Special modified truck",cost=30000,cars={-1649536104}},
    {x=128.1043548584,y=-2197.1125488281,z=6.0333247184753,angle=320.2,sprite=477,name="Smallest truck",cost=12500,cars={-884690486}},
    {x=409.13833618164,y=-2069.9428710938,z=21.3864402771,angle=140.57992553711,sprite=477,name="Getaway van",cost=6000,cars={904750859,-1050465301}},
    {x=1031.9289550781,y=-1963.2841796875,z=30.529121398926,angle=94.166656494141,sprite=477,color=2,name="Upgraded getaway van",cost=12000,cars={-2052737935}},
    {x=853.19781494141,y=-2129.4760742188,z=29.889066696167,angle=86.725280761719,sprite=477,color=2,name="Heavy getaway truck",cost=15000,cars={2053223216}},
    --{x=163.18153381348,y=-1282.4031982422,z=29.146518707275,name="KITT",color=2,sprite=460,cars={941494461},cost=300000},
    --{x=196.76313781738,y=-1498.1608886719,z=29.141607284546,name="Oppressor",color=2,sprite=226,cars={884483972},cost=400000},
    {x=189.34603881836,y=282.08395385742,z=141.4781036377,angle=338.59439086914,name="Havok",cost=7000,sprite=43,factionreq={FACTION.HEISTERS,2000000},cars={-1984275979}},
    {x=133.53921508789,y=273.06643676758,z=109.66710662842,angle=339.94281005859,name="Light armored car",cost=80000,sprite=326,color=2,factionreq={FACTION.HEISTERS,400000},cars={410882957}},
    {x=-160.36054992676,y=-161.21446228027,z=93.70240020752,angle=251.67858886719,name="Helicopter shop",cost=15000,sprite=43,cars={744705981,1949211328,-339587598}},
    {x=-164.40083312988,y=-238.77142333984,z=81.83031463623,angle=249.88282775879,name="Rappel helicopter shop",cost=15000,sprite=43,cars={-1660661558}},
    --{x=-238.67405700684,y=581.41375732422,z=194.42758178711,angle=90.509422302246,name="Annihilator",cost=20000,sprite=43,cars={837858166}},
    {x=694.94934082031,y=-1010.5455932617,z=22.783393859863,angle=358.84677124023,name="Light armored car",cost=70000,sprite=326,color=2,factionreq={FACTION.ANARCHY,200000},cars={-326143852}},
    {x=1596.0075683594,y=-1651.6403808594,z=88.171897888184,angle=264.71340942383,sprite=326,color=24,name="Racing car shop",cost=17500,cars={237764926,-1106353882,-631760477,-591651781,-915704871,349315417,-401643538}},
    {x=1598.5760498047,y=-1664.1368408203,z=88.078819274902,angle=302.54397583008,sprite=348,color=24,name="Racing bike shop",cost=10000,cars={-891462355,-114291515,11251904,-1670998136,1265391242}},
    
    {x=-346.03268432617,y=-1530.9349365234,z=27.435739517212,angle=269.13970947266,sprite=318,color=39,name="Trash truck",cost=0,rent=true,cars={1917016601,-1255698084}},
    {x=1212.9477539063,y=2736.8645019531,z=37.855758666992,name="Offroad stunt car",color=2,sprite=326,cars={101905590,-663299102},cost=15000},
    {x=189.03796386719,y=2786.7778320313,z=45.539836883545,name="Offroad sport car",color=2,sprite=326,cars={-1479664699},cost=11000},
}

lsfd.carshops={
    {x=204.6941986084,y=-1658.7762451172,z=29.871974945068,angle=320.42572021484,sprite=56,color=75,name="Fire truck",cost=0,fbi=true,cars={1938952078}},
    {x=-370.20809936523,y=6127.9321289063,z=31.511556625366,angle=44.605541229248,sprite=56,color=75,name="Fire truck",cost=0,fbi=true,cars={1938952078}}, --paleto
    {x=1695.2797851563,y=3588.7719726563,z=35.696208953857,angle=213.21376037598,sprite=56,color=75,name="Fire truck",cost=0,fbi=true,cars={1938952078}}, --sandy shores
    {x=-1093.9738769531,y=-2369.41796875,z=14.014199256897,angle=151.3292388916,sprite=56,color=75,name="Fire truck",cost=0,fbi=true,cars={1938952078}}, --airport
    {x=-2104.6311035156,y=2832.2895507813,z=32.878559112549,angle=354.49502563477,sprite=56,color=75,name="Fire truck",cost=0,fbi=true,cars={1938952078}}, --airport
    {x=1204.5338134766,y=-1479.7216796875,z=34.928466796875,angle=359.58599853516,sprite=56,color=75,name="Fire truck",cost=0,fbi=true,cars={1938952078}}, --ls east
    {x=-635.00506591797,y=-105.52523040771,z=38.112854003906,angle=83.971015930176,sprite=56,color=75,name="Fire truck",cost=0,fbi=true,cars={1938952078}}, --ELITE
    {x=-1093.1236572266,y=-2354.6625976563,z=20.916704177856,angle=148.7452545166,fbi=true,sprite=43,color=75,name="Helicopter",cost=0,cars={353883353},livery=1},--heli at LSIA
}
paramedics.carshops={
    {x=304.46542358398,y=-1453.1789550781,z=29.734334945679,angle=50.739974975586,sprite=56,color=8,name="Ambulance",cost=0,fbi=true,cars={1171614426},livery=2},
    {x=336.73016357422,y=-1476.8754882813,z=29.271110534668,angle=300.67877197266,sprite=56,color=8,name="Ambulance",cost=0,fbi=true,cars={1171614426},livery=0},
    {x=208.71119689941,y=-1648.1286621094,z=29.572954177856,angle=319.45022583008,sprite=56,color=8,name="Ambulance",cost=0,fbi=true,cars={1171614426},livery=1},
    {x=313.35104370117,y=-1465.0010986328,z=46.89701461792,angle=318.7646484375,fbi=true,sprite=43,color=8,name="Helicopter",cost=0,cars={353883353},livery=1},
}
lspdheavy.carshops={
    {x=462.59909057617,y=-1019.6057739258,z=27.776398849487,angle=90.926322937012,fbi=true,sprite=56,color=3,name="Armored Police car",cost=0,cars={456714581}},
    {x=463.00701904297,y=-1014.5240478516,z=27.747706604004,angle=90.859275817871,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={1912215274}},
    {x=454.84698486328,y=-993.29400634766,z=43.691650390625,angle=87.682159423828,fbi=true,sprite=43,color=3,name="Helicopter",cost=0,cars={353883353},livery=0},
}
faction.detectives.carshops={
    {x=463.00701904297,y=-1014.5240478516,z=27.747706604004,angle=90.859275817871,fbi=true,sprite=56,color=3,name="Unmarked Police car",cost=0,cars={-1973172295}},
}
lspd.carshops={
    {x=457.55673217773,y=-1009.291809082,z=28.305698394775,angle=187.26271057129,fbi=true,sprite=348,color=3,name="Police bike",cost=0,cars={-34623805}},
    {x=462.59909057617,y=-1019.6057739258,z=27.776398849487,angle=90.926322937012,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={2046537925}},
    {x=463.00701904297,y=-1014.5240478516,z=27.747706604004,angle=90.859275817871,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={1912215274}},
}
sspd.carshops={
    {x=1827.6964111328,y=3693.8649902344,z=33.845809936523,angle=299.83209228516,fbi=true,sprite=56,color=5,name="SSPD vehicles",cost=0,cars=VEHICLES.SSPD},
}
sahp.carshops={
    {x=-445.77633666992,y=5984.5478515625,z=31.189825820923,angle=45.788238525391,fbi=true,sprite=56,color=39,name="SAHP car",cost=0,cars={-1627000575}},
    {x=-459.89624023438,y=6022.6635742188,z=31.039912033081,angle=312.2297668457,fbi=true,sprite=348,color=39,name="SAHP bike",cost=0,cars={-34623805}},
    {x=-446.24841308594,y=5994.2797851563,z=31.340522766113,angle=92.593635559082,fbi=true,sprite=348,color=39,modkit=0,mods={[14]=1},color1=0,color2=111,color3=0,color4=111,name="SAHP sport bike",cost=0,cars={-114291515}},
    {x=-482.54336547852,y=6024.6201171875,z=30.927030563354,angle=226.29570007324,fbi=true,sprite=56,color=39,modkit=0,mods={[14]=1},color1=0,color2=111,color3=0,color4=111,color5=111,color6=111,name="SAHP super car (Black & White)",cost=0,cars={1034187331}},
    {x=-479.17492675781,y=6027.814453125,z=30.926990509033,angle=224.93714904785,fbi=true,sprite=56,color=39,modkit=0,mods={[14]=1},color1=111,color2=0,color3=0,color4=111,color5=111,color6=111,name="SAHP super car (White & Black)",cost=0,cars={1034187331}},
}
sapr.carshops={
    {x=372.98739624023,y=786.02355957031,z=186.43234558105,angle=164.47503662109,fbi=true,sprite=56,color=2,name="SAPR SUV",cost=0,cars={741586030}},
    {x=382.37777709961,y=803.44927978516,z=187.75993347168,fbi=true,sprite=56,color=2,color1=51,color2=111,color3=51,color4=51,name="SAPR ATV",cost=0,cars={-2128233223}},
}
noose.carshops={
    {x=2510.7136230469,y=-341.96670532227,z=118.18634796143,fbi=true,sprite=43,color=29,name="SWAT helicopter",cost=0,livery=0,cars={353883353}},
    {x=2503.5627441406,y=-430.99298095703,z=92.992835998535,angle=180.5171661377,fbi=true,sprite=56,color=29,name="SWAT riot",cost=0,cars={-1205689942}},
    {x=2506.734375,y=-450.52795410156,z=92.992866516113,angle=47.119285583496,fbi=true,sprite=56,color=29,color1=11,color2=11,name="SWAT insurgent",cost=0,cars={2071877360}},
}
navy.carshops={
    {x=3099.9243164063,y=-4734.7680664063,z=15.726826667786,angle=89.973442077637,fbi=true,sprite=43,color=52,name="Cargobob",cost=0,cars={-50547061}},
    {x=3092.3352050781,y=-4794.7099609375,z=15.261613845825,angle=27.482593536377,fbi=true,sprite=424,color=26,name="Navy fighter jet",cost=0,cars={-1281684762}},
    {x=3088.1115722656,y=-4801.8598632813,z=-0.78393822908401,angle=196.25451660156,fbi=true,sprite=404,color=26,name="Navy Boat",cost=0,cars={276773164}},
    {x=3057.5893554688,y=-4796.654296875,z=6.0720343589783,angle=104.16527557373,fbi=true,sprite=424,color=26,name="Navy VTOL Jet",cost=0,cars={970385471}},
    {x=3080.9304199219,y=-4646.9438476563,z=6.072190284729,angle=20.514385223389,fbi=true,sprite=424,color=26,name="Navy VTOL Jet",cost=0,cars={970385471}},
    {x=-2403.8483886719,y=3321.3081054688,z=32.336040496826,angle=61.130729675293,fbi=true,sprite=421,color=26,name="Tank",cost=0,cars={782665360}},
    {x=-2235.974609375,y=3272.458984375,z=32.316596984863,angle=240.53776855469,fbi=true,sprite=424,color=26,name="Navy fighter jet",cost=0,cars={-1281684762}},
    {x=-2317.4680175781,y=3258.7744140625,z=32.827655792236,angle=149.67643737793,fbi=true,sprite=56,color=52,name="Military vehicle",cost=0,cars={321739290}},
    {x=-2328.4575195313,y=3251.2482910156,z=32.82763671875,angle=61.942565917969,fbi=true,sprite=56,color=52,name="Military vehicle",cost=0,cars={-823509173}},
    {x=-2192.1254882813,y=3265.7802734375,z=32.432655334473,angle=60.793060302734,fbi=true,sprite=43,color=26,name="Hunter",cost=0,cars={-42959138}},
}
military.carshops={
    --{x=-1877.3778076172,y=2805.0339355469,z=33.270427703857,angle=329.88998413086,fbi=true,sprite=43,color=52,name="Military vehicle",cost=0,cars={-50547061}},
    {x=-2317.4680175781,y=3258.7744140625,z=32.827655792236,angle=149.67643737793,fbi=true,sprite=56,color=52,name="Military vehicle",cost=0,cars={321739290}},
    {x=-2328.4575195313,y=3251.2482910156,z=32.82763671875,angle=61.942565917969,fbi=true,sprite=56,color=52,name="Military vehicle",cost=0,cars={-823509173}},
}
 fbiswat.carshops={    
    --{x=147.94520568848,y=-762.08477783203,z=262.87142944336,angle=161.0,fbi=true,sprite=43,color=29,color1={0,0,0},color2={0,0,0},livery=2,name="FBI helicopter",cost=0,cars={1949211328}},
    {x=166.23600769043,y=-705.29974365234,z=32.991550445557,fbi=true,sprite=56,color=3,name="FIB Heavy armored car",cost=0,cars={1209364519}},
    {x=143.57824707031,y=-736.10357666016,z=32.941730499268,fbi=true,sprite=56,color=3,name="Unmarked fast FBI car",cost=0,cars={1127131465}},
    {x=132.08850097656,y=-731.59490966797,z=32.943347930908,fbi=true,sprite=56,color=3,name="Unmarked off road FBI car",cost=0,cars={-1647941228}},
    {x=125.03157806396,y=-745.263671875,z=262.62380981445,angle=339.13916015625,fbi=true,name="Annihilator",cost=0,sprite=43,cars={837858166}},
}
 faction.fbi.carshops={    
    {x=147.94520568848,y=-762.08477783203,z=262.87142944336,angle=161.0,fbi=true,sprite=43,color=3,color1={0,0,0},color2={0,0,0},livery=2,name="FBI helicopter",cost=0,cars={1949211328}},
    --{x=157.240234375,y=-732.50091552734,z=32.943096160889,fbi=true,sprite=56,color=3,name="Unmarked FBI car",cost=0,cars={-1973172295}},
    {x=143.57824707031,y=-736.10357666016,z=32.941730499268,fbi=true,sprite=56,color=3,name="Unmarked fast FBI car",cost=0,cars={1127131465}},
    {x=132.08850097656,y=-731.59490966797,z=32.943347930908,fbi=true,sprite=56,color=3,name="Unmarked off road FBI car",cost=0,cars={-1647941228}},
    --{x=447.36117553711,y=-997.20043945313,z=25.704141616821,angle=180.58967590332,fbi=true,sprite=56,color=3,name="Unmarked police car",cost=0,cars={-1973172295}},
    --{x=452.33187866211,y=-997.36022949219,z=25.702560424805,angle=180.09335327148,fbi=true,sprite=56,color=3,name="Unmarked fast police car",cost=0,cars={1127131465}},
    --{x=462.2532043457,y=-1014.6189575195,z=28.020277023315,angle=91.622131347656,fbi=true,sprite=56,color=3,name="Unmarked off road police car",cost=0,cars={-1647941228}},
    --{x=462.19750976563,y=-1019.5223999023,z=28.034339904785,angle=92.353416442871,fbi=true,sprite=56,color=3,name="Fast police car",cost=0,cars={-1627000575}},
    --{x=838.80291748047,y=-1265.0863037109,z=25.69623374939,angle=90.622627258301,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={2046537925}},
    --{x=838.80291748047,y=-1265.0863037109,z=25.69623374939,angle=90.622627258301,fbi=true,sprite=56,color=3,name="Armored police car",cost=0,cars={456714581}},
    --{x=-1124.6624755859,y=-839.30310058594,z=13.01847076416,angle=131.89108276367,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={1912215274}},
    --{x=-1072.4680175781,y=-855.62969970703,z=4.4742360115051,angle=217.37126159668,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={1912215274}},
    --{x=838.80291748047,y=-1265.0863037109,z=25.69623374939,angle=90.622627258301,fbi=true,sprite=56,color=3,name="Police car",cost=0,cars={2046537925}}
    
}
 lost.carshops={
    {x=985.50256347656,y=-137.88551330566,z=72.506202697754,angle=57.032344818115,rent=true,sprite=348,color=62,name="Bike",cost=500,cars={390201602,-1404136503,2006142190,741090084,301427732,-159126838,-1606187161,1873600305,-618617997,-1009268949,-570033273}},
    {x=971.02526855469,y=-114.53890228271,z=74.082054138184,angle=223.27487182617,rent=true,sprite=326,color=62,name="Van",cost=500,cars={-1745203402},factionreq={FACTION.LOST,1000000}}
}
 merc.carshops={
    {x=464.01702880859,y=-3235.478515625,z=6.069561958313,angle=270.57464599609,rent=true,sprite=326,color=65,factionreq={FACTION.MERCS,500000},name="Nightshark",cost=5000,cars={433954513}},
    {x=465.02291870117,y=-3191.2585449219,z=5.8632893562317,angle=359.83975219727,rent=true,sprite=326,color=65,name="Mesa",cost=500,cars={-2064372143}},
    {x=580.20471191406,y=-3254.029296875,z=.5,angle=177.01123046875,name=event.submarine,rent=true,cost=500,sprite=308,cars={771711535,-1066334226}},
    {x=503.15692138672,y=-3374.3430175781,z=6.0699095726013,angle=183.92143249512,name="Valkyrie",rent=true,cost=2500,sprite=43,factionreq={FACTION.MERCS,500000},cars={1543134283}},
    {x=494.05456542969,y=-3374.1579589844,z=6.0699138641357,angle=3.3321440219879,name="Valkyrie w/cannon",rent=true,cost=10000,sprite=43,factionreq={FACTION.MERCS,3000000},cars={-1600252419}},
    {x=503.46008300781,y=-3357.6987304688,z=5.8398675918579,angle=359.92239379883,name="Savage",rent=true,cost=25000,sprite=43,factionreq={FACTION.MERCS,12000000},cars={-82626025}},
    {x=503.36743164063,y=-3309.9672851563,z=5.8400278091431,angle=181.9877356290817,name="Akula",rent=true,cost=45000,sprite=43,factionreq={FACTION.MERCS,17000000},cars={1181327175}},
    {x=501.48458862305,y=-3179.8447265625,z=5.8389925956726,angle=0.40175178647041,name="Chernobog",rent=true,cost=10000,sprite=477,factionreq={FACTION.MERCS,1000000},cars={-692292317}},
    {x=500.98321533203,y=-3197.6782226563,z=5.8393874168396,angle=0.31095820665359,name="Halftrack",rent=true,cost=15000,sprite=477,factionreq={FACTION.MERCS,1000000},cars={-32236122}},
}
 cartel.carshops={
    {x=1361.0843505859,y=1165.1298828125,z=113.19039154053,angle=181.92126464844,rent=true,sprite=326,color=47,name="Vehicle",cost=0,cars={-808831384,2006918058,486987393}}
}
 elite.carshops={
    {x=-1802.4645996094,y=-1236.2015380859,z=.5,angle=226,name="Seashark",cost=1000,sprite=471,color=4,cars={-1030275036,-616331036,-311022263}},
    {x=-2043.9359130859,y=-1031.4766845703,z=11.980721473694,angle=73.169227600098,rent=true,sprite=43,color=4,name="Armed Helicopter",cost=8000,factionreq={FACTION.ELITE,1000000},cars={788747387}},
    {x=-83.973495483398,y=369.41790771484,z=112.45824432373,angle=244.74044799805,rent=true,sprite=326,color=4,name="Armored Vehicle",cost=0,cars={3406724313,1922255844,470404958,666166960,3862958888}},
    {x=-82.834434509277,y=361.61199951172,z=112.45824432373,angle=245.49688720703,rent=true,sprite=326,color=4,name="Armed Armored Vehicle",cost=10000,factionreq={FACTION.ELITE,5000000},cars={-114627507}}
}
local carshops=faction.criminal.carshops

function ApplyVehicleMods(veh,kit,mods)
    if kit~=nil then
        SetVehicleModKit(veh,kit)
        if mods~=nil then
            for k,v in pairs(mods) do
                SetVehicleMod(veh, k, v, false)
            end
        end
    end
end

function SetVehicleColorsEnhanced(veh,v_color1,v_color2,v_color3,v_color4,v_color5,v_color6)
    local custom1=false
    local custom2=false
    local standard1=false
    local standard2=false
    if v_color1~=nil then
        if type(v_color1)=='table' then
            custom1=true
        else
            standard1=true
        end
    end
    if v_color2~=nil then
        if type(v_color2)=='table' then
            custom2=true
        else
            standard2=true
        end
    end
    if standard1 and standard2 then
        SetVehicleColours(veh,v_color1,v_color2)
    else
        if standard1 or standard2 then
            local color1,color2=GetVehicleColours(veh)
            if standard1 then color1=v_color1 end
            if standard2 then color2=v_color2 end
            SetVehicleColours(veh,color1,color2)
        end
        if custom1 then SetVehicleCustomPrimaryColour(veh,v_color1[1],v_color1[2],v_color1[3]) end
        if custom2 then SetVehicleCustomSecondaryColour(veh,v_color2[1],v_color2[2],v_color2[3]) end
    end
    if v_color3~=nil or v_color4~=nil then
        local color3,color4=v_color3,v_color4
        if v_color3==nil or v_color4==nil then
            color3,color4=GetVehicleExtraColours(veh)
            if v_color3~=nil then
                color3=v_color3
            end
            if v_color4~=nil then
                color4=v_color4
            end
        end
        SetVehicleExtraColours(veh,color3,color4)
    end
    if v_color5~=nil then
        SetVehicleInteriorColour(veh,v_color5)
    end
    if v_color6~=nil then
        SetVehicleDashboardColour(veh,v_color6)
    end
end

Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.carshops)
    makeblips(lsfd.carshops)
    makeblips(paramedics.carshops)
    makeblips(faction.fbi.carshops)
    makeblips(fbiswat.carshops)
    makeblips(lspd.carshops)
    makeblips(lspdheavy.carshops)
    makeblips(sspd.carshops)
    makeblips(sahp.carshops)
    makeblips(sapr.carshops)
    makeblips(noose.carshops)
    makeblips(military.carshops)
    makeblips(navy.carshops)
    makeblips(lost.carshops)
    makeblips(merc.carshops)
    makeblips(cartel.carshops)
    makeblips(elite.carshops)
    hideblips(lsfd.carshops)
    hideblips(paramedics.carshops)
    hideblips(faction.fbi.carshops)
    hideblips(fbiswat.carshops)
    hideblips(lspd.carshops)
    hideblips(lspdheavy.carshops)
    hideblips(sspd.carshops)
    hideblips(sahp.carshops)
    hideblips(sapr.carshops)
    hideblips(noose.carshops)
    hideblips(military.carshops)
    hideblips(navy.carshops)
    hideblips(lost.carshops)
    hideblips(merc.carshops)
    hideblips(cartel.carshops)
    hideblips(elite.carshops)
    while true do
        Wait(0)
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(carshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not player.is_dead) then
                    if v.factionreq and gangwar.top[v.factionreq[1]].score<v.factionreq[2] then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~r~"..gangwar.top[v.factionreq[1]].name.." needs ~g~$"..v.factionreq[2].." ~r~to unlock this.")
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    elseif IsControlPressed(0, 86) then
                        if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                            if v.rent and rentcar.plate then
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You must return rented vehicle first. Or hold button to abandon it.");
                                DrawNotification(false, false);
                                Wait(1000)
                                if IsControlPressed(0, 86) then
                                    pos=GetEntityCoords(PlayerPedId())
                                    square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
                                    if (square<4) then
                                        abandoncar(rentcar)
                                        rentcar.veh=nil
                                        rentcar.net=nil
                                        forgetgps(rentcar)
                                        rentcar.plate=nil
                                        rentcar.hash=nil
                                        sendcarplates()
                                        SetNotificationTextEntry("STRING");
                                        AddTextComponentString("You failed to return rented vehicle. Shame on you! Shame!");
                                        DrawNotification(false, false);
                                        Wait(10000)
                                        SetNotificationTextEntry("STRING");
                                        AddTextComponentString("You can't rent new vehicle yet, I'm still angry on you.");
                                        DrawNotification(false, false);
                                        Wait(19000)
                                        SetNotificationTextEntry("STRING");
                                        AddTextComponentString("Okay, you can rent another vehicle if you need. Please return it this time.");
                                        DrawNotification(false, false);
                                    end
                                end
                            elseif player.money>=v.cost then
                                -- if mycar then
                                    -- SetNotificationTextEntry("STRING");
                                    -- AddTextComponentString("You need to store your current vehicle in ~b~garage ~s~or ~r~destroy ~s~it.");
                                    -- DrawNotification(false, false);
                                    -- Wait(1000)
                                    -- break
                                -- end
                                local angle=v.angle
                                if not angle then
                                    angle=GetEntityHeading(PlayerPedId())
                                end
                                local hash=v.cars[math.random(#v.cars)]
                                local veh
                                if v.fbi then
                                    veh=createcar(hash,v.x,v.y,v.z,angle)
                                    --TaskEnterVehicle(PlayerPedId(),veh,1,-1,2.0,16,0)
                                    --SetPedIntoVehicle(PlayerPedId(),veh,-1)
                                    SetVehicleAsNoLongerNeeded(veh)
                                elseif v.rent then
                                    rentcar.hash=hash
                                    veh=createcar(hash,v.x,v.y,v.z,angle)
                                    rentcar.veh=veh
                                    local carblip=AddBlipForEntity(rentcar.veh)
                                    SetBlipSprite(carblip, v.sprite)
                                    SetBlipDisplay(carblip, 2)
                                    SetBlipScale(carblip, 0.6)
                                    SetBlipColour(carblip, 32)
                                    --TaskEnterVehicle(PlayerPedId(),rentcar.veh,1,-1,2.0,16,0)
                                    --SetPedIntoVehicle(PlayerPedId(),rentcar.veh,-1)
                                    rentcar.net=networkingshit(rentcar.veh)
                                    rentcar.plate=GetVehicleNumberPlateText(rentcar.veh)
                                    sendcarplates()
                                    SetNotificationTextEntry("STRING");
                                    AddTextComponentString("Don't forget to return it!")
                                    DrawNotification(false, false)
                                else
                                    --TaskEnterVehicle(PlayerPedId(),createmycar(v.cars[math.random(#v.cars)],v.x,v.y,v.z,angle),1,-1,2.0,16,0)
                                    veh=createmycar(hash,v.x,v.y,v.z,angle)
                                    SetNotificationTextEntry("STRING");
                                    AddTextComponentString("You've bought a vehicle. When leaving server your vehicle has to be ~b~in garage~s~ to be saved.");
                                    DrawNotification(false, false);
                                end
                                
                                SetPedIntoVehicle(PlayerPedId(),veh,-1)
                                if v.livery~=nil then SetVehicleLivery(veh,v.livery) end
                                ApplyVehicleMods(veh,v.modkit,v.mods)
                                SetVehicleColorsEnhanced(veh,v.color1,v.color2,v.color3,v.color4,v.color5,v.color6)
                                
                                player.money=player.money-v.cost
                                removemoney(player.money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                SetBlipColour(v.blip, 20)
                                WaitWithMarker(5000,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(PlayerPedId())
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You don't have enough money.");
                                --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                                DrawNotification(false, false);
                            end
                        elseif rentcar.veh==GetVehiclePedIsUsing(PlayerPedId()) then
                            SetEntityAsMissionEntity(rentcar.veh,true,true)
                            DeleteVehicle(rentcar.veh)
                            rentcar.veh=nil
                            rentcar.net=nil
                            forgetgps(rentcar)
                            rentcar.plate=nil
                            rentcar.hash=nil
                            sendcarplates()
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("Thank you for returning rented vehicle.");
                            DrawNotification(false, false);
                            SetBlipColour(v.blip, 20)
                            WaitWithMarker(1000,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                            SetBlipColour(v.blip, v.color)
                            pos=GetEntityCoords(PlayerPedId())
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("Clear this area of any vehicles before buying.");
                            DrawNotification(false, false);
                        end
                    else
                        local action
                        if v.rent then
                            action="rent."
                        elseif v.cost==0 or v.fbi then
                            action="take."
                        else
                            action="buy."
                        end
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to "..action) --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local repair_wheels,repair_windows,repair_engine,repair_body,repair_paint,repair_nopaint,repair_full=1,2,4,8,16,15,31;
 faction.criminal.repairshops={
    {x=888.95196533203,y=-889.42864990234,z=26.414888381958,name="Repair engine and wheels",color=2,sprite=402,cost=700,flags=repair_wheels+repair_windows+repair_engine},
    {x=-31.853324890137,y=-1090.5874023438,z=26.422239303589,name="Repair engine and wheels",color=2,sprite=402,cost=700,flags=repair_wheels+repair_windows+repair_engine},
    {x=-27.108713150024,y=-1493.427734375,z=30.063791275024,name="Repair engine and wheels",color=69,sprite=402,cost=900,factionreq={FACTION.FAMILIES,15000},flags=repair_wheels+repair_windows+repair_engine},
    {x=967.56573486328,y=-1812.7857666016,z=30.833524703979,name="Repair engine and wheels",color=46,sprite=402,cost=1100,factionreq={FACTION.VAGOS,100000},flags=repair_wheels+repair_windows+repair_engine},
    {x=-450.90884399414,y=-1691.4396972656,z=18.660259246826,name="Repair engine and wheels",color=39,sprite=402,cost=500,factionreq={FACTION.MOBS,100000},flags=repair_wheels+repair_windows+repair_engine},
    {x=471.21493530273,y=-578.73657226563,z=28.49973487854,name="Full repair",color=1,sprite=446,cost=2000,flags=repair_nopaint},
    {x=258.84823608398,y=2588.5197753906,z=44.802917480469,name="Full repair",color=1,sprite=446,cost=3000,flags=repair_nopaint}, --"secret" harmony near brawler and house
    {x=-160.34722900391,y=-262.9680480957,z=81.60693359375,name="Full helicopter repair",color=1,sprite=446,cost=5000,flags=repair_full},
    {x=938.67657470703,y=-1495.4936523438,z=29.806707382202,sprite=72,name="Car paint",cost=500,flags=repair_paint},
    {x=-25.218566894531,y=-1427.4871826172,z=30.051826477051,sprite=72,color=69,color1=53,color2=53,name="Car paint (green)",cost=300,flags=repair_paint},
    {x=86.025238037109,y=-1971.1588134766,z=20.80552482605,sprite=72,color=83,color1=145,color2=145,name="Car paint (purple)",cost=300,flags=repair_paint},
    {x=976.76489257813,y=-1828.8614501953,z=30.669563293457,sprite=72,color=46,color1=42,color2=42,name="Car paint (yellow)",cost=300,flags=repair_paint},
    {x=1252.4379882813,y=-1618.8044433594,z=52.929946899414,sprite=72,color=18,color1=68,color2=68,name="Car paint (light blue)",cost=300,flags=repair_paint},
    --{x=-763.970703125,y=-912.88842773438,z=18.307744979858,sprite=72,color=49,color1=39,color2=39,name="Car paint",cost=300,flags=repair_paint},
    {x=137.8140411377,y=316.54156494141,z=111.76704406738,sprite=72,color=45,color1=3,color2=3,name="Car paint (grey)",cost=300,flags=repair_paint},
    --{x=-1272.4753417969,y=-3386.1181640625,z=14.099460601807,name="Full plane repair",color=1,sprite=446,cost=5000,flags=repair_full},
    
}
sahp.repairshops={
    {x=-462.28240966797,y=6009.2807617188,z=31.340553283691,name="Full repair",color=39,sprite=446,cost=0,flags=repair_nopaint},
}
lspd.repairshops={
    {x=435.72744750977,y=-997.92150878906,z=25.358324050903,name="Full repair(white)",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full},
    {x=529.88568115234,y=-28.615762710571,z=69.973480224609,name="Full repair",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full},
    {x=-1121.361328125,y=-843.36505126953,z=12.998027801514,name="Full repair",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full},
    {x=377.84707641602,y=-1630.1400146484,z=27.98410987854,name="Full repair",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full},
}
lsfd.repairshops={
    {x=202.1985168457,y=-1655.5092773438,z=29.825368881226,name="Full repair",color=75,sprite=446,cost=0,flags=repair_nopaint},
    {x=1200.8623046875,y=-1479.7216796875,z=34.927402496338,name="Full repair",color=75,sprite=446,cost=0,flags=repair_nopaint},
    {x=1695.2797851563,y=3588.7719726563,z=35.696208953857,name="Full repair",color=75,sprite=446,cost=0,flags=repair_nopaint},
}
paramedics.repairshops={
    {x=396.21374511719,y=-1438.87890625,z=29.438385009766,name="Full repair",color=8,sprite=446,cost=0,flags=repair_nopaint},
}
 faction.fbi.repairshops={
 {x=163.99192810059,y=-722.24682617188,z=32.778518676758,name="Full repair",color=3,sprite=446,cost=0,flags=repair_nopaint},
    --{x=435.72744750977,y=-997.92150878906,z=25.358324050903,name="Full repair(white)",color=3,color1=111,color2=111,sprite=446,cost=0,flags=repair_full},
    --{x=431.58267211914,y=-998.01678466797,z=25.357425689697,name="Full repair(black)",color=3,color1=12,color2=12,sprite=446,cost=0,flags=repair_full},
}
 lost.repairshops={
    {x=964.72741699219,y=-119.6036529541,z=73.823089599609,name="Full repair",color=62,sprite=446,cost=100,flags=repair_full}
}
 merc.repairshops={
    {x=596.19378662109,y=-3134.685546875,z=5.8618764877319,name="Full repair",color=65,color1=133,color2=133,sprite=446,cost=500,flags=repair_full}
}
 anarchy.repairshops={
    {x=743.66284179688,y=-966.14147949219,z=23.924823760986,name="Full repair",color=25,sprite=446,cost=1500,flags=repair_full}
}
 cartel.repairshops={
    {x=1408.4490966797,y=1117.8303222656,z=114.46551513672,name="Full repair",color=47,sprite=446,cost=1500,flags=repair_full}
}
 elite.repairshops={
    {x=-83.045204162598,y=352.84664916992,z=112.44156646729,name="Full repair",color=4,color1=12,color2=12,sprite=446,cost=2500,flags=repair_full}
}
local repairshops=faction.criminal.repairshops

Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.repairshops)
    makeblips(faction.fbi.repairshops)
    makeblips(lspd.repairshops)
    makeblips(sahp.repairshops)
    makeblips(lsfd.repairshops)
    makeblips(paramedics.repairshops)
    makeblips(lost.repairshops)
    makeblips(merc.repairshops)
    makeblips(anarchy.repairshops)
    makeblips(cartel.repairshops)
    makeblips(elite.repairshops)
    hideblips(faction.fbi.repairshops)
    hideblips(lspd.repairshops)
    hideblips(sahp.repairshops)
    hideblips(lsfd.repairshops)
    hideblips(paramedics.repairshops)
    hideblips(lost.repairshops)
    hideblips(merc.repairshops)
    hideblips(anarchy.repairshops)
    hideblips(cartel.repairshops)
    hideblips(elite.repairshops)
    while true do
        Wait(0)
        --while player.is_cop do Wait(5000) end
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(repairshops) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not player.is_dead) then
                    if v.factionreq and gangwar.top[v.factionreq[1]].score<v.factionreq[2] then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~r~"..gangwar.top[v.factionreq[1]].name.." needs ~g~$"..v.factionreq[2].." ~r~to unlock this.")
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    elseif IsControlPressed(0, 86) then
                        local veh=nil
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            veh = GetVehiclePedIsUsing(PlayerPedId())
                        else
                            local dx,dy,dz
                            local dist1=100
                            local dist2=100
                            if mycar.veh then
                                local pos2=GetEntityCoords(mycar.veh)
                                dx,dy,dz=pos2.x-pos.x,pos2.y-pos.y,pos2.z-pos.z
                                dist1=dx*dx+dy*dy+dz*dz
                                if dist1<100 then veh=mycar.veh end
                            end
                            if mycar_old.veh then
                                local pos2=GetEntityCoords(mycar_old.veh)
                                dx,dy,dz=pos2.x-pos.x,pos2.y-pos.y,pos2.z-pos.z
                                dist2=dx*dx+dy*dy+dz*dz
                                if dist2<dist1 then veh=mycar_old.veh end
                            end
                        end
                        if veh then
                            if player.money>=v.cost then
                                --ResetVehicleWheels(veh,true)
                                --ResetVehicleWheels(veh,false)
                                if (v.flags&repair_paint)==repair_paint then
                                    --SetVehicleColours(veh,-1,-1)
                                    if v.color1 and v.color2 then
                                        SetVehicleColours(veh,v.color1,v.color2)
                                    else
                                        SetVehicleColours(veh,math.random(0,160),math.random(0,160))
                                        local playerid=PlayerId()
                                        if GetPlayerWantedLevel(playerid)<4 then
                                            SetPlayerWantedLevel(playerid,0,false)
                                        end
                                    end
                                end
                                if (v.flags&repair_nopaint)==repair_nopaint then
                                    SetVehicleFixed(veh)
                                else
                                    if (v.flags&repair_wheels)==repair_wheels then
                                        SetVehicleTyreFixed(veh,0)
                                        SetVehicleTyreFixed(veh,1)
                                        SetVehicleTyreFixed(veh,2)
                                        SetVehicleTyreFixed(veh,3)
                                        SetVehicleTyreFixed(veh,4)
                                        SetVehicleTyreFixed(veh,5)
                                        SetVehicleTyreFixed(veh,45)
                                        SetVehicleTyreFixed(veh,47)
                                    end
                                --local engine = GetVehicleEngineHealth(veh)
                                --if engine<1000 then
                                
                                --SetVehicleBodyHealth(veh,1000.0)
                                    if (v.flags&repair_engine)==repair_engine then
                                        SetVehicleEngineHealth(veh,1000.0)
                                        SetVehiclePetrolTankHealth(veh,1000.0)
                                    end
                                --
                                    if (v.flags&repair_windows)==repair_windows then
                                        for i=0,26 do
                                            Citizen.CreateThread(function() FixVehicleWindow(veh,i) end)
                                        end
                                    end
                                end
                                player.money=player.money-v.cost
                                removemoney(player.money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                SetBlipColour(v.blip, 20)
                                WaitWithMarker(5000,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(PlayerPedId())
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You don't have enough money.");
                                --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                                DrawNotification(false, false);
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You need to be in a vehicle or have your bought vehicle nearby.");
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to use.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

local function scuba_criminal()
    local ped=setpedmodel(365775923) -- Дейв Нортон
    givescubagear(ped)
    SetPedComponentVariation(ped,3,2,0,0) --scuba top
    SetPedComponentVariation(ped,4,1,0,0) --scuba legs
    SetPedComponentVariation(ped,5,2,0,0) --scuba hands
    SetPedComponentVariation(ped,6,1,0,0) --scuba feet
    SetPedComponentVariation(ped,8,1,0,0) --scuba mask + oxygen tank
    --SetPedComponentVariation(ped,8,3,0,0) --oxygen tank no mask
    SetPedComponentVariation(ped,11,1,0,0) --no torso?
    --SetPedComponentVariation(ped,11,3,0,0) --no torso?
end
local function scuba_fbi()
    local ped=setpedmodel(941695432) -- агент Хейнс
    givescubagear(ped)
    SetPedComponentVariation(ped,3,2,0,0) --scuba top
    SetPedComponentVariation(ped,4,1,0,0) --scuba legs
    SetPedComponentVariation(ped,5,1,0,0) --scuba hands
    SetPedComponentVariation(ped,6,1,0,0) --scuba feet
    SetPedComponentVariation(ped,8,1,0,0) --oxygen tank
    SetPedPropIndex(ped,1,1,0,true) --scuba mask
end
local function scuba_merc()
    local ped=setpedmodel(225514697) -- Майкл
    givescubagear(ped)
    --SetPedComponentVariation(ped,8,1,0,0) --scuba mask + oxygen tank
    SetPedComponentVariation(ped,8,21,0,0) --scuba mask + oxygen tank + flashlight
    --SetPedPropIndex(ped,1,1,0,true); --blue scuba mask
    SetPedPropIndex(ped,1,2,0,true); --double mask
    SetPedComponentVariation(ped,9,7,0,0) --scuba head
    SetPedComponentVariation(ped,2,1,0,0) --short hair
    SetPedComponentVariation(ped,3,3,0,0) --scuba top
    --SetPedComponentVariation(ped,3,4,0,0) --another top
    --SetPedComponentVariation(ped,3,4,0,0) --heavy armor
    SetPedComponentVariation(ped,4,3,0,0) --scuba legs
    --SetPedComponentVariation(ped,4,5,0,0) --heavy armor
    SetPedComponentVariation(ped,5,1,0,0) --scuba hands
    SetPedComponentVariation(ped,6,3,0,0) --scuba feet
end
local function scuba_heister()
    local ped=setpedmodel(-1686040670) -- Тревор
    givescubagear(ped)
    --SetPedComponentVariation(ped,8,1,0,0) --scuba mask + oxygen tank
    SetPedComponentVariation(ped,8,15,0,0) --scuba mask + oxygen tank + flashlight
    SetPedPropIndex(ped,1,0,0,true); --red scuba mask
    --SetPedComponentVariation(ped,8,6,0,0) --mask
    --SetPedComponentVariation(ped,8,2,0,0) --heavy armor
    --SetPedComponentVariation(ped,2,6,0,0) --shaved
    SetPedComponentVariation(ped,2,1,0,0) --shaved
    --SetPedComponentVariation(ped,3,2,0,0) --heavy armor
    SetPedComponentVariation(ped,3,6,0,0) --scuba top
    SetPedComponentVariation(ped,4,6,0,0) --scuba legs
    --SetPedComponentVariation(ped,4,2,0,0) --heavy armor
    SetPedComponentVariation(ped,5,1,0,0) --scuba hands
    SetPedComponentVariation(ped,6,3,0,0) --scuba feet
end
local function scuba_elite()
    local ped=setpedmodel(-1692214353) -- Франклин
    givescubagear(ped)
    --SetPedComponentVariation(ped,8,8,0,0) --scuba mask + oxygen tank
    SetPedComponentVariation(ped,8,18,0,0) --scuba mask + oxygen tank + flashlight
    SetPedPropIndex(ped,1,0,0,true); --green scuba mask
    --SetPedPropIndex(ped,0,21,0,true); --jet fighter
    --SetPedPropIndex(ped,0,10,0,true); --skull
    --SetPedComponentVariation(ped,8,4,0,0) --mask
    SetPedComponentVariation(ped,2,4,0,0) --shaved
    SetPedComponentVariation(ped,9,4,0,0) --scuba head
    --SetPedComponentVariation(ped,9,3,0,0) --heavy armor
    SetPedComponentVariation(ped,3,3,0,0) --scuba top
    SetPedComponentVariation(ped,4,3,0,0) --scuba legs
    --SetPedComponentVariation(ped,4,4,0,0) --heavy armor
    SetPedComponentVariation(ped,5,4,0,0) --scuba hands
    SetPedComponentVariation(ped,6,2,0,0) --scuba feet
end

 faction.criminal.special={
    {x=-1128.7236328125,y=-1162.3797607422,z=6.4949550628662,name="Scuba gear",color=2,sprite=308,cost=2000,check=havescubagear,equip=scuba_criminal},
}
 faction.fbi.special={
    {x=-1042.3065185547,y=-828.11090087891,z=10.884181022644,name="Scuba gear",color=3,sprite=308,cost=0,check=havescubagear,equip=scuba_fbi},
}
 merc.special={
    { x=611.87548828125,y=-3094.1320800781,z=6.0692591667175,name="Scuba gear",color=65,sprite=308,cost=500,check=havescubagear,equip=scuba_merc}
}
 heisters.special={
    { x=-1128.7236328125,y=-1162.3797607422,z=6.4949550628662,name="Scuba gear",color=25,sprite=308,cost=1500,check=havescubagear,equip=scuba_heister}
}
 elite.special={
    {x=-74.246940612793,y=362.59594726563,z=112.44319152832,name="Scuba gear",color=4,sprite=308,cost=2500,check=havescubagear,equip=scuba_elite}
}
local special=faction.criminal.special

Citizen.CreateThread(function()
Wait(5000)
    makeblips(faction.criminal.special)
    makeblips(faction.fbi.special)
    makeblips(merc.special)
    makeblips(heisters.special)
    makeblips(elite.special)
    hideblips(faction.fbi.special)
    hideblips(merc.special)
    hideblips(heisters.special)
    hideblips(elite.special)
    while true do
        Wait(0)
        --while player.is_cop do Wait(5000) end
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(special) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<4) and (not player.is_dead) then
                    if v.factionreq and gangwar.top[v.factionreq[1]].score<v.factionreq[2] then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~r~"..gangwar.top[v.factionreq[1]].name.." needs ~g~$"..v.factionreq[2].." ~r~to unlock this.")
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    elseif IsControlPressed(0, 86) then
                        if not v.check() then
                            if player.money>=v.cost then
                                v.equip()
                                player.money=player.money-v.cost
                                removemoney(player.money,v.cost)
                                TriggerServerEvent(event.buy,v.cost)
                                SetBlipColour(v.blip, 20)
                                WaitWithMarker(5000,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 0.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                                SetBlipColour(v.blip, v.color)
                                pos=GetEntityCoords(PlayerPedId())
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You don't have enough money.");
                                --SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", false, 9, v.name, "$"..v.cost);
                                DrawNotification(false, false);
                            end
                        else
                            SetNotificationTextEntry("STRING");
                            AddTextComponentString("You already have this equipment.");
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(v.name.." ~b~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to use.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                        --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent(event.plates)
AddEventHandler(event.plates, function(plate_m,hash_m,plate_o,hash_o,plate_r,hash_r)
    if plate_m then print("mycar ["..plate_m.."]") end
    if plate_o then print("oldcar ["..plate_o.."]") end
    if plate_r then print("rentcar ["..plate_r.."]") end
    if hash_m then print("mycar ["..hash_m.."]") end
    if hash_o then print("oldcar ["..hash_o.."]") end
    if hash_r then print("rentcar ["..hash_r.."]") end
    mycar.plate=plate_m
    mycar_old.plate=plate_o
    rentcar.plate=plate_r
    mycar.hash=hash_m
    mycar_old.hash=hash_o
    rentcar.hash=hash_r
    if plate_m or plate_o or plate_r then
        Wait(5000)
        for veh in EnumerateVehicles() do
            local plate=GetVehicleNumberPlateText(veh)
            -- if plate then
             -- print("plate "..plate)
            -- else
             -- print("no plate "..veh)
            -- end
            if plate==mycar.plate then
                mycar.veh=veh
                mycar.net=NetworkGetNetworkIdFromEntity(veh)
                mycar.hash=GetEntityModel(veh)
                addcarblip(veh)
            end
            if plate==mycar_old.plate then
                mycar_old.veh=veh
                mycar_old.net=NetworkGetNetworkIdFromEntity(veh)
                mycar_old.hash=GetEntityModel(veh)
                addcarblip(veh)
            end
            if plate==rentcar.plate then
                rentcar.veh=veh
                rentcar.net=NetworkGetNetworkIdFromEntity(veh)
                rentcar.hash=GetEntityModel(veh)
                addcarblip(veh)
            end
        end
    end
end)

RegisterNetEvent(event.garage)
AddEventHandler(event.garage, function(k,car)
    if car~=nil then
        garages[k].name=GetDisplayNameFromVehicleModel(car.hash)
        garages[k].car=car
        garages[k].color=3
    else
        garages[k].car=nil
        garages[k].name="Garage"
        garages[k].color=4
    end
    local blip=garages[k].blip
    if blip then
        SetBlipColour(blip, garages[k].color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(garages[k].name);
        EndTextCommandSetBlipName(blip)
    end
end)
    
Citizen.CreateThread(function()
    Wait(7000)
    makeblips(garages)
    while true do
        Wait(0)
        while not garages_enabled do Wait(5000) end --GetHashKey("PLAYER")
        pos=GetEntityCoords(PlayerPedId())
        for k,v in pairs(garages) do
            local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
            if square<100 then
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 1.5, 255, 128, 128, 128, false, true, 2, false, false, false, false)
                if (square<v.radius) and (not player.is_dead) then
                    if IsControlPressed(0, 86) then
                        if v.car and not IsPedSittingInAnyVehicle(PlayerPedId()) then
                            -- if mycar and (v.car.wanted==0) then
                                -- SetNotificationTextEntry("STRING");
                                -- AddTextComponentString("You need to store your current vehicle in ~b~garage ~s~or ~r~destroy ~s~it.");
                                -- DrawNotification(false, false);
                                -- Wait(1000)
                                -- break
                            -- end
                            local c=v.car
                            local veh=loadcar(v.x,v.y,v.z,v.angle,c)
                            v.car=nil
                            v.name="Garage"
                            --TaskEnterVehicle(PlayerPedId(),veh,1,-1,2.0,16,0)
                            SetPedIntoVehicle(PlayerPedId(),veh,-1)
                            TriggerServerEvent(event.take_car,k)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(v.name);
                            EndTextCommandSetBlipName(v.blip)
                            SetBlipColour(v.blip, 20)
                            WaitWithMarker(5000,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 1.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                            SetBlipColour(v.blip, 4)
                            pos=GetEntityCoords(PlayerPedId())
                        elseif (not v.car) and IsPedSittingInAnyVehicle(PlayerPedId()) then
                            local veh=GetVehiclePedIsUsing(PlayerPedId())
                            if veh==rentcar.veh then
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("Did you just stole rented vehicle?");
                                DrawNotification(false, false);
                            end
                            v.car=savecar(veh)
                            v.name=GetDisplayNameFromVehicleModel(v.car.hash)
                            TriggerServerEvent(event.save_car,k,v.car)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(v.name);
                            EndTextCommandSetBlipName(v.blip)
                            SetBlipColour(v.blip, 20)
                            WaitWithMarker(5000,1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.7, 2.7, 1.5, 128, 128, 128, 128, false, true, 2, false, false, false, false)
                            SetBlipColour(v.blip, 3)
                            pos=GetEntityCoords(PlayerPedId())
                        else
                            SetNotificationTextEntry("STRING");
                            if v.car then
                                AddTextComponentString("You need to be on foot to take vehicle.");
                            else
                                AddTextComponentString("You need to be in a vehicle to store it.");
                            end
                            DrawNotification(false, false);
                        end
                    else
                        SetTextComponentFormat("STRING")
                        if v.car then
                                AddTextComponentString("Press ~INPUT_VEH_HORN~ to take "..v.name..".")
                        else
                                AddTextComponentString("Press ~INPUT_VEH_HORN~ to save one vehicle in this garage.");
                        end
                        DisplayHelpTextFromStringLabel(0,0,1,-1)
                    end
                end
            end
        end
    end
end)

allies_government[GetHashKey("COP")]="cop"
allies_government[GetHashKey("SECURITY_GUARD")]="security guard"
allies_government[GetHashKey("CIVMALE")]="civilian"
allies_government[GetHashKey("CIVFEMALE")]="civilian"
allies_government[GetHashKey("FIREMAN")]="fireman"
allies_government[GetHashKey("ARMY")]="soldier"
allies_government[GetHashKey("MEDIC")]="medic"
for k,v in pairs(SKINS.LSFD) do
allies_government[v]="fireman"
end
for k,v in pairs(SKINS.MEDICS) do
allies_government[v]="medic"
end
for k,v in pairs(SKINS.FBI) do
allies_government[v]="FBI agent"
end
for k,v in pairs(SKINS.FBISWAT) do
allies_government[v]="FBI agent"
end
for k,v in pairs(SKINS.DETECTIVES) do
allies_government[v]="detective"
end
for k,v in pairs(SKINS.LSPD) do
allies_government[v]="LSPD officer"
end
for k,v in pairs(SKINS.SSPD) do
allies_government[v]="SSPD officer"
end
for k,v in pairs(SKINS.SAHP) do
allies_government[v]="SAHP officer"
end
for k,v in pairs(SKINS.SAPR) do
allies_government[v]="SAPR officer"
end
for k,v in pairs(SKINS.NOOSE) do
allies_government[v]="SWAT operator"
end
for k,v in pairs(SKINS.MILITARY) do
allies_government[v]="soldier"
end
for k,v in pairs(SKINS.NAVY) do
allies_government[v]="soldier"
end

--allies_lost[GetHashKey("AMBIENT_GANG_LOST")]="lost"
for k,v in pairs(SKINS.LOST) do
allies_lost[v]="lost"
end

--allies_mercs[GetHashKey("AGGRESSIVE_INVESTIGATE")]="merc"
for k,v in pairs(SKINS.MERCS) do
allies_mercs[v]="merc"
end

--allies_anarchy[GetHashKey("MISSION2")]="anarchist"
for k,v in pairs(SKINS.ANARCHY) do
allies_anarchy[v]="anarchist"
end

--allies_ballas[GetHashKey("AMBIENT_GANG_BALLAS")]="ballas"
for k,v in pairs(SKINS.BALLAS) do
allies_ballas[v]="ballas"
end

--allies_fams[GetHashKey("AMBIENT_GANG_FAMILY")]="family member"
for k,v in pairs(SKINS.FAMILIES) do
allies_fams[v]="family member"
end

--allies_vagos[GetHashKey("AMBIENT_GANG_MEXICAN")]="vagos"
for k,v in pairs(SKINS.VAGOS) do
allies_vagos[v]="vagos"
end

--allies_salva[GetHashKey("AMBIENT_GANG_SALVA")]="salva"
for k,v in pairs(SKINS.SALVA) do
allies_salva[v]="salva"
end

--allies_triads[GetHashKey("AMBIENT_GANG_WEICHENG")]="triad member"
for k,v in pairs(SKINS.TRIADS) do
allies_triads[v]="triad member"
end

--allies_armmob[GetHashKey("AMBIENT_GANG_MARABUNTE")]="armenian mob"
for k,v in pairs(SKINS.MOBS) do
allies_armmob[v]="armenian mob"
end

--allies_heister[GetHashKey("MISSION3")]="heister"
for k,v in pairs(SKINS.HEISTERS) do
allies_heister[v]="heister"
end

--allies_cartel[GetHashKey("AMBIENT_GANG_MEXICAN")]="cartel member"
for k,v in pairs(SKINS.CARTEL) do
allies_cartel[v]="cartel"
end

--allies_elite[GetHashKey("MISSION4")]="elite security"
for k,v in pairs(SKINS.ELITE) do
allies_elite[v]="elite security"
end

local dont_kill_those={}

local VEHWHITELIST={}
VEHWHITELIST.LSFD={}
for k,v in pairs(VEHICLES.LSFD) do
    VEHWHITELIST.LSFD[v]=true
end
VEHWHITELIST.MEDICS={}
for k,v in pairs(VEHICLES.MEDICS) do
    VEHWHITELIST.MEDICS[v]=true
end
VEHWHITELIST.LSPDHEAVY={}
for k,v in pairs(VEHICLES.LSPDHEAVY) do
    VEHWHITELIST.LSPDHEAVY[v]=true
end
VEHWHITELIST.DETECTIVES={}
for k,v in pairs(VEHICLES.DETECTIVES) do
    VEHWHITELIST.DETECTIVES[v]=true
end
VEHWHITELIST.LSPD={}
for k,v in pairs(VEHICLES.LSPD) do
    VEHWHITELIST.LSPD[v]=true
end
VEHWHITELIST.SSPD={}
for k,v in pairs(VEHICLES.SSPD) do
    VEHWHITELIST.SSPD[v]=true
end
VEHWHITELIST.SAHP={}
for k,v in pairs(VEHICLES.SAHP) do
    VEHWHITELIST.SAHP[v]=true
end
VEHWHITELIST.SAPR={}
for k,v in pairs(VEHICLES.SAPR) do
    VEHWHITELIST.SAPR[v]=true
end
VEHWHITELIST.NOOSE={}
for k,v in pairs(VEHICLES.NOOSE) do
    VEHWHITELIST.NOOSE[v]=true
end
VEHWHITELIST.NAVY={}
for k,v in pairs(VEHICLES.NAVY) do
    VEHWHITELIST.NAVY[v]=true
end
VEHWHITELIST.MILITARY={}
for k,v in pairs(VEHICLES.MILITARY) do
    VEHWHITELIST.MILITARY[v]=true
end
VEHWHITELIST.FBISWAT={}
for k,v in pairs(VEHICLES.FBISWAT) do
    VEHWHITELIST.FBISWAT[v]=true
end

local hide_phone_now=false


local function hide_old_blips() 
    hideblips(weaponshops)
    hideblips(armorshops)
    hideblips(medics)
    hideblips(clothes)
    hideblips(skinshops)
    hideblips(mercenaries)
    hideblips(carshops)
    hideblips(repairshops)
    hideblips(weapon_upgrade_shops)
    hideblips(special)
end

local function show_new_blips()
    showblips(weaponshops)
    showblips(armorshops)
    showblips(medics)
    showblips(clothes)
    showblips(skinshops)
    showblips(mercenaries)
    showblips(carshops)
    showblips(repairshops)
    showblips(weapon_upgrade_shops)
    showblips(special)
end

switch_to_criminal=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,nil)
    relationship_friend=GetHashKey("PLAYER")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    showblips(join_faction)
    medics=faction.criminal.medics
    skinshops=faction.criminal.skinshops
    weaponshops=faction.criminal.weaponshops
    carshops=faction.criminal.carshops
    repairshops=faction.criminal.repairshops
    mercenaries=faction.criminal.mercenaries
    armorshops=faction.criminal.armorshops
    clothes=faction.criminal.clothes
    weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops
    special=faction.criminal.special
    vehiclewhitelist=nil
    show_new_blips()
    showblips(garages)
    garages_enabled=true
    player.civilian=false
    player.is_cop=false
    dont_kill_those={}
    player.special_ability=special_abilities.none
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_firefighters=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,24)
    relationship_friend=GetHashKey("FIREMAN")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    GiveWeaponToPed(PlayerPedId(),101631238,1000,false,true) --fire extinguisher
    hide_old_blips()
    hideblips(join_faction)
    medics=lsfd.medics
    skinshops={}--lsfd.skinshops
    weaponshops={}--lsfd.weaponshops
    carshops=lsfd.carshops
    repairshops=lsfd.repairshops
    mercenaries={}--lsfd.mercenaries
    armorshops={}--lsfd.armorshops
    clothes={}--lsfd.clothes
    weapon_upgrade_shops={}--lsfd.weapon_upgrade_shops
    special={}--lsfd.special
    vehiclewhitelist=VEHWHITELIST.LSFD
    basecoords={x=215.01205444336,y=-1651.2668457031,z=29.803216934204,angle=51.658428192139}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=true
    player.is_cop=false
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.firefighter
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    --SetPedAsCop(PlayerPedId(), true)
end

switch_to_paramedics=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,23)
    relationship_friend=GetHashKey("MEDIC")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics={}--lspd.medics
    skinshops=paramedics.skinshops
    weaponshops={}--lspdheavy.weaponshops
    carshops=paramedics.carshops
    repairshops=paramedics.repairshops
    mercenaries={}--lspd.mercenaries
    armorshops={}--lspdheavy.armorshops
    clothes={}--lspdheavy.clothes
    weapon_upgrade_shops={}--lspd.weapon_upgrade_shops
    special={}--lspd.special
    vehiclewhitelist=VEHWHITELIST.MEDICS
    basecoords={x=294.99197387695,y=-1447.7286376953,z=29.966623306274,angle=320.92782592773}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=true
    player.is_cop=false
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.medic
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    --SetPedAsCop(PlayerPedId(), true)
end

switch_to_lost=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,11)
    relationship_friend=GetHashKey("AMBIENT_GANG_LOST")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=lost.medics
    skinshops=lost.skinshops
    weaponshops=lost.weaponshops
    carshops=lost.carshops
    repairshops=lost.repairshops
    mercenaries=lost.mercenaries
    armorshops=lost.armorshops
    clothes=lost.clothes
    weapon_upgrade_shops=lost.weapon_upgrade_shops
    special={}
    vehiclewhitelist=nil
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_lost
    player.special_ability=special_abilities.passiveregen
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_lspdheavy=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,7)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=lspd.medics
    skinshops={}--lspd.skinshops
    weaponshops=lspdheavy.weaponshops
    carshops=lspdheavy.carshops
    repairshops=lspd.repairshops
    mercenaries={}--lspd.mercenaries
    armorshops=lspdheavy.armorshops
    clothes=lspdheavy.clothes
    weapon_upgrade_shops=lspd.weapon_upgrade_shops
    special={}--lspd.special
    vehiclewhitelist=VEHWHITELIST.LSPDHEAVY
    basecoords={x=441.19030761719,y=-981.13079833984,z=30.689605712891}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.smallmedkit
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end
switch_to_detectives=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,25)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=lspd.medics
    skinshops={}
    weaponshops=faction.detectives.weaponshops
    carshops=faction.detectives.carshops
    repairshops=lspd.repairshops
    mercenaries={}--lspd.mercenaries
    armorshops={}--lspd.armorshops
    clothes=faction.detectives.clothes
    weapon_upgrade_shops={}--lspd.weapon_upgrade_shops
    special={}--lspd.special
    vehiclewhitelist=VEHWHITELIST.DETECTIVES
    basecoords={x=452.10980224609,y=-984.57336425781,z=26.674234390259}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.evidence
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end
switch_to_lspd=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,8)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=lspd.medics
    skinshops=lspd.skinshops
    weaponshops=lspd.weaponshops
    carshops=lspd.carshops
    repairshops=lspd.repairshops
    mercenaries={}--lspd.mercenaries
    armorshops={}--lspd.armorshops
    clothes=lspd.clothes
    weapon_upgrade_shops=lspd.weapon_upgrade_shops
    special={}--lspd.special
    vehiclewhitelist=VEHWHITELIST.LSPD
    basecoords={x=441.19030761719,y=-981.13079833984,z=30.689605712891}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.evidence
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end
switch_to_sspd=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,5)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=sspd.medics
    skinshops=sspd.skinshops
    weaponshops=sspd.weaponshops
    carshops=sspd.carshops
    repairshops={}--sspd.repairshops
    mercenaries={}--sspd.mercenaries
    armorshops={}--sspd.armorshops
    clothes={}--sspd.clothes
    weapon_upgrade_shops={}--sspd.weapon_upgrade_shops
    special={}--sspd.special
    vehiclewhitelist=VEHWHITELIST.SSPD
    basecoords={x=1853.5550537109,y=3689.3596191406,z=34.267066955566}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.fastlowregen
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end
switch_to_sahp=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,4)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=sahp.medics
    skinshops=sahp.skinshops
    weaponshops=sahp.weaponshops
    carshops=sahp.carshops
    repairshops=sahp.repairshops
    mercenaries={}--sahp.mercenaries
    armorshops={}--sahp.armorshops
    clothes={}--sahp.clothes
    weapon_upgrade_shops={}--sahp.weapon_upgrade_shops
    special={}--sahp.special
    vehiclewhitelist=VEHWHITELIST.SAHP
    basecoords={x=-448.84234619141,y=6013.0473632813,z=31.716390609741}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.regenincar
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end
switch_to_sapr=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,6)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=sapr.medics
    skinshops=sapr.skinshops
    weaponshops=sapr.weaponshops
    carshops=sapr.carshops
    repairshops={}--sapr.repairshops
    mercenaries={}--sapr.mercenaries
    armorshops={}--sapr.armorshops
    clothes={}--sapr.clothes
    weapon_upgrade_shops=sapr.weapon_upgrade_shops
    special={}--sapr.special
    vehiclewhitelist=VEHWHITELIST.SAPR
    basecoords={x=379.21508789063,y=792.20190429688,z=190.40716552734}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.baseregen
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end
switch_to_noose=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,3)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=noose.medics
    skinshops=noose.skinshops
    weaponshops=noose.weaponshops
    carshops=noose.carshops
    repairshops={}--noose.repairshops
    mercenaries={}--noose.mercenaries
    armorshops=noose.armorshops
    clothes={}--noose.clothes
    weapon_upgrade_shops=noose.weapon_upgrade_shops
    special={}--noose.special
    vehiclewhitelist=VEHWHITELIST.NOOSE
    basecoords={x=2475.6059570313,y=-384.12286376953,z=94.399314880371}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.regeninvan
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end

switch_to_navy=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,1)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=military.medics
    skinshops=navy.skinshops
    weaponshops=navy.weaponshops
    carshops=navy.carshops
    repairshops={}--military.repairshops
    mercenaries={}--military.mercenaries
    armorshops=navy.armorshops
    clothes={}--military.clothes
    weapon_upgrade_shops={}--military.weapon_upgrade_shops
    special={}--military.special
    vehiclewhitelist=VEHWHITELIST.NAVY
    basecoords={x=-2345.8854980469,y=3268.2790527344,z=32.810749053955}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.armorregen
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end
switch_to_military=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,2)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=military.medics
    skinshops=military.skinshops
    weaponshops=military.weaponshops
    carshops=military.carshops
    repairshops={}--military.repairshops
    mercenaries={}--military.mercenaries
    armorshops=military.armorshops
    clothes={}--military.clothes
    weapon_upgrade_shops={}--military.weapon_upgrade_shops
    special={}--military.special
    vehiclewhitelist=VEHWHITELIST.MILITARY
    basecoords={x=-2345.8854980469,y=3268.2790527344,z=32.810749053955}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.ammoregen
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end

switch_to_fbiswat=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,9)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=faction.fbi.medics
    skinshops=fbiswat.skinshops
    weaponshops=fbiswat.weaponshops
    carshops=fbiswat.carshops
    repairshops=faction.fbi.repairshops
    mercenaries=faction.fbi.mercenaries
    armorshops=faction.fbi.armorshops
    clothes=fbiswat.clothes
    weapon_upgrade_shops=fbiswat.weapon_upgrade_shops
    special=faction.fbi.special
    vehiclewhitelist=VEHWHITELIST.FBISWAT
    basecoords={x=115.88011169434,y=-748.78686523438,z=45.7516746521}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.friendsregen
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end

switch_to_fbi=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,10)
    relationship_friend=GetHashKey("COP")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=faction.fbi.medics
    skinshops=faction.fbi.skinshops
    weaponshops=faction.fbi.weaponshops
    carshops=faction.fbi.carshops
    repairshops=faction.fbi.repairshops
    mercenaries=faction.fbi.mercenaries
    armorshops=faction.fbi.armorshops
    clothes=faction.fbi.clothes
    weapon_upgrade_shops=faction.fbi.weapon_upgrade_shops
    special=faction.fbi.special
    vehiclewhitelist=nil
    basecoords={x=115.88011169434,y=-748.78686523438,z=45.7516746521}
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=true
    dont_kill_those=allies_government
    SetMaxWantedLevel(5) --0
    player.special_ability=special_abilities.seeweaponsinhands
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetPedAsCop(PlayerPedId(), true)
end

switch_to_merc=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,12)
    relationship_friend=GetHashKey("AGGRESSIVE_INVESTIGATE")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=merc.medics
    skinshops=merc.skinshops
    weaponshops=merc.weaponshops
    carshops=merc.carshops
    repairshops=merc.repairshops
    mercenaries=merc.mercenaries
    armorshops=merc.armorshops
    clothes=merc.clothes
    weapon_upgrade_shops=merc.weapon_upgrade_shops
    special=merc.special
    vehiclewhitelist=nil
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_mercs
    player.special_ability=special_abilities.reusehealthandarmor
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_anarchy=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,13)
    relationship_friend=GetHashKey("MISSION2")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=anarchy.medics
    skinshops=anarchy.skinshops
    weaponshops=faction.criminal.weaponshops
    carshops=faction.criminal.carshops
    repairshops=anarchy.repairshops
    mercenaries=faction.criminal.mercenaries
    armorshops=anarchy.armorshops
    clothes=anarchy.clothes
    weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops
    special={}
    vehiclewhitelist=nil
    show_new_blips()
    showblips(garages)
    garages_enabled=true
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_anarchy
    player.special_ability=special_abilities.anarchyfixandfire
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_ballas=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,14)
    relationship_friend=GetHashKey("AMBIENT_GANG_BALLAS")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=faction.criminal.medics
    skinshops=ballas.skinshops
    weaponshops=faction.criminal.weaponshops
    carshops=faction.criminal.carshops
    repairshops=faction.criminal.repairshops
    mercenaries=faction.criminal.mercenaries
    armorshops=faction.criminal.armorshops
    clothes=faction.criminal.clothes
    weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops
    special={}
    vehiclewhitelist=nil
    show_new_blips()
    showblips(garages)
    garages_enabled=true
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_ballas
    player.special_ability=special_abilities.pill
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_fams=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,15)
    relationship_friend=GetHashKey("AMBIENT_GANG_FAMILY")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=faction.criminal.medics
    skinshops=fams.skinshops
    weaponshops=faction.criminal.weaponshops
    carshops=faction.criminal.carshops
    repairshops=faction.criminal.repairshops
    mercenaries=faction.criminal.mercenaries
    armorshops=faction.criminal.armorshops
    clothes=faction.criminal.clothes
    weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops
    special={}
    vehiclewhitelist=nil
    show_new_blips()
    showblips(garages)
    garages_enabled=true
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_fams
    player.special_ability=special_abilities.weed
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_vagos=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,16)
    relationship_friend=GetHashKey("AMBIENT_GANG_MEXICAN")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=faction.criminal.medics
    skinshops=vagos.skinshops
    weaponshops=faction.criminal.weaponshops
    carshops=faction.criminal.carshops
    repairshops=faction.criminal.repairshops
    mercenaries=faction.criminal.mercenaries
    armorshops=faction.criminal.armorshops
    clothes=faction.criminal.clothes
    weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops
    special={}
    vehiclewhitelist=nil
    show_new_blips()
    showblips(garages)
    garages_enabled=true
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_vagos
    player.special_ability=special_abilities.heroin
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_salva=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,17)
    relationship_friend=GetHashKey("AMBIENT_GANG_SALVA")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=faction.criminal.medics
    skinshops=salva.skinshops
    weaponshops=faction.criminal.weaponshops
    carshops=faction.criminal.carshops
    repairshops=faction.criminal.repairshops
    mercenaries=faction.criminal.mercenaries
    armorshops=faction.criminal.armorshops
    clothes=faction.criminal.clothes
    weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops
    special={}
    vehiclewhitelist=nil
    show_new_blips()
    showblips(garages)
    garages_enabled=true
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_salva
    player.special_ability=special_abilities.exchange
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_triads=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,18)
    relationship_friend=GetHashKey("AMBIENT_GANG_WEICHENG")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=faction.criminal.medics
    skinshops=triads.skinshops
    weaponshops=faction.criminal.weaponshops
    carshops=faction.criminal.carshops
    repairshops=faction.criminal.repairshops
    mercenaries=faction.criminal.mercenaries
    armorshops=faction.criminal.armorshops
    clothes=faction.criminal.clothes
    weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops
    special={}
    vehiclewhitelist=nil
    show_new_blips()
    showblips(garages)
    garages_enabled=true
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_triads
    player.special_ability=special_abilities.stim
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_armmob=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,19)
    relationship_friend=GetHashKey("AMBIENT_GANG_MARABUNTE")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=faction.criminal.medics
    skinshops=mobs.skinshops
    weaponshops=faction.criminal.weaponshops
    carshops=faction.criminal.carshops
    repairshops=faction.criminal.repairshops
    mercenaries=faction.criminal.mercenaries
    armorshops=faction.criminal.armorshops
    clothes=faction.criminal.clothes
    weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops
    special={}
    vehiclewhitelist=nil
    show_new_blips()
    showblips(garages)
    garages_enabled=true
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_armmob
    player.special_ability=special_abilities.alco
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_heister=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,20)
    relationship_friend=GetHashKey("MISSION3")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=faction.criminal.medics
    skinshops=heisters.skinshops
    weaponshops=faction.criminal.weaponshops
    carshops=faction.criminal.carshops
    repairshops=faction.criminal.repairshops
    mercenaries=faction.criminal.mercenaries
    armorshops=faction.criminal.armorshops
    clothes=faction.criminal.clothes
    weapon_upgrade_shops=faction.criminal.weapon_upgrade_shops
    special=heisters.special
    vehiclewhitelist=nil
    show_new_blips()
    showblips(garages)
    garages_enabled=true
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_heister
    player.special_ability=special_abilities.lockpick
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_cartel=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,21)
    relationship_friend=GetHashKey("AMBIENT_GANG_MEXICAN")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=cartel.medics
    skinshops=cartel.skinshops
    weaponshops=cartel.weaponshops
    carshops=cartel.carshops
    repairshops=cartel.repairshops
    mercenaries=cartel.mercenaries
    armorshops=cartel.armorshops
    clothes=cartel.clothes
    weapon_upgrade_shops=cartel.weapon_upgrade_shops
    special={}
    vehiclewhitelist=nil
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_cartel
    player.special_ability=special_abilities.anyveh
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end

switch_to_elite=function()
    hide_phone_now=true
    Wait(30)
    TriggerServerEvent(event.gang,22)
    relationship_friend=GetHashKey("MISSION4")
    SetPedRelationshipGroupHash(PlayerPedId(),relationship_friend)
    hide_old_blips()
    hideblips(join_faction)
    medics=elite.medics
    skinshops=elite.skinshops
    weaponshops=elite.weaponshops
    carshops=elite.carshops
    repairshops=elite.repairshops
    mercenaries=elite.mercenaries
    armorshops=elite.armorshops
    clothes=elite.clothes
    weapon_upgrade_shops=elite.weapon_upgrade_shops
    special=elite.special
    vehiclewhitelist=nil
    show_new_blips()
    hideblips(garages)
    garages_enabled=false
    player.civilian=false
    player.is_cop=false
    dont_kill_those=allies_elite
    player.special_ability=special_abilities.losewantedlevel
    player.special_ability_amount=0
    player.special_ability_timestamp=nil
    SetMaxWantedLevel(5);
end


join_faction[1]={func=switch_to_navy,x=-2349.6596679688,y=3268.3637695313,z=32.810760498047,sprite=60,color=26,markercolor={255, 200, 128, 128},name="Join Navy",models=SKINS.NAVY,removeweapons=true}
join_faction[2]={func=switch_to_military,x=-2345.8854980469,y=3268.2790527344,z=32.810749053955,sprite=60,color=52,markercolor={255, 200, 128, 128},name="Join Military",models=SKINS.MILITARY,removeweapons=true}
join_faction[3]={func=switch_to_noose,x=2475.6059570313,y=-384.12286376953,z=94.399314880371,sprite=60,color=29,markercolor={128, 128, 255, 128},name="Join SWAT",models=SKINS.NOOSE,components={[10]={0,0}},removeweapons=true}
join_faction[4]={func=switch_to_sahp,x=-448.84234619141,y=6013.0473632813,z=31.716390609741,sprite=60,color=39,markercolor={128, 128, 128, 128},name="Join SAHP",models=SKINS.SAHP,removeweapons=true}
join_faction[5]={func=switch_to_sspd,x=1853.5550537109,y=3689.3596191406,z=34.267066955566,sprite=60,color=5,markercolor={255, 255, 128, 128},name="Join SSPD",models=SKINS.SSPD,removeweapons=true}
join_faction[6]={func=switch_to_sapr,x=379.21508789063,y=792.20190429688,z=190.40716552734,sprite=60,color=2,markercolor={128, 255, 128, 128},name="Join SAPR",models=SKINS.SAPR,removeweapons=true}
join_faction[7]={func=switch_to_lspdheavy,x=446.41818237305,y=-986.47784423828,z=26.674211502075,sprite=60,color=3,markercolor={128, 128, 255, 128},name="Join LSPD Heavy Unit",models={1581098148},components={[9]=2},removeweapons=true}
join_faction[8]={func=switch_to_lspd,x=441.19030761719,y=-981.13079833984,z=30.689605712891,sprite=60,color=3,markercolor={128, 128, 255, 128},name="Join LSPD",models=SKINS.LSPD,components={[9]=0},removeweapons=true}
join_faction[9]={func=switch_to_fbiswat,x=156.0267791748,y=-741.1162109375,z=242.15208435059,sprite=60,color=4,markercolor={128, 128, 255, 128},name="Join FBI SWAT",models={-1145735340},removeweapons=true}
join_faction[10]={func=switch_to_fbi,x=115.88011169434,y=-748.78686523438,z=45.7516746521,sprite=60,color=4,markercolor={128, 128, 255, 128},name="Join FBI",models=SKINS.FBI,removeweapons=true}
join_faction[11]={func=switch_to_lost,x=984.76843261719,y=-91.682571411133,z=74.848892211914,sprite=378,color=62,markercolor={150, 150, 150, 128},name="Join Lost M.C.",models=SKINS.LOST}
join_faction[12]={func=switch_to_merc,x=484.337890625,y=-3052.2468261719,z=6.2286891937256,sprite=431,color=65,markercolor={150, 150, 200, 128},name="Join Mercs",models=SKINS.MERCS}
join_faction[13]={func=switch_to_anarchy,x=707.38952636719,y=-967.00140380859,z=30.412853240967,sprite=442,color=25,markercolor={150, 150, 200, 128},name="Join Anarchists",models=SKINS.ANARCHY}
join_faction[14]={func=switch_to_ballas,x=78.277633666992,y=-1974.7937011719,z=20.911375045776,sprite=491,color=83,markercolor={200, 0, 200, 128},name="Join Ballas",models=SKINS.BALLAS}
join_faction[15]={func=switch_to_fams,x=-11.148657798767,y=-1433.2587890625,z=31.116823196411,sprite=491,color=69,markercolor={0, 200, 0, 128},name="Join Families",models=SKINS.FAMILIES}
join_faction[16]={func=switch_to_vagos,x=967.79791259766,y=-1828.583984375,z=31.236526489258,sprite=491,color=46,markercolor={200, 200, 0, 128},name="Join Vagos",models=SKINS.VAGOS}
join_faction[17]={func=switch_to_salva,x=1230.8974609375,y=-1591.1851806641,z=53.820705413818,sprite=491,color=18,markercolor={0, 0, 200, 128},name="Join Salva",models=SKINS.SALVA}
join_faction[18]={func=switch_to_triads,x=-775.37646484375,y=-890.73687744141,z=21.605070114136,sprite=491,color=49,markercolor={200, 0, 0, 128},name="Join Triads",models=SKINS.TRIADS}
join_faction[19]={func=switch_to_armmob,x=-429.05123901367,y=-1728.0805664063,z=19.783840179443,sprite=491,color=39,markercolor={200, 0, 0, 128},name="Join Armenian Mobs",models=SKINS.MOBS}
join_faction[20]={func=switch_to_heister,x=134.90467834473,y=323.68109130859,z=116.72046661377,sprite=362,color=45,markercolor={125, 125, 125, 128},name="Join Heisters",models=SKINS.HEISTERS}
join_faction[21]={func=switch_to_cartel,x=1394.7595214844,y=1141.8107910156,z=114.61865997314,sprite=84,color=47,markercolor={125, 125, 125, 128},name="Join Cartel",models=SKINS.CARTEL}
join_faction[22]={func=switch_to_elite,x=-70.679946899414,y=359.08154296875,z=112.44521331787,sprite=432,color=4,markercolor={255, 255, 255, 128},name="Join Elite Security",models=SKINS.ELITE}
join_faction[23]={func=switch_to_paramedics,x=294.99197387695,y=-1447.7286376953,z=29.966623306274,sprite=61,color=8,markercolor={255, 200, 128, 128},name="Join Medics",models=SKINS.MEDICS,removeweapons=true}
join_faction[24]={func=switch_to_firefighters,x=199.41911315918,y=-1634.6833496094,z=29.80322265625,sprite=436,color=75,markercolor={255, 0, 0, 128},name="Join LSFD",models=SKINS.LSFD,removeweapons=true}
join_faction[25]={func=switch_to_detectives,x=452.10980224609,y=-984.57336425781,z=26.674234390259,sprite=60,color=3,markercolor={128, 128, 255, 128},name="Join Detectives",models=SKINS.DETECTIVES,removeweapons=true}

for i,f in pairs(join_faction) do
    join_faction[i].cost=gang_economy[i][2]
end

local function kick_from_faction(reason,killed_ped)
    if killed_ped==PlayerPedId() then
        reason="You killed yourself."
        SetNotificationTextEntry("STRING");
        AddTextComponentString(reason)
        DrawNotification(false, false);
    else
        Citizen.CreateThread(function()
            Wait(800)
            DecorSetBool(killed_ped,decor.teamkiller_punished,true)
        end)
        SetNotificationTextEntry("STRING");
        AddTextComponentString(reason)
        DrawNotification(false, false);
        --TriggerServerEvent(event.punishment,12,pos.x,pos.y,pos.z)
        TriggerServerEvent(event.factionban,12,pos.x,pos.y,pos.z)
        if not IsPedInAnyVehicle(PlayerPedId(),false) then
            Wait(2000)
            local animdict="combat@damage@injured_pistol@to_writhe"
            local anim="variation_b"
            if not HasAnimDictLoaded(animdict) then
             RequestAnimDict(animdict)
             while not HasAnimDictLoaded(animdict) do Wait(10) end
            end
            TaskPlayAnim(PlayerPedId(), animdict, anim, 1.0, 1.0, 10000, 0, 0, 0, 0, 0);
        end
        Wait(6250)
        SetEntityHealth(PlayerPedId(),0.0)
    end
    --DoScreenFadeOut(1000);
    switch_to_criminal()
end

-- local function cop_killed_ped(ped,how)
    -- local relgroup=GetPedRelationshipGroupHash(ped)
    -- if relgroup==1862763509 then --GetHashKey("PLAYER")
        -- if GetEntityModel(ped)==2072724299 then --FBI model
            -- kick_from_faction("~r~You "..how.." another FIB agent.")
        -- end
    -- elseif dont_kill_those[relgroup] then
        -- kick_from_faction("~r~You "..how.." "..dont_kill_those[relgroup]..".")
    -- end
-- end

-- local function gang_member_killed_ped(ped,how)
    -- local relgroup=GetPedRelationshipGroupHash(ped)
    -- if relgroup==1862763509 then --GetHashKey("PLAYER")
        -- local hash=GetEntityModel(ped)
        -- if dont_kill_those[hash] then --check model
            -- kick_from_faction("~r~You "..how.." another "..dont_kill_those[hash]..".")
        -- end
    -- elseif dont_kill_those[relgroup] then
        -- kick_from_faction("~r~You "..how.." "..dont_kill_those[relgroup]..".")
    -- end
    
    -- local hash=GetEntityModel(ped)
    -- if hash==1330042375 or hash==1032073858 or hash==850468060 then --1 2 3
        -- kick_from_faction("~r~You "..how.." another lost.")
    -- elseif relationship_friend==GetPedRelationshipGroupHash(ped) then
        -- kick_from_faction("~r~You "..how.." another lost.")
    -- end
-- end

-- local function cop_killed_ped(ped,how)
    -- local name=dont_kill_those[GetPedRelationshipGroupHash(ped)]
    -- if name then
        -- SetPedAsCop(PlayerPedId(),false)
        -- kick_from_faction("~r~You "..how.." "..name..".")
    -- else
        -- name=dont_kill_those[GetEntityModel(ped)]
        -- if name then
            -- SetPedAsCop(PlayerPedId(),false)
            -- kick_from_faction("~r~You "..how.." "..name..".")
        -- end
    -- end
-- end

local function gang_member_killed_ped(ped,how)
    local name=dont_kill_those[GetEntityModel(ped)]
    if name then
        kick_from_faction("~r~You "..how.." "..name..".",ped)
    else
        name=dont_kill_those[GetPedRelationshipGroupHash(ped)]
        if name then
            kick_from_faction("~r~You "..how.." "..name..".",ped)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped=PlayerPedId()
        local veh=GetVehiclePedIsUsing(ped)
        if veh~=nil and veh~=0 then
            if player.civilian then
                local seat=GetSeatPedIsTryingToEnter(ped)
                local another_ped=GetPedInVehicleSeat(veh,seat)
                    --print("ped in seat: "..another_ped)
                if another_ped~=0 and another_ped~=ped then
                    --can't throw anyone out of car
                    ClearPedTasks(ped)
                else
                    local model=GetEntityModel(veh)
                    local seats=GetVehicleModelNumberOfSeats(model)
                    --print("seats: "..seats)
                    local criminals=false
                    local civs=false
                    local cops=false
                    for i=-1,seats-1 do
                        another_ped=GetPedInVehicleSeat(veh,i)
                        if another_ped~=0 and ped~=another_ped and GetEntityHealth(another_ped)>0 then
                            if IsPedCop(another_ped) then
                                cops=true
                            elseif civplayermodels[GetEntityModel(another_ped)] then
                                civs=true
                            else
                                criminals=true
                            end
                        end
                    end
                    if vehiclewhitelist~=nil then
                        if seat==-1 then
                            local whitelisted=false
                            if vehiclewhitelist[model] then
                                whitelisted=true
                            end
                            if not whitelisted then
                                ClearPedTasks(ped)
                                local sit_with_cops=false
                                if cops then
                                    for i=0,seats-1 do
                                        if IsVehicleSeatFree(veh,i) then
                                            TaskEnterVehicle(ped,veh,10000,i,1.0,0,0)
                                            sit_with_cops=true
                                            SetPedAsCop(ped,true)
                                            SetNotificationTextEntry("STRING");
                                            AddTextComponentString("Can be a passenger.")
                                            DrawNotification(false, false);
                                            break
                                        end
                                    end
                                end
                                if not sit_with_cops then
                                    TaskLeaveVehicle(ped,veh,0)
                                    SetNotificationTextEntry("STRING");
                                    AddTextComponentString("You can't drive this on your own.")
                                    DrawNotification(false, false);
                                end
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You can drive only faction vehicles.")
                                DrawNotification(false, false);
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You can drive.")
                                DrawNotification(false, false);
                                SetVehicleDoorsLocked(veh, 1)
                            end
                        end
                    end
                end
            elseif player.is_cop then
                local seat=GetSeatPedIsTryingToEnter(ped)
                local another_ped=GetPedInVehicleSeat(veh,seat)
                    --print("ped in seat: "..another_ped)
                if another_ped~=0 and not IsPedCop(another_ped) then
                    --throwing criminal out of car
                    SetNotificationTextEntry("STRING");
                    AddTextComponentString("Throwing civilian/criminal out of car.")
                    DrawNotification(false, false);
                else
                    local model=GetEntityModel(veh)
                    local seats=GetVehicleModelNumberOfSeats(model)
                    --print("seats: "..seats)
                    local criminals=false
                    local civs=false
                    local cops=false
                    for i=-1,seats-1 do
                        another_ped=GetPedInVehicleSeat(veh,i)
                        if another_ped~=0 and ped~=another_ped and GetEntityHealth(another_ped)>0 then
                            if IsPedCop(another_ped) then
                                cops=true
                            elseif civplayermodels[GetEntityModel(another_ped)] then
                                civs=true
                            else
                                criminals=true
                            end
                        end
                    end
                    if criminals then
                        ClearPedTasks(ped)
                        TaskLeaveVehicle(ped,veh,0)
                        SetNotificationTextEntry("STRING")
                        AddTextComponentString("You can't get in car with criminals.")
                        DrawNotification(false, false)
                    elseif vehiclewhitelist~=nil then
                        if seat==-1 then
                            local whitelisted=false
                            if vehiclewhitelist[model] then
                                whitelisted=true
                            end
                            if not whitelisted then
                                ClearPedTasks(ped)
                                local sit_with_cops=false
                                if cops then
                                    for i=0,seats-1 do
                                        if IsVehicleSeatFree(veh,i) then
                                            TaskEnterVehicle(ped,veh,10000,i,1.0,0,0)
                                            sit_with_cops=true
                                            SetNotificationTextEntry("STRING");
                                            AddTextComponentString("Can be a passenger.")
                                            DrawNotification(false, false);
                                            break
                                        end
                                    end
                                end
                                if not sit_with_cops then
                                    TaskLeaveVehicle(ped,veh,0)
                                    SetNotificationTextEntry("STRING");
                                    AddTextComponentString("You can't drive this on your own.")
                                    DrawNotification(false, false);
                                end
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You can drive only faction vehicles.")
                                DrawNotification(false, false);
                            else
                                SetNotificationTextEntry("STRING");
                                AddTextComponentString("You can drive.")
                                DrawNotification(false, false);
                                SetVehicleDoorsLocked(veh, 1)
                            end
                        end
                    end
                end
            else --criminal
                local model=GetEntityModel(veh)
                local seats=GetVehicleModelNumberOfSeats(model)
                --local criminals=false
                local cops=false
                for i=-1,seats-1 do
                    another_ped=GetPedInVehicleSeat(veh,i)
                    if another_ped~=0 and ped~=another_ped and GetEntityHealth(another_ped)>0 then
                        if IsPedCop(another_ped) then
                            cops=true
                        --else
                        --    criminals=true
                        end
                    end
                end
                if cops then
                    DisableControlAction(0,24,false)
                    DisableControlAction(0,47,false)
                    DisableControlAction(0,58,false)
                    DisableControlAction(0,91,false)
                    DisableControlAction(0,92,false)
                    DisableControlAction(0,263,false)
                    DisableControlAction(0,264,false)
                    DisableControlAction(0,257,false)
                    DisableControlAction(0,140,false)
                    DisableControlAction(0,141,false)
                    DisableControlAction(0,142,false)
                    DisableControlAction(0,143,false)
                    DisablePlayerFiring(PlayerId(),true)
                end
            end
        end
    end
end)

RegisterNetEvent(event.join_gang)
AddEventHandler(event.join_gang,function(gang)
    local v=join_faction[gang]
    local model=v.models[math.random(#v.models)]
    if v.removeweapons then
        setpedmodel_noweapons(model)
    else
        setpedmodel(model)
    end
    set_ped_components(PlayerPedId(),v.components)
    v.func()
end)

Citizen.CreateThread(function()
    local armed_vehicle={
    [-1600252419]=true,--valkyrie
    [1543134283]=true,--valkyrie2
    [-32236122]=true,--halftrack
    [562680400]=true,--apc
    [-692292317]=true,--chernobog
    [-1860900134]=true,--insurgent pickup
    [-1924433270]=true,--insurgent pickup mk2
    [-2096818938]=true,--technical
    [1180875963]=true,--Technical2
    [1356124575]=true,--Technical3
    [1897744184]=true,--Dune3
    [-114627507]=true,--Limo2
    }
    Wait(6500)
    makeblips(join_faction)
    while true do
        Wait(0)
        local you=PlayerPedId()
        local faction=GetPedRelationshipGroupHash(you)
        if player.civilian or player.is_cop then
            local your_car=nil
            if IsPedInAnyVehicle(you) then
                local car=GetVehiclePedIsUsing(you)
                if you==GetPedInVehicleSeat(car,-1) or armed_vehicle[GetEntityModel(car)] then
                    your_car=car
                end
            end
            if your_car~=nil then
                for ped in EnumeratePeds() do
                    if not DecorExistOn(ped,decor.civilianbecamecriminal) and not DecorExistOn(ped,decor.teamkiller_punished) then
                        local killer=GetPedKiller(ped)
                        if killer==you then
                            gang_member_killed_ped(ped,"killed")
                        elseif killer==your_car then
                            gang_member_killed_ped(ped,"ran over")
                        end
                    end
                end
            else
                for ped in EnumeratePeds() do
                    if not DecorExistOn(ped,decor.civilianbecamecriminal) and not DecorExistOn(ped,decor.teamkiller_punished) then
                        local killer=GetPedKiller(ped)
                        if killer==you then
                            gang_member_killed_ped(ped,"killed")
                        end
                    end
                end
            end
        elseif faction~=1862763509 and dont_kill_those then --GetHashKey("PLAYER")
            local your_car=nil
            if IsPedInAnyVehicle(you) then
                local car=GetVehiclePedIsUsing(you)
                if you==GetPedInVehicleSeat(car,-1) or armed_vehicle[GetEntityModel(car)] then
                    your_car=car
                end
            end
            if your_car~=nil then
                for ped in EnumeratePeds() do
                    if not DecorExistOn(ped,decor.teamkiller_punished) then
                        local killer=GetPedKiller(ped)
                        if killer==you then
                            gang_member_killed_ped(ped,"killed")
                        elseif killer==your_car then
                            gang_member_killed_ped(ped,"ran over")
                        end
                    end
                end
            else
                for ped in EnumeratePeds() do
                    if not DecorExistOn(ped,decor.teamkiller_punished) then
                        local killer=GetPedKiller(ped)
                        if killer==you then
                            gang_member_killed_ped(ped,"killed")
                        end
                    end
                end
            end
        else
            pos=GetEntityCoords(PlayerPedId())
            for k,v in pairs(join_faction) do
                local square=((v.x-pos.x)*(v.x-pos.x)+(v.y-pos.y)*(v.y-pos.y)+(v.z-pos.z)*(v.z-pos.z))
                if square<100 then
                    DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.35, v.markercolor[1],v.markercolor[2],v.markercolor[3],v.markercolor[4], false, true, 2, false, false, false, false)
                    if (square<4) and (not player.is_dead) then
                        if IsControlPressed(0, 86) and player.wanted==0 and player.money and player.money>=v.cost then
                            TriggerServerEvent(event.join_gang,k)
                            Wait(1000)
                        else
                            SetTextComponentFormat("STRING")
                            AddTextComponentString("You need to have ~g~$"..v.cost.."\n~s~Press ~INPUT_VEH_HORN~ to ~g~"..v.name.."~s~.") --\nPress ~INPUT_HUD_SPECIAL~ to check your money.")
                            --SetNotificationMessage("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 9, v.name, "$"..v.cost);
                            DisplayHelpTextFromStringLabel(0,0,1,-1)
                        end
                    end
                end
            end
        end
    end
end)

local function phone_background(phone)
    DrawSprite(phone.dict,phone.sprite,.5,.5,1.0,1.0,.0,phone.bgcolor[1],phone.bgcolor[2],phone.bgcolor[3],phone.bgcolor[4])
end

local function phone_text(text,offset,phone)
    SetTextColour(255, 255, 255, 255);
    --SetTextDropshadow(3, 0, 0, 0, 255);
    --SetTextDropShadow();
    --SetTextEdge(1000, 255, 0, 0, 255);
    local maxonscreen=90
    --local maxonline=10
    local o=offset
    local new_o=o
    local part=1
    if string.len(text)>maxonscreen then
        while true do
            local nxt=string.find(text,"\n",part)
            if nxt==nil or nxt>maxonscreen then
                if part==1 then
                    text="Error:overflow"
                    break
                end
                SetTextOutline();
                SetTextFont(phone.font);
                SetTextScale(phone.scale[1], phone.scale[2]);
                SetTextEntry("STRING");
                AddTextComponentString(string.sub(text,1,part-2));
                EndTextCommandDisplayText(.05, o);
                text=string.sub(text,part)
                part=1
                o=new_o
                if string.len(text)<maxonscreen then break end
            else
                new_o=new_o+phone.cursor_step
                part=nxt+1
            end
        end
        
    end
    SetTextOutline();
    SetTextFont(phone.font);
    SetTextScale(phone.scale[1], phone.scale[2]);
    SetTextEntry("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(.05, o)
end

local function phone_print(text,phone)
    SetTextRenderId(GetMobilePhoneRenderId());
    phone_background(phone)
    phone_text(text,phone.text_offset,phone)
    SetTextRenderId(1);
end

local function phone_menu(text,func,phone)
    local half_step=phone.cursor_step*.5
    local cursor=1
    local offset=phone.text_offset
    local cursor_offset=offset-half_step
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if IsControlJustPressed(0,172) then --up
         if cursor>1 then
          cursor=cursor-1
         else
          cursor=#func
         end
        elseif IsControlJustPressed(0,173) then --down
         if cursor<#func then
          cursor=cursor+1
         else
          cursor=1
         end
        elseif IsControlJustPressed(0,176) then --select phone
         Wait(0)
         func[cursor](phone)
        end
        if cursor>phone.maxlines then
         offset=phone.text_offset-(cursor-phone.maxlines)*phone.cursor_step
         cursor_offset=phone.text_offset-half_step+phone.maxlines*phone.cursor_step
        else
         offset=phone.text_offset
         cursor_offset=offset-half_step+cursor*phone.cursor_step
        end
        SetTextRenderId(GetMobilePhoneRenderId());
        phone_background(phone)
        DrawRect(.5, cursor_offset, .9, phone.cursor_step,phone.cursor_color[1],phone.cursor_color[2],phone.cursor_color[3],phone.cursor_color[4]);
        phone_text(text,offset,phone)
        SetTextRenderId(1);
        Wait(5)
    end
end

autopilot.app=function(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        local blip=GetFirstBlipInfoId(8)
        if blip~=0 and (autopilot.blip==nil or blip~=autopilot.blip) then
            autopilot.setblip(blip)
        elseif autopilot.blip~=nil and autopilot.blip~=0 and blip==0 then
            autopilot.off()
        end
        SetTextRenderId(GetMobilePhoneRenderId());
        if blip==nil then blip="nil" end
        phone_text("Use waypoint to control autopilot.\n"..blip,phone.text_offset,phone)
        SetTextRenderId(1);
        Wait(5)
    end
    autopilot.off()
end

local hitman={
hash=nil,
mission_is_active=false,
mission_ped=nil,
mission_net=nil,
mission_trackify=false
}

local function get_random_coords()
    local x,y --x=-44.801700592041,y=-706.75598144531,z=32.727561950684
    while true do
        x=math.random(-1450,1450)
        y=math.random(-1450,1450)
        if x*x+y*y<2102500 then break end --1450*1450
        Wait(0)
    end
    x=x-44.8
    y=y-706.756
    return x,y
end

local function get_to_random_coords()
    local x,y=get_random_coords()
    local blip_test=AddBlipForCoord(x,y,50.0)
    SetBlipDisplay(blip_test, 8)
    SetBlipAsShortRange(blip_test, true)
    SetBlipColour(blip_test,3)
    SetBlipAlpha(blip_test,100)
    local blip_far=AddBlipForCoord(x,y,50.0)
    SetBlipDisplay(blip_far, 8)
    SetBlipSprite(blip_far,4)
    SetBlipAsShortRange(blip_far, false)
    local blip=AddBlipForRadius(x,y,100.0,100.0)
    SetBlipDisplay(blip, 2)
    SetBlipSprite(blip,9)
    SetBlipColour(blip,3)
    SetBlipAlpha(blip,100)
    while true do
        local pos=GetEntityCoords(PlayerPedId())
        local dx,dy=pos.x-x,pos.y-y
        if dx*dx+dy*dy<10000 then break end --100*100
        --SetBlipCoords(blip,x,y,pos.z)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("Go to target area.")
        DrawNotification(false, false)
        SetBlipColour(blip,1)
        if IsBlipOnMinimap(blip_test) then
            SetBlipDisplay(blip_far, 0)
            SetBlipColour(blip_test,1)
        else
            SetBlipDisplay(blip_far, 8)
        end
        Wait(250)
        BeginTextCommandPrint("STRING");
        AddTextComponentString("Go to target area.")
        EndTextCommandPrint(500, true);
        SetBlipColour(blip,3)
        if IsBlipOnMinimap(blip_test) then
            SetBlipDisplay(blip_far, 0)
            SetBlipColour(blip_test,3)
        else
            SetBlipDisplay(blip_far, 8)
        end
        Wait(250)
    end
    RemoveBlip(blip)
    RemoveBlip(blip_far)
    RemoveBlip(blip_test)
end

local function get_far_human_ped_2d_no_players(x,y,radius)
    radius=radius*radius
    local ret=0
    for ped in EnumeratePeds() do
        local invehicle=IsPedInAnyVehicle(ped)
        if (not IsPedAPlayer(ped))
           and
           IsPedHuman(ped)
           and
           GetEntityHealth(ped)>0
           and
           (
              (not invehicle)
              or
              (
                 IsAnyVehicleSeatEmpty(GetVehiclePedIsUsing(ped))
                 and
                 (not (IsPedInAnyPlane(ped) or IsPedInAnyHeli(ped)))
              )
           )
        then
            local pos=GetEntityCoords(ped)
            if (invehicle or pos.z>.01) and math.abs(pos.x)+math.abs(pos.y)>.01 then
                local dx,dy=pos.x-x,pos.y-y
                local r=dx*dx+dy*dy
                if r>radius then
                    radius=r
                    ret=ped
                end
            end
        end
    end
    return ret
end
hitman.mission_failed=function()
    SetModelAsNoLongerNeeded(hitman.hash)
    hitman.hash=nil
    SetNotificationTextEntry("STRING");
    AddTextComponentString("Signal lost.");
    DrawNotification(false, false);
    hitman.mission_trackify=false
    hitman.mission_ped=nil
    hitman.mission_net=nil
    hitman.mission_is_active=false
    TriggerServerEvent(event.debug,4283)
end
hitman.mission=function()
    local skins={
    "A_M_M_MexLabor_01",
    "S_M_M_AutoShop_01",
    "A_M_Y_Beach_02",
    "A_M_Y_BeachVesp_01",
    "A_M_Y_BeachVesp_02",
    "A_M_M_BevHills_01",
    "A_M_Y_BevHills_01",
    "A_M_M_BevHills_02",
    "A_M_Y_BevHills_02",
    "A_M_Y_BusiCas_01",
    "A_M_Y_Business_02",
    "A_M_Y_Business_03",
    "S_M_O_Busker_01",
    "A_M_Y_Cyclist_01",
    "S_M_Y_Dealer_01",
    "A_M_Y_Downtown_01",
    "A_M_M_EastSA_01",
    "A_M_Y_EastSA_01",
    "A_M_M_EastSA_02",
    "A_M_Y_EastSA_02",
    "U_M_M_Edtoh",
    "A_M_Y_Gay_01",
    "A_M_M_GenFat_01",
    "A_M_M_GenFat_02",
    "A_M_Y_GenStreet_01",
    "A_M_Y_GenStreet_02",
    "A_M_Y_Golfer_01",
    "S_M_Y_Grip_01",
    "A_M_Y_Indian_01",
    "A_M_M_KTown_01",
    "A_M_O_KTown_01",
    "A_M_Y_KTown_01",
    "A_M_Y_KTown_02",
    "A_M_Y_Latino_01",
    "U_M_Y_Party_01",
    "A_M_M_Polynesian_01",
    "A_M_Y_Polynesian_01",
    "S_M_Y_Robber_01",
    "A_M_Y_Runner_02",
    "A_M_M_Skater_01",
    "A_M_Y_Skater_01",
    "A_M_Y_Skater_02",
    "A_M_M_Skidrow_01",
    "A_M_M_SoCenLat_01",
    "A_M_M_SouCent_01",
    "A_M_M_SouCent_02",
    "A_M_M_SouCent_03",
    "A_M_M_SouCent_04",
    "A_M_O_SouCent_01",
    "A_M_O_SouCent_02",
    "A_M_O_SouCent_03",
    "A_M_Y_SouCent_01",
    "A_M_Y_SouCent_02",
    "A_M_Y_SouCent_03",
    "A_M_Y_SouCent_04",
    "A_M_Y_StBla_01",
    "A_M_Y_StBla_02",
    "A_M_Y_StLat_01",
    "A_M_M_StLat_02",
    "G_M_Y_StrPunk_01",
    "G_M_Y_StrPunk_02",
    "S_M_Y_StrVend_01",
    "A_M_Y_StWhi_01",
    "A_M_Y_StWhi_02",
    "A_M_Y_Sunbathe_01",
    "U_M_Y_Tattoo_01",
    "A_M_Y_VinDouche_01"
    }
    --local hash=nil
    ReserveNetworkMissionPeds(1)
    TriggerServerEvent(event.debug,4357)
    get_to_random_coords()
    TriggerServerEvent(event.debug,4359)
    hitman.hash=GetHashKey(skins[math.random(#skins)])
    RequestModel(hitman.hash)
    while not HasModelLoaded(hitman.hash) do Wait(0) end
    while true do
        local pos=GetEntityCoords(PlayerPedId())
        hitman.mission_ped=get_far_human_ped_2d_no_players(pos.x,pos.y,50.0)
        if hitman.mission_ped then
            pos=GetEntityCoords(hitman.mission_ped)
            if IsPedInAnyVehicle(hitman.mission_ped) then
                local veh=GetVehiclePedIsUsing(hitman.mission_ped)
                for i=-1,GetVehicleMaxNumberOfPassengers(veh)-1 do
                    if IsVehicleSeatFree(veh,i) then
                        hitman.mission_ped=CreatePedInsideVehicle(veh,4,hitman.hash,i,true,false)
                        if hitman.mission_ped then
                            --SetEntityAsMissionEntity(hitman.mission_ped,true,true)
                            hitman.mission_net=networkingshit(hitman.mission_ped)
                            TaskEnterVehicle(hitman.mission_ped,veh,0,i,2.0,16,0)
                            if i==-1 then
                                Wait(100)
                                TaskVehicleDriveWander(hitman.mission_ped, veh, 1.0, 786603);
                            end
                            goto spawned_target_ped
                        end
                    end
                end
            else
                hitman.mission_ped=CreatePed(4,hitman.hash,pos.x,pos.y,pos.z,0.0,true,false)
                if hitman.mission_ped then
                    --SetEntityAsMissionEntity(hitman.mission_ped,true,true)
                    hitman.mission_net=networkingshit(hitman.mission_ped)
                    TaskWanderStandard(hitman.mission_ped, 10.0, 10);
                    goto spawned_target_ped
                end
            end
        end
        Wait(1000)
    end
    ::spawned_target_ped::
    SetPedRandomComponentVariation(hitman.mission_ped, false)
    TriggerServerEvent(event.debug,4399)
            -- SetNotificationTextEntry("STRING");
            -- AddTextComponentString("ped="..hitman.mission_ped.."\nnetid="..hitman.mission_net)
            -- DrawNotification(false, false)
    hitman.mission_trackify=true
    while GetEntityHealth(hitman.mission_ped)>0 do
        SetNotificationTextEntry("STRING");
        AddTextComponentString("Signal detected. Use ~r~Hitman ~s~app on your phone to measure distance to target.");
        DrawNotification(false, false);
        BeginTextCommandPrint("STRING");
        AddTextComponentString("Use ~r~hitman app ~s~in your phone to find target.")
        EndTextCommandPrint(1000, false);
        if not hitman.mission_ped or hitman.hash~=GetEntityModel(hitman.mission_ped) then
            return hitman.mission_failed()
        end
        Wait(1000)
    end
    if not hitman.mission_ped or hitman.hash~=GetEntityModel(hitman.mission_ped) then
        return hitman.mission_failed()
    end
    TriggerServerEvent(event.debug,4419)
    SetModelAsNoLongerNeeded(hitman.hash)
    hitman.hash=nil
    hitman.mission_trackify=false
    RemovePedElegantly(hitman.mission_ped)
    Wait(4000)
    if GetPlayerWantedLevel(PlayerId())==0 then
        TriggerServerEvent(event.pay,'hitman',3000)
        TriggerServerEvent(event.debug,4426)
    else
        TriggerServerEvent(event.pay,'hitman',2000)
        TriggerServerEvent(event.debug,4428)
    end
    DeletePed(hitman.mission_ped);
    hitman.mission_ped=nil
    hitman.mission_net=nil
    hitman.mission_is_active=false
end

hitman.app=function(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if hitman.mission_trackify then
            local pos1=GetEntityCoords(hitman.mission_ped)
            local pos2=GetEntityCoords(PlayerPedId())
            local dx,dy,dz=pos1.x-pos2.x,pos1.y-pos2.y,pos1.z-pos2.z
            local text=string.format("%.1fm",math.sqrt(dx*dx+dy*dy+dz*dz))
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Distance:\n"..text,.05,phone)
            SetTextRenderId(1);
        elseif hitman.mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Scanning...",.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            hitman.mission_is_active=true;
            Citizen.CreateThread(hitman.mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local carjack={
mission_is_active=false,
mission_veh=nil,
mission_net=nil,
mission_plate=nil,
mission_trackify=false
}

local function get_far_empty_veh(x,y,radius)
    radius=radius*radius
    local plate=nil
    local ret=0
    for veh in EnumerateVehicles() do
        if GetVehicleClass(veh)<10 and not IsEntityAMissionEntity(veh) then
            local pl=GetVehicleNumberPlateText(veh)
            if pl then
                local pos=GetEntityCoords(veh)
                local dx,dy=pos.x-x,pos.y-y
                local r=dx*dx+dy*dy
                if GetPedInVehicleSeat(veh, -1)==0 then
                    r=r+r
                end
                if r>radius then
                    radius=r
                    ret=veh
                    plate=pl
                end
            end
        end
    end
    return plate,ret
end

carjack.mission=function()
    TriggerServerEvent(event.debug,4497)
    get_to_random_coords()
    TriggerServerEvent(event.debug,4499)
    while true do
        local pos=GetEntityCoords(PlayerPedId())
        carjack.mission_plate,carjack.mission_veh=get_far_empty_veh(pos.x,pos.y,100.0)
        if carjack.mission_veh then break end
        Wait(1000)
    end
    carjack.mission_net=networkingshit(carjack.mission_veh)
    carjack.mission_trackify=true
    local blip=AddBlipForCoord(-255.311,-2586.180,5.3760)
    SetBlipSprite(blip,89)
    SetBlipDisplay(blip,2)
    SetBlipScale(blip,1.0)
    SetBlipColour(blip,46)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Get carjacked vehicle here");
    EndTextCommandSetBlipName(blip)
    while GetVehicleEngineHealth(carjack.mission_veh)>1.0 do
        if carjack.mission_net~=NetworkGetNetworkIdFromEntity(carjack.mission_veh) or GetVehicleNumberPlateText(carjack.mission_veh)~=carjack.mission_plate then
            carjack.mission_trackify=false
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Losing signal! Get closer if possible.")
            DrawNotification(false, false)
            for i=1,120 do
                local new_veh=get_vehicle_from_plate(carjack.mission_plate)
                if new_veh~=nil and new_veh~=0 then
                    carjack.mission_veh=new_veh
                    carjack.mission_net=NetworkGetNetworkIdFromEntity(carjack.mission_veh)
                    carjack.mission_trackify=true
                    SetNotificationTextEntry("STRING")
                    AddTextComponentString("Found it again!")
                    -- AddTextComponentString("found\nveh="..carjack.mission_veh.."\nnetid="..carjack.mission_net.."\nv2n="..NetworkGetNetworkIdFromEntity(carjack.mission_veh).."\nn2v="..NetworkGetEntityFromNetworkId(carjack.mission_net))
                    DrawNotification(false, false)
                    break
                end
                Wait(250)
            end
            if not carjack.mission_trackify then
                abandoncar_plate(carjack.mission_plate)
                SetNotificationTextEntry("STRING");
                AddTextComponentString("Signal lost.");
                DrawNotification(false, false);
                Wait(1000)
                SetNotificationTextEntry("STRING");
                AddTextComponentString("Carjack mission over.");
                DrawNotification(false, false);
                carjack.mission_veh=nil
                carjack.mission_net=nil
                carjack.mission_plate=nil
                carjack.mission_is_active=false
                return
            end
        end
        SetNotificationTextEntry("STRING");
        AddTextComponentString("Signal detected. Use ~y~Carjack ~s~app on your phone to measure distance to vehicle.");
        DrawNotification(false, false);
        local pos=GetEntityCoords(carjack.mission_veh)
        local dx,dy,dz=pos.x+255.311,pos.y+2586.180,pos.z-5.3760
        if dx*dx+dy*dy+dz*dz<25 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Mission success.");
            DrawNotification(false, false);
            TriggerServerEvent(event.pay,'carjack',2000)                                                                                                                                                                                                                                        TriggerServerEvent(event.debug,4561)
            carjack.mission_trackify=false
            SetVehicleUndriveable(carjack.mission_veh, true);
            DeleteVehicle(carjack.mission_veh)
            carjack.mission_veh=nil
            carjack.mission_net=nil
            carjack.mission_plate=nil
            carjack.mission_is_active=false
            RemoveBlip(blip)
            return
        end
        if IsPedInAnyVehicle(PlayerPedId()) and GetVehicleNumberPlateText(GetVehiclePedIsUsing(PlayerPedId()))==carjack.mission_plate then
            BeginTextCommandPrint("STRING");
            AddTextComponentString("Get vehicle to ~y~C ~s~icon.")
            EndTextCommandPrint(1000, true);
        else
            BeginTextCommandPrint("STRING");
            AddTextComponentString("Use ~y~carjack app ~s~in your phone to find vehicle. Then get vehicle to ~y~C ~s~icon.")
            EndTextCommandPrint(1000, true);
        end
        Wait(1000)
    end
    SetNotificationTextEntry("STRING");
    AddTextComponentString("~r~Vehicle is broken.");
    DrawNotification(false, false);
    carjack.mission_trackify=false
    Wait(1000)
    DeleteVehicle(carjack.mission_veh)
    carjack.mission_veh=nil
    carjack.mission_net=nil
    carjack.mission_plate=nil
    carjack.mission_is_active=false
end

carjack.app=function(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if carjack.mission_trackify then
            local pos1=GetEntityCoords(carjack.mission_veh)
            local pos2=GetEntityCoords(PlayerPedId())
            local dx,dy,dz=pos1.x-pos2.x,pos1.y-pos2.y,pos1.z-pos2.z
            local text=math.floor(math.sqrt(dx*dx+dy*dy+dz*dz))
            text="Distance:"..text.."m\n"
            if carjack.mission_plate then text=text..carjack.mission_plate end
            local street1,street2=GetStreetNameAtCoord(pos1.x,pos1.y,pos1.z);
            text=text.."\n"..GetStreetNameFromHashKey(street1);
            text=text.."\n"..GetStreetNameFromHashKey(street2);
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text(text,.05,phone)
            SetTextRenderId(1);
        elseif carjack.mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Scanning...",.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            carjack.mission_is_active=true;
            Citizen.CreateThread(carjack.mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local pilot={
autopilot_old=false,
autopilot=false,
mission_is_active=false,
mission_state="Error"
}
pilot.mission=function()
    local runways={
        {x=-1551.138671875,y=-3122.1628417969,z=15.1}, --lsia
        {x=-2120.6645507813,y=2965.7944335938,z=34.0} --zancudo
    }
    local dest=runways[math.random(#runways)]
    local dest_ux=math.random(1,5)
    local dest_uy=math.random(1,5)
    local pos=GetEntityCoords(PlayerPedId())
    local reward={dest_ux,dest_uy}
    dest_ux=world.universe_x+dest_ux
    dest_uy=world.universe_y+dest_uy
    local blip=CreateFarBlip(dest.x,dest.y,dest.z,dest_ux,dest_uy)
    if pilot.autopilot then
        pilot.mission_state="Autopilot:on"
    else
        pilot.mission_state="Autopilot:off"
    end
    TriggerServerEvent(event.debug,4649,{pos.x,pos.y,world.universe_x,world.universe_y,dest.x,dest.y,dest_ux,dest_uy})
    Wait(100)
    while true do
        pos=GetEntityCoords(PlayerPedId())
        local tx,ty=GetFarBlipCoords(blip)
        local dx,dy=tx-pos.x,ty-pos.y
        if pilot.autopilot and not pilot.autopilot_old then
            if autopilot.setblip(blip) then
                pilot.autopilot_old=pilot.autopilot
                pilot.mission_state="Autopilot:on"
            else
                pilot.autopilot=pilot.autopilot_old
            end
        elseif pilot.autopilot_old and not pilot.autopilot then
            autopilot.off()
            pilot.autopilot_old=pilot.autopilot
            pilot.mission_state="Autopilot:off"
            --ClearPedTasks(PlayerPedId())
        else
            local dist=math.sqrt(dx*dx+dy*dy)
            local speed=GetEntitySpeed(PlayerPedId())
            if dist<300.0 and speed<1.0 then
                break
            else
                local aps
                if pilot.autopilot then
                    aps="Autopilot:on\n"
                else
                    aps="Autopilot:off\n"
                end
                aps=aps..one_decimal_digit(math.floor(dist*.01)*.1).."km\n"..math.floor(speed*3.6).."km/h\n"
                aps=aps.."Alt. "..math.floor(pos.z).."m\n"
                --(dest_ux-world.universe_x).." "..(dest_uy-world.universe_y)
                if speed>.1 then
                    local t=dist/speed
                    local s=t
                    local h=math.floor(s/3600)
                    s=s-h*3600
                    local m=math.floor(s/60)
                    s=math.floor(s-m*60)
                    aps=aps..h.."h"..m.."m"..s.."s"
                end
                pilot.mission_state=aps
            end
        end
        Wait(1000)
    end
    RemoveFarBlip(blip)
    pilot.mission_state="Success."
    TriggerServerEvent(event.pay,'pilot',math.floor(math.sqrt(reward[1]*reward[1]+reward[2]*reward[2])*2500))                                                                                                                                                                                                                                                                        TriggerServerEvent(event.debug,4696)
    ClearPedTasks(PlayerPedId())
    pilot.autopilot_old=false
    pilot.autopilot=false
    Wait(5000)
    pilot.mission_is_active=false
end
pilot.app=function(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if pilot.mission_is_active then
            if IsControlJustPressed(0,176) then
                pilot.autopilot=not pilot.autopilot
            end
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text(pilot.mission_state,.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            pilot.autopilot=false
            pilot.mission_is_active=true
            Citizen.CreateThread(pilot.mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?\nYou will need a plane.",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local trucker={
mission_is_active=false,
mission_state="Error"
}
trucker.mission=function()
    local trailers={
    -2140210194, 	--крамный контейрен
    -1207431159, 	--camouflage liquid
    -1476447243,	--empty camo
    -- -1637149482,	--campty pilit vhod v bank cherez metro
    ---399841706,	--seno
    --1019737494,	--samosval
    --356391690,	--dom s antennoi
    2078290630,	--pustaya fignya для машин
    --1784254509,	--лодка 
    2091594960,	--машины
    -1352468814,	--платформа пустая
    -1770643266,	--тв трейлер
    -730904777,	--бензин
    1956216962,	--бензин без обозначений
    2016027501,	--бревна
    -877478386,	--белый контейнер
    -1579533167,	--что-то про атом
    -2058878099	-- неизвестный контейнер
    }
    local places={
    {x=1180.5511474609,y=-3243.6540527344,z=6.0287680625916,angle=173.47682189941},	--порт
    {x=514.30084228516,y=-3028.4931640625,z=5.7183485031128,angle=91.194473266602},	--мерривезер
    {x=209.55111694336,y=-3327.1547851563,z=5.7933807373047,angle=269.31860351563},	--док
    {x=-525.61871337891,y=-2902.2983398438,z=5.6917433738708,angle=22.932670593262},	--док около аэропорт
    {x=-438.03256225586,y=-2268.783203125,z=7.2989959716797,angle=269.51089477539},	-- cnhfyysq док
    {x=-1223.6895751953,y=-2341.8015136719,z=13.636587142944,angle=328.10488891602},	-- airport
    {x=-2579.615234375,y=1929.2371826172,z=167.07209777832,angle=256.46075439453},	-- somewhere near left edge
    {x=-2529.7067871094,y=2340.224609375,z=32.750713348389,angle=213.58680725098},	-- left gas station
    {x=-2010.7397460938,y=3425.7580566406,z=30.804550170898,angle=84.078025817871},	-- zancudo
    {x=-2199.2419433594,y=4256.52734375,z=47.539615631104,angle=22.102794647217},	-- bikers
    {x=-1576.3927001953,y=5152.7412109375,z=19.627981185913,angle=190.47175598145},	-- left small dock
    {x=-577.72412109375,y=5325.7646484375,z=69.929847717285,angle=340.39096069336}	-- lumber
    }
    local source=math.random(#places)
    local dest=math.random(#places-1)
    if source==dest then source=#places end
    source=places[source]
    dest=places[dest]
    local pos=GetEntityCoords(PlayerPedId())
    TriggerServerEvent(event.debug,4770,{source.x,source.y,source.z,dest.x,dest.y,dest.z,pos.x,pos.y,pos.z})
    local blip=AddBlipForCoord(source.x,source.y,source.z);
    SetBlipSprite(blip,479)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip,2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Trailer");
    EndTextCommandSetBlipName(blip)
    trucker.mission_state="Get the trailer"
    while true do
        local pos=GetEntityCoords(PlayerPedId())
        if math.abs(pos.x-source.x)<30.0 and math.abs(pos.y-source.y)<30.0 and math.abs(pos.z-source.z)<30.0 then break end
        BeginTextCommandPrint("STRING");
        AddTextComponentString("Get the ~g~trailer~s~.")
        EndTextCommandPrint(500, true);
        Wait(500)
    end
    TriggerServerEvent(event.debug,4788)
    SetBlipCoords(blip,dest.x,dest.y,dest.z)
    SetBlipSprite(blip,79)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip,2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Leave trailer here");
    EndTextCommandSetBlipName(blip)
    local trailer=createcar(trailers[math.random(#trailers)],source.x,source.y,source.z,source.angle)
    local plate=GetVehicleNumberPlateText(trailer)
    SetEntityAsMissionEntity(trailer,true,true)
    local blip2=AddBlipForEntity(trailer)
    SetBlipSprite(blip2, 479)
    SetBlipDisplay(blip2, 2)
    SetBlipScale(blip2, 1.0)
    SetBlipColour(blip2,2)
    trucker.mission_state="Get trailer to\nthe destination"
    while true do
        local pos=GetEntityCoords(trailer)
        if math.abs(pos.x-dest.x)<30.0 and math.abs(pos.y-dest.y)<30.0 and math.abs(pos.z-dest.z)<30.0 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("Mission success.");
            DrawNotification(false, false);
            RemoveBlip(blip)
            TriggerServerEvent(event.pay,'trucker',(math.abs(source.x-dest.x)+math.abs(source.y-dest.y)+math.abs(source.z-dest.z))*2)                                                                                                                                                                                                                                               TriggerServerEvent(event.debug,4813)
            trucker.mission_state="Success"
            Wait(10000)
            DeleteVehicle(trailer)
            trucker.mission_is_active=false
            return
        else
            BeginTextCommandPrint("STRING");
            AddTextComponentString("Get ~g~trailer~s~ to the ~g~T ~s~icon.")
            EndTextCommandPrint(1000, true);
        end
        Wait(1000)
    end
end
trucker.app=function(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if trucker.mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text(trucker.mission_state,.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            trucker.mission_is_active=true;
            Citizen.CreateThread(trucker.mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?\nYou will need a truck.",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local garbage={mission_state="Error"}
garbage.truck_models={
[1917016601]=true,
[-1255698084]=true,
}
garbage.trash_models={
[1813879595]=true,--"small black trash bag",
[1388308576]=true,--"white trash bag",
[1948359883]=true,--"black trash bag",
[897494494]=true,--"white trash bag",
[600967813]=true,--"black trash bag",
[-1681329307]=true,--"triple black trash bag",
[1098827230]=true,--"black trash bag",
}
garbage.intruck=0
garbage.collected={}
garbage.blips={}
garbage.makeblip=function(x,y,z)
    local blip=AddBlipForCoord(x,y,z)
    SetBlipSprite(blip,365)
    SetBlipScale(blip,.7)
    SetBlipColour(blip,2)
    return blip
end
RegisterNetEvent(event.garbage)
AddEventHandler(event.garbage,function(collected)
    if type(collected)=="table" then
        garbage.collected=collected
    else
        garbage.collected[collected]=true
    end
end)
garbage.hash=function(x,y,z) return (math.floor(x)*127)~math.floor(y)~(math.floor(z)*1023) end
garbage.base={x=-348.16033935547,y=-1533.0646972656,z=27.707433700562}
garbage.mission=function()
    TriggerServerEvent(event.garbage)
    while true do
        Wait(0)
        local ped=PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local veh=GetVehiclePedIsUsing(ped)
            if garbage.truck_models[GetEntityModel(veh)] then
                garbage.truck=veh
                local pos=GetEntityCoords(ped)
                if math.abs(pos.x-garbage.base.x)+math.abs(pos.y-garbage.base.y)<20.0 and math.abs(pos.z-garbage.base.z)<3.0 then
                    for k,v in pairs(garbage.blips) do
                        RemoveBlip(v)
                        garbage.blips[k]=nil
                    end
                    --garbage.collected={}
                    if garbage.intruck>0 then
                        TriggerServerEvent(event.pay,"garbage",20*garbage.intruck)
                        garbage.mission_state=garbage.intruck.." collected"
                        SetNotificationTextEntry("STRING");
                        AddTextComponentString(garbage.mission_state)
                        DrawNotification(false, false);
                        garbage.intruck=0
                        Wait(2000)
                        garbage.mission_is_active=false
                        return
                    else
                        garbage.mission_state="Collect garbage bags."
                    end
                else
                    for obj in EnumerateObjects() do
                        if garbage.trash_models[GetEntityModel(obj)] then
                            local garbage_pos=GetEntityCoords(obj)
                            local garbage_hash
                            if DecorExistOn(obj,decor.garbage_bag) then
                                garbage_hash=DecorGetInt(obj,decor.garbage_bag)
                            else
                                garbage_hash=garbage.hash(garbage_pos.x,garbage_pos.y,garbage_pos.z)
                                DecorSetInt(obj,decor.garbage_bag,garbage_hash)
                            end
                            if garbage.collected[garbage_hash] then
                                SetEntityAsMissionEntity(obj,true)
                                DeleteObject(obj)
                            elseif not garbage.blips[garbage_hash] then
                                garbage.blips[garbage_hash]=garbage.makeblip(garbage_pos.x,garbage_pos.y,garbage_pos.z)
                            end
                        end
                    end
                    garbage.mission_state="Move collected garbage back to base."
                end
            end
            --garbage.mission_is_active=false
        elseif (GetEntityModel(ped)==-294281201) then
            local veh=garbage.truck
            if veh~=nil then
                if garbage.truck_models[GetEntityModel(veh)] then
                    local pos=GetEntityCoords(ped)
                    local truck_pos=GetEntityCoords(veh)
                    local dx,dy,dz=pos.x-truck_pos.x,pos.y-truck_pos.y,pos.z-truck_pos.z
                    local close_enough=(dx*dx+dy*dy+dz*dz<256.0)
                    for obj in EnumerateObjects() do
                        if garbage.trash_models[GetEntityModel(obj)] then
                            local garbage_pos=GetEntityCoords(obj)
                            local garbage_hash
                            if DecorExistOn(obj,decor.garbage_bag) then
                                garbage_hash=DecorGetInt(obj,decor.garbage_bag)
                            else
                                garbage_hash=garbage.hash(garbage_pos.x,garbage_pos.y,garbage_pos.z)
                                DecorSetInt(obj,decor.garbage_bag,garbage_hash)
                            end
                            if garbage.collected[garbage_hash] then
                                SetEntityAsMissionEntity(obj,true)
                                DeleteObject(obj)
                            else
                                if close_enough and math.abs(garbage_pos.x-pos.x)+math.abs(garbage_pos.y-pos.y)+math.abs(garbage_pos.z-pos.z)<3.0 then
                                    garbage.collected[garbage_hash]=true
                                    local blip=garbage.blips[garbage_hash]
                                    if blip then
                                        RemoveBlip(blip)
                                        garbage.blips[garbage_hash]=nil
                                    end
                                    SetEntityAsMissionEntity(obj,true)
                                    DeleteObject(obj)
                                    garbage.intruck=garbage.intruck+1
                                    TriggerServerEvent(event.garbage,garbage_hash)
                                elseif not garbage.blips[garbage_hash] then
                                    garbage.blips[garbage_hash]=garbage.makeblip(garbage_pos.x,garbage_pos.y,garbage_pos.z)
                                end
                            end
                        end
                    end
                    if close_enough then
                        garbage.mission_state=garbage.intruck.." collected."
                    else
                        garbage.mission_state="Truck is too far."
                    end
                     --removing broken blips
                    local garbage_hash=garbage.hash(pos.x,pos.y,pos.z-1.0)
                    if garbage.collected[garbage_hash] then
                       local blip=garbage.blips[garbage_hash]
                       if blip then
                           RemoveBlip(blip)
                           garbage.blips[garbage_hash]=nil
                       end
                    end
                    garbage_hash=garbage.hash(pos.x-1,pos.y,pos.z-1.0)
                    if garbage.collected[garbage_hash] then
                       local blip=garbage.blips[garbage_hash]
                       if blip then
                           RemoveBlip(blip)
                           garbage.blips[garbage_hash]=nil
                       end
                    end
                    garbage_hash=garbage.hash(pos.x+1,pos.y,pos.z-1.0)
                    if garbage.collected[garbage_hash] then
                       local blip=garbage.blips[garbage_hash]
                       if blip then
                           RemoveBlip(blip)
                           garbage.blips[garbage_hash]=nil
                       end
                    end
                    garbage_hash=garbage.hash(pos.x,pos.y-1,pos.z-1.0)
                    if garbage.collected[garbage_hash] then
                       local blip=garbage.blips[garbage_hash]
                       if blip then
                           RemoveBlip(blip)
                           garbage.blips[garbage_hash]=nil
                       end
                    end
                    garbage_hash=garbage.hash(pos.x,pos.y+1,pos.z-1.0)
                    if garbage.collected[garbage_hash] then
                       local blip=garbage.blips[garbage_hash]
                       if blip then
                           RemoveBlip(blip)
                           garbage.blips[garbage_hash]=nil
                       end
                    end
                else
                    garbage.truck=nil
                end
            else
                garbage.mission_state="You can use Waypoints app to find where you can rent the trash truck."
            end
            if garbage.base_blip~=nil then
                SetBlipRoute(garbage.base_blip,false)
                RemoveBlip(garbage.base_blip)
                garbage.base_blip=nil
            end
        else
            garbage.mission_state="Change to work clothes at base."
            if garbage.base_blip==nil then
                garbage.base_blip=AddBlipForCoord(-321.84967041016,-1545.7795410156,31.019914627075)
                SetBlipRoute(garbage.base_blip,true)
            end
        end
    end
end
garbage.app=function(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if garbage.mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text(garbage.mission_state,.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            garbage.mission_is_active=true
            Citizen.CreateThread(garbage.mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?\nYou will need a trash truck.",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local taxidriver={}
taxidriver.chat_hook=nil
taxidriver.fucked_up=false
taxidriver.agreed=false
taxidriver.hackernames={"G4057","Ghost","Cypher","Neuromancer","N3ur0m4nc3r","Flatline"}
taxidriver.greetings={"Hello,","Hey,","Hi,","Good driving,"}
taxidriver.goodwords={"nice","great","good","cool"}
taxidriver.badwords={"stupid","silly"}
taxidriver.disappointment={"I'm disappoint son.","I'm disappointed.","You are useless."}
taxidriver.score=0
taxidriver.minscore=10
taxidriver.chance=10
taxidriver.mission_state="Loading..."
taxidriver.mission_is_active=false
taxidriver.remove_blip=function()
    if taxidriver.blip~=nil then
        SetBlipRoute(taxidriver.blip, false)
        RemoveBlip(taxidriver.blip)
        taxidriver.blip=nil
    end
end
taxidriver.passenger_kill_driver_inside=function()
    local me=PlayerPedId()
    local veh=GetVehiclePedIsIn(me)
    if taxidriver.passenger~=nil and GetVehiclePedIsIn(taxidriver.passenger)==veh and GetEntityHealth(taxidriver.passenger)>0 and GetEntityHealth(me)>0 then
        --SetPedCanBeShotInVehicle(me,true)
        GiveWeaponToPed(taxidriver.passenger,GetHashKey("WEAPON_PISTOL50"),1000,false,true)
        --SetAiWeaponDamageModifier(50000.0)
        local boneindex=GetEntityBoneIndexByName(veh,'seat_dside_f')
        local targetpos=GetWorldPositionOfEntityBone(veh,boneindex)
        local killerpos=GetEntityCoords(taxidriver.passenger)
        --TaskShootAtCoord(taxidriver.passenger,targetpos.x,targetpos.y,targetpos.z,1000,GetHashKey("firing_pattern_burst_fire_driveby"))
        TaskVehicleShootAtCoord(
            taxidriver.passenger,
            (targetpos.x*2-killerpos.x),
            (targetpos.y*2-killerpos.y),
            (targetpos.z*2-killerpos.z),
            3000)
        Wait(600)
        SetEntityHealth(PlayerPedId(),0)
        Wait(1300)
        TaskWanderStandard(taxidriver.passenger,9.99,10);
        --ResetAiWeaponDamageModifier()
    end
end
taxidriver.passenger_kill_driver_driver_exiting=function()
    local me=PlayerPedId()
    if taxidriver.passenger~=nil and GetEntityHealth(taxidriver.passenger)>0 and GetEntityHealth(me)>0 then
        --SetPedCanBeShotInVehicle(me,true)
        GiveWeaponToPed(taxidriver.passenger,GetHashKey("WEAPON_PISTOL50"),1000,false,true)
        SetAiWeaponDamageModifier(50000.0)
        TaskVehicleAimAtPed(taxidriver.passenger,me)
        Wait(1000)
        for i=0,5 do
            if IsPedFatallyInjured(PlayerPedId()) then break end
            Wait(500)
        end
        ResetAiWeaponDamageModifier()
        TaskWanderStandard(taxidriver.passenger,9.99,10);
    end
end
taxidriver.failed=function(reason)
    taxidriver.mission_state=reason
    taxidriver.remove_blip()
    if taxidriver.passenger~=nil then
        RemovePedFromGroup(taxidriver.passenger)
        SetBlockingOfNonTemporaryEvents(taxidriver.passenger,false)
        taxidriver.passenger=nil
    end
    Wait(5000)
    taxidriver.mission_is_active=false
end
taxidriver.place_blip=function(x,y,z)
    if taxidriver.blip==nil then
        taxidriver.blip=AddBlipForCoord(x,y,z)
    else
        SetBlipCoords(taxidriver.blip,x,y,z)
    end
    SetBlipRoute(taxidriver.blip,true)
end
local function get_closest_human_ped_2d_no_players(x,y,radius)
    radius=radius*radius
    local ret=0
    for ped in EnumeratePeds() do
        local invehicle=IsPedInAnyVehicle(ped)
        if (not IsPedAPlayer(ped)) and IsPedHuman(ped) and GetEntityHealth(ped)>0 and not invehicle then
            local pos=GetEntityCoords(ped)
            if pos.z>.01 and math.abs(pos.x)+math.abs(pos.y)>.01 then
                local dx,dy=pos.x-x,pos.y-y
                local r=dx*dx+dy*dy
                if r<radius then
                    radius=r
                    ret=ped
                end
            end
        end
    end
    return ret
end

RegisterNetEvent('chat_bot:player')

taxidriver.mission=function()
    local x,y=get_random_coords()
    local x0,y0,reward=x,y,0
    while true do
        local me=PlayerPedId()
        if IsPedInAnyVehicle(me) then
            local playerid=PlayerId()
            local veh=GetVehiclePedIsUsing(me)
            if GetEntityModel(veh)==-956048545 then --taxicab
                taxidriver.mission_state="~y~Go to yellow area to pick up passenger."
                while math.abs(x-pos.x)+math.abs(y-pos.y)<300.0 do
                    x,y=get_random_coords()
                    Wait(0)
                end
                taxidriver.place_blip(x,y,80.0)
                while true do
                    Wait(0)
                    if GetPlayerWantedLevel(playerid)>0 then
                        taxidriver.score=0
                        return taxidriver.failed("~r~Mission failed! You've got wanted level.")
                    elseif GetVehicleEngineHealth(veh)<300 then
                        taxidriver.score=0
                        return taxidriver.failed("~r~Mission failed! You've damaged your car.")
                    elseif taxidriver.passenger==nil then
                        if math.abs(pos.x-x)+math.abs(pos.y-y)<50.0 then
                            taxidriver.passenger=get_closest_human_ped_2d_no_players(pos.x,pos.y,80.0)
                            if taxidriver.passenger==0 then
                                taxidriver.passenger=nil
                            else
                                x0,y0,taxidriver.mission_state=x,y,"~y~Pick up passenger."                                                                                                                                                                                                                                        TriggerServerEvent(event.debug,6437,{x,y})
                                x,y=get_random_coords()
                                while math.abs(x-pos.x)+math.abs(y-pos.y)<300.0 do
                                    x,y=get_random_coords()
                                    Wait(0)
                                end
                                local hash1,hash2=GetStreetNameAtCoord(x,y,80.0)
                                if hash1==hash2 or hash2==0 then
                                    taxidriver.passenger_said="~y~Take me to\n"..GetStreetNameFromHashKey(hash1).."."
                                else
                                    taxidriver.passenger_said="~y~Take me to\n"..GetStreetNameFromHashKey(hash1).." and "..GetStreetNameFromHashKey(hash2).." cross."
                                end
                            end
                        end
                    elseif GetEntityHealth(taxidriver.passenger)==0 then
                        return taxidriver.failed("~r~Mission failed! Passenger died.")
                    elseif not IsPedInAnyVehicle(taxidriver.passenger) then
                        local passenger_pos=GetEntityCoords(taxidriver.passenger)
                        taxidriver.place_blip(passenger_pos.x,passenger_pos.y,passenger_pos.z)
                        if GetVehiclePedIsUsing(taxidriver.passenger)~=veh then
                            ClearPedTasks(taxidriver.passenger)
                            if math.abs(pos.x-passenger_pos.x)+math.abs(pos.y-passenger_pos.y)<10.0 then
                                TaskEnterVehicle(taxidriver.passenger,veh,20000,2,1.0,1,0)
                            end
                            SetBlockingOfNonTemporaryEvents(taxidriver.passenger,true)
                        end
                        taxidriver.mission_state=taxidriver.passenger_said
                    elseif math.abs(pos.x-x)+math.abs(pos.y-y)<30.0 then
                        --RemovePedFromGroup(taxidriver.passenger)
                        taxidriver.score=taxidriver.score+1
                        if taxidriver.score<taxidriver.minscore or math.random(1,100)>taxidriver.chance then
                            taxidriver.mission_state="~y~Stop right here."
                            ClearPedTasks(taxidriver.passenger)
                            TaskUseNearestScenarioToCoord(taxidriver.passenger,pos.x,pos.y,pos.z,300.0,0)
                            Wait(1000)
                            while IsPedInAnyVehicle(taxidriver.passenger) do
                                TaskUseNearestScenarioToCoord(taxidriver.passenger,pos.x,pos.y,pos.z,300.0,0)
                                Wait(1000)
                            end
                            taxidriver.remove_blip()
                            Wait(1000)
                            SetBlockingOfNonTemporaryEvents(taxidriver.passenger,false)
                            x0,y0=x0-x,y0-y
                            reward=math.floor(math.sqrt(x0*x0+y0*y0)/15+10)
                            TriggerServerEvent(event.pay,'taxidriver',reward)                                                                                                                                                                                                                                        TriggerServerEvent(event.debug,6480,{x,y})
                            taxidriver.passenger=nil
                            --x,y=get_random_coords()
                            --taxidriver.place_blip(x,y,80.0)
                            --taxidriver.mission_state="~y~Go to yellow area to pick up passenger."
                            taxidriver.mission_is_active=false
                        else
                            local hackername=taxidriver.hackernames[math.random(1,#taxidriver.hackernames)]
                            local greetings=taxidriver.greetings[math.random(1,#taxidriver.greetings)]
                            local badword=taxidriver.badwords[math.random(1,#taxidriver.badwords)]
                            local goodword=taxidriver.goodwords[math.random(1,#taxidriver.goodwords)]
                            local namecolor={math.random(0,255),math.random(0,255),math.random(0,255)}
                            local steamname=GetPlayerName(PlayerId())
                            local scname=ScGetNickname()
                            local driverserverid=GetPlayerServerId(PlayerId())
                            taxidriver.agreed=false
                            taxidriver.fucked_up=false
                            taxidriver.remove_blip()
                            if taxidriver.chat_hook==nil then
                                taxidriver.chat_hook=AddEventHandler('chat_bot:player', function(id,msg)
                                    msg=string.lower(msg)
                                    if id==driverserverid then
                                        if msg=='ok' or msg=='okay' or msg=='kay' or msg=='k' or msg=='yes' or msg=='ye' or msg=='y' or msg=='fine'
                                        or msg=='sure' or msg=='sure thing' or msg=='got it' or msg=='ofc' or msg=='understood' then
                                            if not taxidriver.agreed then
                                                local approve=taxidriver.goodwords[math.random(1,#taxidriver.goodwords)]
                                                TriggerEvent("chatMessage",hackername,namecolor,approve)
                                            end
                                            taxidriver.agreed=true
                                        else
                                            taxidriver.fucked_up=true
                                        end
                                    end
                                end)
                            end
                            taxidriver.mission_state=string.format("~y~Error 0x%8X",math.random(0,0xFFFFFFFF)|math.random(0,0xFFFF))
                            if steamname~=scname then
                                TriggerEvent("chatMessage",hackername,namecolor,greetings.." "..steamname..". Or should I say "..scname.."?")
                            else
                                TriggerEvent("chatMessage",hackername,namecolor,greetings.." "..steamname..".")
                            end
                            Citizen.CreateThread(function()
                                Wait(1000)
                                TriggerEvent("chatMessage",hackername,namecolor,"Rules changed. Only you see my messages and trust me you don't want anyone else know what we are doing.")
                                Wait(3000)
                                TriggerEvent("chatMessage",hackername,namecolor,"Don't talk or type anything in chat except when I ask you to.")
                                Wait(2500)
                                TriggerEvent("chatMessage",hackername,namecolor,"Don't fucking dare doing anything "..badword..". Or you will die.")
                                Wait(2000)
                                TriggerEvent("chatMessage",hackername,namecolor,"Do what I say and everything will be "..goodword..". Understood? Type 'yes'.")
                                Wait(2000)
                                if not taxidriver.fucked_up and not taxidriver.agreed then
                                    if math.random(1,2)==1 then
                                        TriggerEvent("chatMessage",hackername,namecolor,"I'm only giving you 20 seconds to think about it.")
                                    else
                                        TriggerEvent("chatMessage",hackername,namecolor,"20 seconds to comply.")
                                    end
                                    Wait(5000)
                                end
                                if not taxidriver.fucked_up and not taxidriver.agreed then
                                    if math.random(1,2)==1 then
                                        TriggerEvent("chatMessage",hackername,namecolor,"You now have 15 seconds to comply.")
                                    else
                                        TriggerEvent("chatMessage",hackername,namecolor,"15 seconds to comply.")
                                    end
                                    Wait(5000)
                                end
                                if not taxidriver.fucked_up and not taxidriver.agreed then
                                    TriggerEvent("chatMessage",hackername,namecolor,"10 seconds to comply.")
                                    Wait(10000)
                                end
                                if not taxidriver.fucked_up and not taxidriver.agreed then
                                    TriggerEvent("chatMessage",hackername,namecolor,"5 seconds to comply.")
                                    Wait(5000)
                                end
                                if not taxidriver.fucked_up and not taxidriver.agreed then
                                    TriggerEvent("chatMessage",hackername,namecolor,"Time is up.")
                                    Wait(1000)
                                    if not taxidriver.agreed then
                                        taxidriver.fucked_up=true
                                    end
                                end
                                Wait(5000)
                                if not taxidriver.fucked_up then
                                    TriggerEvent("chatMessage",hackername,namecolor,"Don't draw any attention, drive normally, not too fast, stop at red light.")
                                    Wait(5000)
                                end
                                if not taxidriver.fucked_up then
                                    TriggerEvent("chatMessage",hackername,namecolor,"Don't tell anyone about me.")
                                    Wait(5000)
                                end
                                while not taxidriver.fucked_up do
                                    local me=PlayerId()
                                    local pos=GetEntityCoords(PlayerPedId())
                                    local closest_pos
                                    local closest=me
                                    local square_distance=1000000.0
                                    local min_radius=50.0
                                    local square_min_radius=min_radius*min_radius
                                    local in_min_radius=0
                                    for i=me-1,0,-1 do
                                        if NetworkIsPlayerActive(i) then
                                            local target_pos=GetEntityCoords(GetPlayerPed(i))
                                            local dx,dy,dz=pos.x-target_pos.x,pos.y-target_pos.y,pos.z-target_pos.z
                                            local dist=dx*dx+dy*dy+dz*dz
                                            if dist>4.0 then
                                                if dist<square_distance then
                                                    square_distance=dist
                                                    closest_pos=target_pos
                                                    closest=i
                                                end
                                                if dist<square_min_radius then
                                                    in_min_radius=in_min_radius+1
                                                end
                                            end
                                        end
                                    end
                                    for i=me+1,31 do
                                        if NetworkIsPlayerActive(i) then
                                            local target_pos=GetEntityCoords(GetPlayerPed(i))
                                            local dx,dy,dz=pos.x-target_pos.x,pos.y-target_pos.y,pos.z-target_pos.z
                                            local dist=dx*dx+dy*dy+dz*dz
                                            if dist>4.0 then
                                                if dist<square_distance then
                                                    square_distance=dist
                                                    closest_pos=target_pos
                                                    closest=i
                                                end
                                                if dist<square_min_radius then
                                                    in_min_radius=in_min_radius+1
                                                end
                                            end
                                        end
                                    end
                                    
                                    if in_min_radius>1 then
                                        if in_min_radius~=taxidriver.players_in_min_radius then
                                            TriggerEvent("chatMessage",hackername,namecolor,"There are "..in_min_radius.." people in "..min_radius.." meter radius around us.")
                                            taxidriver.players_in_min_radius=in_min_radius
                                        end
                                    elseif closest~=me then
                                        local distance=(math.floor((math.sqrt(square_distance)+5)/10)*10)
                                        if taxidriver.closest_player_dist~=distance then
                                            TriggerEvent("chatMessage",hackername,namecolor,"Closest player is "..distance.." meters from us.")
                                            taxidriver.closest_player_dist=distance
                                        end
                                        --if target"To the "....". "...." meters "..math.abs("higher." or "lower."))
                                    end
                                    Wait(10000)
                                end
                            end)
                            while true do
                                if me~=PlayerPedId() then
                                    taxidriver.fucked_up=true
                                    TaskWanderStandard(taxidriver.passenger,9.99,10)
                                    print("player ped changed(death?)")
                                    break
                                elseif taxidriver.fucked_up then
                                    local disappointment=taxidriver.disappointment[math.random(1,#taxidriver.disappointment)]
                                    TriggerEvent("chatMessage",hackername,namecolor,disappointment)
                                    taxidriver.passenger_kill_driver_inside()
                                    break
                                elseif GetVehiclePedIsIn(me)~=veh then
                                    taxidriver.fucked_up=true
                                    taxidriver.passenger_kill_driver_driver_exiting()
                                    break
                                elseif GetVehicleEngineHealth(veh)<300 then
                                    taxidriver.fucked_up=true
                                    TaskWanderStandard(taxidriver.passenger,9.99,10)
                                    print("vehicle damaged")
                                    break
                                elseif GetEntityHealth(taxidriver.passenger)==0 then
                                    taxidriver.fucked_up=true
                                    print("???? died")
                                    break
                                else
                                    
                                end
                                Wait(0)
                            end
                            if taxidriver.chat_hook~=nil then
                                RemoveEventHandler(taxidriver.chat_hook)
                                taxidriver.chat_hook=nil
                            end
                            Wait(10000)
                            taxidriver.mission_is_active=false
                        end
                        return
                    else
                        taxidriver.place_blip(x,y,80.0)
                        taxidriver.mission_state=taxidriver.passenger_said
                    end
                end
            else
                taxidriver.mission_state="~y~Go to yellow blip and get taxicab."
                taxidriver.place_blip(887.78521728516,-182.7448425293,73.222465515137)
                while not IsPedInAnyVehicle(PlayerPedId()) or GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))~=-956048545 do --taxicab
                    Wait(1000)
                end
            end
        else
            taxidriver.mission_state="~y~Go to yellow blip and get taxicab."
            taxidriver.place_blip(887.78521728516,-182.7448425293,73.222465515137)
            while not IsPedInAnyVehicle(PlayerPedId()) or GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))~=-956048545 do --taxicab
                Wait(1000)
            end
        end
        Wait(1000)
    end
end
taxidriver.app=function(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if taxidriver.mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text(taxidriver.mission_state,.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            taxidriver.mission_is_active=true;
            Citizen.CreateThread(taxidriver.mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?\nYou will need a taxicab.",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local patrol={action=0,mission_state="Loading..."}
local function get_far_criminal_2d_no_players(x,y,radius)
    radius=radius*radius
    local farest=1
    local ret=0
    for ped in EnumeratePeds() do
        --local invehicle=IsPedInAnyVehicle(ped)
        if (not IsPedAPlayer(ped)) and IsPedHuman(ped) and GetEntityHealth(ped)>0 and allies_government[GetEntityModel(ped)]==nil then
            local pos=GetEntityCoords(ped)
            if pos.z>.01 and math.abs(pos.x)+math.abs(pos.y)>.01 then
                local dx,dy=pos.x-x,pos.y-y
                local r=dx*dx+dy*dy
                if r<radius and r>farest then
                    farest=r
                    ret=ped
                end
            end
        end
    end
    return ret
end
patrol.randgun={WEAPON.SNSPISTOL,WEAPON.VINTAGEPISTOL,WEAPON.COMBAT,WEAPON.PISTOL,WEAPON.PISTOL50,WEAPON.MICROSMG,WEAPON.SNIPERRIFLE,
    WEAPON.PUMPSHOTGUN,WEAPON.MACHINEPISTOL,WEAPON.MUSKET,WEAPON.GUSENBERG,WEAPON.SAWNOFFSHOTGUN,WEAPON.MARKSMANRIFLE,WEAPON.MARKSMANPISTOL,
    WEAPON.HEAVYPISTOL,WEAPON.HEAVYSHOTGUN,WEAPON.REVOLVER}
patrol.mission=function()
    local prisoner=GetHashKey("PRISONER")
    patrol.action=0
    patrol.timestamp=GetGameTimer()
    patrol.mission_state="~b~Patrol the streets."
    while true do
        Wait(1000)
        patrol.action=math.random(1,8)
        if patrol.action~=1 then
            --patrol.mission_state="~b~Patrol the streets."
            Wait(1000)
        else
            --patrol.mission_state="~r~Eliminate the criminals."
            patrol.criminal=get_far_criminal_2d_no_players(pos.x,pos.y,35)
            while patrol.criminal==0 do
                Wait(0)
                patrol.criminal=get_far_criminal_2d_no_players(pos.x,pos.y,35)
            end
            if allies_government[GetPedRelationshipGroupHash(patrol.criminal)]~=nil then
                SetPedRelationshipGroupHash(patrol.criminal,prisoner)
                DecorSetBool(patrol.criminal,decor.civilianbecamecriminal,true)
            end
            GiveWeaponToPed(patrol.criminal, patrol.randgun[math.random(#patrol.randgun)], 1000, false, true)
            --patrol.blip_criminal=AddBlipForEntity(patrol.criminal)
            --SetBlipColour(patrol.blip_criminal,1)
            --SetBlipScale(patrol.blip_criminal,0.5)
            --patrol.victim=GetRandomPedAtCoord(pos.x,pos.y,pos.z,100.0,100.0,30.0,4)
            local criminal_pos=GetEntityCoords(patrol.criminal)
            patrol.victim=get_closest_human_ped_2d_no_players(criminal_pos.x,criminal_pos.y,50)
            while patrol.criminal==patrol.victim do
                Wait(100)
                patrol.victim=GetRandomPedAtCoord(pos.x,pos.y,pos.z,100.0,100.0,30.0,4)
            end
            TaskCombatPed(patrol.criminal,patrol.victim,0,16)
            --while GetEntityHealth(patrol.criminal)>0 do
            --    Wait(0)
            --end
            -- if GetEntityHealth(patrol.victim)>0 then
                -- patrol.mission_state="~g~Criminal is dead, victim saved."
                -- Wait(5000)
                -- patrol.mission_is_active=false
                -- return
            -- else
                -- patrol.mission_state="~y~Criminal is dead."
                -- Wait(5000)
                -- patrol.mission_is_active=false
                -- return
            -- end
        end
        local criminals=0
        local frags=0
        for ped in EnumeratePeds() do
            if not IsPedAPlayer(ped) and GetPedRelationshipGroupHash(ped)==prisoner and not IsEntityAMissionEntity(ped) then
                criminals=criminals+1
                if GetEntityHealth(ped)==0 then
                    frags=frags+1
                end
            end
        end
        local timestamp=GetGameTimer()
        if math.abs(timestamp-patrol.timestamp)>60000 then
            patrol.timestamp=timestamp
            TriggerServerEvent(event.pay,'patrol',math.random(1,2)*200+100)                                                                                                                                                                                                        TriggerServerEvent(event.debug,6602,{pos.x,pos.y,pos.z,criminals,frags})
        end
        --patrol.mission_state=frags.."/"..criminals.." criminals dead"
        if not (player.civilian or player.is_cop) then
            patrol.mission_is_active=false
            return
        end
    end
end

Citizen.CreateThread(function()
    local prisoner=GetHashKey("PRISONER")
    local cop=GetHashKey("COP")
    while true do
        Wait(0)
        if player.civilian or player.is_cop then
            for ped in EnumeratePeds() do
                if not IsPedAPlayer(ped) then
                    --if IsPedShooting(ped) and allies_government[GetEntityModel(ped)]==nil and allies_government[GetPedRelationshipGroupHash(ped)]~=nil then
                    local weapon=GetSelectedPedWeapon(ped)
                    local relationship=GetPedRelationshipGroupHash(ped)
                    if weapon~=0 and weapon~=-1 and weapon~=966099553 and weapon~=WEAPON.UNARMED and allies_government[relationship]~=nil then
                        if allies_government[GetEntityModel(ped)]==nil then
                            if relationship~=prisoner then
                                SetPedRelationshipGroupHash(ped,prisoner)
                            end
                            DecorSetBool(patrol.criminal,decor.civilianbecamecriminal,true)
                        elseif relationship~=cop then
                            SetPedRelationshipGroupHash(ped,cop)
                        end
                        --print(weapon)
                    end
                end
            end
        end
    end
end)

patrol.app=function(phone)
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if patrol.mission_is_active then
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text(patrol.mission_state,.05,phone)
            SetTextRenderId(1);
        elseif IsControlJustPressed(0,176) then
            patrol.mission_is_active=true;
            Citizen.CreateThread(patrol.mission)
        else
            SetTextRenderId(GetMobilePhoneRenderId());
            phone_text("Start mission?",.05,phone)
            SetTextRenderId(1);
        end
        Wait(0)
    end
end

local current_waypoint=nil

local function show_way_to_blip(phone,blips)
    local names=""
    local filtered={}
    local functions={}
    local i=0
    local wantcolors={[0]=4,[1]=2,[2]=2,[3]=46,[4]=51,[5]=1}
    for k,v in pairs(blips) do
        if money_drops[k] then
            local name=money_drops[k].name
            if name then
                if string.sub(name,1,6)=="Steal " then
                    name=string.upper(string.sub(name,7,7))..string.sub(name,8)
                elseif string.sub(name,-5)==" loot" then
                    name=string.sub(name,1,-6)
                end
                if filtered[name] then
                    local x1,y1,z1=pos.x-filtered[name].x,pos.y-filtered[name].y,pos.z-filtered[name].z
                    local x2,y2,z2=pos.x-money_drops[k].x,pos.y-money_drops[k].y,pos.z-money_drops[k].z
                    if x2*x2+y2*y2+z2*z2<x1*x1+y1*y1+z1*z1 then
                        filtered[name].blip=v
                        filtered[name].x=money_drops[k].x
                        filtered[name].y=money_drops[k].y
                        filtered[name].z=money_drops[k].z
                        filtered[name].color=wantcolors[money_drops[k].wanted]
                    end
                else
                    filtered[name]={}
                    filtered[name].blip=v
                    filtered[name].x=money_drops[k].x
                    filtered[name].y=money_drops[k].y
                    filtered[name].z=money_drops[k].z
                    filtered[name].color=wantcolors[money_drops[k].wanted]
                end
            end
        end
    end
    for k,v in pairs(filtered) do
        if v.blip then
            i=i+1
            names=names..k.."\n"
            local blip=v.blip
            local color=v.color
            functions[i]=function(phone)
                if current_waypoint==blip then
                    current_waypoint={}
                    current_waypoint=nil
                    SetBlipRoute(blip, false)
                else
                    current_waypoint=blip
                    SetBlipRoute(blip, true)
                    SetBlipRouteColour(blip, color)
                end
            end
        end
    end
    if i>0 then
        phone_menu(names,functions,phone)
    end
    -- local state=false
    -- while not IsControlJustPressed(0,177) and not hide_phone_now do
        -- if IsControlJustPressed(0,176) then
            -- state=not state
            -- if state then
                -- for k,v in pairs(blips) do
                    -- if GetBlipSprite(v)~=406 then
                        -- SetBlipRoute(v, true)
                        -- SetBlipRouteColour(v, GetBlipColour(v))
                    -- end
                -- end
            -- else
                -- for k,v in pairs(blips) do
                    -- SetBlipRoute(v, false)
                -- end
            -- end
        -- end
        -- if state then
            -- phone_print("Turn off\nwaypoints",phone)
        -- else
            -- phone_print("Turn on\nwaypoints",phone)
        -- end
        -- Wait(0)
    -- end
end

local function show_way_to(phone,blips)
    local names=""
    local filtered={}
    local functions={}
    local pos=GetEntityCoords(PlayerPedId())
    local i=0
    for k,v in pairs(blips) do
        local name=v.name
        if name then
            if string.sub(name,1,5)=="Join " then
                name=string.sub(name,6)
            elseif string.sub(name,-5)==" shop" then
                name=string.sub(name,1,-6)
            end
            if filtered[name] then
                local x1,y1,z1=pos.x-filtered[name].x,pos.y-filtered[name].y,pos.z-filtered[name].z
                local x2,y2,z2=pos.x-v.x,pos.y-v.y,pos.z-v.z
                if x2*x2+y2*y2+z2*z2<x1*x1+y1*y1+z1*z1 then
                    filtered[name]=v
                end
            else
                filtered[name]=v
            end
        end
    end
    for k,v in pairs(filtered) do
        if v.blip then
            i=i+1
            names=names..k.."\n"
            local blip=v.blip
            local color=v.color
            functions[i]=function(phone)
                if current_waypoint==blip then
                    current_waypoint={}
                    current_waypoint=nil
                    SetBlipRoute(blip, false)
                else
                    current_waypoint=blip
                    SetBlipRoute(blip, true)
                    SetBlipRouteColour(blip, color)
                end
            end
        end
    end
    if i>0 then
        phone_menu(names,functions,phone)
    end
    -- local state=false
    -- while not IsControlJustPressed(0,177) and not hide_phone_now do
        -- if IsControlJustPressed(0,176) then
            -- state=not state
            -- if state then
                -- for k,v in pairs(blips) do
                    -- if v.sprite~=406 then
                        -- SetBlipRoute(v.blip, true)
                        -- SetBlipRouteColour(v.blip, v.color)
                    -- end
                -- end
            -- else
                -- for k,v in pairs(blips) do
                    -- SetBlipRoute(v.blip, false)
                -- end
            -- end
        -- end
        -- if state then
            -- phone_print("Turn off\nwaypoints",phone)
        -- else
            -- phone_print("Turn on\nwaypoints",phone)
        -- end
        -- Wait(0)
    -- end
end

local function toggle_blips(phone,blips)
    local state=false
    while not IsControlJustPressed(0,177) and not hide_phone_now do
        if IsControlJustPressed(0,176) then
            state=not state
            if state then
                showblips(blips)
            else
                hideblips(blips)
            end
        end
        if state then
            phone_print("Turn off\nblips",phone)
        else
            phone_print("Turn on\nblips",phone)
        end
        Wait(0)
    end
end

local tetris={}
tetris.check=function(fig,x,y,all)
 if all[x][y] then return false end
 for i=1,3 do
  if all[fig[i][1]+x][fig[i][2]+y] then return false end
 end
 return true
end
tetris.init=function (maxx,maxy)
     local all={}
     all[-1]={}
     all[0]={}
     for i=1,maxx do
      all[i]={}
      for j=-3,maxy do
       all[i][j]=false
      end
      all[i][maxy+1]=true
     end
     all[maxx+1]={}
     all[maxx+2]={}
     for i=-4,maxy do
      all[0][i+1]=true
      --all[-1][i+1]=true
      all[maxx+1][i+1]=true
      --all[maxx+2][i+1]=true
     end
     return all
end
tetris.game=function(phone)
    local maxx=30
    local maxy=40
    local mx=1.0/maxx
    local my=1.0/maxy
    local figs={{{0,1},{0,2},{0,-1}},
                {{0,1},{1,1},{-1,0}},
                {{0,1},{1,1},{-1,0}},
                {{1,0},{0,1},{-1,1}},
                {{0,1},{1,1},{ 1,0}},
                {{0,1},{0,2},{ 1,2}},
                {{0,1},{0,2},{-1,2}}}
    local x=15
    local y=0
    local timer=0
    local timestamp=GetGameTimer()
    local color={0,0,127}
    if not tetris.all then
     tetris.all=tetris.init(maxx,maxy)
    end
    if not tetris.figure then
     tetris.figure=figs[math.random(#figs)]
    end
    while not IsControlPressed(0,177) and not hide_phone_now do
        if IsControlPressed(0,172) and timer>4 then --up
         local new={{tetris.figure[1][2],-tetris.figure[1][1]},
                    {tetris.figure[2][2],-tetris.figure[2][1]},
                    {tetris.figure[3][2],-tetris.figure[3][1]}}
         if tetris.check(new,x,y,tetris.all) then tetris.figure=new end
         timer=1
        elseif IsControlPressed(0,174) then --left
         if tetris.check(tetris.figure,x-1,y,tetris.all) then x=x-1 end
        elseif IsControlPressed(0,175) then --right
         if tetris.check(tetris.figure,x+1,y,tetris.all) then x=x+1 end
        end
        if IsControlPressed(0,173) then --down
         timer=8
        end
         for i=1,3 do
          SetTextRenderId(GetMobilePhoneRenderId());
          for j=1,maxx do
           for k=1,maxy do
            if tetris.all[j][k] then
             DrawRect((j-.5)*mx,(k-.5)*my,mx,my,128+color[1],128+color[2],128+color[3],255)
            end
           end
          end
          DrawRect((x-.5)*mx,(y-.8+.05*timer)*my,mx,my,color[1]+color[1],color[2]+color[2],color[3]+color[3],255)
          for i=1,3 do
           DrawRect((tetris.figure[i][1]+x-.5)*mx,(tetris.figure[i][2]+y-.8+.05*timer)*my,mx,my,color[1]+color[1],color[2]+color[2],color[3]+color[3],255)
          end
          SetTextRenderId(1);
            if color[1]==0 and color[3]<127 then
            color[2],color[3]=color[2]-1,color[3]+1
            elseif color[2]==0 and color[1]<127 then
            color[3],color[1]=color[3]-1,color[1]+1
            elseif color[3]==0 and color[2]<127 then
            color[1],color[2]=color[1]-1,color[2]+1
            end
          Wait(0)
         end
        if timer==8 then
         if tetris.check(tetris.figure,x,y+1,tetris.all) then
          y=y+1
         else 
          tetris.all[x][y]=true
          for i=1,3 do
           tetris.all[tetris.figure[i][1]+x][tetris.figure[i][2]+y]=true
          end
          local dropped=false
          for j=maxy,1,-1 do
           while true do
            local full=true
            for i=maxx,1,-1 do
             if not tetris.all[i][j] then full=false end
            end
            if full then
             for i=maxx,1,-1 do
              for k=j,1,-1 do
               tetris.all[i][k]=tetris.all[i][k-1]
              end
             end
             dropped=true
            else
             break
            end
           end
          end
          if y<1 and not dropped then tetris.all=tetris.init(maxx,maxy) end
          tetris.figure=figs[math.random(#figs)]
          x=15
          y=0
         end
         timer=0
        elseif GetGameTimer()-timestamp>10 then
         timer=timer+1
         timestamp=GetGameTimer()
        end
    end
end
local partyhelp_app=function(phone)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~g~/party NUMBER ~s~- create/join party.")
        DrawNotification(false, false);
        Wait(0)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~g~/partycolor green ~s~- change color to green. (or /partyc 2)")
        DrawNotification(false, false);
        Wait(0)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~b~/partyshowself ~s~- toggle show self. (or /partyss)")
        DrawNotification(false, false);
        Wait(0)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~b~/partyshowselfface ~s~- toggle show own face. (or /partysf)")
        DrawNotification(false, false);
        Wait(5000)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~g~/party NUMBER ~s~- create/join party.")
        DrawNotification(false, false);
        Wait(0)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~g~/partycolor green ~s~- change color to green. (or /partyc 2)")
        DrawNotification(false, false);
        Wait(0)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~b~/partyshowself ~s~- toggle show self. (or /partyss)")
        DrawNotification(false, false);
        Wait(0)
        SetNotificationTextEntry("STRING");
        AddTextComponentString("~b~/partyshowselfface ~s~- toggle show own face. (or /partysf)")
        DrawNotification(false, false);
end
gangwar.app=function(phone)
    -- SetTextColour(255, 255, 255, 255);
    -- SetTextOutline();
    -- SetTextFont(phone.font);
                -- SetTextScale(phone.scale[1], phone.scale[2]);
                -- SetTextEntry("STRING");
                -- AddTextComponentString("Lost M.C.:");
                -- EndTextCommandDisplayText(.05, offset);
    local scroll=.0
    TriggerServerEvent(event.gangwarscore)
    while not IsControlPressed(0,177) and not hide_phone_now do
        if IsControlPressed(0,173) then --down
            if scroll>1.0-13.0*phone.cursor_step then
                scroll=scroll-.02
            end
        elseif IsControlPressed(0,172) then --up
            if scroll<.0 then
                scroll=scroll+.02
            end
        end
        local unsorted=false
        local prev=nil
        local offset=scroll
        SetTextRenderId(GetMobilePhoneRenderId());
        phone_background(phone)
        for i=1,13 do
            local v=gangwar.top[gangwar.sort[i]]
            local score=v.score
            if prev and score>prev then unsorted=true end prev=score
            SetTextColour(v.color[1], v.color[2], v.color[3], 255);
            SetTextOutline();
            SetTextFont(phone.font);
            SetTextScale(phone.scale[1], phone.scale[2]);
            SetTextEntry("STRING");
            AddTextComponentString(i..". "..v.name);
            EndTextCommandDisplayText(.05, offset);
            
            SetTextJustification(2) --right
            SetTextOutline();
            SetTextFont(phone.font);
            SetTextScale(phone.scale[1], phone.scale[2]);
            if score>1000000 then
                SetTextEntry("STRING")
                AddTextComponentString(math.floor(score/1000000).."M")
            elseif score>1000 then
                SetTextEntry("STRING")
                AddTextComponentString(math.floor(score/1000).."K")
            else
                SetTextEntry("NUMBER");
                AddTextComponentInteger(score)
            end
            EndTextCommandDisplayText(.05, offset);
            offset=offset+phone.cursor_step
        end
        --SetTextJustification(1) --left
        SetTextRenderId(1);
        if unsorted then
            table.sort(gangwar.sort,function(a,b)return gangwar.top[a].score>gangwar.top[b].score end)
        end
        Wait(5)
    end
end

local randommission={
 state="Loading...",
 missions={
  --movevehicle, 6000
  --bringweapons, 
  --destroyvehicle, 5000
  --bringvehicle, 
  --bringcase, 7000
  -- protectarea,
  -- protectped,
  -- repaircar,
  -- setplaceonfire,
  --escortped, 8000
 },
 spawnvehicles={
 -1372848492,904750859,-1050465301,1747439474,
 -344943009,1039032026,1549126457,-1130810103,-1177863319,-431692672,-1450650718,841808271,
 1830407356,1078682497,-2124201592,330661258,-5153954,-591610296,-89291282,1349725314,873639469,-1122289213,-1193103848,2016857647,
 970598228,-391594584,-624529134,1348744438,-511601230,-1930048799,-1809822327,-1903012613,906642318,-2030171296,-685276541,1909141499,75131841,-1289722222,886934177,-1883869285,-1150599089,-1477580979,1723137093,-1894894188,-1008861746,1373123368,1777363799,-310465116,-1255452397,970598228,
 464687292,1531094468,-1205801634,-682211828,349605904,80636076,723973206,-2119578145,-1800170043,-1943285540,-2095439403,1507916787,-227741703,-1685021548,1923400478,972671128,-825837129,-498054846,2006667053,
 914654722,1645267888,-2045594037,-1189015600,989381445,850565707,-808831384,142944341,1878062887,634118882,2006918058,-789894171,683047626,1177543287,-1137532101,-1775728740,-1543762099,884422927,486987393,1269098716,-808457413,-1651067813,2136773105,1221512915,1337041428,1203490606,-16948145,1069929536,
 -1346687836,1162065741,-119658072,-810318068,65402552,1026149675,
 -2033222435,-667151410,523724515,-1435919434,1770332643,-1207771834,-1883002148,-14495224,1762279763,-120287622,-1311240698,
 -1622444098,1123216662,767087018,-1041692462,1274868363,736902334,2072687711,-1045541610,108773431,196747873,-566387422,-1995326987,-1089039904,499169875,-1297672541,544021352,-1372848492,482197771,-142942670,-1461482751,-777172681,-377465520,-1934452204,1737773231,1032823388,719660200,-746882698,-1757836725,1886268224,384071873,-295689028,
 -982130927,-1566741232,-1405937764,1887331236,941800958,223240013,1011753235,784565758,1051415893,-1660945322,-433375717,1545842587,-2098947590,1504306544,
 -1216765807,-1696146015,-1311154784,-1291952903,1426219628,1234311532,418536135,-1232836011,1034187331,1093792632,1987142870,-1758137366,-1829802492,2123327359,234062309,819197656,1663218586,272929391,408192225,2067820283,338562499,1939284556,-1403128555,-2048333973,-482719877,917809321,
 627535535,-757735410,1672195559,-2140431165,86520421,1753414259,627535535,640818791,-1523428744,-634879114,-909201658,-893578776,-1453280962,788045382,1836027715,-140902153,-1353081087,
 237764926,-1106353882,-631760477,-591651781,-915704871,349315417,-401643538,
 -891462355,-114291515,11251904,-1670998136,1265391242,
 101905590,-663299102,
 -1479664699,
 },
 peds={
 810804565, --mexthug
 1226102803, --mexboss2
 1466037421, --mexboss1
 1768677545, --methhead
 355916122, --ktown
 -782401935, --ktown
 452351020,
 696250687,
 -1395868234,
 -422822692,
 -1047300121,
 
 },
 vips={
 -680474188, --agent cutscene
 },
 weapons={
 WEAPON.PISTOL,
 WEAPON.COMBATPISTOL,
 WEAPON.SNSPISTOL,
 WEAPON.VINTAGEPISTOL,
 WEAPON.PISTOLMK2,
 WEAPON.PISTOL50,
 WEAPON.HEAVYPISTOL,
 WEAPON.APPISTOL,
 WEAPON.MUSKET,
 WEAPON.DBSHOTGUN,
 WEAPON.REVOLVER,
 WEAPON.ASSAULTRIFLE,
 WEAPON.CARBINERIFLE,
 WEAPON.PUMPSHOTGUN,
 WEAPON.SAWNOFFSHOTGUN,
 WEAPON.SNIPERRIFLE,
 WEAPON.MICROSMG,
 WEAPON.MINISMG,
 WEAPON.COMPACTRIFLE,
 WEAPON.MACHINEPISTOL,
 },
 needweapons=needweapons,
 needvehicles=needvehicles,
 bases={
  { -- near molotovs near vagos
   x=217.90853881836,y=-2001.2611083984,z=19.570650100708,r=80,
   pedspawns={
   {x=189.11433410645,y=-2019.1674804688,z=18.287298202515,angle=270.18502807617},
   {x=190.99380493164,y=-2016.1768798828,z=18.302564620972,angle=264.0950012207},
   {x=220.9821472168 ,y=-2032.9807128906,z=18.169111251831,angle=233.92999267578},
   {x=224.76454162598,y=-2036.1956787109,z=18.176797866821,angle=55.742874145508},
   {x=200.09774780273,y=-2002.3020019531,z=18.861577987671,angle=239.95846557617},
   {x=210.09632873535,y=-1989.6256103516,z=19.716470718384,angle=151.74798583984},
   },
   vehspawn={x=220.33895874023,y=-1994.0046386719,z=19.298191070557,angle=221.73561096191},
   vehdelivery={x=229.80065917969,y=-1991.9798583984,z=19.256690979004,angle=139.69387817383},
  },
  { --near combat pistol micro smg
   x=454.57501220703,y=-1559.6976318359,z=29.282598495483,r=140,
   pedspawns={
   {x=430.4462890625,y=-1559.2930908203,z=32.792266845703,angle=325.25308227539},
   {x=436.29879760742,y=-1564.3244628906,z=32.792324066162,angle=332.42233276367},
   {x=442.43829345703,y=-1569.4415283203,z=32.792285919189,angle=323.98724365234},
   {x=455.14581298828,y=-1580.0264892578,z=32.792064666748,angle=327.19702148438},
   {x=461.37353515625,y=-1585.2528076172,z=32.792053222656,angle=325.9680480957},
   {x=467.24981689453,y=-1590.1715087891,z=32.792251586914,angle=334.10736083984},
   {x=451.54156494141,y=-1569.4566650391,z=29.283004760742,angle=142.26695251465},
   {x=444.78713989258,y=-1575.9266357422,z=29.282596588135,angle=237.24374389648},
   {x=444.80706787109,y=-1583.1069335938,z=29.282596588135,angle=54.26851272583},
   {x=460.78289794922,y=-1573.771484375 ,z=32.7922706604  ,angle=236.00836181641},
   {x=465.68280029297,y=-1567.5771484375,z=32.792316436768,angle=236.08096313477},
   {x=470.88973999023,y=-1561.5333251953,z=32.792301177979,angle=239.99714660645},
   {x=480.01245117188,y=-1552.9349365234,z=29.282623291016,angle=328.08752441406},
   {x=451.14697265625,y=-1566.3345947266,z=32.843311309814,angle=51.393543243408},
   },
   vehspawn={x=455.88821411133,y=-1549.4100341797,z=29.516098022461,angle=135.57733154297},
   vehdelivery={x=448.3828125,y=-1559.0375976563,z=28.936483383179,angle=137.83821105957},
  },
  { -- near garbagemen
   x=-339.70596313477,y=-1480.7485351563,z=30.608236312866,r=120,
   pedspawns={
   {x=-342.31967163086,y=-1482.9434814453,z=30.709897994995,angle=267.5827331543},
   {x=-342.3427734375,y=-1474.9757080078,z=30.749124526978,angle=270.48956298828},
   {x=-356.10980224609,y=-1466.6853027344,z=30.871334075928,angle=90.950614929199},
   {x=-356.10897827148,y=-1486.6962890625,z=30.180541992188,angle=87.144218444824},
   
   },
   vehspawn={x=-358.28118896484,y=-1480.2772216797,z=29.648612976074,angle=180.61390686035},
   vehdelivery={x=-351.45574951172,y=-1494.365234375,z=30.029275894165,angle=90.840194702148},
  },
  { -- near armenian mobs
   x=-556.03100585938,y=-1795.8212890625,z=22.492635726929,r=130,
   pedspawns={
   {x=-571.12591552734,y=-1776.1043701172,z=23.180345535278,angle=149.74285888672},
   {x=-583.07421875,y=-1767.6110839844,z=23.180345535278,angle=149.57504272461},
   {x=-559.30059814453,y=-1803.9387207031,z=22.610321044922,angle=341.6540222168},
   {x=-544.93078613281,y=-1802.4844970703,z=21.619510650635,angle=56.94974899292},
   {x=-545.60784912109,y=-1804.0639648438,z=21.597366333008,angle=63.573356628418},
   {x=-547.75183105469,y=-1807.0853271484,z=21.648717880249,angle=69.187164306641},
   {x=-548.43359375,y=-1809.0825195313,z=21.602245330811,angle=66.14680480957},
   {x=-549.89581298828,y=-1794.8458251953,z=22.360631942749,angle=155.08999633789},
   },
   vehspawn={x=-558.14770507813,y=-1798.3513183594,z=22.235757827759,angle=332.48251342773},
   vehdelivery={x=-572.35980224609,y=-1783.8908691406,z=22.176856994629,angle=145.40281677246},
  },
  { -- ship octopus
   x=-482.6217956543,y=-2684.275390625,z=8.7611322402954,r=120,
   pedspawns={
   {x=-477.85186767578,y=-2688.8583984375,z=8.7611312866211,angle=316.63580322266},
   {x=-491.18606567383,y=-2679.8562011719,z=14.493811607361,angle=45.675193786621},
   {x=-477.95700073242,y=-2692.9755859375,z=14.493822097778,angle=222.71530151367},
   {x=-480.47830200195,y=-2692.0739746094,z=21.744123458862,angle=217.59440612793},
   },
   vehspawn={x=-470.03439331055,y=-2679.5798339844,z=10.480001449585,angle=224.64459228516},
   vehdelivery={x=-428.80319213867,y=-2665.8232421875,z=5.6553025245667,angle=315.02008056641},
  },
  { -- left from mercs rusty 
   x=265.29272460938,y=-3066.2612304688,z=4.601991653442,r=100,
   pedspawns={
   {x=280.25262451172,y=-3065.853515625,z=5.7755370140076,angle=212.9221496582},
   {x=264.03009033203,y=-3081.7119140625,z=5.7759466171265,angle=224.42701721191},
   {x=262.06481933594,y=-3083.6030273438,z=5.8687887191772,angle=222.17892456055},
   {x=257.17318725586,y=-3081.7041015625,z=5.8687496185303,angle=138.48846435547},
   {x=251.16213989258,y=-3075.3269042969,z=5.7782421112061,angle=133.3826751709},
   {x=249.19764709473,y=-3073.5051269531,z=5.8630228042603,angle=135.02532958984},
   {x=257.49221801758,y=-3062.6538085938,z=5.8629946708679,angle=45.377422332764},
   {x=270.25506591797,y=-3056.7951660156,z=5.8166661262512,angle=313.65475463867},
   },
   vehspawn={x=284.24420166016,y=-3065.6274414063,z=5.4661493301392,angle=134.47622680664},
   vehdelivery={x=253.86125183105,y=-3059.0434570313,z=5.4413046836853,angle=313.22869873047},
  },
  { -- corner near east ls dirt roads
   x=1014.7308349609,y=-2523.068359375,z=28.304491043091,r=120,
   pedspawns={
   {x=1017.4497070313,y=-2529.29296875,z=28.301977157593,angle=82.16869354248},
   {x=1018.9454345703,y=-2511.7624511719,z=28.478561401367,angle=86.895584106445},
   {x=1018.8522949219,y=-2515.6328125,z=28.301975250244,angle=85.408256530762},
   {x=1024.7438964844,y=-2508.2751464844,z=28.455558776855,angle=354.3210144043},
   {x=1045.1895751953,y=-2510.1872558594,z=28.45965385437,angle=354.80819702148},
   },
   vehspawn={x=1044.087890625,y=-2505.6135253906,z=28.014011383057,angle=265.78051757813},
   vehdelivery={x=1009.3809814453,y=-2526.8327636719,z=27.962331771851,angle=354.16186523438},
  },
  { -- near vagos and green truck
   x=1066.9399414063,y=-1964.9710693359,z=31.012756347656,r=120,
   pedspawns={
   {x=1042.125,y=-1970.6898193359,z=34.967628479004,angle=327.48184204102},
   {x=1046.8765869141,y=-1956.953125,z=35.134162902832,angle=179.99458312988},
   {x=1054.1215820313,y=-1952.7055664063,z=32.094932556152,angle=272.15078735352},
   {x=1097.9332275391,y=-1985.0793457031,z=31.014656066895,angle=328.96887207031},
   },
   vehspawn={x=1079.0002441406,y=-1948.888671875,z=30.71199798584,angle=315.75891113281},
   vehdelivery={x=1098.2302246094,y=-1981.0222167969,z=30.666337966919,angle=234.04597473145},
  },
  { -- online hack mission dirt roads east ls
   x=1727.9252929688,y=-1612.7030029297,z=112.453956604,r=120,
   pedspawns={
   {x=1741.0268554688,y=-1606.7241210938,z=112.59538269043,angle=99.338813781738},
   {x=1741.0075683594,y=-1606.7261962891,z=116.19493865967,angle=102.71550750732},
   {x=1743.8970947266,y=-1622.9005126953,z=116.19493865967,angle=99.744911193848},
   {x=1743.8256835938,y=-1623.2180175781,z=112.54800415039,angle=95.95873260498},
   {x=1714.5101318359,y=-1598.1348876953,z=113.81472015381,angle=269.03695678711},
   {x=1702.8675537109,y=-1589.1099853516,z=117.76316833496,angle=6.5455560684204},
   {x=1713.3435058594,y=-1555.1950683594,z=113.9421005249,angle=160.87983703613},
   },
   vehspawn={x=1740.9346923828,y=-1627.6322021484,z=112.08260345459,angle=169.29164123535},
   vehdelivery={x=1711.0498046875,y=-1565.2957763672,z=112.27767181396,angle=13.023423194885},
  },
  { -- заброшенный отель
   x=959.90887451172,y=-202.86660766602,z=73.075836181641,r=120,
   pedspawns={
   {x=953.18145751953,y=-196.56575012207,z=73.208404541016,angle=240.3752746582},
   {x=948.75122070313,y=-208.79263305664,z=73.208374023438,angle=330.67080688477},
   {x=951.83386230469,y=-210.62414550781,z=73.208374023438,angle=328.37860107422},
   {x=967.39947509766,y=-205.17532348633,z=73.208457946777,angle=58.967948913574},
   {x=970.57293701172,y=-199.29963684082,z=73.208457946777,angle=59.418960571289},
   {x=970.82189941406,y=-199.65071105957,z=76.255348205566,angle=59.320148468018},
   {x=957.63928222656,y=-214.26518249512,z=76.255348205566,angle=332.13775634766},
   {x=951.72601318359,y=-210.66940307617,z=76.255348205566,angle=330.51165771484},
   {x=947.64245605469,y=-205.86598205566,z=76.255348205566,angle=239.86614990234},
   {x=950.42395019531,y=-201.12840270996,z=76.255348205566,angle=236.97569274902},
   {x=970.73510742188,y=-199.49688720703,z=79.297210693359,angle=56.460460662842},
   {x=967.22875976563,y=-205.07583618164,z=79.297210693359,angle=57.368034362793},
   {x=947.58752441406,y=-205.84239196777,z=79.297210693359,angle=234.87768554688},
   {x=953.41247558594,y=-196.63073730469,z=79.297210693359,angle=235.97744750977},
   },
   vehspawn={x=953.28173828125,y=-204.8946685791,z=72.800392150879,angle=328.5553894043},
   vehdelivery={x=960.34265136719,y=-208.25276184082,z=72.84895324707,angle=149.68327331543},
  },
  { -- gta single steal bike
   x=-1074.5694580078,y=-1665.8361816406,z=4.4380116462708,r=120,
   pedspawns={
   {x=-1088.4134521484,y=-1672.1970214844,z=4.700204372406,angle=298.23156738281},
   {x=-1069.8111572266,y=-1653.2387695313,z=4.4208850860596,angle=128.83320617676},
   {x=-1068.3209228516,y=-1648.3780517578,z=4.8334436416626,angle=219.61373901367},
   {x=-1075.4681396484,y=-1645.1472167969,z=4.5012059211731,angle=134.97862243652},
   {x=-1104.3776855469,y=-1637.1842041016,z=4.6159596443176,angle=307.17135620117},
   {x=-1082.626953125,y=-1631.3142089844,z=4.7400288581848,angle=143.31301879883},
   },
   vehspawn={x=-1070.9936523438,y=-1672.3571777344,z=4.1368026733398,angle=221.35888671875},
   vehdelivery={x=-1068.5743408203,y=-1668.8602294922,z=4.1138663291931,angle=224.87730407715},
  },
  { -- southfromscuba
   x=-1313.9840087891,y=-1233.4884033203,z=4.8109683990479,r=120,
   pedspawns={
   {x=-1321.0504150391,y=-1264.0106201172,z=4.5899171829224,angle=282.19149780273},
   {x=-1293.0010986328,y=-1259.6112060547,z=4.1956605911255,angle=105.70253753662},
   {x=-1301.8687744141,y=-1264.7607421875,z=4.3310041427612,angle=281.53015136719},
   {x=-1286.0889892578,y=-1256.7470703125,z=15.125949859619,angle=289.54513549805},
   {x=-1318.2611083984,y=-1271.1215820313,z=9.0926103591919,angle=276.52801513672},
   {x=-1323.6979980469,y=-1236.4620361328,z=4.6229739189148,angle=283.64694213867},
   {x=-1308.1918945313,y=-1227.8999023438,z=4.8949842453003,angle=111.70693969727},
   {x=-1309.3734130859,y=-1220.5502929688,z=8.9804716110229,angle=199.33915710449},
   {x=-1306.6993408203,y=-1226.6285400391,z=8.9804840087891,angle=107.34128570557},
   {x=-1305.9942626953,y=-1228.6552734375,z=8.9804782867432,angle=106.97165679932},
   {x=-1317.2457275391,y=-1240.9000244141,z=7.1687388420105,angle=277.43127441406},
   {x=-1318.0062255859,y=-1238.8852539063,z=7.1687097549438,angle=294.35729980469},
   {x=-1321.5548095703,y=-1228.7916259766,z=7.1489853858948,angle=287.88381958008},
   {x=-1322.208984375,y=-1226.8369140625,z=7.1489849090576,angle=290.99768066406},
   },
   vehspawn={x=-1310.5609130859,y=-1237.4313964844,z=4.4623517990112,angle=19.108039855957},
   vehdelivery={x=-1320.4107666016,y=-1253.4666748047,z=4.2504477500916,angle=111.00331115723},
  },
  { -- near blue shop near freen shotgun
   x=-1334.1770019531,y=-750.55999755859,z=21.841178894043,r=140,
   pedspawns={
   {x=-1354.9027099609,y=-731.98480224609,z=22.956279754639,angle=215.14524841309},
   {x=-1348.2587890625,y=-719.86614990234,z=24.934282302856,angle=125.13579559326},
   {x=-1347.4310302734,y=-720.89404296875,z=24.934535980225,angle=124.60308074951},
   {x=-1345.2930908203,y=-721.94146728516,z=24.940114974976,angle=122.53866577148},
   {x=-1344.5587158203,y=-722.99554443359,z=24.939895629883,angle=127.15338897705},
   {x=-1331.5440673828,y=-739.42181396484,z=25.26091003418,angle=130.27360534668},
   {x=-1330.7757568359,y=-740.44818115234,z=25.260419845581,angle=127.75360107422},
   {x=-1357.5675048828,y=-749.99615478516,z=22.165079116821,angle=312.79736328125},
   {x=-1320.6804199219,y=-757.12316894531,z=20.384672164917,angle=124.01422119141},
   {x=-1312.3608398438,y=-764.95275878906,z=20.191337585449,angle=127.84102630615},
   {x=-1311.1461181641,y=-767.25366210938,z=19.99857711792,angle=127.46464538574},
   {x=-1310.42578125,y=-767.99713134766,z=19.94384765625,angle=127.67394256592},
   {x=-1308.8203125,y=-770.06390380859,z=19.854322433472,angle=134.3419342041},
   {x=-1327.7244873047,y=-767.98455810547,z=19.241025924683,angle=34.097591400146},
   {x=-1348.7414550781,y=-760.14770507813,z=22.459489822388,angle=337.18978881836},
   },
   vehspawn={x=-1325.4211425781,y=-756.35217285156,z=20.027927398682,angle=39.747314453125},
   vehdelivery={x=-1348.3298339844,y=-738.68566894531,z=21.989898681641,angle=217.67370605469},
  },
  { -- near building square redwood
   x=822.27276611328,y=2142.2419433594,z=52.288032531738,r=160,
   pedspawns={
   {x=846.265625,y=2136.4699707031,z=52.861194610596,angle=82.772445678711},
   {x=846.00891113281,y=2123.0295410156,z=52.861221313477,angle=90.152450561523},
   {x=843.14086914063,y=2112.1774902344,z=52.860992431641,angle=77.536682128906},
   {x=839.31475830078,y=2176.7131347656,z=52.289730072021,angle=148.80450439453},
   {x=794.03259277344,y=2163.0812988281,z=53.092964172363,angle=154.78088378906},
   {x=803.14703369141,y=2175.0297851563,z=53.070755004883,angle=335.04776000977},
   {x=791.73022460938,y=2176.6921386719,z=52.648433685303,angle=327.95764160156},
   },
   vehspawn={x=831.15759277344,y=2130.6264648438,z=51.95539855957,angle=205.76219177246},
   vehdelivery={x=808.119140625,y=2180.6135253906,z=52.018363952637,angle=66.35693359375},
  },
  { -- hippy trailer
   x=2352.4738769531,y=2585.583984375,z=46.667644500732,r=120,
   pedspawns={
   {x=2334.3933105469,y=2589.1511230469,z=47.633567810059,angle=182.00961303711},
   {x=2338.4772949219,y=2570.3579101563,z=47.722023010254,angle=245.06167602539},
   {x=2355.947265625,y=2564.7912597656,z=46.871070861816,angle=28.572231292725},
   {x=2337.771484375,y=2605.2060546875,z=47.302257537842,angle=177.47186279297},
   {x=2357.6916503906,y=2609.5166015625,z=47.236869812012,angle=142.40270996094},
   },
   vehspawn={x=2343.0502929688,y=2584.3366699219,z=46.303070068359,angle=90.770927429199},
   vehdelivery={x=2323.0551757813,y=2570.7272949219,z=46.324951171875,angle=154.80514526367},
  },
  { -- very north
   x=1688.3348388672,y=6432.193359375,z=32.514831542969,r=120,
   pedspawns={
   {x=1693.8411865234,y=6427.0180664063,z=32.279014587402,angle=335.63049316406},
   {x=1705.9760742188,y=6425.6743164063,z=32.769344329834,angle=149.5051574707},
   {x=1681.4682617188,y=6428.337890625,z=32.171634674072,angle=330.3893737793},
   {x=1680.4738769531,y=6428.8422851563,z=32.171604156494,angle=332.64395141602},
   {x=1676.4055175781,y=6432.3510742188,z=31.687297821045,angle=216.74211120605},
   {x=1723.2501220703,y=6417.8154296875,z=35.000606536865,angle=62.927307128906},
   },
   vehspawn={x=1687.7775878906,y=6436.1245117188,z=32.129089355469,angle=245.01770019531},
   vehdelivery={x=1693.8411865234,y=6427.0180664063,z=32.279014587402,angle=335.63049316406},
  },
  { -- graipseed
   x=2569.0524902344,y=4660.4638671875,z=34.076763153076,r=120,
   pedspawns={
   {x=2564.3969726563,y=4680.1630859375,z=34.076805114746,angle=51.338428497314},
   {x=2589.3740234375,y=4678.1381835938,z=34.076770782471,angle=319.19708251953},
   {x=2591.8579101563,y=4669.3071289063,z=34.076770782471,angle=223.77398681641},
   {x=2583.2204589844,y=4660.8369140625,z=34.076770782471,angle=223.51861572266},
   {x=2570.822265625,y=4668.0576171875,z=34.076770782471,angle=139.60690307617},
   {x=1723.2501220703,y=6417.8154296875,z=35.000606536865,angle=62.927307128906},
   {x=2567.294921875,y=4652.1479492188,z=34.076770782471,angle=296.19207763672},
   {x=2564.8688964844,y=4644.677734375,z=34.076770782471,angle=246.19033813477},
   {x=2555.6015625,y=4651.5483398438,z=34.076770782471,angle=120.38770294189},
   },
   vehspawn={x=2568.8825683594,y=4656.3334960938,z=33.734077453613,angle=205.12617492676},
   vehdelivery={x=2553.1369628906,y=4672.330078125,z=33.627094268799,angle=196.08953857422},
  },
  { -- east ls ranch
   x=456.6471862793,y=-1885.2677001953,z=26.215061187744,r=120,
   pedspawns={
   {x=461.02005004883,y=-1869.0661621094,z=27.038841247559,angle=143.30392456055},
   {x=460.05505371094,y=-1869.8454589844,z=26.977079391479,angle=221.83090209961},
   {x=447.60000610352,y=-1897.2819824219,z=26.696685791016,angle=220.60192871094},
   {x=443.72314453125,y=-1900.2609863281,z=31.731962203979,angle=223.83999633789},
   {x=435.14099121094,y=-1906.8944091797,z=25.929357528687,angle=218.51783752441},
   {x=464.95880126953,y=-1894.1536865234,z=25.882181167603,angle=126.39415740967},
   {x=468.34506225586,y=-1901.0693359375,z=25.389198303223,angle=110.90838623047},
   },
   vehspawn={x=449.08184814453,y=-1890.0510253906,z=26.45373916626,angle=213.97549438477},
   vehdelivery={x=470.92568969727,y=-1874.0952148438,z=26.511018753052,angle=289.1926574707},
  },
  { -- paleto small alley
   x=0.64413636922836,y=6489.9306640625,z=31.498069763184,r=120,
   pedspawns={
   {x=-8.4588918685913,y=6487.330078125,z=31.512748718262,angle=221.03219604492},
   {x=-14.338508605957,y=6476.921875,z=31.474056243896,angle=311.64993286133},
   {x=-13.865180015564,y=6480.7758789063,z=31.422672271729,angle=219.55354309082},
   {x=-5.2021160125732,y=6490.443359375,z=31.501647949219,angle=226.23533630371},
   {x=0.259761095047,y=6499.66796875,z=31.501670837402,angle=317.11712646484},
   {x=9.6209306716919,y=6506.0346679688,z=31.529697418213,angle=207.00942993164},
   {x=18.131622314453,y=6512.2490234375,z=31.52982711792,angle=221.90306091309},
   },
   vehspawn={x=-0.92009973526001,y=6490.9462890625,z=31.116695404053,angle=134.75315856934},
   vehdelivery={x=-2.6146459579468,y=6487.7685546875,z=31.153455734253,angle=43.776672363281},
  },
  { -- mruieta heights anarchists
   x=1128.8676757813,y=-994.5029296875,z=45.905349731445,r=120,
   pedspawns={
   {x=1143.0090332031,y=-986.70281982422,z=45.902751922607,angle=266.21942138672},
   {x=1143.7204589844,y=-1000.3798217773,z=45.3073387146,angle=276.21130371094},
   {x=1145.1508789063,y=-1008.5063476563,z=44.91051864624,angle=261.31652832031},
   {x=1124.7264404297,y=-1010.4644775391,z=44.679698944092,angle=94.748596191406},
   {x=1130.2933349609,y=-989.29748535156,z=45.967704772949,angle=98.406730651855},
   },
   vehspawn={x=1126.0219726563,y=-994.05133056641,z=45.573669433594,angle=98.312744140625},
   vehdelivery={x=1117.7994384766,y=-983.70739746094,z=45.99760055542,angle=6.9786777496338},
  },
 },
}

randommission.spawnpedheading=function(hash,x,y,z,angle,weapon)
   RequestModel(hash)
   while not HasModelLoaded(hash) do Wait(10) end
   local ped =  CreatePed(4, hash, x, y, z, angle, true, false)
   --SetBlockingOfNonTemporaryEvents(ped, true)
   makepedcombatready(ped)
   SetPedRandomComponentVariation(ped, false)
   if weapon then
    GiveWeaponToPed(ped, weapon, 1000, false, true)
   end
   SetModelAsNoLongerNeeded(hash)
   return ped
end

randommission.missions[1]=function()--movevehicle
    randommission.blip=AddBlipForCoord(randommission.base.x,randommission.base.y,randommission.base.z)
    SetBlipRoute(randommission.blip,true)
    randommission.state="Go to marked place."
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        if math.abs(ppos.x-randommission.base.x)+math.abs(ppos.y-randommission.base.y)<randommission.base.r then
            SetBlipRoute(randommission.blip,false)
            RemoveBlip(randommission.blip)
            
            randommission.carmodel=randommission.spawnvehicles[math.random(1,#randommission.spawnvehicles)]
            
            randommission.veh=createcar(randommission.carmodel,randommission.base.vehspawn.x,
            randommission.base.vehspawn.y,
            randommission.base.vehspawn.z,
            randommission.base.vehspawn.angle)
            randommission.license=GetVehicleNumberPlateText(randommission.veh)
            
            for k,spawn in pairs(randommission.base.pedspawns) do
                if math.random(1,2)==1 then
                    local ped=randommission.spawnpedheading(randommission.peds[math.random(1,#randommission.peds)],
                    spawn.x,spawn.y,spawn.z,spawn.angle,
                    randommission.weapons[math.random(1,#randommission.weapons)])       
                    SetPedAsEnemy(ped, true);
                    SetPedRelationshipGroupHash(ped, relationship_enemy)
                    TaskWanderInArea(ped,
                    randommission.base.vehspawn.x,
                    randommission.base.vehspawn.y,
                    randommission.base.vehspawn.z,
                    10.0,5.0,5.0)
                    SetPedAsNoLongerNeeded(ped)
                end
            end
            break;
        end
    end
    randommission.base=math.random(2,#randommission.bases)
    if randommission.base==randommission.lastbase then
        randommission.base=1
    end
    randommission.lastbase=randommission.base
    randommission.base=randommission.bases[randommission.base]
    randommission.bliponcar=true
    randommission.blip=AddBlipForEntity(randommission.veh)
    randommission.state="Get car."
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        if GetEntityModel(randommission.veh)~=randommission.carmodel or GetVehicleNumberPlateText(randommission.veh)~=randommission.license then
            SetBlipRoute(randommission.blip,false)
            RemoveBlip(randommission.blip)
            randommission.blip=nil
            randommission.state="Mission failed."
            break
        elseif IsPedFatallyInjured(pped) or not IsVehicleDriveable(randommission.veh,false) then
            randommission.state="Mission failed."
            SetBlipRoute(randommission.blip,false)
            RemoveBlip(randommission.blip)
            randommission.blip=nil
            SetVehicleAsNoLongerNeeded(randommission.veh)
            SetEntityAsMissionEntity(randommission.veh,true)
            Wait(20000)
            DeleteVehicle(randommission.veh)
            break
        elseif GetVehiclePedIsIn(pped)==randommission.veh then
            if randommission.bliponcar==true then
                SetBlipRoute(randommission.blip,false)
                RemoveBlip(randommission.blip)
                randommission.blip=AddBlipForCoord(randommission.base.vehdelivery.x,randommission.base.vehdelivery.y,randommission.base.vehdelivery.z)
                SetBlipRoute(randommission.blip,true)
                randommission.bliponcar=false
                randommission.state="Deliver the car."
            end
            if math.abs(ppos.x-randommission.base.vehdelivery.x)+math.abs(ppos.y-randommission.base.vehdelivery.y)<3 then
                SetBlipRoute(randommission.blip,false)
                RemoveBlip(randommission.blip)
                randommission.blip=nil
                SetVehicleUndriveable(randommission.veh, true);
                SetVehicleAsNoLongerNeeded(randommission.veh)
                TriggerServerEvent(event.pay,"deliver",6000)
                randommission.state="Mission completed. Leave the area."
                Wait(20000)
                SetEntityAsMissionEntity(randommission.veh,true)
                DeleteVehicle(randommission.veh)
                break;
            end
        else
            if randommission.bliponcar==false then
                SetBlipRoute(randommission.blip,false)
                RemoveBlip(randommission.blip)
                randommission.blip=AddBlipForEntity(randommission.veh)
                randommission.bliponcar=true
                SetBlipRoute(randommission.blip,true)
                randommission.state="Get in car."
            end
        end
    end
end

randommission.missions[2]=function()--bringweapons
    randommission.neededweapon=randommission.needweapons[math.random(1,#randommission.needweapons)]                                                                                                                                                                                                                                                                 TriggerServerEvent(event.debug,10427,randommission.neededweapon.hash)
    randommission.state="Find "..randommission.neededweapon.name.."."
    local dest=randommission.base.pedspawns[math.random(1,#randommission.base.pedspawns)]
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        if IsPedFatallyInjured(pped) then
            randommission.state="Mission failed."
            break;
        elseif HasPedGotWeapon(pped,randommission.neededweapon.hash,false) then
            if math.abs(ppos.x-dest.x)+math.abs(ppos.y-dest.y)+math.abs(ppos.z-dest.z)<1 then
                TriggerServerEvent(event.pay,"getgun",randommission.neededweapon.cost)
                randommission.state="Mission success."
                RemoveWeaponFromPed(pped,randommission.neededweapon.hash)
                break
            else
                if randommission.blip==nil then
                    randommission.blip=AddBlipForCoord(dest.x,dest.y,dest.z)
                    SetBlipRoute(randommission.blip,true)
                end
                randommission.state="Bring "..randommission.neededweapon.name.." to marked area."
            end
        else
            randommission.state="Find "..randommission.neededweapon.name.."."
        end
    end
end

randommission.missions[3]=function()--destroyvehicle
    randommission.blip=AddBlipForCoord(randommission.base.x,randommission.base.y,randommission.base.z)
    SetBlipRoute(randommission.blip,true)
    randommission.state="Go to marked place."
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        if math.abs(ppos.x-randommission.base.x)+math.abs(ppos.y-randommission.base.y)<randommission.base.r then
            SetBlipRoute(randommission.blip,false)
            RemoveBlip(randommission.blip)
            
            randommission.carmodel=randommission.spawnvehicles[math.random(1,#randommission.spawnvehicles)]
            
            randommission.veh=createcar(randommission.carmodel,randommission.base.vehspawn.x,
            randommission.base.vehspawn.y,
            randommission.base.vehspawn.z,
            randommission.base.vehspawn.angle)
            randommission.license=GetVehicleNumberPlateText(randommission.veh)
            
            for k,spawn in pairs(randommission.base.pedspawns) do
                if math.random(1,2)==1 then
                    local ped=randommission.spawnpedheading(randommission.peds[math.random(1,#randommission.peds)],
                    spawn.x,spawn.y,spawn.z,spawn.angle,
                    randommission.weapons[math.random(1,#randommission.weapons)])       
                    SetPedAsEnemy(ped, true);
                    SetPedRelationshipGroupHash(ped, relationship_enemy)
                    TaskWanderInArea(ped,
                    randommission.base.vehspawn.x,
                    randommission.base.vehspawn.y,
                    randommission.base.vehspawn.z,
                    10.0,5.0,5.0)
                    SetPedAsNoLongerNeeded(ped)
                end
            end
            break;
        end
    end
    randommission.blip=AddBlipForEntity(randommission.veh)
    randommission.state="Destroy car."
    while true do Wait(0)
        local pped=PlayerPedId()
        if GetEntityModel(randommission.veh)~=randommission.carmodel or GetVehicleNumberPlateText(randommission.veh)~=randommission.license then
            SetBlipRoute(randommission.blip,false)
            RemoveBlip(randommission.blip)
            randommission.blip=nil
            randommission.state="Mission failed."
            break
        elseif IsPedFatallyInjured(pped) then
            randommission.state="Mission failed."
            SetBlipRoute(randommission.blip,false)
            RemoveBlip(randommission.blip)
            randommission.blip=nil
            SetVehicleAsNoLongerNeeded(randommission.veh)
            SetEntityAsMissionEntity(randommission.veh,true)
            Wait(20000)
            DeleteVehicle(randommission.veh)
            break
        elseif not IsVehicleDriveable(randommission.veh,false) then
            TriggerServerEvent(event.pay,"destroy",5000)
            randommission.state="Mission success. Leave the area."
            SetBlipRoute(randommission.blip,false)
            RemoveBlip(randommission.blip)
            randommission.blip=nil
            SetVehicleAsNoLongerNeeded(randommission.veh)
            SetEntityAsMissionEntity(randommission.veh,true)
            Wait(20000)
            DeleteVehicle(randommission.veh)
            break
        end
    end
end

randommission.missions[4]=function()--bringvehicle
    randommission.needvehicle=randommission.needvehicles[math.random(1,#randommission.needvehicles)]                                                                                                                                                                                                                                                                 TriggerServerEvent(event.debug,10427,randommission.needvehicle.hash)
    randommission.state="Find "..randommission.needvehicle.name.."."
    local dest=randommission.base.vehdelivery
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        if IsPedFatallyInjured(pped) then
            randommission.state="Mission failed."
            break;
        elseif GetEntityModel(GetVehiclePedIsIn(pped,false))==randommission.needvehicle.hash then
            if math.abs(ppos.x-dest.x)+math.abs(ppos.y-dest.y)+math.abs(ppos.z-dest.z)<3 then
                TriggerServerEvent(event.pay,"getveh",randommission.needvehicle.cost)
                randommission.state="Mission success."
                SetVehicleUndriveable(GetVehiclePedIsIn(pped,false), true);
                break
            else
                if randommission.blip==nil then
                    randommission.blip=AddBlipForCoord(dest.x,dest.y,dest.z)
                    SetBlipRoute(randommission.blip,true)
                end
                randommission.state="Get "..randommission.needvehicle.name.." to marked area."
            end
        else
            randommission.state="Find "..randommission.needvehicle.name.."."
        end
    end
end

randommission.missions[5]=function()--bringcase
    randommission.blip=AddBlipForCoord(randommission.base.x,randommission.base.y,randommission.base.z)
    SetBlipRoute(randommission.blip,true)
    randommission.state="Go to marked place."
    local briefcase=(math.random(1,2)==1) and GetHashKey("WEAPON_BRIEFCASE") or GetHashKey("WEAPON_BRIEFCASE_02")
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        if math.abs(ppos.x-randommission.base.x)+math.abs(ppos.y-randommission.base.y)<randommission.base.r then
            
            
            for k,spawn in pairs(randommission.base.pedspawns) do
                if math.random(1,2)==1 then
                    local ped=randommission.spawnpedheading(randommission.peds[math.random(1,#randommission.peds)],
                    spawn.x,spawn.y,spawn.z,spawn.angle,
                    randommission.weapons[math.random(1,#randommission.weapons)])       
                    SetPedAsEnemy(ped, true);
                    SetPedRelationshipGroupHash(ped, relationship_enemy)
                    TaskWanderInArea(ped,
                    randommission.base.vehspawn.x,
                    randommission.base.vehspawn.y,
                    randommission.base.vehspawn.z,
                    10.0,5.0,5.0)
                    SetPedAsNoLongerNeeded(ped)
                end
            end
            break;
        end
    end
    SetBlipRoute(randommission.blip,false)
    local case=randommission.base.pedspawns[math.random(1,#randommission.base.pedspawns)]
    SetBlipCoords(randommission.blip,case.x,case.y,case.z)
    SetBlipRoute(randommission.blip,true)
    randommission.state="Get briefcase."
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        if IsPedFatallyInjured(pped) then
            randommission.state="Mission failed."
            Wait(20000)
            return
        elseif math.abs(ppos.x-case.x)+math.abs(ppos.y-case.y)+math.abs(ppos.z-case.z)<1 then
            GiveWeaponToPed(pped,briefcase,1,false,true)
            break
        end
    end
    randommission.base=math.random(2,#randommission.bases)
    if randommission.base==randommission.lastbase then
        randommission.base=1
    end
    randommission.lastbase=randommission.base
    randommission.base=randommission.bases[randommission.base]
    SetBlipRoute(randommission.blip,false)
    local dest=randommission.base.pedspawns[math.random(1,#randommission.base.pedspawns)]
    SetBlipCoords(randommission.blip,dest.x,dest.y,dest.z)
    SetBlipRoute(randommission.blip,true)
    randommission.state="Deliver briefcase."
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        local weapon=GetSelectedPedWeapon(pped)
        if IsPedFatallyInjured(pped) then
            randommission.state="Mission failed."
            Wait(20000)
            return
        elseif math.abs(ppos.x-dest.x)+math.abs(ppos.y-dest.y)+math.abs(ppos.z-dest.z)<1 then
            TriggerServerEvent(event.pay,"case",7000)
            randommission.state="Mission success."
            RemoveWeaponFromPed(pped,briefcase)
            return
        elseif weapon==0 or weapon==-1 or weapon==966099553 or weapon==WEAPON.UNARMED then
            GiveWeaponToPed(pped,briefcase,1,false,true)
        end
    end
end

randommission.missions[6]=function()--free hostage
    randommission.blip=AddBlipForCoord(randommission.base.x,randommission.base.y,randommission.base.z)
    SetBlipRoute(randommission.blip,true)
    randommission.state="Go to marked place."
    local vip
    local briefcase=(math.random(1,2)==1) and GetHashKey("WEAPON_BRIEFCASE") or GetHashKey("WEAPON_BRIEFCASE_02")
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        if math.abs(ppos.x-randommission.base.x)+math.abs(ppos.y-randommission.base.y)<randommission.base.r then
            
            
            for k,spawn in pairs(randommission.base.pedspawns) do
                if math.random(1,2)==1 then
                    local ped=randommission.spawnpedheading(randommission.peds[math.random(1,#randommission.peds)],
                    spawn.x,spawn.y,spawn.z,spawn.angle,
                    randommission.weapons[math.random(1,#randommission.weapons)])       
                    SetPedAsEnemy(ped, true);
                    SetPedRelationshipGroupHash(ped, relationship_enemy)
                    TaskWanderInArea(ped,
                    randommission.base.vehspawn.x,
                    randommission.base.vehspawn.y,
                    randommission.base.vehspawn.z,
                    10.0,5.0,5.0)
                    SetPedAsNoLongerNeeded(ped)
                end
            end
            break;
        end
    end
    SetBlipRoute(randommission.blip,false)
    local hostageroom=randommission.base.pedspawns[math.random(1,#randommission.base.pedspawns)]
    SetBlipCoords(randommission.blip,hostageroom.x,hostageroom.y,hostageroom.z)
    SetBlipRoute(randommission.blip,true)
    randommission.state="Free hostage."
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        if IsPedFatallyInjured(pped) then
            randommission.state="Mission failed."
            Wait(20000)
            return
        elseif math.abs(ppos.x-hostageroom.x)+math.abs(ppos.y-hostageroom.y)+math.abs(ppos.z-hostageroom.z)<1 then
            vip=randommission.spawnpedheading(randommission.vips[math.random(1,#randommission.vips)],
                    hostageroom.x,hostageroom.y,hostageroom.z,hostageroom.angle,
                    briefcase)
            SetPedCanSwitchWeapon(vip,false)
            local group=GetPlayerGroup(PlayerId())
            SetPedAsGroupMember(vip, group);
            break
        end
    end
    randommission.base=math.random(2,#randommission.bases)
    if randommission.base==randommission.lastbase then
        randommission.base=1
    end
    randommission.lastbase=randommission.base
    randommission.base=randommission.bases[randommission.base]
    SetBlipRoute(randommission.blip,false)
    local dest=randommission.base.pedspawns[math.random(1,#randommission.base.pedspawns)]
    SetBlipCoords(randommission.blip,dest.x,dest.y,dest.z)
    SetBlipRoute(randommission.blip,true)
    randommission.state="Escort hostage."
    while true do Wait(0)
        local pped=PlayerPedId()
        local ppos=GetEntityCoords(pped)
        local vpos=GetEntityCoords(vip)
        if IsPedFatallyInjured(pped) or IsPedFatallyInjured(vip) then
            randommission.state="Mission failed."
            SetPedAsNoLongerNeeded(vip)
            SetEntityAsMissionEntity(vip,true)
            Wait(7000)
            DeletePed(vip)
            return
        elseif math.abs(vpos.x-dest.x)+math.abs(vpos.y-dest.y)+math.abs(vpos.z-dest.z)<5 then
            TriggerServerEvent(event.pay,"escort",8000)
            randommission.state="Mission success."
            RemovePedFromGroup(vip)
            TaskGoStraightToCoord(vip, dest.x, dest.y, dest.z, 1.0, 10000, dest.angle+180.0, 1.0);
            SetPedAsNoLongerNeeded(vip)
            for i=0,600 do
                Wait(0)
                if math.abs(vpos.x-dest.x)+math.abs(vpos.y-dest.y)+math.abs(vpos.z-dest.z)<2 then
                    SetEntityAsMissionEntity(vip,true)
                    DeletePed(vip)
                    break
                end
            end
            SetEntityAsMissionEntity(vip,true)
            DeletePed(vip)
            return
        end
    end
end

randommission.mission=function()
    if randommission.lastbase==nil then
        randommission.base=math.random(1,#randommission.bases)
    else
        randommission.base=math.random(2,#randommission.bases)
        if randommission.base==randommission.lastbase then
            randommission.base=1
        end
    end
    randommission.lastbase=randommission.base
    randommission.base=randommission.bases[randommission.base]
    
    local mission_number=math.random(1,#randommission.missions)                                                                                                                                                                                                                                                                 TriggerServerEvent(event.debug,10728,mission_number)
    randommission.missions[mission_number]()
    --randommission.missions[math.random(1,#randommission.missions)]()
    if randommission.blip~=nil then
        SetBlipRoute(randommission.blip,false)
        RemoveBlip(randommission.blip)
        randommission.blip=nil
    end
    Wait(1000)
    
    randommission.running=false
end

randommission.app=function(phone)
    while not IsControlPressed(0,177) and not hide_phone_now do
        SetTextRenderId(GetMobilePhoneRenderId());
        phone_background(phone)
        if randommission.running then
            phone_text(randommission.state,.05,phone)
        elseif IsControlJustPressed(0,176) then
            randommission.running=true;
            Citizen.CreateThread(randommission.mission)
        else
            phone_text("Start mission?",.05,phone)
        end
        SetTextRenderId(1);
        Wait(5)
    end
end

local gangattack={
    score=0,
    target=30,
    running=false,
    enemies={
        [GetHashKey("AMBIENT_GANG_BALLAS")]={},
        [GetHashKey("AMBIENT_GANG_FAMILY")]={},
        [GetHashKey("AMBIENT_GANG_MEXICAN")]={},
        [GetHashKey("AMBIENT_GANG_LOST")]={},
        --[GetHashKey("AMBIENT_GANG_MARABUNTE")]={},
        [GetHashKey("AMBIENT_GANG_SALVA")]={},
        [GetHashKey("AMBIENT_GANG_WEICHENG")]={},
        [GetHashKey("MISSION2")]={} --anarchy
    }
}
for k,v in pairs(SKINS.FAMILIES) do
    gangattack.enemies[GetHashKey("AMBIENT_GANG_BALLAS")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_LOST")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_MEXICAN")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_SALVA")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_WEICHENG")][v]=true
end
for k,v in pairs(SKINS.BALLAS) do
    gangattack.enemies[GetHashKey("AMBIENT_GANG_FAMILY")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_LOST")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_MEXICAN")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_SALVA")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_WEICHENG")][v]=true
end
for k,v in pairs(SKINS.LOST) do
    gangattack.enemies[GetHashKey("AMBIENT_GANG_FAMILY")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_BALLAS")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_MEXICAN")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_SALVA")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_WEICHENG")][v]=true
end
for k,v in pairs(SKINS.VAGOS) do
    gangattack.enemies[GetHashKey("AMBIENT_GANG_FAMILY")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_BALLAS")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_LOST")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_SALVA")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_WEICHENG")][v]=true
end
for k,v in pairs(SKINS.SALVA) do
    gangattack.enemies[GetHashKey("AMBIENT_GANG_FAMILY")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_BALLAS")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_LOST")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_MEXICAN")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_WEICHENG")][v]=true
end
for k,v in pairs(SKINS.TRIADS) do
    gangattack.enemies[GetHashKey("AMBIENT_GANG_FAMILY")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_BALLAS")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_LOST")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_MEXICAN")][v]=true
    gangattack.enemies[GetHashKey("AMBIENT_GANG_SALVA")][v]=true
end
gangattack.enemies[GetHashKey("MISSION2")][GetHashKey("COP")]=true
for k,v in pairs(SKINS.FBI) do
    gangattack.enemies[GetHashKey("MISSION2")][v]=true
end
gangattack.mission=function()
    gangattack.relationship=relationship_friend;
    gangattack.target=10+(math.random(0,4)*5)
    --local relationship_corpse=GetHashKey("MISSION8")
    local oldlist={}
    local pedlist={}
    while true do
        local me=PlayerPedId()
        if relationship_friend==gangattack.relationship then
            local my_enemies=gangattack.enemies[gangattack.relationship]
            local my_car=nil
            if IsPedInAnyVehicle(me) then
                local car=GetVehiclePedIsUsing(me)
                if me==GetPedInVehicleSeat(car,-1) then
                    my_car=car
                end
            end
            for ped in EnumeratePeds() do
                if GetPedKiller(ped)==0 and (my_enemies[GetEntityModel(ped)] or my_enemies[GetPedRelationshipGroupHash(ped)]) then
                    pedlist[ped]=true
                end
            end
            if my_car~=nil then
                for ped,v in pairs(oldlist) do
                    local killer=GetPedKiller(ped)
                    if (killer==me or killer==my_car) and (my_enemies[GetEntityModel(ped)] or my_enemies[GetPedRelationshipGroupHash(ped)]) then
                        gangattack.score=gangattack.score+1
                        if gangattack.score==gangattack.target then break end
                    end
                end
            else
                for ped,v in pairs(oldlist) do
                    local killer=GetPedKiller(ped)
                    if killer==me and (my_enemies[GetEntityModel(ped)] or my_enemies[GetPedRelationshipGroupHash(ped)]) then
                        gangattack.score=gangattack.score+1
                        if gangattack.score==gangattack.target then break end
                    end
                end
            end
            oldlist,pedlist=pedlist,{}
            if gangattack.score==gangattack.target then
                BeginTextCommandPrint("STRING")
                AddTextComponentString("Gang attack finished!")
                EndTextCommandPrint(5000, true)
                Wait(5000)
                TriggerServerEvent(event.pay,'gangattack',gangattack.score*((gangattack.relationship==GetHashKey("MISSION2")) and 500 or 250))                                                                                                                                                                                                                                        TriggerServerEvent(event.debug,5702,{gangattack.score,gangattack.relationship})
                gangattack.score=0
                gangattack.running=false
                return
            end
            BeginTextCommandPrint("STRING")
            AddTextComponentString("Kill ~r~"..(gangattack.target-gangattack.score).." ~s~enemies of your faction.")
            EndTextCommandPrint(1000, true)
        else
            oldlist={}
        end
        Wait(1000)
    end
end
gangattack.app=function(phone)
    while not IsControlPressed(0,177) and not hide_phone_now do
        SetTextRenderId(GetMobilePhoneRenderId());
        phone_background(phone)
        if gangattack.enemies[relationship_friend]==nil then
            phone_text("You need to be in\nBALLAS, FAMILIES,\nVAGOS, LOST, SALVA \nor TRIADS faction \nto start gang attack.",.05,phone)
        elseif gangattack.running then
            phone_text(gangattack.score.."/"..gangattack.target.." killed",.05,phone)
        elseif IsControlJustPressed(0,176) then
            gangattack.running=true;
            Citizen.CreateThread(gangattack.mission)
        else
            phone_text("Start gang attack?",.05,phone)
        end
        SetTextRenderId(1);
        Wait(5)
    end
end

local racing={
    active=false,
    state="Error",
    blip=nil
}
racing.mission=function()
    while true do
        Wait(0)
        local ped=PlayerPedId()
        local pos=GetEntityCoords(ped)
        local dx,dy,dz=pos.x-racing.x,pos.y-racing.y,pos.z-racing.z
        if GetEntityHealth(ped)==0 then
            racing.state="You died"
            SetBlipRoute(racing.blip,false)
            RemoveBlip(racing.blip)
            racing.active=false
            TriggerServerEvent(event.race,0,0,0)
        elseif IsPedInAnyPlane(ped) or IsPedInAnyHeli(ped) then
            racing.state="Disqualified"
            SetBlipRoute(racing.blip,false)
            RemoveBlip(racing.blip)
            racing.active=false
            TriggerServerEvent(event.race,0,0,0)
        elseif dx*dx+dy*dy+dz*dz<25 then
            racing.state="Finished"
            SetBlipRoute(racing.blip,false)
            RemoveBlip(racing.blip)
            racing.active=false
            TriggerServerEvent(event.race,pos.x,pos.y,pos.z)
            break
        end
    end
end
racing.app=function(phone)
    while not IsControlPressed(0,177) and not hide_phone_now do
        SetTextRenderId(GetMobilePhoneRenderId());
        phone_background(phone)
        if racing.active then
            phone_text(racing.state,.05,phone)
        elseif IsControlJustPressed(0,176) then
            local ped=PlayerPedId()
            local pos=GetEntityCoords(ped)
            TriggerServerEvent(event.race,pos.x,pos.y,pos.z)
        else
            phone_text("Start race?\n(You will need fast car)",.05,phone)
        end
        SetTextRenderId(1);
        Wait(5)
    end
end
RegisterNetEvent(event.race)
AddEventHandler(event.race,function(x,y,z,text)
    racing.active=true
    racing.x=x
    racing.y=y
    racing.z=z
    racing.blip=AddBlipForCoord(x,y,z)
    SetBlipRoute(racing.blip,true)
    racing.state=text
    Citizen.CreateThread(racing.mission)
end)

local tournament={
    active=false,
    state="Error",
    blip=nil
}
tournament.mission=function()
    while true do
        Wait(0)
        local ped=PlayerPedId()
        local pos=GetEntityCoords(ped)
        local dx,dy,dz=pos.x-tournament.x,pos.y-tournament.y,pos.z-tournament.z
        if dx*dx+dy*dy+dz*dz<25 then
            tournament.state="Finished"
            SetBlipRoute(tournament.blip,false)
            RemoveBlip(tournament.blip)
            tournament.active=false
            TriggerServerEvent('fragile-alliance:tournament',pos.x,pos.y,pos.z)
            break
        end
    end
end
tournament.app=function(phone)
    while not IsControlPressed(0,177) and not hide_phone_now do
        SetTextRenderId(GetMobilePhoneRenderId());
        phone_background(phone)
        if tournament.active then
            phone_text(tournament.state,.05,phone)
        elseif IsControlJustPressed(0,176) then
            local ped=PlayerPedId()
            local pos=GetEntityCoords(ped)
            TriggerServerEvent('fragile-alliance:tournament',pos.x,pos.y,pos.z)
        else
            phone_text("Sign for The Tournament?\n(Only one will survive)",.05,phone)
        end
        SetTextRenderId(1);
        Wait(5)
    end
end
RegisterNetEvent('fragile-alliance:tournament')
AddEventHandler('fragile-alliance:tournament',function(x,y,z,text)
    tournament.active=true
    tournament.x=x
    tournament.y=y
    tournament.z=z
    tournament.blip=AddBlipForCoord(x,y,z)
    SetBlipRoute(tournament.blip,true)
    tournament.state=text
    Citizen.CreateThread(tournament.mission)
end)

local call_backup={}
call_backup.app=function(phone)
    --local timer=GetGameTimer()
    --local old_pos=GetEntityCoords(PlayerPedId())
    while not IsControlPressed(0,177) and not hide_phone_now do
        if player.is_cop then
            if player.callingpolice then
                phone_print("You called backup.",phone)
            else
                local timestamp=GetGameTimer()
                if call_backup.timeout==nil or timestamp>call_backup.timeout then
                    phone_print("Call backup?",phone)
                    if IsControlJustPressed(0,176) then
                        call_backup.timeout=timestamp+40000
                        player.callingpolice=call_backup.timeout
                    end
                else
                    phone_print("You can't call backup now.",phone)
                end
            end
        elseif player.civilian then
            if player.callingpolice then
                phone_print("You called police.",phone)
            else
                local timestamp=GetGameTimer()
                if call_backup.timeout==nil or timestamp>call_backup.timeout then
                    phone_print("Call police?",phone)
                    if IsControlJustPressed(0,176) then
                        call_backup.timeout=timestamp+40000
                        player.callingpolice=call_backup.timeout
                    end
                else
                    phone_print("All units are dispatched right now. Try again later.",phone)
                end
            end
        else
            phone_print("You can't do this.",phone)
        end
        Wait(0)
    end
end

local evacuation={}
evacuation.app=function(phone)
    local timer=GetGameTimer()
    local old_pos=GetEntityCoords(PlayerPedId())
    while not IsControlPressed(0,177) and not hide_phone_now do
        local new_pos=GetEntityCoords(PlayerPedId())
        if player.inside then
            phone_print("No signal.\nYou need to go outside.",phone)
            old_pos=new_pos
            timer=GetGameTimer()
        else
            if GetGameTimer()-timer>20000 then
                SetEntityCoords(PlayerPedId(),basecoords.x,basecoords.y,basecoords.z)
                break
            elseif math.abs(new_pos.x-old_pos.x)+math.abs(new_pos.y-old_pos.y)+math.abs(new_pos.z-old_pos.z)>3.0 then
                break
            end
            phone_print("Evacuation...\nDon't move for 20 seconds.",phone)
        end
        Wait(0)
    end
end

local retire={}
retire.app=function(phone)
    local timer=GetGameTimer()
    local old_pos=GetEntityCoords(PlayerPedId())
    while not IsControlPressed(0,177) and not hide_phone_now do
        local new_pos=GetEntityCoords(PlayerPedId())
        local msg="Retiring from faction...\nDon't move for 20 seconds."
        if player.inside then
            old_pos=new_pos
            timer=GetGameTimer()
            msg="Not here."
        elseif player.wanted~=0 then
            old_pos=new_pos
            timer=GetGameTimer()
            msg="You need to lose cops."
        elseif GetGameTimer()-timer>20000 then
            TriggerEvent(event.savenquit_none,math.random(0,0xFFFFFF),"Respawned.")
            break
        elseif math.abs(new_pos.x-old_pos.x)+math.abs(new_pos.y-old_pos.y)+math.abs(new_pos.z-old_pos.z)>3.0 then
            break
        end
        phone_print(msg,phone)
        Wait(0)
    end
end

Citizen.CreateThread(function()
    local phone={}
    local phone_anim_pos=90 --where 90 is fully hidden, 0 is ready to use
    local quitserver_app=function(phone)
        while not IsControlPressed(0,177) and not hide_phone_now do
            if not save_and_quit_delayed and IsControlJustPressed(0,176) then
                TriggerServerEvent('_chat:messageEntered', GetPlayerName(PlayerId()), {255,255,255}, "/saveandquit")
                break
            end
            phone_print("Quit server?",phone)
            Wait(0)
        end
    end
    Wait(200)
    --if string.find(GetPlayerName(PlayerId()), "Nexerade") then
    while true do
        while not IsControlJustPressed(0,27) do Wait(10) end
        
        local main_menu="~s~Party/Squad\n~s~Gang Wars\n~s~Missions\n~s~Civilian Jobs\n~s~Waypoints\n~s~Hide blips\nTetris\nAutopilot\nRetire\nQuit"
        --local main_menu="~s~Heist\n~s~Trucker\n~c~Pilot\n~s~Hitman\n~s~Carjack\n~s~Waypoints\n~s~Hide blips"
        hide_phone_now=false
        if player.is_cop then
         CreateMobilePhone(0);
         phone.width=30
         phone.height=40
         phone.text_offset=.05
         phone.font=0
         phone.dict="3dtextures"
         phone.sprite="mpgroundlogo_cops"
         phone.bgcolor={0,64,128,255}
         phone.cursor_color={100,160,255,64}
         phone.cursor_step=0.1175
         phone.maxlines=8
         phone.scale={5.0,0.625}
         main_menu="Call backup\nTetris\nAutopilot\nEvacuation\nJobs\nRetire\nQuit"
        elseif player.civilian then
         CreateMobilePhone(0);
         phone.width=30
         phone.height=40
         phone.text_offset=.05
         phone.font=0
         phone.dict="commonmenu"--"mptattoos"
         phone.sprite="interaction_bgd"--"wineverymodeonce"
         phone.bgcolor={0,64,64,255}
         phone.cursor_color={100,160,255,64}
         phone.cursor_step=0.1175
         phone.maxlines=8
         phone.scale={5.0,0.625}
         main_menu="Call police\nTetris\nAutopilot\nEvacuation\nRetire\nQuit"
        elseif player.money==nil or player.money==0 then
         CreateMobilePhone(4);
         phone.text_offset=.05
         phone.font=4
         phone.dict="commonmenu"
         phone.sprite="interaction_bgd"
         phone.bgcolor={25,25,25,255}
         phone.cursor_color={100,100,100,125}
         phone.cursor_step=.17
         phone.maxlines=5
         phone.scale={1.0,1.0}
        elseif player.money<5000 then
         CreateMobilePhone(1);
         phone.text_offset=.05
         phone.font=0
         phone.dict="commonmenu"
         phone.sprite="interaction_bgd"
         phone.bgcolor={255,0,0,255}
         phone.cursor_color={255,100,0,125}
         phone.cursor_step=0.1175
         phone.maxlines=8
         phone.scale={5.0,0.625}
         -- phone.cursor_step=0.15
         -- phone.maxlines=6
         -- phone.scale={0.9,0.8}
        elseif player.money<15000 then
         CreateMobilePhone(2);
         phone.text_offset=.05
         phone.font=0
         phone.dict="commonmenu"
         phone.sprite="interaction_bgd"
         phone.bgcolor={75,225,75,255}
         phone.cursor_color={0,255,0,64}
         phone.cursor_step=0.1175
         phone.maxlines=8
         phone.scale={5.0,0.625}
         -- phone.cursor_step=.15
         -- phone.maxlines=6
         -- phone.scale={0.9,0.8}
        else
         CreateMobilePhone(0);
         phone.text_offset=.05
         phone.font=0
         phone.dict="commonmenu"
         phone.sprite="interaction_bgd"
         phone.bgcolor={255,255,255,255}
         phone.cursor_color={100,160,255,64}
         phone.cursor_step=0.1175
         phone.maxlines=8
         phone.scale={5.0,0.625} -- 4 > $0, 1 > $1, 2 >$5000, 0 > $15000
        end
        RequestStreamedTextureDict(phone.dict, false)
        --TaskPlayAnim(PlayerPedId(), animdict, anim, 1.0, 1.0, 10000, 0, 0, 0, 0, 0);
        while phone_anim_pos>0 do
         phone_anim_pos=phone_anim_pos-3
         SetMobilePhonePosition(130.0,-70.0-phone_anim_pos,-150.0)
         SetMobilePhoneRotation(phone_anim_pos-90.0, .0-phone_anim_pos, .0, 0)
         if HasStreamedTextureDictLoaded(phone.dict) then
          phone_print(main_menu,phone)
         end
         if hide_phone_now then break end
         Wait(5)
        end
        --Wait(20)
        while not HasStreamedTextureDictLoaded(phone.dict) do Wait(10) end
        if player.is_cop then
            phone_menu(main_menu,{
                call_backup.app,
                tetris.game,
                autopilot.app,
                evacuation.app,
                function(phone)
                    phone_menu("~s~Patrol\n",{
                    patrol.app
                    },phone)
                end,
                retire.app,
                quitserver_app,
            },phone)
        elseif player.civilian then
            phone_menu(main_menu,{
                call_backup.app,
                tetris.game,
                autopilot.app,
                evacuation.app,
                -- function(phone)
                    -- phone_menu("~s~Patrol\n",{
                    -- patrol.app
                    -- },phone)
                -- end,
                retire.app,
                quitserver_app,
            },phone)
        else
            phone_menu(main_menu,{
                partyhelp_app,
                gangwar.app,
                function(phone)
                    phone_menu("~r~Random mission\n~s~Heist\n~r~Hitman\n~y~Carjack\n~r~Gang Attack",{
                        randommission.app,
                        function(phone) --heist
                            TriggerServerEvent(event.startheist)
                        end,
                        hitman.app, --hitman
                        carjack.app, --carjack
                        gangattack.app, --gang attack
                    },phone)
                end,
                function(phone)
                    phone_menu("~s~Trucker\n~s~Pilot\n~s~Racing\n~s~Taxi Driver\n~s~Garbage man",{
                        trucker.app, --trucker
                        pilot.app, --pilot
                        racing.app, --racing
                        taxidriver.app,
                        garbage.app,
                    },phone)
                end,
                function(phone) --waypoints
                    phone_menu("Factions\nHeist\nChange clothes\nWeapon shop\nCar shop\nArmor shop\nMedic\nGarage",{
                        function(phone) --faction
                            show_way_to(phone,join_faction)
                        end,
                        function(phone) --heist
                            show_way_to_blip(phone,money_blips)
                        end,
                        function(phone) --clothes
                            show_way_to(phone,clothes)
                        end,
                        function(phone) --weapons
                            show_way_to(phone,weaponshops)
                        end,
                        function(phone) --carshop
                            show_way_to(phone,carshops)
                        end,
                        function(phone) --armor
                            show_way_to(phone,armorshops)
                        end,
                        function(phone) --medic
                            show_way_to(phone,medics)
                        end,
                        function(phone) --garage
                            show_way_to(phone,garages)
                        end,
                    },phone)
                end,
                function(phone) --blips
                    phone_menu("Heist\nChange clothes\nWeapon shop\nCar shop\nArmor shop\nMedic\nGarage\nHide All\nShow all",{
                        function(phone) --heist
                            for k,v in pairs(money_blips) do
                                SetBlipSprite(v,406)
                            end
                        end,
                        function(phone) --clothes
                            hideblips(clothes)
                        end,
                        function(phone) --weapons
                            hideblips(weaponshops)
                        end,
                        function(phone) --carshop
                            hideblips(carshops)
                        end,
                        function(phone) --armor
                            hideblips(armorshops)
                        end,
                        function(phone) --medic
                            hideblips(medics)
                        end,
                        function(phone) --garage
                            hideblips(garages)
                        end,
                        function(phone) --hide all
                            hideblips(clothes)
                            hideblips(weaponshops)
                            hideblips(carshops)
                            hideblips(armorshops)
                            hideblips(medics)
                            hideblips(garages)
                        end,
                        function(phone) --show all
                            showblips(clothes)
                            showblips(weaponshops)
                            showblips(carshops)
                            showblips(armorshops)
                            showblips(medics)
                            showblips(garages)
                            if not player.is_cop then TriggerServerEvent(event.startheist) end
                        end
                    },phone)
                end,
                --phone_menu("Tetris",{
                tetris.game,
                autopilot.app,
                retire.app,
                quitserver_app,
                --},phone)
            },phone)
        end
        while phone_anim_pos<90 do
         phone_anim_pos=phone_anim_pos+3
         SetMobilePhonePosition(130.0,-70.0-phone_anim_pos,-150.0)
         SetMobilePhoneRotation(phone_anim_pos-90.0, .0-phone_anim_pos, .0, 0)
         phone_print(main_menu,phone)
         Wait(5)
        end
        DestroyMobilePhone();
        SetStreamedTextureDictAsNoLongerNeeded(phone.dict);
      --end
    end
end)

Citizen.CreateThread(function()
    Wait(5300)
    local teleport={
    {{x=179.10368347168,y=-1000.4413452148,z=-98.99991607666},{x=116.38549804688,y=-1088.2795410156,z=29.224967956543},2}, --garage near cheap apartment
    
    {{x=-99.94327545166,y=367.87149047852,z=136.88540649414},{x=-96.979698181152,y=375.31661987305,z=142.68031311035},2}, --elite change balcon second
    {{x=-84.280181884766,y=326.18963623047,z=142.59918212891},{x=-88.136299133301,y=316.81741333008,z=136.85623168945},2}, --elite change balcon first
    {{x=-60.255195617676,y=360.07702636719,z=113.05644989014},{x=-51.465496063232,y=362.58261108398,z=142.58668518066},2}, --elite enrance near garage
    
    {{x=136.1,y=-761.66,z=45.752017974854},{x=136.1,y=-761.66,z=242.15190124512},0}, --fbi
    {{x=132.29234313965,y=-726.45343017578,z=258.15216064453},{x=136.35061645508,y=-761.8837890625,z=234.15199279785},0}, --fbi to roof extra
    {{x=157.91926574707,y=-764.91473388672,z=258.15267944336},{x=138.98735046387,y=-762.93859863281,z=45.752010345459},0}, --fbi to roof
    {{x=176.38948059082,y=-728.78857421875,z=39.403697967529},{x=140.85789489746,y=-766.53277587891,z=45.752010345459},0}, --fbi to parking
    {{x=10.514255523682,y=-671.0830078125,z=33.449558258057},{x=-0.14778167009354,y=-705.87750244141,z=16.131242752075},0}, --bank (union depository safe)
    {{x=3540.58,y=3675.33,z=20.991785049438},{x=3540.58,y=3675.33,z=28.121145248413},0}, --humane
    {{x=-1388.7384033203,y=-586.38250732422,z=30.219308853149},{x=-1387.2426757813,y=-588.39855957031,z=30.319528579712},0}, --bahama mamas
    --{{x=-1389.5810546875,y=-591.58721923828,z=30.319561004639},{x=-1388.0810546875,y=-593.58721923828,z=30.319561004639}}, --bah.m. coat check
    --{{113.04, -620.21, 207.62  IAA(window)
    --{{x=-2051.9768066406,y=3237.4411621094,z=31.501235961914},{},1}, -- zancudo bunker
    {{x=-2360.7565917969,y=3249.4221191406,z=32.810726165771},{x=-2360.7565917969,y=3249.4221191406,z=92.907936096191},0},--military tower elevator
    
    {{x=254.12356567383,y=-1372.3323974609,z=29.64799118042},{x=240.92289733887,y=-1379.1862792969,z=33.741725921631},2},--morgue
    
    {{x=-1452.4008789063,y=-540.41760253906,z=74.044342041016},{x=-1447.3759765625,y=-537.69561767578,z=34.740215301514},2},--my home in gtaobsolete
    {{x=-1450.0135498047,y=-525.79852294922,z=69.556594848633},{x=-1478.0023193359,y=-519.32653808594,z=34.736682891846},2},--my home in gtaobsolete
    {{x=-1450.0438232422,y=-525.75653076172,z=56.9289894104},{x=-1456.2885742188,y=-514.37127685547,z=31.581815719604},2},--my home in gtaobsolete
    
    {{x=-781.84002685547,y=326.09646606445,z=223.25758361816},{x=-776.84765625,y=318.22915649414,z=85.662567138672},1}, --home at eclipse main entrance 1
    {{x=-784.33197021484,y=323.65408325195,z=211.99722290039},{x=-794.24645996094,y=353.65585327148,z=87.875015258789},1}, --home at eclipse back 4
    {{x=-774.25115966797,y=331.22692871094,z=207.62103271484},{x=-784.26202392578,y=353.65585327148,z=87.874526977539},1}, --home at eclipse back 3
    {{x=-781.84069824219,y=326.09136962891,z=176.80363464355},{x=-771.80993652344,y=353.65585327148,z=87.868003845215},1}, --home at eclipse back 2
    {{x=-774.63720703125,y=331.50643920898,z=160.00144958496},{x=-771.12036132813,y=318.1640625,z=85.662567138672},1}, --home at eclipse main entrance 2
    {{x=-755.70623779297,y=334.61624145508,z=230.63687133789},{x=-761.83123779297,y=353.65585327148,z=87.860282897949},1}, --roof back 1
    
    {{x=-596.49578857422,y=56.059864044189,z=108.02702331543},{x=-614.59069824219,y=45.853183746338,z=43.591464996338},1}, --home at Tinsel towers
    {{x=-603.65313720703,y=58.958003997803,z=98.200202941895},{x=-621.07495117188,y=45.856052398682,z=43.591464996338},1}, --home at Tinsel towers
    {{x=-604.97869873047,y=51.153518676758,z=93.626129150391},{x=-636.29132080078,y=44.208354949951,z=42.69766998291},1}, --home at Tinsel towers
    
    {{x=-30.793453216553,y=-595.20989990234,z=80.030899047852},{x=-36.039257049561,y=-570.05126953125,z=38.833343505859},1}, --home at 4 Integrity way
    {{x=-18.444511413574,y=-591.36114501953,z=90.114807128906},{x=-14.568516731262,y=-612.93511962891,z=35.861480712891},1}, --home at 4 Integrity way
    {{x=-25.372816085815,y=-607.34533691406,z=100.2328414917},{x=-39.100040435791,y=-614.44342041016,z=35.268527984619},1}, --home at 4 Integrity way
    
    {{x=-907.68786621094,y=-453.58840942383,z=126.53441619873},{x=-906.79760742188,y=-451.81100463867,z=39.605278015137},1}, --home weasel plaza
    {{x=-890.73608398438,y=-436.62799072266,z=121.60710144043},{x=-909.53356933594,y=-446.46926879883,z=39.605278015137},1}, --home weasel plaza
    {{x=-890.71032714844,y=-452.80456542969,z=95.461090087891},{x=-914.08471679688,y=-443.30319213867,z=39.605293273926},1}, --home weasel plaza
    {{x=-888.82916259766,y=-443.88052368164,z=168.11874389648},{x=-908.36840820313,y=-455.20474243164,z=39.605278015137},1}, --roof(workaround)
    {{x=-888.82916259766,y=-443.88052368164,z=168.11874389648},{x=-907.28411865234,y=-457.83926391602,z=39.605293273926},1}, --roof
    
    {{x=-913.20983886719,y=-365.29461669922,z=114.27479553223},{x=-936.55914306641,y=-379.01208496094,z=38.961292266846},1}, --home richards majestic
    {{x=-907.26800537109,y=-372.271484375,z=109.440284729},{x=-933.64636230469,y=-384.37829589844,z=38.96134185791},1}, --home richards majestic
    {{x=-922.8896484375,y=-378.71728515625,z=85.480476379395},{x=-902.41082763672,y=-378.19281005859,z=38.961330413818},0}, --home richards majestic
    {{x=-908.51147460938,y=-369.88528442383,z=113.07417297363},{x=-903.18896484375,y=-370.01379394531,z=136.28221130371},0}, --roof richards majestic(from flat to helipad)
    
    --{{x=-273.23248291016,y=-967.24597167969,z=77.231407165527},{x=-293.78643798828,y=-957.40075683594,z=31.211786270142},1}, -- home 3 alta str
    --{{x=-269.96142578125,y=-941.06811523438,z=92.510902404785},{x=-266.59945678711,y=-956.03387451172,z=31.223134994507},1}, -- home 3 alta str norm
    
    {{x=-1370.6779785156,y=-503.3337097168,z=33.15739440918},{x=-1396.0753173828,y=-479.81362915039,z=72.042175292969},0},--my office
    {{x=-1392.8668212891,y=-479.35598754883,z=72.042175292969},{x=-1368.9675292969,y=-471.51470947266,z=84.446922302246},0},--my office helipad
    
    {{x=-66.987716674805,y=-822.03552246094,z=321.28732299805},{x=-76.518287658691,y=-826.76751708984,z=243.38597106934},1},--biggest building, maze tower roof
    --garage or heli shop on top of maze tower x=-74.26961517334,y=-817.82238769531,z=326.56411743164,angle=320.11834716797
    {{x=-66.977386474609,y=-802.21911621094,z=44.227298736572},{x=-77.63794708252,y=-829.80676269531,z=243.38597106934},1},--maze tower entrance
    --
    {{x=-136.60023498535,y=-596.10064697266,z=206.91572570801},{x=-140.41282653809,y=-620.84814453125,z=168.82055664063},1},--arcadius roof
    {{x=-116.81313323975,y=-604.64208984375,z=36.28071975708},{x=-140.70249938965,y=-617.53430175781,z=168.82055664063},1},--arcadius entrance
    --
    {{x=-1561.2158203125,y=-568.74938964844,z=114.44840240479},{x=-1578.7490234375,y=-564.43121337891,z=108.52295684814},0},--lom bank roof
    {{x=-1581.5513916016,y=-557.98529052734,z=34.953018188477},{x=-1580.8099365234,y=-561.62872314453,z=108.52295684814},0},--lom bank entrance
    
    --{{x=514.24072265625,y=4888.3081054688,z=-62.589630126953},{}} --doomsday submarine
    }
    while true do
        while not IsControlPressed(0,86) do Wait(10) end
        local ped=PlayerPedId()
        local pos=GetEntityCoords(ped)
        local x,y,z=pos.x,pos.y,pos.z
        for k,v in pairs(teleport) do
            local dx,dy,dz=x-v[1].x,y-v[1].y,z-v[1].z
            if v[3]==0 then
                if dz<.2 and dz>-.2 and dx*dx+dy*dy<1.0 then
                    SetEntityCoords(ped,v[2].x+dx,v[2].y+dy,v[2].z+dz)
                    Wait(1000)
                    break
                end
                dx,dy,dz=x-v[2].x,y-v[2].y,z-v[2].z
                if dz<.2 and dz>-.2 and dx*dx+dy*dy<1.0 then
                    SetEntityCoords(ped,v[1].x+dx,v[1].y+dy,v[1].z+dz)
                    Wait(1000)
                    break
                end
                DrawBox(v[1].x-1.0,v[1].y-1.0,v[1].z-.2,v[1].x+1.0,v[1].y+1.0,v[1].z+.2,255,0,0,100)
                DrawBox(v[2].x-1.0,v[2].y-1.0,v[2].z-.2,v[2].x+1.0,v[2].y+1.0,v[2].z+.2,255,0,0,100)
            elseif v[3]==1 then
                if math.abs(dz)<.2 and math.abs(dx)<1.0 and math.abs(dy)<1.0 then
                    SetEntityCoords(ped,v[2].x+dx,v[2].y+dy,v[2].z+dz)
                    Wait(1000)
                    break
                end
                dx,dy,dz=x-v[2].x,y-v[2].y,z-v[2].z
                if math.abs(dz)<.2 and math.abs(dx)<1.0 and math.abs(dy)<1.0 then
                    SetEntityCoords(ped,v[1].x+dx,v[1].y+dy,v[1].z+dz)
                    Wait(1000)
                    break
                end
                DrawBox(v[1].x-1.0,v[1].y-1.0,v[1].z-.2,v[1].x+1.0,v[1].y+1.0,v[1].z+.2,0,255,0,100)
                DrawBox(v[2].x-1.0,v[2].y-1.0,v[2].z-.2,v[2].x+1.0,v[2].y+1.0,v[2].z+.2,0,255,0,100)
            else --if (v[3]==2) then
                if math.abs(dz)<.2 and math.abs(dx)+math.abs(dy)<1.0 then
                    SetEntityCoords(ped,v[2].x+dx,v[2].y+dy,v[2].z+dz)
                    Wait(1000)
                    break
                end
                dx,dy,dz=x-v[2].x,y-v[2].y,z-v[2].z
                if math.abs(dz)<.2 and math.abs(dx)+math.abs(dy)<1.0 then
                    SetEntityCoords(ped,v[1].x+dx,v[1].y+dy,v[1].z+dz)
                    Wait(1000)
                    break
                end
                DrawBox(v[1].x-1.0,v[1].y-1.0,v[1].z-.2,v[1].x+1.0,v[1].y+1.0,v[1].z+.2,0,0,255,100)
                DrawBox(v[2].x-1.0,v[2].y-1.0,v[2].z-.2,v[2].x+1.0,v[2].y+1.0,v[2].z+.2,0,0,255,100)
            end
            -- SetTextComponentFormat("STRING")
            -- AddTextComponentString("~s~Press ~INPUT_VEH_HORN~ to use elevator.")
            -- DisplayHelpTextFromStringLabel(0,0,1,-1)
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped=PlayerPedId()
        pos=GetEntityCoords(ped)
        if (math.abs(pos.x+268.26617431641)+math.abs(pos.y+958.71459960938))<20.0 then
            if pos.z>35.0 and pos.z<36.0 then
                print("ragdolling z="..pos.z)
                SetHighFallTask(ped, 2000, -1, -1)
            end
        end
    end
end)

local fast_join_faction={}
fast_join_faction[GetHashKey("AMBIENT_GANG_LOST")]=switch_to_lost
--fast_join_faction[GetHashKey("COP")]=switch_to_cop
fast_join_faction[GetHashKey("AGGRESSIVE_INVESTIGATE")]=switch_to_merc
fast_join_faction[GetHashKey("MISSION2")]=switch_to_anarchy
fast_join_faction[GetHashKey("AMBIENT_GANG_BALLAS")]=switch_to_ballas
fast_join_faction[GetHashKey("AMBIENT_GANG_FAMILY")]=switch_to_fams
--fast_join_faction[GetHashKey("AMBIENT_GANG_MEXICAN")]=switch_to_vagos
fast_join_faction[GetHashKey("AMBIENT_GANG_SALVA")]=switch_to_salva
fast_join_faction[GetHashKey("AMBIENT_GANG_WEICHENG")]=switch_to_triads
fast_join_faction[GetHashKey("AMBIENT_GANG_MARABUNTE")]=switch_to_armmob
fast_join_faction[GetHashKey("MISSION3")]=switch_to_heister
--fast_join_faction[GetHashKey("AMBIENT_GANG_MEXICAN")]=switch_to_cartel
fast_join_faction[GetHashKey("MISSION4")]=switch_to_elite

RegisterNetEvent(event.savenquit_load)
AddEventHandler(event.savenquit_load,function(pos,model,components,props,health,armor,weapons,ammo,relationship,textures)
    while GetEntityModel(PlayerPedId())~=model do Wait(50) end
    Wait(600)
    if model==941695432 then
        switch_to_fbi()
        Wait(100)
        givescubagear(PlayerPedId())
        return
    elseif model==365775923 then
        switch_to_criminal()
        Wait(100)
        givescubagear(PlayerPedId())
        return 
    elseif model==225514697 then
        switch_to_merc()
        Wait(100)
        givescubagear(PlayerPedId())
        return 
    elseif model==-1686040670 then
        switch_to_heister()
        Wait(100)
        givescubagear(PlayerPedId())
        return 
    elseif model==-1692214353 then
        switch_to_elite()
        Wait(100)
        givescubagear(PlayerPedId())
        return
    end
    local fjf=fast_join_faction[relationship]
    if fjf~=nil then
     fjf()
    else
     if allies_cartel[model]~=nil then
      switch_to_cartel()
     elseif allies_vagos[model]~=nil then
      switch_to_vagos()
     else
      if model==-1920001264 then
       if components[10+1]==0 and textures[10+1]==1 then
        switch_to_fbiswat()
       else
        switch_to_noose()
       end
       return
      end
      for k,v in pairs(SKINS.FBISWAT) do
       if model==v then
        switch_to_fbiswat()
        break
       end
      end
      for k,v in pairs(SKINS.LSFD) do
       if model==v then
        switch_to_firefighters()
        break
       end
      end
      for k,v in pairs(SKINS.MEDICS) do
       if model==v then
        switch_to_paramedics()
        break
       end
      end
      for k,v in pairs(SKINS.FBI) do
       if model==v then
        switch_to_fbi()
        break
       end
      end
      for k,v in pairs(SKINS.LSPD) do
       if model==v then
        if components[9+1]==2 then
            switch_to_lspdheavy()
        else
            switch_to_lspd()
        end
        break
       end
      end
      for k,v in pairs(SKINS.DETECTIVES) do
       if model==v then
            switch_to_detectives()
        break
       end
      end
      for k,v in pairs(SKINS.SSPD) do
       if model==v then
        switch_to_sspd()
        break
       end
      end
      for k,v in pairs(SKINS.SAHP) do
       if model==v then
        switch_to_sahp()
        break
       end
      end
      for k,v in pairs(SKINS.SAPR) do
       if model==v then
        switch_to_sapr()
        break
       end
      end
      -- for k,v in pairs(SKINS.NOOSE) do
       -- if model==v then
        -- switch_to_noose()
        -- break
       -- end
      -- end
      for k,v in pairs(SKINS.MILITARY) do
       if model==v then
        switch_to_military()
        break
       end
      end
      for k,v in pairs(SKINS.NAVY) do
       if model==v then
        switch_to_navy()
        break
       end
      end
     end
    end
    --Wait(100)
    --if is_model_scuba(model) then givescubagear(PlayerPedId()) end
end)

Citizen.CreateThread(function()
    local blip
    local blips
    local function atan2(x,y)
        if x > 0 then
            return math.atan(y / x)
        end

        if x < 0 and y >= 0 then
            return math.atan(y / x) + math.pi
        end

        if x < 0 and y < 0 then
            return math.atan(y / x) - math.pi
        end

        if x == 0 and y > 0 then
            return math.pi / 2
        end

        if x == 0 and y < 0 then
            return - (math.pi / 2)
        end

        if x == 0 and y == 0 then
            return nil
        end
    end
    while true do
        local playerid=PlayerId()
            --if ArePlayerStarsGreyedOut(playerid) then
            --    WriteText(0,"PlayerStarsGreyedOut",0.45,255,255,255,255,0.16,0.35)
            --end
            --if ArePlayerFlashingStarsAboutToDrop(playerid) then
            --    WriteText(0,"PlayerFlashingStarsAboutToDrop",0.45,255,255,255,255,0.16,0.4)
            --    --print("PlayerFlashingStarsAboutToDrop")
            --end
        if player.is_cop then
            local faster=false
            pos=GetEntityCoords(PlayerPedId())
            if blips==nil then
                blips={}
            end
            local show_cones=GetPlayerWantedLevel(playerid)>0 and ArePlayerStarsGreyedOut(playerid)
            for i = 0, 31 do
                if NetworkIsPlayerActive(i) then
                    if i~=playerid then --enable/disable cones on player cops
                        local cop=GetPlayerPed(i)
                        if IsPedCop(cop) then
                            local cop_blip=GetBlipFromEntity(cop)
                            if cop_blip~=0 then SetBlipShowCone(cop_blip,show_cones) end
                        end
                    end
                    if GetPlayerWantedLevel(i)>0 then
                        local b=blips[i]
                        local spos=GetPlayerWantedCentrePosition(i)
                        local dx,dy=pos.x-spos.x,pos.y-spos.y
                        local dist=dx*dx+dy*dy
                        if dist>10000.0 then
                            dist=100.001
                        else
                            local dz=pos.z-spos.z
                            if dist+dz*dz<10000.0 then faster=true end
                            if dist<4.0 then
                                dist=2.001
                            else
                                dist=math.sqrt(dist)--*.5
                            end
                        end
                        if b==nil then
                            b=AddBlipForRadius(spos.x,spos.y,spos.z,1.0)
                            blips[i]=b
                            SetBlipDisplay(b, 2)
                            SetBlipSprite(b,9)
                            SetBlipColour(b,3)
                            SetBlipAlpha(b,100)
                            SetBlipScale(b,dist)
                        else
                            SetBlipCoords(b,spos.x,spos.y,spos.z)
                            SetBlipScale(b,dist)
                        end
                    elseif blips[i]~=nil then --player is active but not wanted
                        RemoveBlip(blips[i])
                        blips[i]=nil
                    end
                elseif blips[i]~=nil then --player is inactive
                    RemoveBlip(blips[i])
                    blips[i]=nil
                end
            end
            if blip~=nil then
                RemoveBlip(blip)
                blip=nil
            end
            if faster then
                Wait(100)
            else
                Wait(1000)
            end
        else--im not a cop
            if player.wanted>0 and GetPlayerWantedLevel(playerid)>0 and player.wanted==GetPlayerWantedLevel(playerid) then
                local myped=PlayerPedId()
                pos=GetEntityCoords(myped)
                local wpos=GetPlayerWantedCentrePosition(playerid)
                if blip==nil then
                    blip=AddBlipForRadius(wpos.x,wpos.y,wpos.z,100.0)
                    SetBlipDisplay(blip, 2)
                    SetBlipSprite(blip,9)
                    SetBlipColour(blip,3)
                    SetBlipAlpha(blip,100)
                else
                    SetBlipCoords(blip,wpos.x,wpos.y,wpos.z)
                end
                local show_cones=ArePlayerStarsGreyedOut(playerid)
                for i = 0, 31 do
                    if i~=playerid and NetworkIsPlayerActive(i) then
                        local cop=GetPlayerPed(i)
                        if IsPedCop(cop) then
                            local cop_blip=GetBlipFromEntity(cop)
                            local cop_pos=GetEntityCoords(cop)
                            if cop_blip~=0 then SetBlipShowCone(cop_blip,show_cones) end
                            local dx,dy=pos.x-cop_pos.x,pos.y-cop_pos.y
                            local dist=dx*dx+dy*dy
                            if dist<4500.0 then
                                local dz=pos.z-cop_pos.z
                                local heading=(GetEntityHeading(cop))*(math.pi/180.0)
                                local dir=atan2(dx,dy)
                                --WriteText(0,"he "..heading,0.45,255,255,255,255,0.16,0.45)
                                if dir~=nil then
                                    --WriteText(0,"dr "..dir,0.45,255,255,255,255,0.16,0.5)
                                    local angle=heading-dir
                                    --WriteText(0,"a "..angle,0.45,255,255,255,255,0.16,0.55)
                                    if angle>3.5 and angle<5.7 or angle>-2.6 and angle<-.5 then
                                        if HasEntityClearLosToEntity(cop,myped,17) then
                                            --WriteText(0,"can see",0.45,255,255,255,255,0.16,0.9)
                                            if show_cones then
                                                SetPlayerWantedLevel(playerid,0,false)
                                                SetPlayerWantedLevelNow(playerid,false)
                                            end
                                            SetPlayerWantedLevel(playerid,player.wanted,false)
                                            SetPlayerWantedLevelNow(playerid,false)
                                            SetPlayerWantedCentrePosition(playerid,pos.x,pos.y,pos.z)
                                        end
                                        --WriteText(0,"in cone",0.45,255,255,255,255,0.16,0.85)
                                    end
                                end
                                --WriteText(0,"in radius",0.45,255,255,255,255,0.16,0.8)
                            end
                            --WriteText(0,"dx "..dx,0.45,255,255,255,255,0.16,0.6)
                            --WriteText(0,"dy "..dy,0.45,255,255,255,255,0.16,0.65)
                            --WriteText(0,"sd "..dist,0.45,255,255,255,255,0.16,0.7)
                        end
                    end
                end
            else
                for i = 0, 31 do --disable cones on player cops
                    if i~=playerid and NetworkIsPlayerActive(i) then
                        local cop=GetPlayerPed(i)
                        if IsPedCop(cop) then
                            local cop_blip=GetBlipFromEntity(cop)
                            if cop_blip~=0 then SetBlipShowCone(cop_blip,false) end
                        end
                    end
                end
                if blip~=nil then
                    RemoveBlip(blip)
                    blip=nil
                end
            end
            if blips~=nil then
                for k,v in pairs(blips) do
                    RemoveBlip(v)
                end
                blips=nil
            end
            Wait(0)
        end
    end
end)

--RegisterNetEvent(event.savenquit_none) --moved into main event handler
--AddEventHandler(event.savenquit_none,function(seed)
--    switch_to_criminal()
--end)

-- local function cops_aim_but_dont_shoot()
    -- local player_ped=PlayerPedId()
    -- for cop in EnumeratePeds() do
        -- if not IsPedAPlayer(cop) and GetPedRelationshipGroupHash(cop)==relationship_cop and not IsEntityDead(cop) then
            -- if IsPedInCombat(cop,player_ped) then
                -- ClearPedTasks(cop)
                -- TaskGotoEntityAiming(cop, player_ped, 3.0, 3.0)
            -- end
        -- end
    -- end
-- end

-- local function cops_aim_but_dont_shoot_loop()
    -- while player.surrendering do
        -- cops_aim_but_dont_shoot()
        -- Wait(0)
    -- end
-- end

local function ArrestedByNPCCop()
    local wanted=GetPlayerWantedLevel(PlayerId())
    local cost=0
    local timestamp=GetGameTimer()
    --print("wantedlevel="..wanted)
    if wanted == 1 then
        cost=math.floor(player.money*0.4)
    elseif wanted == 2 then
        cost=math.floor(player.money*0.6)
    elseif wanted == 3 then
        cost=math.floor(player.money*0.7)
    elseif wanted == 4 then
        cost=math.floor(player.money*0.8)
    elseif wanted == 5 then
        cost=math.floor(player.money*0.95)
    end
        player.money=player.money-cost
        removemoney(player.money,cost)
        TriggerServerEvent(event.buy,cost)
    --print("wantedlevel="..wanted)
    player.wanted=0
    SetPlayerWantedLevel(PlayerId(),0,false)
    SetPlayerWantedLevelNow(PlayerId(),false)
    SetMaxWantedLevel(0);
    SetEnableHandcuffs(PlayerPedId(),true)
    TriggerServerEvent(event.wanted,0)
    while GetGameTimer()<timestamp+5000 do
        local ped=PlayerPedId()
        SetPedToRagdoll(ped,5000,1000,0,true,true,false)
        Wait(0)
    end
    TriggerEvent(event.savenquit_none,math.random(0,0xFFFFFF),"You got arrested and lost $"..cost)
    Wait(10000)
    SetEnableHandcuffs(PlayerPedId(),false)
    Wait(1000)
    player.surrendering=false
end

local function player_surrendering_loop()
    local relationship_cop=GetHashKey("COP")
    local timestamp=GetGameTimer()
    while player.surrendering do
        local ped=PlayerPedId()
        local mindist=5.0
        for cop in EnumeratePeds() do
            if not IsPedAPlayer(cop) and GetPedRelationshipGroupHash(cop)==relationship_cop and not IsEntityDead(cop) then
                if IsPedInCombat(cop,ped) then
                    ClearPedTasks(cop)
                    TaskGotoEntityAiming(cop, ped, 3.0, 3.0)
                end
                local cop_pos=GetEntityCoords(cop)
                local dist=math.abs(pos.x-cop_pos.x)+math.abs(pos.y-cop_pos.y)+math.abs(pos.z-cop_pos.z)
                if dist<mindist then mindist=dist end
                --TaskAimGunAtEntity(cop,ped,500,true)
                --TaskShootAtEntity(cop, ped, 100, GetHashKey("FIRING_PATTERN_FROM_GROUND"));
                --SetPedKeepTask(cop, true);
            end
        end
        DrawRect(.5,.9,.2,.025,0,0,0,255);
        if mindist>4.9 then
            timestamp=GetGameTimer()
        else
            local timepassed=GetGameTimer()-timestamp
            if timepassed>10000 then
                Citizen.CreateThread(ArrestedByNPCCop)
                Wait(0)
                while player.surrendering do
                    local player_ped=PlayerPedId()
                    for cop in EnumeratePeds() do
                        if not IsPedAPlayer(cop) and GetPedRelationshipGroupHash(cop)==relationship_cop and not IsEntityDead(cop) then
                            if IsPedInCombat(cop,player_ped) then
                                ClearPedTasks(cop)
                                TaskGotoEntityAiming(cop, player_ped, 3.0, 3.0)
                            end
                        end
                    end
                    DrawRect(.5,.9,.2,.025,0,0,0,255);
                    Wait(0)
                end
                return;
            else
                DrawRect(.4+timepassed*.00001, .9, timepassed*.00002, .025,255,0,0,255);
            end
        end
        Wait(0)
    end
end


Citizen.CreateThread(function()
    --local dict,anim='random@arrests','kneeling_arrest_idle'
    local dict,anim='random@arrests@busted','idle_a'
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
    while true do
        Wait(0)
        local ped=PlayerPedId()
        if (not IsPedInAnyVehicle(ped)) and IsControlPressed(0,74) then
            if player.is_cop then
                --print("arresting")
                local cop=PlayerPedId()
                local pos=GetEntityCoords(cop)
                local taken=false
                for i=0,31 do
                    if NetworkIsPlayerActive(i) then
                            --print("network done")
                    local suspect=GetPlayerPed(i)
                    if suspect~=nil then 
                            --print("1 check done")
                    if suspect~=0 then 
                            --print("2 check done")
                    if suspect~=cop then
                            --print("3 check done")
                    if (IsEntityPlayingAnim(suspect,dict,anim,3) or IsPedRagdoll(suspect)) and allies_government[GetEntityModel(suspect)]==nil then
                            --print("check done")
                        local suspect_pos=GetEntityCoords(suspect)
                        local dx,dy,dz=suspect_pos.x-pos.x,suspect_pos.y-pos.y,suspect_pos.z-pos.z
                        if dx*dx+dy*dy+dz*dz<4.0 then
                            --print("sending event")
                            TriggerServerEvent(event.take_suspect_alive,GetPlayerServerId(i))
                            taken=true
                        end
                    end
                    end
                    end
                    end
                    end
                end
                if taken then
                    Wait(1000)
                end
            else
                --print("surrender")
                ClearPedTasks(ped)
                RequestAnimDict(dict)
                TaskPlayAnim(ped, dict, anim, 2.0, -8.0, -1, 0, 0, 0, 0, 0)
                Wait(2000)
                player.surrendering=true
                Citizen.CreateThread(player_surrendering_loop)
                while player.surrendering and not IsControlPressed(0,21) do
                    TaskPlayAnim(ped, dict, anim, 2.0, -8.0, -1, 0, 0, 0, 0, 0)
                    SetNotificationTextEntry("STRING");
                    AddTextComponentString("Hold ~g~SPRINT ~s~button to stop surrendering.")
                    DrawNotification(false, false);
                    if IsControlPressed(0,21) or not player.surrendering then break end
                    Wait(1000)
                    if IsControlPressed(0,21) or not player.surrendering then break end
                    Wait(1000)
                    if IsControlPressed(0,21) or not player.surrendering then break end
                    Wait(1000)
                end
                player.surrendering=false
                Wait(1000)
                --TriggerServerEvent("fragile-alliance:surrender")
                ClearPedTasks(PlayerPedId())
            end
        end
    end
end)

-- Citizen.CreateThread(function()
    -- local hashes={
    -- [-1205689942]=true,
    -- [-34623805]=true,
    -- }
    -- while true do
        -- Wait(500)
        -- for veh in EnumerateVehicles() do
            -- local ped=GetPedInVehicleSeat(veh,-1)
            -- if (not IsPedAPlayer(ped)) and hashes[GetEntityModel(veh)] then
                -- SetSirenWithNoDriver(veh, true)
                -- SetVehicleSiren(veh,true)
                -- --SetVehicleAlarm(veh,true)
            -- end
        -- end
    -- end
-- end)

Citizen.CreateThread(function()
    while true do
        Wait(300)
        for ped in EnumeratePeds() do
            if not IsPedAPlayer(ped) then
                if GetPedArmour(ped)>0 then
                    SetPedRagdollBlockingFlags(ped,1)
                else
                    ResetPedRagdollBlockingFlags(ped,1)
                end
            end
        end
    end
end)
        
Citizen.CreateThread(function()
    local relationship_cop=GetHashKey("COP")
    local fbicar=1127131465
    local granger=-1647941228
    local sheriffgranger=1922257928
    local riot=-1205689942
    local insurgent=2071877360
    local policebike=-34623805
    local policecar=1912215274
    local sheriffpolicecar=-1683328900
    local policevan=456714581
    local policefastcar=-1627000575
    local policestealth=-1973172295
    local crusader=321739290
    local barracks=-823509173
    local rcv=-1693015116
    --local maxseats=8
    local grangerpos
    local grangerhead
    
    local copmodel=1581098148
    local detectivemodel=GetHashKey("s_m_m_dick_01")
    local sheriffmodel=-1320879687
    local policebikeRmodel=1939545845
    local swatcopmodel=-1920001264
    local fbiped=2072724299
    local heavyarmy=1925237458
    local army1=-220552467
    local army2=1702441027
    local grsechs=-839953400
    RequestModel(detectivemodel)
    RequestModel(riot)
    RequestModel(insurgent)
    RequestModel(policebike)
    --RequestModel(granger)
    RequestModel(fbicar)
    RequestModel(fbiped) --fbi ped
    RequestModel(policebikeRmodel) --patrol highway bike ped
    RequestModel(policevan)
    RequestModel(crusader)
    RequestModel(policestealth)
    RequestModel(policefastcar)
    RequestModel(barracks)
    RequestModel(rcv)
    RequestModel(heavyarmy)
    RequestModel(grsechs)
    
    local veh_count={}
    local ped_count={}
    
    local custom_dispatch_123={
     {mdl=policebike,--vehicle model
      limits={
       {veh_count,policebike,2},
       {ped_count,policebikeRmodel,2},
      },
      team={--team
       [-1]={--driver
        need=60000,--don't call no longer needed
        type=6,--cop
        mdl=policebikeRmodel,
        rndp=true,--random props
        prop={{0,0,0}},--helmet
        wpns={--weapons
         [WEAPON.COMBATPISTOL]={}
        }
       }
      }
     },
     {mdl=policestealth,--vehicle model
      limits={
       {veh_count,policestealth,2},
       {ped_count,detectivemodel,4},
      },
      team={--team
       [-1]={--driver
        need=60000,--don't call no longer needed
        type=6,
        cop=true,--set ped as cop
        rel=relationship_cop,
        mdl=detectivemodel,
        rndp=true,
        wpns={--weapons
         [WEAPON.COMBATPISTOL]={}
        }
       },
       [0]={
        need=60000,--don't call no longer needed
        type=6,
        cop=true,--set ped as cop
        rel=relationship_cop,
        mdl=detectivemodel,
        rndp=true,
        wpns={--weapons
         [WEAPON.PISTOL]={}
        }
       }
      },
     },
     {mdl=policefastcar,--vehicle model
      limits={
       {veh_count,policefastcar,1},
       {ped_count,policebikeRmodel,2},
      },
      team={--team
       [-1]={--driver
        need=60000,--don't call no longer needed
        type=6,--cop
        mdl=policebikeRmodel,
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.REVOLVER]={}
        }
       },
      },
     },
     {mdl=rcv,--vehicle model
      limits={
       {veh_count,rcv,1},
       {ped_count,grsechs,4},
      },
      team={--team
       [-1]={--driver
        need=60000,--don't call no longer needed
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        mdl=grsechs,
        rndp=true,
        dontleavecar=true,
        melee=true,
        prop={{0,1,0}},--helmet
        armor=150,
        wpns={--weapons
         [WEAPON.NIGHTSTICK]={}
        }
       },
       [0]={
        need=60000,--don't call no longer needed
        type=6,
        cop=true,--set ped as cop
        rel=relationship_cop,
        mdl=grsechs,
        rndp=true,
        melee=true,
        prop={{0,1,0}},--helmet
        armor=150,
        wpns={--weapons
         [WEAPON.NIGHTSTICK]={}
        }
       },
       [1]={
        need=60000,--don't call no longer needed
        type=6,
        cop=true,--set ped as cop
        rel=relationship_cop,
        mdl=grsechs,
        rndp=true,
        melee=true,
        prop={{0,1,0}},--helmet
        armor=150,
        wpns={--weapons
         [WEAPON.NIGHTSTICK]={}
        }
       },
       [2]={
        need=60000,--don't call no longer needed
        type=6,
        cop=true,--set ped as cop
        rel=relationship_cop,
        mdl=grsechs,
        rndp=true,
        melee=true,
        armor=150,
        prop={{0,1,0}},--helmet
        wpns={--weapons
         [WEAPON.NIGHTSTICK]={}
        }
       },
      },
     },
    }
    
    local custom_dispatch_45={
     {mdl=riot,--vehicle model
      rem=true,--remove anyway
      limits={
      {ped_count,swatcopmodel,4},
      {veh_count,riot,1},
      },
      team={--team
       [-1]={--driver
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        type=27,--swat
        rndp=true,
        prop={{0,0,0}},--helmet
        wpns={--weapons
         [WEAPON.SMG]={upgr={'flashlight'}},
        }
       },
       [0]={--codriver
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        type=27,--swat
        rndp=true,
        prop={{0,0,0}},--helmet
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={upgr={'grip','flashlight'}},
        }
       },
       [1]={--backleft
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        type=27,--swat
        rndp=true,
        --prop={{0,0,0}},--helmet
        wpns={--weapons
         [WEAPON.MARKSMANRIFLE]={}
        }
       },
       [2]={--backright
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        type=27,--swat
        rndp=true,
        prop={{0,0,0}},--helmet
        wpns={--weapons
         [WEAPON.SPECIALCARBINE]={upgr={'scope','grip','flashlight'}}
        }
       },
      }
     },
     {mdl=fbicar,--FBI Buffalo
      rem=true,--remove anyway
      limits={
      {ped_count,fbiped,4},
      {veh_count,fbicar,1},
      },
      team={
       [-1]={
        mdl=fbiped,
        need=60000,--don't call no longer needed
        type=27,--swat
        cop=true,--set ped as cop
        rel=relationship_cop,
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.SMG]={upgr={'scope'}},
         [WEAPON.HEAVYPISTOL]={},
        }
       },
       [0]={
        mdl=fbiped,
        need=60000,--don't call no longer needed
        type=27,--swat
        cop=true,--set ped as cop
        rel=relationship_cop,
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.MICROSMG]={upgr={'silencer','extendedmag'}},
        }
       },
       [1]={
        mdl=fbiped,
        need=60000,--don't call no longer needed
        type=27,--swat
        cop=true,--set ped as cop
        rel=relationship_cop,
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.COMBATPDW]={upgr={'grip','scope'}},
         [WEAPON.HEAVYPISTOL]={},
        }
       },
       [2]={
        mdl=fbiped,
        need=60000,--don't call no longer needed
        type=27,--swat
        cop=true,--set ped as cop
        rel=relationship_cop,
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.SMG]={upgr={'grip','scope','silencer'}},
         [WEAPON.HEAVYPISTOL]={},
        }
       },
      }
     },
     {mdl=policevan,--FBI Grangler
      rem=true,--remove anyway
      limits={
      {ped_count,copmodel,4},
      {veh_count,policevan,1},
      },
      team={
       [-1]={
        mdl=copmodel,
        need=60000,--don't call no longer needed
        comp={{9,2,0,0}},
        type=6,--swat
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.SMG]={upgr={'flashlight'}},
        }
       },
       [0]={
        mdl=copmodel,
        need=60000,--don't call no longer needed
        comp={{9,2,0,0}},
        type=6,--swat
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.SMG]={upgr={'flashlight'}},
        }
       },
       [1]={
        mdl=copmodel,
        need=60000,--don't call no longer needed
        comp={{9,2,0,0}},
        type=6,--swat
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.PUMPSHOTGUN]={upgr={'flashlight'}},
        }
       },
       [2]={
        mdl=copmodel,
        need=60000,--don't call no longer needed
        comp={{9,2,0,0}},
        type=6,--swat
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={upgr={'flashlight'}},
        }
       },
      }
     },
      {mdl=granger,--FBI Grangler
      rem=true,--remove anyway
      limits={
      {ped_count,swatcopmodel,2},
      {ped_count,fbiped,2},
      {veh_count,granger,1},
      },
      team={
       [-1]={
        mdl=fbiped,
        need=60000,--don't call no longer needed
        type=27,--swat
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.ASSAULTSMG]={},
        }
       },
       [0]={
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        comp={{10,0,1,0}},
        type=27,--swat
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.ASSAULTSMG]={upgr={'scope','flashlight','silencer'}},
        }
       },
       [1]={
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        comp={{10,0,1,0}},
        type=27,--swat
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.ADVANCEDRIFLE]={upgr={'scope','grip'}},
        }
       },
       [2]={
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        comp={{10,0,1,0}},
        type=27,--swat
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={upgr={'scope','grip','silencer'}},
        }
       },
      }
     },
     {mdl=crusader,--vehicle model
      rem=true,--remove anyway
      limits={
      {ped_count,heavyarmy,4},
      {veh_count,crusader,1},
      },
      team={
       [-1]={
        mdl=heavyarmy,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.SMG]={tint=4},
        }
       },
       [0]={
        mdl=heavyarmy,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
         [WEAPON.COMBATPISTOL]={},
        }
       },
       [1]={
        mdl=heavyarmy,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
         [WEAPON.COMBATPISTOL]={},
        }
       },
       [2]={
        mdl=heavyarmy,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.COMBATMG]={tint=4},
         [WEAPON.COMBATPISTOL]={},
        }
       },
      }
     },
     {mdl=barracks,--vehicle model
      rem=true,--remove anyway
      limits={
      {ped_count,army1,4},
      {ped_count,army2,4},
      {ped_count,heavyarmy,4},
      {veh_count,barracks,1},
      },
      team={
       [-1]={
        mdl=army1,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.SMG]={tint=4},
        }
       },
       [0]={
        mdl=army2,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.SMG]={tint=4},
        }
       },
       [1]={
        mdl=army1,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
        }
       },
       [2]={
        mdl=army1,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
        }
       },
       [3]={
        mdl=army1,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
        }
       },
       [4]={
        mdl=army2,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
        }
       },
       [5]={
        mdl=army1,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.COMBATMG]={tint=4},
        }
       },
       [6]={
        mdl=heavyarmy,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.COMBATMG]={tint=4},
        }
       },
       [7]={
        mdl=army2,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
        }
       },
       [8]={
        mdl=heavyarmy,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        armor=100,
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
        }
       },
       [9]={
        mdl=army1,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
        }
       },
       [10]={
        mdl=army1,
        type=29,--army
        cop=true,--set ped as cop
        rel=relationship_cop,
        need=60000,--don't call no longer needed
        rndp=true,--random props
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={tint=4},
        }
       },
      }
     },
     {mdl=insurgent,--vehicle model
      rem=true,--remove anyway
      limits={
      {ped_count,swatcopmodel,4},
      {veh_count,insurgent,1},
      },
      clr1=11,--color 1
      clr2=11,--color 2
      team={--team
       [-1]={--driver
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        type=27,--swat
        rndp=true,
        prop={{0,0,0}},--helmet
        wpns={--weapons
         [WEAPON.SMG]={upgr={'flashlight'}},
        }
       },
       [0]={--codriver
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        type=27,--swat
        rndp=true,
        prop={{0,0,0}},--helmet
        wpns={--weapons
         [WEAPON.CARBINERIFLE]={upgr={'grip','flashlight'}},
        }
       },
       [1]={--backleft
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        type=27,--swat
        rndp=true,
        --prop={{0,0,0}},--helmet
        wpns={--weapons
         [WEAPON.MARKSMANRIFLE]={}
        }
       },
       [2]={--backright
        mdl=swatcopmodel,
        need=60000,--don't call no longer needed
        type=27,--swat
        rndp=true,
        prop={{0,0,0}},--helmet
        wpns={--weapons
         [WEAPON.SPECIALCARBINE]={upgr={'scope','grip','flashlight'}}
        }
       },
      }
     },
    }
    
    local unwanted_cars={}
    unwanted_cars[policecar]={copmodel,custom_dispatch_123}
    unwanted_cars[sheriffpolicecar]={sheriffmodel,custom_dispatch_123}
    unwanted_cars[granger]={swatcopmodel,custom_dispatch_45}
    unwanted_cars[sheriffgranger]=unwanted_cars[granger]
    
   for model,model_dispatch in pairs(unwanted_cars) do
    for squadtype,squad_data in pairs(model_dispatch[2]) do
     if squad_data.limits~=nil then
      for _,list_model_max in pairs(squad_data.limits) do
       if list_model_max[1]==ped_count then
        ped_count[list_model_max[2]]=0
       elseif list_model_max[1]==veh_count then
        veh_count[list_model_max[2]]=0
       end
      end
     end
     for seat,member in pairs(squad_data.team) do
      for weaponhash,weapon_data in pairs(member.wpns) do
       if weapon_data.upgr~= nil then
        for upgrade_index,upgradename in pairs(weapon_data.upgr) do
         if weapon_upgrades[upgradename]~=nil then
          weapon_data.upgr[upgrade_index]=weapon_upgrades[upgradename][weaponhash]
         end
        end
       end
      end
     end
    end
   end
    -- print("peds")
    -- for k,v in pairs(ped_count) do
        -- print(k.." "..v)
    -- end
    -- print("vehs")
    -- for k,v in pairs(veh_count) do
        -- print(k.." "..v)
    -- end
  Wait(15000)
    --GiveWeaponToPed(PlayerPedId(), WEAPON.APPISTOL, 1000, false, true)
    --SetPlayerWantedLevel(PlayerId(),4,false)
    --SetPlayerWantedLevelNow(PlayerId(),false)
  while true do
   for k,v in pairs(ped_count) do ped_count[k]=0 end
   for k,v in pairs(veh_count) do veh_count[k]=0 end
   local timestamp=GetSyncTimer()
   for ped in EnumeratePeds() do
    if not IsPedAPlayer(ped) then
     if GetEntityHealth(ped)==0 then
      if DecorExistOn(ped,decor.corpseremovaltimestamp) then
          if DecorGetInt(ped,decor.corpseremovaltimestamp)<timestamp then
              RemovePedElegantly(ped)
          end
      else
          DecorSetInt(ped,decor.corpseremovaltimestamp,timestamp+20000)
      end
     elseif DecorExistOn(ped,decor.customdispatchtimestamp) and DecorGetInt(ped,decor.customdispatchtimestamp)<timestamp then
      SetPedAsNoLongerNeeded(ped)
     end
     local model=GetEntityModel(ped)
     if ped_count[model]~=nil then
       ped_count[model]=ped_count[model]+1
     end
    end
   end
   local vehicles_to_remove={}
   for veh in EnumerateVehicles() do
    local model=GetEntityModel(veh)
    if veh_count[model]~=nil then
     veh_count[model]=veh_count[model]+1
    end
    local unwanted_car=unwanted_cars[model]
    if unwanted_car~=nil and not DecorExistOn(veh,decor.dontchangemodel) then
     --DecorSetBool(veh,decor.dontchangemodel)
     local ped=GetPedInVehicleSeat(veh,-1)
     if ped~=0 and not IsPedAPlayer(ped) and GetEntityModel(ped)==unwanted_car[1] then
      local disp=unwanted_car[2]
      local squad_data=disp[1+(math.abs(GetHashKey(GetVehicleNumberPlateText(veh)))%(#disp))]
      vehicles_to_remove[veh]=squad_data
     end
    -- elseif model==rcv then
     -- local driver=GetPedInVehicleSeat(veh,-1)
     -- if driver==0 then
      -- driver=GetLastPedInVehicleSeat(veh,-1)
      -- if driver~=0 and not IsPedAPlayer(driver) and not IsPedGettingIntoAVehicle(driver) then
       -- --TaskEnterVehicle(driver,veh,2000,-1,1.0,1,0)
       -- SetPedIntoVehicle(driver, veh, -1);
      -- end
     -- elseif not IsPedAPlayer(driver) then
      -- ControlMountedWeapon(driver)
     -- end
    end
   end
    for oldveh,squad_data in pairs(vehicles_to_remove) do
      if squad_data.limits~=nil then
       for _,list_model_max in pairs(squad_data.limits) do
        if list_model_max[1][list_model_max[2]]>=list_model_max[3] then
         if squad_data.rem then
          SetEntityAsMissionEntity(oldveh,true,true)
          DeleteVehicle(oldveh)
         else
          DecorSetBool(oldveh,decor.dontchangemodel)
         end
         goto too_many
        end
       end
      end
      SetEntityAsMissionEntity(oldveh,true,true)
      local pos=GetEntityCoords(oldveh)
      local angle=GetEntityHeading(oldveh)
      DeleteVehicle(oldveh)
      
      if veh_count[squad_data.mdl]~=nil then veh_count[squad_data.mdl]=veh_count[squad_data.mdl]+1 end
      local veh=CreateVehicle(squad_data.mdl,pos.x,pos.y,pos.z-.99,angle,true,false)
      SetVehicleColorsEnhanced(veh,squad_data.clr1,squad_data.clr2)
      for seat,member in pairs(squad_data.team) do
       if ped_count[member.mdl]~=nil then ped_count[member.mdl]=ped_count[member.mdl]+1 end
       local ped=CreatePedInsideVehicle(veh,member.type,member.mdl,seat,true,false)
       if member.cop then SetPedAsCop(ped,true) end
       if member.rel~=nil then
        SetPedRelationshipGroupHash(ped,member.rel)
       end
       if member.dontleavecar then
       --SetVehicleDoorsLockedForAllPlayers(veh, true)
       --SetVehicleDoorsLocked(veh, 4)
        --TaskWarpPedIntoVehicle(ped, veh, -1);
        makepedcombatreadydriver(ped)
        --SetVehicleDoorLatched(veh,0,true,true,false)
        --TaskEnterVehicle(ped,veh,20000,-1,1.0,1,0)
        --SetPedIntoVehicle(ped, veh, -1);
       else
        makepedcombatready(ped)
       end
       if member.melee then SetPedCombatMovement(ped,3) end
       if member.rndp then SetPedRandomProps(ped) end
       if member.rndc then SetPedRandomComponentVariation(ped,false) end
       if member.prop~=nil then
        for _,v in pairs(member.prop) do
         SetPedPropIndex(ped,v[1],v[2],v[3],true)
        end
       end
       if member.comp~=nil then
        for _,v in pairs(member.comp) do
         SetPedComponentVariation(ped,v[1],v[2],v[3],v[4])
        end
       end
       if member.armor~=nil then
        SetPedArmour(ped,member.armor)
       end
       for weaponhash,weapon_data in pairs(member.wpns) do
        GiveWeaponToPed(ped,weaponhash,1000,false,true)
        if weapon_data.tint~=nil then SetPedWeaponTintIndex(ped,weaponhash,weapon_data.tint) end
        if weapon_data.upgr~=nil then
         for upgrade_index,upgradehash in pairs(weapon_data.upgr) do
          GiveWeaponComponentToPed(ped,weaponhash,upgradehash)
         end
        end
       end
       if member.need~=nil then
        DecorSetInt(ped,decor.customdispatchtimestamp,timestamp+member.need)
       else
        SetPedAsNoLongerNeeded(ped)
       end
      end
      SetVehicleAsNoLongerNeeded(veh)
      ::too_many::
    end
    -- мусоровоз для военных 
    -- максимум военных - 16
    -- удалять трупы heavyarmy, army1, army2
    -- не спавнить crusader и barracks если военных больше 16 (я код для barracks еще не написал)
    -- удалять barracks если в нем сидит цивил
    -- сделай мне все таблицами что бы удобнее было добавлять юнитов в машины
    -- почини баг с тем что куча байков policebike вылазит и крешит игру
    Wait(0)
  end
end)

Citizen.CreateThread(function() --настройка ии
    while true do
    Wait(0)
        for i=0,16 do 
            SetDispatchTimeBetweenSpawnAttemptsMultiplier(1,10.0)
            i=i+1
        end
        SetAiWeaponDamageModifier(1.0)
    end
end)

Citizen.CreateThread(function()
    while not IsPlayerPlaying(PlayerId()) do Wait(50) end
    while not NetworkIsPlayerActive(PlayerId()) do Wait(50) end
    Wait(1000)
    BeginTextCommandPrint("STRING");
    AddTextComponentString("~r~Loading character...")
    EndTextCommandPrint(8000, true);
    Wait(8000)
    TriggerServerEvent(event.savenquit_load)
end)

local function freezePlayer(id, freeze)
    local playerid = id
    SetPlayerControl(playerid, not freeze, false)

    local ped = GetPlayerPed(playerid)

    if not freeze then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end

        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        --SetCharNeverTargetted(ped, false)
        --SetPlayerInvincible(playerid, false) --hack detection
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end

        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        --SetCharNeverTargetted(ped, true)
        --SetPlayerInvincible(playerid, true) --hack detection
        --RemovePtfxFromPed(ped)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

RegisterNetEvent(event.savenquit_load)
AddEventHandler(event.savenquit_load,function(pos,model,components,props,health,armor,weapons,ammo,relationship,textures)
    DoScreenFadeOut(500)
    while IsScreenFadingOut() do
        Citizen.Wait(0)
    end
    freezePlayer(PlayerId(), true)
    
    local ped=PlayerPedId()
    if model~=GetEntityModel(ped) then
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(10) end
        SetPlayerModel(PlayerId(),model)
        SetModelAsNoLongerNeeded(model)
        ped=PlayerPedId()
    end
    SetEntityCoords(ped,pos.x,pos.y,pos.z)
    
    SetEntityCoordsNoOffset(ped, pos.x, pos.y, pos.z, false, false, false, true)
    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, .0, false) --, true, true, false)
    
    if forced_max_health~=nil then SetPedMaxHealth(ped,forced_max_health) end
    SetEntityHealth(ped,health)
    SetPedArmour(ped,armor)
    for i=0,11 do
        SetPedComponentVariation(ped,i,components[i+1],textures[i+1],0)
    end
    for i=0,3 do
        SetPedPropIndex(ped,i,props[i+1],0,true)
    end
    for k,v in pairs(weapons) do
        GiveWeaponToPed(ped,k,0,false,true)
        for i,upgrade in pairs(v) do
            GiveWeaponComponentToPed(ped,k,upgrade)
        end
    end
    for k,v in pairs(ammo) do
        SetPedAmmoByType(ped,k,v)
    end
    SetPedRelationshipGroupHash(ped,relationship)

    RequestCollisionAtCoord(pos.x, pos.y, pos.z)
    while not HasCollisionLoadedAroundEntity(ped) do
        Citizen.Wait(0)
    end
    ShutdownLoadingScreen()
    DoScreenFadeIn(500)
    while IsScreenFadingIn() do
        Citizen.Wait(0)
    end
    freezePlayer(PlayerId(), false)
    TriggerEvent('playerSpawned')
    Wait(100)
    SetNotificationTextEntry("STRING");
    AddTextComponentString("~g~Character loaded!")
    DrawNotification(false, false);
end)


local function getRandomSpawnCoordsInRadiusSquared(spawn,radius)
    local squared=radius*radius
    local double=radius+radius
    spawn.x=math.random()*double-radius
    spawn.y=math.random()*double-radius
    if spawn.x*spawn.x+spawn.y*spawn.y<squared then return end
    spawn.x=math.random()*double-radius
    spawn.y=math.random()*double-radius
    if spawn.x*spawn.x+spawn.y*spawn.y<squared then return end
    spawn.x=math.random()*double-radius
    spawn.y=math.random()*double-radius
    if spawn.x*spawn.x+spawn.y*spawn.y<squared then return end
    spawn.x=math.random()*double-radius
    spawn.y=math.random()*double-radius
    if spawn.x*spawn.x+spawn.y*spawn.y<squared then return end
    --if we got here, we suck
    double=radius*1.41421356237 --exactly that hard
    spawn.x=math.random()*double
    spawn.y=math.random()*double
    double=double*.5
    spawn.x=spawn.x-double
    spawn.y=spawn.y-double
end

local function checkForBadSpawn()
    local timer=GetGameTimer()
    while GetTimeDifference(GetGameTimer(),timer)<5000 do
        local ped=PlayerPedId()
        local pos=GetEntityCoords(ped)
        if pos.z>.0 then break end
        if GetEntityHealth(ped)<150 or IsEntityInWater(ped) then
            SetEntityCoords(ped,pos.x,pos.y,1000.0)
            GiveWeaponToPed(ped,0xFFFFFFFFFBAB5776,1,false,true) --parachute
            break
        end
        Wait(10)
    end
end

RegisterNetEvent(event.savenquit_none)
AddEventHandler(event.savenquit_none,function(seed,text)
    --print('snq:none')
    math.randomseed(seed)
    math.random()
    math.random()
    math.random()
    math.random()
    math.random()

    DoScreenFadeOut(500)
    while IsScreenFadingOut() do
        Citizen.Wait(0)
    end
    freezePlayer(PlayerId(), true)
    
    local randomspawns_x=-44.8
    local randomspawns_y=-706.756
    local randomspawns_radius=1500.1

    --randomspawns_x,randomspawns_y=-3032.8419189453,-1071.7670898438
    --randomspawns_radius=1.1
    local randomspawns_models={
    "A_M_M_MexLabor_01",
    "S_M_M_AutoShop_01",
    "A_M_Y_Beach_02",
    "A_M_Y_BeachVesp_01",
    "A_M_Y_BeachVesp_02",
    "A_M_M_BevHills_01",
    "A_M_Y_BevHills_01",
    "A_M_M_BevHills_02",
    "A_M_Y_BevHills_02",
    "A_M_Y_BusiCas_01",
    "A_M_Y_Business_02",
    "A_M_Y_Business_03",
    "S_M_O_Busker_01",
    "A_M_Y_Cyclist_01",
    "S_M_Y_Dealer_01",
    "A_M_Y_Downtown_01",
    "A_M_M_EastSA_01",
    "A_M_Y_EastSA_01",
    "A_M_M_EastSA_02",
    "A_M_Y_EastSA_02",
    "U_M_M_Edtoh",
    "A_M_Y_Gay_01",
    "A_M_M_GenFat_01",
    "A_M_M_GenFat_02",
    "A_M_Y_GenStreet_01",
    "A_M_Y_GenStreet_02",
    "A_M_Y_Golfer_01",
    "S_M_Y_Grip_01",
    "A_M_Y_Indian_01",
    "A_M_M_KTown_01",
    "A_M_O_KTown_01",
    "A_M_Y_KTown_01",
    "A_M_Y_KTown_02",
    "A_M_Y_Latino_01",
    "U_M_Y_Party_01",
    "A_M_M_Polynesian_01",
    "A_M_Y_Polynesian_01",
    "S_M_Y_Robber_01",
    "A_M_Y_Runner_02",
    "A_M_M_Skater_01",
    "A_M_Y_Skater_01",
    "A_M_Y_Skater_02",
    "A_M_M_Skidrow_01",
    "A_M_M_SoCenLat_01",
    "A_M_M_SouCent_01",
    "A_M_M_SouCent_02",
    "A_M_M_SouCent_03",
    "A_M_M_SouCent_04",
    "A_M_O_SouCent_01",
    "A_M_O_SouCent_02",
    "A_M_O_SouCent_03",
    "A_M_Y_SouCent_01",
    "A_M_Y_SouCent_02",
    "A_M_Y_SouCent_03",
    "A_M_Y_SouCent_04",
    "A_M_Y_StBla_01",
    "A_M_Y_StBla_02",
    "A_M_Y_StLat_01",
    "A_M_M_StLat_02",
    "G_M_Y_StrPunk_01",
    "G_M_Y_StrPunk_02",
    "S_M_Y_StrVend_01",
    "A_M_Y_StWhi_01",
    "A_M_Y_StWhi_02",
    "A_M_Y_Sunbathe_01",
    "U_M_Y_Tattoo_01",
    "A_M_Y_VinDouche_01"
    }
    local pos={x=.0,y=.0,z=.0}
    local model=GetHashKey(randomspawns_models[math.random(#randomspawns_models)])
    local ped=PlayerPedId()
    getRandomSpawnCoordsInRadiusSquared(pos,randomspawns_radius)
    pos.z=-201.0
    pos.x=pos.x+randomspawns_x
    pos.y=pos.y+randomspawns_y
    --if model~=GetEntityModel(ped) then
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(10) end
        SetPlayerModel(PlayerId(),model)
        SetModelAsNoLongerNeeded(model)
        ped=PlayerPedId()
    --end
    if forced_max_health~=nil then
        SetPedMaxHealth(ped,forced_max_health)
        SetEntityHealth(ped,forced_max_health)
    end
    SetEntityCoords(ped,pos.x,pos.y,pos.z)
    
    SetEntityCoordsNoOffset(ped, pos.x,pos.y,pos.z, false, false, false, true)
    NetworkResurrectLocalPlayer(pos.x,pos.y,pos.z, .0, false) --,true, true, false)

    RequestCollisionAtCoord(pos.x,pos.y,pos.z)
    while not HasCollisionLoadedAroundEntity(ped) do
        Citizen.Wait(0)
    end
    ShutdownLoadingScreen()
    DoScreenFadeIn(500)
    while IsScreenFadingIn() do
        Citizen.Wait(0)
    end
    freezePlayer(PlayerId(), false)
    checkForBadSpawn()
    switch_to_criminal()
    TriggerEvent('playerSpawned')
    Wait(100)
    if text==nil then
        text="~r~No data saved!\nUse /savenquit next time."
    else
        text=tostring(text)
    end
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text)
    DrawNotification(false, false);
end)

RegisterNetEvent(event.savenquit)
AddEventHandler(event.savenquit,function(anyway)
    local ped=PlayerPedId()
    if (anyway==nil) then
        if GetPlayerWantedLevel(PlayerId())>0 or GetEntitySpeed(ped)>2.0 then
            SetNotificationTextEntry("STRING");
            AddTextComponentString("~r~You can not save and quit while wanted or moving.")
            DrawNotification(false, false);
            return
        else
            if save_and_quit_delayed then
                return
            else
                local timer_old=moved_last_time
                save_and_quit_delayed=true
                while save_and_quit_timeleft>0 do
                    Wait(1000)
                    if moved_last_time~=timer_old then
                        save_and_quit_delayed=false
                        SetNotificationTextEntry("STRING");
                        AddTextComponentString("~r~You can not save and quit while wanted or moving.")
                        DrawNotification(false, false);
                        return
                    end
                end
                Citizen.CreateThread(function()
                    Wait(1000)
                    save_and_quit_delayed=false
                end)
                ped=PlayerPedId()
            end
        end
    else
        save_and_quit_delayed=false
        moved_last_time=GetGameTimer()+1
    end
    local v3=GetEntityCoords(ped)
    local model=GetEntityModel(ped)
    local pos={x=v3.x,y=v3.y,z=v3.z}
    local components={}
    local textures={}
    for i=0,11 do
        components[i+1]=GetPedDrawableVariation(ped,i)
        textures[i+1]=GetPedTextureVariation(ped,i)
    end
    local props={}
    for i=0,3 do
        props[i+1]=GetPedPropIndex(ped,i)
    end
    local relationship=GetPedRelationshipGroupHash(ped)
    local weapons={}
    local ammo={}
    local health=GetEntityHealth(ped)
    local armor=GetPedArmour(ped)
    for name,w in pairs(WEAPON) do
        if HasPedGotWeapon(ped, w, false) then
            local i=0
            local ammo_type=GetPedAmmoTypeFromWeapon(ped,w)
            weapons[w]={}
            ammo[ammo_type]=GetPedAmmoByType(ped,ammo_type)
            for upgrade_name,upgrade_type in pairs(weapon_upgrades) do
                local upgrade=upgrade_type[w]
                if upgrade and HasPedGotWeaponComponent(ped,w,upgrade) then
                    i=i+1
                    weapons[w][i]=upgrade
                end
            end
        end
    end
    TriggerServerEvent(event.savenquit,pos,model,components,props,health,armor,weapons,ammo,relationship,textures,player.propertyname)
end)

Citizen.CreateThread(function()
    while true do
        local curhp=GetEntityHealth(PlayerPedId())
        if (curhp<150) and curhp~=0 then
            SetEntityHealth(PlayerPedId(),curhp+1)
        end
        Wait(1000)
    end
end)

special_abilities.pill=function()
    if IsControlJustPressed(0,182) then
        if player.special_ability_amount>0 
        then
            if player.special_ability_timestamp~=nil then
                player.special_ability_timestamp=player.special_ability_timestamp+45000;
            else
                player.special_ability_timestamp=GetGameTimer()+45000;
                player.special_ability_lastapplied=nil;
            end
            player.special_ability_amount=player.special_ability_amount-1;
            if not IsPedInAnyVehicle(PlayerPedId(),false) and not player.surrendering then
                local animdict="mp_suicide"
                local anim="pill"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(PlayerPedId(), animdict, anim, 1.0, 1.0, 2000, 0, 0, 0, 0, 0);
            end
        end
    end
    if player.special_ability_timestamp~=nil then
        if player.special_ability_timestamp<GetGameTimer() then
            player.special_ability_timestamp=nil
        elseif player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>300 then
            local playerped=PlayerPedId()
            local curhealth=GetEntityHealth(playerped)
            SetEntityHealth(playerped,curhealth+1)
            player.special_ability_lastapplied=GetGameTimer()
        end
    end
    local dict="mpinventory"
    local texturename="drug_trafficking"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        if player.special_ability_timestamp==nil then
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            255, 255, 255, 255);
            WriteText(0,"x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
            local pos=GetEntityCoords(PlayerPedId())
            local dx,dy=pos.x-100.50,pos.y+1946.45
            if dx*dx+dy*dy<2500.0 and pos.z<25.0
            then
                player.special_ability_amount=3
            end
        else
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            (player.special_ability_timestamp-GetGameTimer())*.3, 
            255, GetGameTimer()&255, 255, 255);
            WriteText(0,"x "..player.special_ability_amount,0.45,255,GetGameTimer()&255,255,255,0.185,0.935)
        end
    end
end

special_abilities.weed=function()
    if IsControlJustPressed(0,182) then
        if player.special_ability_amount>0 
        then
            if player.special_ability_timestamp~=nil then
                player.special_ability_timestamp=player.special_ability_timestamp+90000;
            else
                player.special_ability_timestamp=GetGameTimer()+90000;
                player.special_ability_lastapplied=nil;
            end
            player.special_ability_amount=player.special_ability_amount-1;
            if not IsPedInAnyVehicle(PlayerPedId(),false) and not player.surrendering then
                local animdict="anim@mp_player_intcelebrationmale@smoke_flick"
                local anim="smoke_flick"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(PlayerPedId(), animdict, anim, 1.0, 1.0, 2500, 0, 0, 0, 0, 0);
            end
        end
    end
    if player.special_ability_timestamp~=nil then
        if player.special_ability_timestamp<GetGameTimer() then
            player.special_ability_timestamp=nil
        elseif player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>900 then
            local playerped=PlayerPedId()
            local curhealth=GetEntityHealth(playerped)
            local curarmor=GetPedArmour(playerped)
            SetEntityHealth(playerped,curhealth+1)
            if curarmor<25 then SetPedArmour(playerped,curarmor+1) end
            player.special_ability_lastapplied=GetGameTimer()
        end
    end
    local dict="commonmenu"
    local texturename="mp_specitem_weed"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        if player.special_ability_timestamp==nil then
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            255, 255, 255, 255);
            WriteText(0," x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
            local pos=GetEntityCoords(PlayerPedId())
            local dx,dy=pos.x+14.34,pos.y+1442.21
            if dx*dx+dy*dy<2500.0 and pos.z<40.0
            then
                player.special_ability_amount=3
            end
        else
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            GetGameTimer()&255, 255, GetGameTimer()&255, 255);
            WriteText(0," x "..player.special_ability_amount,0.45,GetGameTimer()&255,255,GetGameTimer()&255,255,0.185,0.935)
        end
    end
end

special_abilities.heroin=function()
    if IsControlJustPressed(0,182) then
        if player.special_ability_amount>0 
        then
            if player.special_ability_timestamp~=nil then
                player.special_ability_timestamp=player.special_ability_timestamp+30000;
            else
                player.special_ability_timestamp=GetGameTimer()+30000;
                player.special_ability_lastapplied=nil;
            end
            player.special_ability_amount=player.special_ability_amount-1;
            if not IsPedInAnyVehicle(PlayerPedId(),false) and not player.surrendering then
                local animdict="anim@melee@switchblade@holster"
                local anim="holster"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(PlayerPedId(), animdict, anim, 1.0, 1.0, 1500, 0, 0, 0, 0, 0);
                -- local animations={
                -- 'plyr_failed_takedown_rear_r_facehit',
                -- }
                --for k,v in pairs(animations) do
                --    TaskPlayAnim(PlayerPedId(), animdict, v, 1.0, 1.0, 5000, 0, 0, 0, 0, 0)
                --    local started=GetGameTimer()
                --    Wait(0)
                --    while GetGameTimer()-started<5000 do
                --        Wait(0)
                --        WriteText(0,v,0.45,255,255,255,255,0.185,0.5)
                --    end
                --end
            end
        end
    end
    if player.special_ability_timestamp~=nil then
        if player.special_ability_timestamp<GetGameTimer() then
            player.special_ability_timestamp=nil
        else
            local playerped=PlayerPedId()
            if player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>200 then
                local curhealth=GetEntityHealth(playerped)
                local curarmor=GetPedArmour(playerped)
                SetEntityHealth(playerped,curhealth+1)
                player.special_ability_lastapplied=GetGameTimer()
            end
            local mypos=GetEntityCoords(playerped)
            for ped in EnumeratePeds() do
                if IsPedHuman(ped) 
                then
                    local rel=GetRelationshipBetweenPeds(ped,playerped)
                    if rel==4 or rel==5 or IsPedInCombat(ped,playerped)
                    then
                        local health=math.floor(GetEntityHealth(ped))
                        if health>0
                        then
                            local pos=GetEntityCoords(ped)
                            local dx,dy,dz=pos.x-mypos.x,pos.y-mypos.y,pos.z-mypos.z
                            local square=dx*dx+dy*dy+dz*dz
                            if square<10000.0
                            then
                                local on_screen,x,y=World3dToScreen2d(pos.x,pos.y,pos.z)
                                if on_screen
                                then
                                    local dict="mpbeamhackfg"
                                    local texturename="firewall_shatter_fg_74"
                                    if not HasStreamedTextureDictLoaded(dict) then
                                        RequestStreamedTextureDict(dict,false)
                                    else
                                        local dist=math.sqrt(square)
                                        square=1.0/dist
                                        DrawSprite(dict, texturename, 
                                        x, y, 
                                        square, square+square, 
                                        0.0, 
                                        255, 0, 0, 255-math.floor(dist*2.55));
                                    end
                                    -- local armor=GetPedArmour(ped)
                                    -- local msg="~r~"..health-100
                                    -- if armor~=0 then msg=msg.."~s~+~b~"..armor end
                                    -- SetTextColour(255, 255, 255, 255)
                                    -- SetTextOutline()
                                    -- SetTextFont(4)
                                    -- SetTextScale(.3, .3)
                                    -- SetTextEntry("STRING")
                                    -- AddTextComponentString(msg)
                                    -- EndTextCommandDisplayText(x,y)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local dict="commonmenu"
    local texturename="mp_specitem_heroin"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        if player.special_ability_timestamp==nil then
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            255, 255, 255, 255);
            WriteText(0," x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
            local pos=GetEntityCoords(PlayerPedId())
            local dx,dy=pos.x-973.76800537109,pos.y+1822.3959960938
            if dx*dx+dy*dy<2500.0 and pos.z<40.0
            then
                player.special_ability_amount=1
            end
        else
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            255, GetGameTimer()&255, GetGameTimer()&255, 255);
            WriteText(0," x "..player.special_ability_amount,0.45,255,GetGameTimer()&255,GetGameTimer()&255,255,0.185,0.935)
        end
    end
end

special_abilities.stim=function()
    if IsControlJustPressed(0,182) then
        if player.special_ability_amount>0 
        then
            if player.special_ability_timestamp~=nil then
                player.special_ability_timestamp=player.special_ability_timestamp+90000;
            else
                player.special_ability_timestamp=GetGameTimer()+90000;
                player.special_ability_lastapplied=nil;
            end
            player.special_ability_amount=player.special_ability_amount-1;
            if not IsPedInAnyVehicle(PlayerPedId(),false) and not player.surrendering then
                local animdict="anim@melee@switchblade@holster"
                local anim="holster"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(PlayerPedId(), animdict, anim, 1.0, 1.0, 2500, 0, 0, 0, 0, 0);
            end
        end
    end
    if player.special_ability_timestamp~=nil then
        if player.special_ability_timestamp<GetGameTimer() then
            player.special_ability_timestamp=nil
        elseif player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>1000 then
            ResetPlayerStamina(PlayerId())
            player.special_ability_lastapplied=GetGameTimer()
        end
    end
    local dict="triathlon"
    local texturename="triathlon_running"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        if player.special_ability_timestamp==nil then
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            255, 255, 255, 255);
            WriteText(0,"x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
            local pos=GetEntityCoords(PlayerPedId())
            local dx,dy=pos.x+780.09936523438,pos.y+910.53063964844
            if dx*dx+dy*dy<2500.0 and pos.z<30.0
            then
                player.special_ability_amount=3
            end
        else
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            25, math.abs((GetGameTimer()&511)-255), 255, 255);
            WriteText(0,"x "..player.special_ability_amount,0.45,25,math.abs((GetGameTimer()&511)-255), 255,255,0.185,0.935)
        end
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.losewantedlevel=function()
    if IsControlJustPressed(0,182) and player.wanted~=5 then
        if player.special_ability_amount>0 
        then
            SetPlayerWantedLevel(PlayerId(),0,false)
            SetPlayerWantedLevelNow(PlayerId(),false)
            player.wanted=0
            player.special_ability_amount=player.special_ability_amount-1;
            if not IsPedInAnyVehicle(PlayerPedId(),false) and not player.surrendering then
                local animdict="amb@world_human_stand_mobile@male@text@exit"
                local anim="exit_to_call"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(PlayerPedId(), animdict, anim, 1.0, 1.0, 2500, 0, 0, 0, 0, 0);
            end
        end
    end
    local dict="mpcharselect"
    local texturename="mp_generic_avatar"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        if player.special_ability_timestamp==nil then
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            255, 255, 255, 255);
            WriteText(0," x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
            local pos=GetEntityCoords(PlayerPedId())
            local dx,dy=pos.x+70.679946899414,pos.y-359.08154296875
            if dx*dx+dy*dy<2500.0 and pos.z<147.0
            then
                player.special_ability_amount=2
            end
        else
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            GetGameTimer()&255, 255, GetGameTimer()&255, 255);
            WriteText(0," x "..player.special_ability_amount,0.45,GetGameTimer()&255,255,GetGameTimer()&255,255,0.185,0.935)
        end
    end
end

special_abilities.passiveregen=function()
    if player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>2000 then
        local playerped=PlayerPedId()
        local curhealth=GetEntityHealth(playerped)
        local curarmor=GetPedArmour(playerped)
        SetEntityHealth(playerped,curhealth+1)
        if curarmor<50 then SetPedArmour(playerped,curarmor+1) end
        player.special_ability_lastapplied=GetGameTimer()
    end
    local dict="commonmenu"
    local texturename="shop_health_icon_a"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.alco=function()
    if IsControlJustPressed(0,182) and player.wanted~=5 then
        if player.special_ability_amount>0 
        then
            local playerped=PlayerPedId()
            player.special_ability_amount=player.special_ability_amount-1;
            if not IsPedInAnyVehicle(playerped,false) and not player.surrendering then
                local model=GetHashKey("prop_beer_pissh")
                local animdict="mp_player_intdrink"
                local anim="loop_bottle"
                local obj
                RequestModel(model)
                RequestAnimDict(animdict)
                if not HasAnimDictLoaded(animdict) then
                 while not HasAnimDictLoaded(animdict) do RequestAnimDict(animdict) Wait(10) end
                end
                local mypos=GetEntityCoords(playerped)
                if HasModelLoaded(model) then
                    obj=CreateObject(model, mypos.x, mypos.y, mypos.z-1.0, true, false, false)
                    if obj~=nil then
                        AttachEntityToEntity(obj,playerped,GetPedBoneIndex(playerped,0x49d9),
                        .06,-.15,.05, --coords
                        -65.0,115.0,0.0, --rot            
                        false, --p9
                        false, --soltpinning
                        false, --collision
                        true, --isped
                        0, --vertexindex
                        true --fixedrot
                        )
                    end
                end
                TaskPlayAnim(playerped, animdict, anim, 1.0, 1.0, 10000, 0, 0, 0, 0, 0);
                local curarmor=GetPedArmour(playerped)
                for friend in EnumeratePeds() do
                    if dont_kill_those[GetEntityModel(friend)]~=nil or dont_kill_those[GetPedRelationshipGroupHash(friend)]~=nil then
                        local pos=GetEntityCoords(friend)
                        local dx,dy,dz=pos.x-mypos.x,pos.y-mypos.y,pos.z-mypos.z
                        local square=dx*dx+dy*dy+dz*dz
                        if square<400.0 then
                            curarmor=curarmor+5
                            if square<25.0 then
                                curarmor=curarmor+5
                                if square<3.0 then
                                    curarmor=curarmor-10
                                end
                            end
                        end
                    end
                end
                SetPedArmour(playerped,curarmor)
                Wait(4000)
                if obj~=nil then
                    SetEntityAsNoLongerNeeded(obj)
                    SetEntityAsMissionEntity(obj)
                    DeleteObject(obj)
                end
            end
        end
    end
    local dict="mpleaderboard"
    local texturename="leaderboard_friends_icon"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
        WriteText(0," x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
        local pos=GetEntityCoords(PlayerPedId())
        local dx,dy=pos.x+459.11273193359,pos.y+1709.0319824219
        if dx*dx+dy*dy<2500.0 and pos.z<30.0
        then
            player.special_ability_amount=10
        end
    end
end

special_abilities.ammoregen=function()
    if IsControlJustPressed(0,182) then
        if player.special_ability_amount>0 
        then
            local playerped=PlayerPedId()
            local curweap=GetSelectedPedWeapon(playerped)
            SetPedAmmo(playerped, curweap, 1000);
            player.special_ability_amount=player.special_ability_amount-1;
            if not IsPedInAnyVehicle(PlayerPedId(),false) and not player.surrendering then
                local animdict="cover@weapon@rpg"
                local anim="low_r_unholster"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(PlayerPedId(), animdict, anim, 1.0, 1.0, 2500, 0, 0, 0, 0, 0);
            end
        end
    end
    local dict="mphud"
    local texturename="ammo_pickup"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        if player.special_ability_timestamp==nil then
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            255, 255, 255, 255);
            WriteText(0," x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
            local pos=GetEntityCoords(PlayerPedId())
            local dx,dy=pos.x+2347.4812011719,pos.y-3267.0656738281
            if dx*dx+dy*dy<2500.0 --and pos.z<50.0
            then
                player.special_ability_amount=6
            end
        else
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            GetGameTimer()&255, 255, GetGameTimer()&255, 255);
            WriteText(0," x "..player.special_ability_amount,0.45,GetGameTimer()&255,255,GetGameTimer()&255,255,0.185,0.935)
        end
    end
end

special_abilities.anarchyfixandfire=function()
    local ped=PlayerPedId()
    local pos=GetEntityCoords(ped)
    local fires=GetNumberOfFiresInRange(pos.x,pos.y,pos.z,30.0)
    if fires>30 then
        if player.special_ability_2_lastapplied==nil or GetGameTimer()-player.special_ability_2_lastapplied>300 then
            local health=GetEntityHealth(ped)
            if health>0 then
                local armor=GetPedArmour(ped)
                if armor<99 then
                    SetPedArmour(ped,armor+2)
                end
                SetEntityHealth(ped,health+2)
                player.special_ability_2_lastapplied=GetGameTimer()
            end
        end
    elseif fires>20 then
        if player.special_ability_2_lastapplied==nil or GetGameTimer()-player.special_ability_2_lastapplied>300 then
            local health=GetEntityHealth(ped)
            if health>0 then
                local armor=GetPedArmour(ped)
                if armor<100 then
                    SetPedArmour(ped,armor+1)
                end
                SetEntityHealth(ped,health+2)
                player.special_ability_2_lastapplied=GetGameTimer()
            end
        end
    elseif fires>10 then
        if player.special_ability_2_lastapplied==nil or GetGameTimer()-player.special_ability_2_lastapplied>300 then
            local health=GetEntityHealth(ped)
            if health>0 then
                SetEntityHealth(ped,health+2)
                player.special_ability_2_lastapplied=GetGameTimer()
            end
        end
    elseif fires>3 then
        if player.special_ability_2_lastapplied==nil or GetGameTimer()-player.special_ability_2_lastapplied>300 then
            local health=GetEntityHealth(ped)
            if health>0 then
                SetEntityHealth(ped,health+1)
                player.special_ability_2_lastapplied=GetGameTimer()
            end
        end
    end
    if IsControlJustPressed(0,182) then
        if player.special_ability_amount>0 
        then
            local playerped=PlayerPedId()
            local pos=GetEntityCoords(playerped)
            for veh in EnumerateVehicles() do
                local vehpos=GetEntityCoords(veh)
                local dx,dy,dz=vehpos.x-pos.x,vehpos.y-pos.y,vehpos.z-pos.z
                if dx*dx+dy*dy+dz*dz<16.0 and not IsPedInAnyVehicle(playerped,false)
                then
                    SetVehicleTyreFixed(veh,0)
                    SetVehicleTyreFixed(veh,1)
                    SetVehicleTyreFixed(veh,2)
                    SetVehicleTyreFixed(veh,3)
                    SetVehicleTyreFixed(veh,4)
                    SetVehicleTyreFixed(veh,5)
                    SetVehicleTyreFixed(veh,45)
                    SetVehicleTyreFixed(veh,47)
                    SetVehicleEngineHealth(veh,500.0)
                    --SetVehiclePetrolTankHealth(veh,500.0)
                    player.special_ability_amount=player.special_ability_amount-1;
                end
            end
            if not IsPedInAnyVehicle(PlayerPedId(),false) and not player.surrendering then
                local animdict="cover@weapon@rpg"
                local anim="low_r_unholster"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(PlayerPedId(), animdict, anim, 1.0, 1.0, 2500, 0, 0, 0, 0, 0);
            end
        end
    end
    local dict="mpweaponsunusedfornow"
    local texturename="w_me_wrench_silhouette"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        if player.special_ability_timestamp==nil then
            DrawSprite(dict, texturename, 
            0.175, 0.95, 
            0.020, 0.035, 
            -45.0, 
            255, 255, 255, 255);
            WriteText(0," x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
            
            -- DrawSprite(dict, "w_ex_molotov_silhouette", 
            -- 0.225, 0.95, 
            -- 0.015, 0.035, 
            -- -90.0, 
            -- 255, 255, 255, 255);
            local pos=GetEntityCoords(PlayerPedId())
            local dx,dy=pos.x-717.15899658203,pos.y+964.27935791016
            if dx*dx+dy*dy<2500.0 and pos.z<40.0
            then
                player.special_ability_amount=3
            end
        else
            local r,g,b=GetGameTimer()&255, 255, GetGameTimer()&255
            DrawSprite(dict, "w_me_wrench_silhouette", 
            0.175, 0.95, 
            0.020, 0.035, 
            0.0, 
            r,g,b,255);
            WriteText(0," x "..player.special_ability_amount,0.45,r,g,b,255,0.185,0.935)
        end
    end
end

special_abilities.armorregen=function()
    if player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>1000 then
        local playerped=PlayerPedId()
        local curhealth=GetEntityHealth(playerped)
        local curarmor=GetPedArmour(playerped)
        if curarmor<100 then SetPedArmour(playerped,curarmor+1) end
        player.special_ability_lastapplied=GetGameTimer()
    end
    local dict="commonmenu"
    local texturename="shop_armour_icon_b"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.friendsregen=function()
    if player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>1700 then
        local playerped=PlayerPedId()
        local mypos=GetEntityCoords(playerped)
        for friend in EnumeratePeds() do
            if friend~=playerped then
                if dont_kill_those[GetEntityModel(friend)]~=nil or dont_kill_those[GetPedRelationshipGroupHash(friend)]~=nil then
                    local pos=GetEntityCoords(friend)
                    local mypos=GetEntityCoords(playerped)
                    local dx,dy,dz=pos.x-mypos.x,pos.y-mypos.y,pos.z-mypos.z
                    local square=dx*dx+dy*dy+dz*dz
                    if square<100.0 then
                        local curhealth=GetEntityHealth(playerped)
                        local curarmor=GetPedArmour(playerped)
                        SetEntityHealth(playerped,curhealth+1)
                        SetPedArmour(playerped,curarmor+1)
                        player.special_ability_lastapplied=GetGameTimer()
                        break;
                    end
                end
            end
        end
    end
    local dict="commonmenutu"
    local texturename="team_deathmatch"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.exchange=function()
    if player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>600 then
        local playerped=PlayerPedId()
        local curhealth=GetEntityHealth(playerped)
        local curarmor=GetPedArmour(playerped)
        if curhealth>150 and curarmor<100 then
        SetEntityHealth(playerped,curhealth-1)
        SetPedArmour(playerped,curarmor+1)
        player.special_ability_lastapplied=GetGameTimer()
        --SetPedAllowedToDuck(playerped,true)
        end
    end
    local dict="mpturf"
    local texturename="swap"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.reusehealthandarmor=function()
    if IsControlJustPressed(0,182) then
        if player.special_ability_amount>0 
        then
            local playerped=PlayerPedId()
            
            SetEntityHealth(playerped,200)
            SetPedArmour(playerped,100)
            player.special_ability_amount=player.special_ability_amount-1
            
            if not IsPedInAnyVehicle(playerped,false) and not player.surrendering then
                local animdict="cover@weapon@rpg"
                local anim="low_r_unholster"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(playerped, animdict, anim, 1.0, 1.0, 5000, 0, 0, 0, 0, 0);
            end
        end
    end
    local dict="commonmenutu"
    local texturename="capture_the_flag"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
        WriteText(0," x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
        local pos=GetEntityCoords(PlayerPedId())
        local dx,dy=pos.x-568.61987304688,pos.y+3118.4719238281
        if dx*dx+dy*dy<2500.0 and pos.z<30.0
        then
            player.special_ability_amount=3
        end
    end
end

special_abilities.lockpick=function()
    local dict="commonmenu"
    local texturename="shop_lock"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.seeweaponsinhands=function()
    local playerid=PlayerId()
    local playerped=PlayerPedId()
    local mypos=GetEntityCoords(playerped)
    for ped in EnumeratePeds() do
        if IsPedHuman(ped) and ped~=playerped
        then
            local weapon=GetSelectedPedWeapon(ped)
            if weapon~=0 and weapon~=-1 and weapon~=966099553 and weapon~=WEAPON.UNARMED
            then
                local pos=GetEntityCoords(ped)
                local dx,dy,dz=pos.x-mypos.x,pos.y-mypos.y,pos.z-mypos.z
                local square=dx*dx+dy*dy+dz*dz
                
                if square<10000.0
                then
                    local on_screen,x,y=World3dToScreen2d(pos.x,pos.y,pos.z+1.2)
                    if on_screen and HasEntityClearLosToEntity(playerped,ped,17)
                    then
                    
                        -- local handle=StartShapeTestRay(
                                    -- mypos.x, mypos.y, mypos.z,
                                    -- pos.x, pos.y, pos.z, 
                                    -- -1, playerped, 0);
                        
                        -- local hit,endcoords,normal,entity=GetShapeTestResult(handle)
                        
                        --if hit then
                            local dict="commonmenu"
                            local texturename="shop_gunclub_icon_a"
                            if not HasStreamedTextureDictLoaded(dict) then
                                RequestStreamedTextureDict(dict,false)
                            else
                                square=0.025
                                DrawSprite(dict, texturename, 
                                x, y, 
                                square, square+square, 
                                0.0, 
                                255, 255, 255, 50);
                                --WriteText(0,"hit:"..hit.."\nentity:"..entity.."\ncoords:"..endcoords.."\nnormal:"..normal,0.25,255,255,255,255,x,y)
                            end
                        --end
                    end
                end
            end
        end
    end
        
    local dict="commonmenu"
    local texturename="shop_gunclub_icon_a"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
end

special_abilities.anyveh=function()
    local dict="commonmenu"
    local texturename="shop_garage_icon_a"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.regeninvan=function()
    if player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>400 then
        local playerped=PlayerPedId()
        if IsPedInAnyVehicle(playerped,false)
        then
            local veh=GetVehiclePedIsUsing(playerped)
            local model=GetEntityModel(veh)
            if model==-1205689942 or model==2071877360 then --swat van
                local curhealth=GetEntityHealth(playerped)
                local curarmor=GetPedArmour(playerped)
                SetEntityHealth(playerped,curhealth+1)
                SetPedArmour(playerped,curarmor+1)
                SetPedAmmo(playerped,WEAPON.COMBATPISTOL,1000)
                SetPedAmmo(playerped,WEAPON.PUMPSHOTGUNMK2,1000)
                SetPedAmmo(playerped,WEAPON.BULLPUPSHOTGUN,1000)
                SetPedAmmo(playerped,WEAPON.ASSAULTSMG,1000)
                SetPedAmmo(playerped,WEAPON.SMG,1000)
                SetPedAmmo(playerped,WEAPON.ADVANCEDRIFLE,1000)
                SetPedAmmo(playerped,WEAPON.CARBINERIFLE,1000)
                SetPedAmmo(playerped,WEAPON.SPECIALCARBINE,1000)
                SetPedAmmo(playerped,WEAPON.BZGAS,1000)
                player.special_ability_lastapplied=GetGameTimer()
            end
        end
    end
    local dict="commonmenutu"
    local texturename="gang_attack"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.smallmedkit=function()
    if IsControlJustPressed(0,182) then
        if player.special_ability_amount>0 
        then
            local playerped=PlayerPedId()
            local playerhp=GetEntityHealth(playerped)
            
            SetEntityHealth(playerped,playerhp+25)
            player.special_ability_amount=player.special_ability_amount-1
            
            if not IsPedInAnyVehicle(playerped,false) and not player.surrendering then
                local animdict="cover@weapon@rpg"
                local anim="low_r_unholster"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(playerped, animdict, anim, 1.0, 1.0, 5000, 0, 0, 0, 0, 0);
            end
        end
    end
    local dict="commonmenu"
    local texturename="shop_health_icon_b"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
        WriteText(0," x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
        local pos=GetEntityCoords(PlayerPedId())
        local dx,dy=pos.x-446.46932983398,pos.y+986.15057373047
        if dx*dx+dy*dy<2500.0 and pos.z<60.0
        then
            player.special_ability_amount=5
        end
    end
end

special_abilities.evidence=function()
    if IsControlJustPressed(0,182) then
        local playerped=PlayerPedId()
        local sw=GetSelectedPedWeapon(playerped)
        if player.special_ability_amount>0 
        and sw~=0 and sw~=-1 and sw~=966099553 and sw~=WEAPON.UNARMED and sw~=WEAPON.STUNGUN and sw~=WEAPON.PISTOL and sw~=WEAPON.COMBATPISTOL and sw~=WEAPON.NIGHTSTICK and sw~=WEAPON.PUMPSHOTGUN
        then
            local playerarmor=GetPedArmour(playerped)
            RemoveWeaponFromPed(playerped,sw)
            SetPedArmour(playerped,playerarmor+25)
            player.special_ability_amount=player.special_ability_amount-1
            
            if not IsPedInAnyVehicle(playerped,false) and not player.surrendering then
                local animdict="cover@weapon@rpg"
                local anim="low_r_unholster"
                if not HasAnimDictLoaded(animdict) then
                 RequestAnimDict(animdict)
                 while not HasAnimDictLoaded(animdict) do Wait(10) end
                end
                TaskPlayAnim(playerped, animdict, anim, 1.0, 1.0, 5000, 0, 0, 0, 0, 0);
            end
        else
            SetNotificationTextEntry("STRING");
            AddTextComponentString("You need ~r~evidence weapon ~s~to pack it.")
            DrawNotification(false, false);
        end
    end
    local dict="commonmenu"
    local texturename="mp_specitem_coke"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
        WriteText(0," x "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
        local pos=GetEntityCoords(PlayerPedId())
        local dx,dy=pos.x-446.46932983398,pos.y+986.15057373047
        if dx*dx+dy*dy<2500.0 and pos.z<60.0
        then
            player.special_ability_amount=8
        end
    end
end

special_abilities.regenincar=function()
    local playerped=PlayerPedId()
    local inveh=IsPedInAnyVehicle(playerped,false)
    if player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>300 then
        if inveh
        then
            local curhealth=GetEntityHealth(playerped)
            SetEntityHealth(playerped,curhealth+1)
            player.special_ability_lastapplied=GetGameTimer()
        end
    end
    local dict="commonmenu"
    local texturename="shop_garage_icon_b"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
    
    if inveh then
        local veh=GetVehiclePedIsUsing(playerped)
        if GetEntityModel(veh)==1034187331 then
            local state=((GetGameTimer()&512)==0)
            SetVehicleNeonLightEnabled(veh, 0, true)
            SetVehicleNeonLightEnabled(veh, 1, true)
            SetVehicleNeonLightEnabled(veh, 2, true)
            SetVehicleNeonLightEnabled(veh, 3, true)
            if state then
                SetVehicleNeonLightsColour(veh,0,0,255)
            else
                SetVehicleNeonLightsColour(veh,255,0,0)
            end
            SetVehicleBrakeLights(veh,state)
            -- SetVehicleIndicatorLights(veh, 0, state);
            -- SetVehicleIndicatorLights(veh, 1, state);
        end
    end
end

special_abilities.fastlowregen=function()
    if player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>100 then
        local playerped=PlayerPedId()
        local curhealth=GetEntityHealth(playerped)
        if curhealth<140 then SetEntityHealth(playerped,curhealth+2) end
        player.special_ability_lastapplied=GetGameTimer()
    end
    local dict="commonmenu"
    local texturename="shop_arrows_upanddown"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.baseregen=function()
    if player.special_ability_lastapplied==nil or GetGameTimer()-player.special_ability_lastapplied>1000 and player.special_ability_amount>0 then
        local playerped=PlayerPedId()
        local curhealth=GetEntityHealth(playerped)
        SetEntityHealth(playerped,curhealth+2)
        player.special_ability_amount=player.special_ability_amount-1
        player.special_ability_lastapplied=GetGameTimer()
    end
    local dict="commonmenu"
    local texturename="shop_health_icon_b"
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict,false)
    else
        DrawSprite(dict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
        WriteText(0," "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
        local pos=GetEntityCoords(PlayerPedId())
        local dx,dy=pos.x-384.29837036133,pos.y-790.41711425781
        if dx*dx+dy*dy<1000.0 --and pos.z<60.0
        then
            player.special_ability_amount=1000
        end
    end
    --WriteText(0,GetPlayerSprintStaminaRemaining(PlayerId()),0.45,255,255,255,255,0.185,0.91)
end

special_abilities.firefighter_stations={
    {x=212.82231140137,y=-1656.21875,z=32.503360748291},--central station where you join lsfd
    {x=-2131.8061523438,y=2821.0539550781,z=34.833042144775},--zancudo
    {x=1691.6262207031,y=3585.8562011719,z=35.620983123779},--sandy shores
    {x=-379.69274902344,y=6118.4248046875,z=31.848714828491},--paleto
    {x=1208.4714355469,y=-1472.6845703125,z=36.304149627686},--east of LS
    {x=-1095.4703369141,y=-2363.1921386719,z=14.024006843567},--LSIA
    {x=-632.68377685547,y=-121.87236022949,z=39.228706359863},--elite
}

local fire={
startdist=40.1*40.1,
stopdist=50.1*50.1,
killdist=30.1*30.1,
synced={},
synced_active=0,
synced_total=0,
hash_func=garbage.hash,
natural_fires={},
blacklist1={
[1]={x=467,y=-534,z=27},
[2]={x=467,y=-534,z=28},
[3]={x=454,y=-842,z=27},
[4]={x=464,y=-850,z=26},
[5]={x=460,y=-864,z=26},
[6]={x=173,y=-1202,z=28},
[7]={x=168,y=-1225,z=28},
[8]={x=-12,y=-1232,z=28},
[9]={x=37,y=-1239,z=29},
[10]={x=37,y=-1210,z=29},
[11]={x=254,y=-1112,z=28},
[12]={x=254,y=-1112,z=29},
[13]={x=264,y=-1118,z=28},
[14]={x=367,y=-1110,z=28},
[15]={x=367,y=-1110,z=29},
[16]={x=347,y=-1094,z=28},
[17]={x=347,y=-1094,z=29},
[18]={x=337,y=-1086,z=29},
[19]={x=387,y=-1104,z=29},
[20]={x=387,y=-1104,z=28},
[21]={x=37,y=-1210,z=28},
[22]={x=37,y=-1239,z=28},
[23]={x=604,y=-1256,z=9},
[24]={x=624,y=-630,z=13},
[25]={x=599,y=-596,z=14},
[26]={x=604,y=-584,z=14},
[27]={x=612,y=-566,z=14},
[28]={x=1071,y=-261,z=58},
[29]={x=-2869,y=-30,z=4},
[30]={x=-2962,y=-11,z=4},
[31]={x=-3078,y=533,z=1},
[32]={x=-3247,y=1152,z=2},
[33]={x=-2878,y=3106,z=2},
[34]={x=-2611,y=3564,z=3},
[35]={x=-2608,y=3575,z=2},
[36]={x=-2601,y=3581,z=3},
[37]={x=-2320,y=4373,z=7},
[38]={x=-2316,y=4383,z=7},
[39]={x=-1731,y=4940,z=3},
[40]={x=-1718,y=4955,z=6},
[41]={x=-1734,y=4981,z=5},
[42]={x=-834,y=5893,z=4},
[43]={x=-837,y=5904,z=4},
[44]={x=-346,y=6502,z=2},
[45]={x=61,y=7183,z=1},
[46]={x=180,y=7058,z=2},
[47]={x=165,y=7034,z=1},
[48]={x=1298,y=6611,z=1},
[49]={x=1548,y=6620,z=1},
[50]={x=841,y=-846,z=25},
[51]={x=899,y=-847,z=28},
[52]={x=253,y=-1074,z=28},
[53]={x=-32,y=-1979,z=4},
[54]={x=-32,y=-1979,z=5},
[55]={x=140,y=-1196,z=28},
[56]={x=140,y=-1196,z=29},
[57]={x=124,y=-1182,z=28},
[58]={x=173,y=-1202,z=29},
},
blacklist2={
 {x=31,y=2938,z=55},--forests of san andreas
},
interior_blacklist={
--apartments and hotel
[149761]=true,
[149505]=true,
[148225]=true,
[141569]=true,

--stilthouses
[208385]=true,
[207361]=true,
[207617]=true,
[208129]=true,
[207873]=true,
[207105]=true,
[206593]=true,
[206081]=true,
[206337]=true,

--[260353]=true, --arena(lsia hangar)
--[270337]=true, --radiotelescopes
--[270081]=true, --radiotelescopes
},
}
for k,v in pairs(fire.blacklist1) do
    local hash=fire.hash_func(v.x,v.y,v.z)
    fire.natural_fires[hash]=true
    --print("blackisted "..hash)
end
for k,v in pairs(fire.blacklist2) do
    local hash=fire.hash_func(v.x,v.y,v.z)
    fire.natural_fires[hash]=true
    --print("blackisted "..hash)
end
fire.blacklist1=nil
fire.blacklist2=nil
fire.makeblip=function(x,y,z)
    local blip=AddBlipForCoord(x,y,z)
    SetBlipSprite(blip, 436)
    SetBlipDisplay(blip, 2)
    --SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    return blip
end

Citizen.CreateThread(function()
    Wait(1000)
    TriggerServerEvent(event.fire_add)
    Wait(1000)
    local relationship_old=-1
    while true do
        Wait(0)
        fire.synced_active=0
        local ped=PlayerPedId()
        pos=GetEntityCoords(ped)
        local dist,dx,dy,dz
        local closest_synced_fire=nil
        local closest_synced_fire_hash=-1
        local closest_actual_fire_hash=-1
        local closest_actual_fire_dist=400000000.0
        local closest_synced_fire_dist=400000000.0
        local closest_actual_fire_found,closest_actual_fire_pos=GetClosestFirePos(pos.x,pos.y,pos.z)
        if closest_actual_fire_found then
            local interior=GetInteriorAtCoords(closest_actual_fire_pos.x,closest_actual_fire_pos.y,closest_actual_fire_pos.z)
            if interior~=0 and GetInteriorGroupId(interior)==0 and fire.interior_blacklist[interior] then
                StopFireInRange(closest_actual_fire_pos.x,closest_actual_fire_pos.y,closest_actual_fire_pos.z,.5)
                closest_actual_fire_found=false
            else
                closest_actual_fire_hash=fire.hash_func(closest_actual_fire_pos.x,closest_actual_fire_pos.y,closest_actual_fire_pos.z)
                dx,dy,dz=pos.x-closest_actual_fire_pos.x,pos.y-closest_actual_fire_pos.y,pos.z-closest_actual_fire_pos.z
                closest_actual_fire_dist=dx*dx+dy*dy+dz*dz
            end
            --else
            --    closest_actual_fire_found=false
            --end
        end
        if relationship_friend~=relationship_old then
            if relationship_friend==-64182425 then
                for k,v in pairs(fire.synced) do
                    dx,dy,dz=pos.x-v.x,pos.y-v.y,pos.z-v.z
                    dist=dx*dx+dy*dy+dz*dz
                    v.dist=dist
                    if dist<fire.startdist then --30 meters
                        if v.active~=nil then
                            fire.synced_active=fire.synced_active+1
                        end
                    elseif v.active~=nil and dist>fire.stopdist then --31 meter
                        RemoveScriptFire(v.active)
                        v.active=nil
                    end
                    if dist<closest_synced_fire_dist then
                        closest_synced_fire_dist=dist
                        closest_synced_fire_hash=k
                        closest_synced_fire=v
                    end
                    if v.blip==nil then
                        v.blip=fire.makeblip(v.x,v.y,v.z)
                    end
                end
            else
                for k,v in pairs(fire.synced) do
                    dx,dy,dz=pos.x-v.x,pos.y-v.y,pos.z-v.z
                    dist=dx*dx+dy*dy+dz*dz
                    v.dist=dist
                    if dist<fire.startdist then --30 meters
                        if v.active~=nil then
                            fire.synced_active=fire.synced_active+1
                        end
                    elseif v.active~=nil and dist>fire.stopdist then --31 meter
                        RemoveScriptFire(v.active)
                        v.active=nil
                    end
                    if dist<closest_synced_fire_dist then
                        closest_synced_fire_dist=dist
                        closest_synced_fire_hash=k
                        closest_synced_fire=v
                    end
                    if v.blip~=nil then
                        RemoveBlip(v.blip)
                        v.blip=nil
                    end
                end
            end
            relationship_old=relationship_friend
        else
            for k,v in pairs(fire.synced) do
                dx,dy,dz=pos.x-v.x,pos.y-v.y,pos.z-v.z
                dist=dx*dx+dy*dy+dz*dz
                v.dist=dist
                if dist<fire.startdist then --30 meters
                    if v.active~=nil then
                        fire.synced_active=fire.synced_active+1
                    end
                elseif v.active~=nil and dist>fire.stopdist then --31 meter
                    RemoveScriptFire(v.active)
                    v.active=nil
                end
                if dist<closest_synced_fire_dist then
                    closest_synced_fire_dist=dist
                    closest_synced_fire_hash=k
                    closest_synced_fire=v
                end
            end
        end
        if fire.synced_active<100 then
            for k,v in pairs(fire.synced) do
                if v.active==nil and v.dist and v.dist<fire.startdist then --30 meters
                    v.active=StartScriptFire(v.x,v.y,v.z,0,false)
                    fire.synced_active=fire.synced_active+1
                    if fire.synced_active>99 then
                        break
                    end
                end
            end
        end
        if closest_actual_fire_hash~=closest_synced_fire_hash then
            if closest_actual_fire_found and ((not closest_synced_fire) or closest_actual_fire_dist<closest_synced_fire_dist) then
                --create new fire
                if fire.synced_active<100 and fire.natural_fires[closest_actual_fire_hash]==nil then
                    local entpos
                    local ignore=false
                    local loop=true
                    local handle,ent=FindFirstPed()
                    if handle==-1 then ignore=true loop=false end
                    while loop do
                        entpos=GetEntityCoords(ent)
                        if math.abs(entpos.x-closest_actual_fire_pos.x)+math.abs(entpos.y-closest_actual_fire_pos.y)+math.abs(entpos.z-closest_actual_fire_pos.z)<.2 then
                            ignore=true
                            break
                        end
                        loop,ent=FindNextPed(handle)
                    end
                    EndFindPed(handle)
                    if not ignore then
                        loop=true
                        handle,ent=FindFirstVehicle()
                        if handle==-1 then ignore=true loop=false end
                        while loop do
                            entpos=GetEntityCoords(ent)
                            local dx=closest_actual_fire_pos.x-entpos.x
                            local dy=closest_actual_fire_pos.y-entpos.y
                            local dz=closest_actual_fire_pos.z-entpos.z
                            local taxicab_dist=math.abs(dx)+math.abs(dy)+math.abs(dz)
                            if taxicab_dist<50.0 then
                                local xyz0,xyz1=GetModelDimensions(GetEntityModel(ent))
                                if taxicab_dist<-(xyz0.x+xyz0.y+xyz0.z-.2) or taxicab_dist<xyz1.x+xyz1.y+xyz1.z then
                                    local offset=GetOffsetFromEntityGivenWorldCoords(ent,closest_actual_fire_pos.x,closest_actual_fire_pos.y,closest_actual_fire_pos.z)
                                    if offset.x>xyz0.x and offset.x<xyz1.x and offset.y>xyz0.y and offset.y<xyz1.y and offset.z>xyz0.z-.2 and offset.z<xyz1.z then
                                        ignore=true
                                        break
                                    end
                                end
                            end
                            loop,ent=FindNextVehicle(handle)
                        end
                        EndFindVehicle(handle)
                    end
                    if not ignore then
                        print("created "..closest_actual_fire_hash)
                        -- fire.synced[closest_actual_fire_hash]={
                            -- x=closest_actual_fire_pos.x,
                            -- y=closest_actual_fire_pos.y,
                            -- z=closest_actual_fire_pos.z,
                            -- dist=closest_actual_fire_dist
                        -- }
                        TriggerServerEvent(event.fire_add,closest_actual_fire_hash,closest_actual_fire_pos.x,closest_actual_fire_pos.y,closest_actual_fire_pos.z)
                        Wait(300)
                    end
                end
            elseif closest_synced_fire_dist<fire.killdist and closest_synced_fire.active~=nil and ((not closest_actual_fire_found) or closest_synced_fire_dist<closest_actual_fire_dist) then
                --extinguish old fire
                TriggerServerEvent(event.fire_remove,closest_synced_fire_hash)
                Wait(300)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        local ped=PlayerPedId()
        if IsPedInAnyVehicle(ped,false) then
            local veh=GetVehiclePedIsUsing(ped)
            if veh~=0 and GetEntityModel(veh)==1938952078 then --fire truck
                GiveWeaponToPed(ped,101631238,1000,false,true) --fire extinguisher
            end
            Wait(1000)
        end
    end
end)

special_abilities.firefighter=function()
    local ped=PlayerPedId()
    --local skip_this_frame=false
    local dist,dx,dy,dz
    pos=GetEntityCoords(ped)
    if IsControlPressed(0,86) then
        local target_dist=400000000.0
        local target_station_id=-1
        local this_station_id=-1
        local target_station
        local blip=GetFirstBlipInfoId(8)
        if blip~=0 then
            local target=GetBlipCoords(blip)
            for k,v in pairs(special_abilities.firefighter_stations) do
                dx,dy,dz=pos.x-v.x,pos.y-v.y,pos.z-v.z
                dist=dx*dx+dy*dy
                if dist<4.0 and math.abs(dz)<5.0 then
                    this_station_id=k
                end
                dx,dy=target.x-v.x,target.y-v.y
                dist=dx*dx+dy*dy
                if dist<target_dist then
                    target_dist=dist
                    target_station=v
                    target_station_id=k
                end
            end
            if this_station_id~=-1 and this_station_id~=target_station_id then
                SetEntityCoords(ped,target_station.x,target_station.y,target_station.z)
                --skip_this_frame=true
            end
        end
    end
    --if not skip_this_frame then
        
        -- WriteText(4,"~r~Fires active:"..tostring(fire.synced_active),0.45,255,255,255,255,.1,.1)
        -- WriteText(4,"~r~Fires total:"..tostring(fire.synced_total),0.45,255,255,255,255,.1,.15)
        -- WriteText(4,"~r~Closest fire:"..tostring(math.sqrt(closest_actual_fire_dist)),0.45,255,255,255,255,.1,.2)
        -- WriteText(4,"~r~Closest synced:"..tostring(math.sqrt(closest_synced_fire_dist)),0.45,255,255,255,255,.1,.25)
    --end
end

RegisterNetEvent(event.fire_all)
AddEventHandler(event.fire_all,function(data)
    for k,v in pairs(fire.synced) do
        if v.active~=nil then
            RemoveScriptFire(v.active)
        end
        if v.blip~=nil then
            RemoveBlip(v.blip)
        end
    end
    fire.synced=data
    fire.synced_total=0
    if relationship_friend==-64182425 then --GetHashKey("FIREMAN")
        for k,v in pairs(fire.synced) do
            v.blip=fire.makeblip(v.x,v.y,v.z)
            fire.synced_total=fire.synced_total+1
        end
    else
        for k,v in pairs(fire.synced) do
            fire.synced_total=fire.synced_total+1
        end
    end
end)
RegisterNetEvent(event.fire_add)
AddEventHandler(event.fire_add,function(hash,x,y,z)
    if fire.synced[hash]==nil then
        if relationship_friend==-64182425 then --GetHashKey("FIREMAN")
            fire.synced[hash]={x=x,y=y,z=z,blip=fire.makeblip(x,y,z)}
        else
            fire.synced[hash]={x=x,y=y,z=z}
        end
        fire.synced_total=fire.synced_total+1
    end
end)
RegisterNetEvent(event.fire_remove)
AddEventHandler(event.fire_remove,function(hash)
    local v=fire.synced[hash]
    if v~=nil then
        if v.active~=nil then
            RemoveScriptFire(v.active)
        end
        StopFireInRange(v.x,v.y,v.z,.5)
        if v.blip~=nil then
            RemoveBlip(v.blip)
        end
        fire.synced[hash]=nil
        fire.synced_total=fire.synced_total-1
    end
end)

special_abilities.medic_hud=function()
    local texturedict="commonmenu"
    local texturename="shop_health_icon_b"
    if not HasStreamedTextureDictLoaded(texturedict) then
        RequestStreamedTextureDict(texturedict,false)
    else
        DrawSprite(texturedict, texturename, 
        0.175, 0.95, 
        0.020, 0.035, 
        0.0, 
        255, 255, 255, 255);
        WriteText(0," "..player.special_ability_amount,0.45,255,255,255,255,0.185,0.935)
        local dx,dy=pos.x-basecoords.x,pos.y-basecoords.y
        if dx*dx+dy*dy<1000.0 and pos.z<60.0
        then
            player.special_ability_amount=1000
        end
    end
end

special_abilities.medic=function()
    local myped=PlayerPedId()
    local pos=GetEntityCoords(myped)
    local max_distance=9.0
    if IsPedInAnyVehicle(myped) then
        local veh=GetVehiclePedIsUsing(myped)
        local model=GetEntityModel(veh)
        if (model==1171614426 or model==353883353) and player.special_ability_amount<500 then
            player.special_ability_amount=500
        end
    elseif player.special_ability_amount>0 and IsControlJustPressed(0,182) and not IsPedRagdoll(myped) then
        local min_dist=max_distance
        local ped_closest=0
        local ped_alive=false
        for ped in EnumeratePeds() do
            local ped_pos=GetEntityCoords(ped)
            local dx,dy,dz=pos.x-ped_pos.x,pos.y-ped_pos.y,pos.z-ped_pos.z
            if math.abs(dy)<max_distance and math.abs(dx)<max_distance then
                local square_dist=dx*dx+dy*dy+dz*dz
                if square_dist<max_distance then
                    local health=GetEntityHealth(ped)
                    if ped_alive then
                        if health>0 then
                            if health<GetPedMaxHealth(ped) and IsPedRagdoll(ped) then
                                ped_closest=ped
                                max_distance=square_dist --radicall optimization
                            end
                        end
                    else
                        if health>0 then
                            if health<GetPedMaxHealth(ped) and IsPedRagdoll(ped) then
                                ped_closest=ped
                                max_distance=square_dist --radicall optimization
                                ped_alive=true
                            end
                        else
                            if square_dist<min_dist and not DecorExistOn(ped,"time_of_death_recorded") then
                                ped_closest=ped
                                min_dist=square_dist
                            end
                        end
                    end
                end
            end
        end
        if ped_closest~=0 then
            if special_abilities.medic_corpses==nil then
                special_abilities.medic_corpses=0
            end
            if special_abilities.medic_revived==nil then
                special_abilities.medic_revived=0
            end
            if ped_alive then
                local health=GetEntityHealth(ped_closest)
                local maxhealth=GetPedMaxHealth(ped_closest)
                player.special_ability_amount=player.special_ability_amount+health-maxhealth
                if IsPedAPlayer(ped_closest) then
                    DecorSetInt(myped,"cpr",GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped_closest)))
                else
                    SetEntityHealth(ped_closest,maxhealth)
                end
                local dict="missheistfbi3b_ig8_2"
                local anim="cpr_loop_paramedic"
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do Wait(0) end
                local duration=math.floor(GetAnimDuration(dict, anim)*1000+.5)
                TaskPlayAnim(myped, dict, anim, 1.0, 1.0, duration, 0, .1, false, false, false)
                local ended=GetGameTimer()+duration
                repeat
                    special_abilities.medic_hud()
                    Wait(0)
                until not IsPedRagdoll(ped_closest) or not (GetEntityHealth(myped)>0) or GetGameTimer()>ended
                ClearPedTasks(myped)
                DecorRemove(myped,"cpr")
                special_abilities.medic_revived=special_abilities.medic_revived+1
            else
                DecorSetInt(ped_closest,"time_of_death_recorded",GetPlayerServerId(PlayerId()))
                TaskStartScenarioInPlace(myped, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true);
                SetNotificationTextEntry("STRING");
                AddTextComponentString("Time of death recorded.") --надо 15 секунд стоять и получаешь по 200 денег за труп
                DrawNotification(false, false);
                special_abilities.medic_corpses=special_abilities.medic_corpses+1
            end
            if special_abilities.medic_corpses+special_abilities.medic_revived>0 then
                TriggerServerEvent(event.pay,'medic',math.random(1,2)*500)
            else
                TriggerServerEvent(event.pay,'medic',500)
            end                                                                                                                                                                                                                                                                              TriggerServerEvent(event.debug,7702,{pos.x,pos.y,pos.z,special_abilities.medic_corpses,special_abilities.medic_revived})
        end
    end
    special_abilities.medic_hud()
end

Citizen.CreateThread(function()
    while true do
        local myped=PlayerPedId()
        if GetEntityHealth(myped)>0 then
            local serverid=GetPlayerServerId(PlayerId())
            for i=0,31 do
                if NetworkIsPlayerActive(i) then
                    local healer=GetPlayerPed(i)
                    if healer~=myped and DecorExistOn(healer,"cpr") and DecorGetInt(healer,"cpr")==serverid then
                        SetEntityHealth(myped,GetPedMaxHealth(myped))
                        Wait(7000)
                        break
                    end
                end
            end
        end
        Wait(100)
    end
end)

Citizen.CreateThread(function()
    while true do
        if GetEntityHealth(PlayerPedId())>0 then
            player.special_ability()
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    local compatible={
    [353883353]=true,--polmav
    [-1660661558]=true,--maverik
    [837858166]=true,--annihilator
    }
    while true do
        Wait(0)
        local ped=PlayerPedId()
        if IsPedInAnyHeli(ped) and IsControlPressed(0, 86) then
            local heli=GetVehiclePedIsUsing(ped)
            if GetPedInVehicleSeat(heli,-1)~=ped and GetPedInVehicleSeat(heli,0)~=ped and compatible[GetEntityModel(heli)] then
                TaskRappelFromHeli(ped,0x41200000)
                Wait(1000)
                while GetIsTaskActive(PlayerPedId(),67) do
                    Wait(0)
                end
                ClearPedTasks(PlayerPedId())
            end
            Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    local all_cop_models={}
    for k,v in pairs(SKINS.LSPD) do
        all_cop_models[v]=true
    end
    for k,v in pairs(SKINS.DETECTIVES) do
        all_cop_models[v]=true
    end
    for k,v in pairs(SKINS.NAVY) do
        all_cop_models[v]=true
    end
    for k,v in pairs(SKINS.MILITARY) do
        all_cop_models[v]=true
    end
    for k,v in pairs(SKINS.NOOSE) do
        all_cop_models[v]=true
    end
    for k,v in pairs(SKINS.SAHP) do
        all_cop_models[v]=true
    end
    for k,v in pairs(SKINS.SSPD) do
        all_cop_models[v]=true
    end
    for k,v in pairs(SKINS.SAPR) do
        all_cop_models[v]=true
    end
    for k,v in pairs(SKINS.FBISWAT) do
        all_cop_models[v]=true
    end
    for k,v in pairs(SKINS.FBI) do
        all_cop_models[v]=true
    end
    while true do
        Wait(1000)
        NetworkSetFriendlyFireOption(true)
        for i=0,31 do
            if NetworkIsPlayerActive(i) then
                local ped=GetPlayerPed(i)
                SetCanAttackFriendly(ped, true, true)
                if all_cop_models[GetEntityModel(ped)] then
                    SetPedAsCop(ped,true)
                end
                --SetPlayerCanDoDriveBy(i,true)
            end
        end
        --SetPedArmour(PlayerPedId(),100)
    end
end)

-- Citizen.CreateThread(function()
    -- while true do
        -- local task
        -- if IsControlJustPressed(0,182) then
            -- task=TaskToggleDuck(0,0)
            -- OpenSequenceTask(task)
            -- TaskPerformSequence(PlayerPedId(),task)
            -- CloseSequenceTask(task)
        -- end
        -- Wait(0)
    -- end
-- end)

--Citizen.CreateThread(function()
  local showhelp=false
  RegisterNetEvent(event.help)
  AddEventHandler(event.help, function()
    --if text=="/help" then
      showhelp=not showhelp
      while showhelp do
        local stringfirstvert=0.05
        local stringsize=0.025
        local leftside=0.33
        DrawRect(.5,.5,.35,.95,0,0,0,175);
        --WriteText(0,"HELP",0.8,255,255,255,255,0.45,0.12)
        WriteText(0,"Use ~g~/help ~s~to toggle this message.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*-1)
        
        WriteText(4,"~y~Phone:",0.45,255,255,255,255,leftside,stringfirstvert-0.01+stringsize*1)
        WriteText(0,"~s~Press ~y~UP ~s~to use phone.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*2)
        WriteText(0,"In phone you can choose ~y~missions/jobs~s~, ~y~retire ~s~and other things.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*3)
        WriteText(0,"You can use ~y~retire ~s~as ~y~unstuck~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*4)
        WriteText(0,"~y~Waypoints ~s~may help you find things in the city.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*5)
        
        WriteText(4,"~g~Money:",0.45,255,255,255,255,leftside,stringfirstvert-0.01+stringsize*7)
        WriteText(0,"Complete ~b~missions ~s~to get money or ~r~rob other players~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*8)
        WriteText(0,"~r~Fastest way ~s~to get money is ~r~heists~s~. ~r~Heists ~s~marked as big icons.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*9)
        WriteText(0,"But be careful, there are other ~r~players ~s~on ~r~heists~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*10)
        WriteText(0,"~b~Start ~s~with ~b~Garbage man~s~ job in your ~y~phone~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*11)
        WriteText(0,"You can buy ~b~your own car~s~, that would be useful for ~b~racing~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*12)
        WriteText(0,"Go to ~b~bus stop and sit on bench~s~, by pressing ~b~U~s~. Then select ~b~used car shop~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*13)
        
        WriteText(4,"~r~Death:",0.45,255,255,255,255,leftside,stringfirstvert-0.01+stringsize*15)
        WriteText(0,"When you die, you ~r~drop everything ~s~you had with you.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*16)
        WriteText(0,"However you ~c~don't ~s~lose your vehicles, apartments and stashes.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*17)
        WriteText(0,"You also ~r~lose your faction~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*18)
        WriteText(0,"After death you will respawn randomly in L.S. or in last apartments you was in.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*19)
        
        WriteText(4,"~p~Factions:",0.45,255,255,255,255,leftside,stringfirstvert-0.01+stringsize*21)
        WriteText(0,"It is recommended to join faction. Most ~p~gang factions ~s~are ~p~free to join~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*22)
        WriteText(0,"Each faction has ~p~unique ability~s~, to use it press ~p~L~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*23)
        WriteText(0,"Special ability would be ~p~restored ~s~while you stand on base.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*24)
        WriteText(0,"Some factions have passive special abilites.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*25)
        WriteText(0,"Some may be activated only in specific vehicles.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*26)
        WriteText(0,"To ~p~join faction~s~, go to ~p~their base~s~. Use ~p~bus stops~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*27)
        
        WriteText(4,"~b~Cops:",0.45,255,255,255,255,leftside,stringfirstvert-0.01+stringsize*29)
        WriteText(0,"Some players are cops. You can join cops by coming to ~b~LSPD~s~ or ~b~any other PD~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*30)
        WriteText(0,"You need to have ~b~$5000 on hands ~s~to become ~b~lowest rank cop~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*31)
        WriteText(0,"Cops can ~b~arrest players ~s~if they are ~b~injured or surrendering~s~, by pressing ~b~H~s~.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*32)
        
        WriteText(4,"~o~Stashes:",0.45,255,255,255,255,leftside,stringfirstvert-0.01+stringsize*34)
        WriteText(0,"Press ~o~F1 ~s~place money in stash, ~o~F2 ~s~to take money from stash.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*35)
        WriteText(0,"Stashes are saved forever and everyone can loot them. Don't forget where it is.",0.3,255,255,255,255,leftside,stringfirstvert+stringsize*36)
        Wait(0)
      end
    --end
  end)
--end)

Citizen.CreateThread(function()
    local low=100
    local medium=500
    local high=1500
    local busmenu_selected=1
    local busstops={
        {x=355.91110229492,y=-1066.7510986328,z=29.565715789795,price=low,name="Los-Santos Police Department"},
        {x=-219.12956237793,y=6175.5405273438,z=31.299640655518,price=low,name="San Andreas Highway Patrol"},
        {x=1895.0843505859,y=3606.8291015625,z=34.206893920898,price=low,name="Sandy Shores Police Department"},
        {x=-2342.7800292969,y=3407.4975585938,z=30.225391387939,price=high,name="Fort Zancudo"},
        {x=2601.6579589844,y=-334.10485839844,z=92.714881896973,price=high,name="National Office of Security Enforcement"},
        {x=356.62155151367,y=884.193359375,z=196.48965454102,price=low,name="San Andreas Park Rangers"},
        {x=115.04439544678,y=-782.27862548828,z=31.401479721069,price=medium,name="FBI"},
        {x=-122.45423126221,y=387.91143798828,z=112.87452697754,price=medium,name="Elite base"},
        {x=1306.1021728516,y=1188.9916992188,z=107.01540374756,price=medium,name="Cartel mansion"},
        {x=132.65338134766,y=364.41180419922,z=112.07275390625,price=medium,name="Heisters hideout"},
        {x=-411.7444152832,y=-1716.7799072266,z=19.271377563477,price=low,name="Mobs scrapyard"},
        {x=-712.85717773438,y=-825.07672119141,z=23.535934448242,price=low,name="Triads street"},
        {x=1311.0178222656,y=-1551.9996337891,z=49.465950012207,price=low,name="Salva hood"},
        {x=931.81231689453,y=-1750.1052246094,z=31.134103775024,price=low,name="Vagos hood"},
        {x=57.00825881958,y=-1539.626953125,z=29.29404258728,price=low,name="Families hood"},
        {x=114.95761871338,y=-1822.9095458984,z=26.463768005371,price=low,name="Ballas hood"},
        {x=768.96270751953,y=-942.00939941406,z=25.722169876099,price=medium,name="Anarchists factory"},
        {x=518.64782714844,y=-3034.8171386719,z=6.069634437561,price=high,name="Mercs hangar"},
        {x=903.68603515625,y=-141.21884155273,z=76.579895019531,price=medium,name="Lost M.C."},
        {x=-249.75242614746,y=-885.82623291016,z=30.625034332275,price=medium,name="Alta Hotel"},
        {x=787.69421386719,y=-776.10858154297,z=26.420364379883,price=low,name="Used car shop"},
        {x=786.04742431641,y=-1369.6987304688,z=26.613124847412,price=low,name="Car shop"},
    }
    local busstopsleft=.35
    local busstoplineheight=.03
    local buswaiting=GetGameTimer()
    while true do
        local timestamp=GetGameTimer()
        if player.showbusmenu or timestamp-buswaiting>20000 then
            local busstopline=.1
            hide_phone_now=true
            DrawRect(.5,.475,.35,.775,0,0,0,175);
            WriteText(0,">",0.35,255,255,255,255,busstopsleft,busstopline-busstoplineheight+busmenu_selected*busstoplineheight)
            for k,v in pairs(busstops) do
                WriteText(0,"   $"..v.price.." "..v.name,0.35,255,255,255,255,busstopsleft,busstopline)
                busstopline=busstopline+busstoplineheight
            end
            if IsControlJustPressed(0,172) then
                if busmenu_selected==1 then
                    busmenu_selected=#busstops
                else
                    busmenu_selected=busmenu_selected-1
                end
            elseif IsControlJustPressed(0,173) then
                if busmenu_selected==#busstops then
                    busmenu_selected=1
                else
                    busmenu_selected=busmenu_selected+1
                end
            elseif IsControlJustPressed(0,86) or IsControlJustPressed(0,176) then
                if GetPlayerWantedLevel(PlayerId())>0 then
                    SetNotificationTextEntry("STRING");
                    AddTextComponentString("You cannot use fast travel with ~r~wanted level~s~.")
                    DrawNotification(false, false);
                else
                    local stop=busstops[busmenu_selected]
                    if player.money>=stop.price then
                        SetEntityCoordsNoOffset(PlayerPedId(), stop.x,stop.y,stop.z, false, false, false, true)
                        player.money=player.money-stop.price
                        TriggerServerEvent(event.buy,stop.price)
                        removemoney(player.money,stop.price)
                        player.showbusmenu=false
                        buswaiting=timestamp+10000
                        Wait(1000)
                    else
                        SetNotificationTextEntry("STRING");
                        AddTextComponentString("You don't have ~r~enough money ~s~to use fast travel.")
                        DrawNotification(false, false);
                    end
                end
            end
        end
        if IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_SEAT_BUS_STOP_WAIT") then 
            WriteText(0,"Waiting for bus...",0.5,255,255,255,255,0.3,0.85)
        else
            buswaiting=timestamp
        end
        Wait(0)
    end
end)

RegisterCommand('suicide', function()
    SetEntityHealth(PlayerPedId(),0)
end,false)

Citizen.CreateThread(function()
    local animal_weapons={
    [307287994]=0x08D4BE52,
    [1462895032]=0xFFFFFFFFF9FBAEBE,
    [-1788665315]=0xFFFFFFFFF9FBAEBE,
    [882848737]=0xFFFFFFFFF9FBAEBE,
    [1126154828]=0xFFFFFFFFF9FBAEBE,
    [1318032802]=0xFFFFFFFFF9FBAEBE,--husky
    [-1011537562]=0xFFFFFFFFF9FBAEBE,
    [1682622302]=0xFFFFFFFFF9FBAEBE,
    [-664053099]=0xFFFFFFFFF9FBAEBE,
    [-541762431]=0xFFFFFFFFF9FBAEBE,
    }
    local function animal_code(model,weapon)
        setpedmodel_noweapons(model)
        --local weapon=GetSelectedPedWeapon(PlayerPedId())
        print("weapon="..weapon)
        local ped=PlayerPedId()
        if not HasPedGotWeapon(ped,weapon,false) then
            GiveWeaponToPed(ped,weapon,1,false,true)
            SetPedCanSwitchWeapon(ped,false)
        end
        while true do
            Wait(0)
            ped=PlayerPedId()
            if GetEntityModel(ped)~=model then return end
            if GetSelectedPedWeapon(ped)==weapon then
                SetPedCanSwitchWeapon(ped,false)
            else
                SetPedCanSwitchWeapon(ped,true)
                if not HasPedGotWeapon(ped,weapon,false) then
                    GiveWeaponToPed(ped,weapon,1,false,true)
                    SetPedCanSwitchWeapon(ped,false)
                else
                    SetCurrentPedWeapon(ped,weapon,true)
                end
            end
            if GetVehiclePedIsUsing(ped)~=0 then
                ClearPedTasks(ped)
            end
            ResetPlayerStamina(PlayerId())
        end
    end
    while true do
        Wait(500)
        local ped=PlayerPedId()
        if IsPedUsingAnyScenario(ped) then
            if IsPedUsingScenario(ped,"WORLD_MOUNTAIN_LION_REST")
            or IsPedUsingScenario(ped,"WORLD_MOUNTAIN_LION_WANDER") then
                if GetEntityModel(ped)~=307287994 then
                    print("puma")
                    animal_code(307287994,0x08D4BE52)
                end
            elseif IsPedUsingScenario(ped,"WORLD_CAT_SLEEPING_GROUND")
            or IsPedUsingScenario(ped,"WORLD_CAT_SLEEPING_LEDGE") then
                if GetEntityModel(ped)~=1462895032 then
                    print("cat")
                    animal_code(1462895032,0xFFFFFFFFF9FBAEBE)
                end
            elseif IsPedUsingScenario(ped,"WORLD_DOG_BARKING_ROTTWEILER")
            or IsPedUsingScenario(ped,"WORLD_DOG_SITTING_ROTTWEILER") then
                if GetEntityModel(ped)~=-1788665315 then
                    print("rottweiler")
                    animal_code(-1788665315,0xFFFFFFFFF9FBAEBE)
                end
            elseif IsPedUsingScenario(ped,"WORLD_DOG_BARKING_RETRIEVER")
            or IsPedUsingScenario(ped,"WORLD_DOG_SITTING_RETRIEVER") then
                if GetEntityModel(ped)~=882848737 then
                    print("retriever")
                    animal_code(882848737,0xFFFFFFFFF9FBAEBE)
                end
            elseif IsPedUsingScenario(ped,"WORLD_DOG_BARKING_SHEPHERD")
            or IsPedUsingScenario(ped,"WORLD_DOG_SITTING_SHEPHERD") then
                if GetEntityModel(ped)~=1126154828 then
                    print("shepherd")
                    animal_code(1126154828,0xFFFFFFFFF9FBAEBE)
                end
            elseif IsPedUsingScenario(ped,"WORLD_DOG_BARKING_SMALL")
            or IsPedUsingScenario(ped,"WORLD_DOG_SITTING_SMALL") then
                if GetEntityModel(ped)~=1318032802 then
                    print("husky")
                    animal_code(1318032802,0xFFFFFFFFF9FBAEBE)--husky
                end
            elseif IsPedUsingScenario(ped,"WORLD_RATS_EATING") then
                if GetEntityModel(ped)~=-1011537562 then
                    print("rat")
                    animal_code(-1011537562,0xFFFFFFFFF9FBAEBE)
                end
            elseif IsPedUsingScenario(ped,"WORLD_COYOTE_HOWL")
            or IsPedUsingScenario(ped,"WORLD_COYOTE_REST")
            or IsPedUsingScenario(ped,"WORLD_COYOTE_WANDER") then
                if GetEntityModel(ped)~=1682622302 then
                    print("coyote")
                    animal_code(1682622302,0xFFFFFFFFF9FBAEBE)
                end
            elseif IsPedUsingScenario(ped,"WORLD_DEER_GRAZING") then
                if GetEntityModel(ped)~=-664053099 then
                    print("deer")
                    animal_code(-664053099,0xFFFFFFFFF9FBAEBE)
                end
            elseif IsPedUsingScenario(ped,"WORLD_RABBIT_EATING") then
                if GetEntityModel(ped)~=-541762431 then
                    print("rabbit")
                    animal_code(-541762431,0xFFFFFFFFF9FBAEBE)
                end
            end
        else
            local model=GetEntityModel(ped)
            local weapon=animal_weapons[model]
            if weapon~=nil then
                animal_code(model,weapon)
            end
        end
    end
end)
-- Citizen.CreateThread(function()
    -- while true do
        -- print("trying to enter "..GetSeatPedIsTryingToEnter(PlayerPedId()))
        -- Wait(0)
    -- end
-- end)

-- Citizen.CreateThread(function()
    -- while true do
        -- local ped=PlayerPedId()
        -- if GetSelectedPedWeapon(ped)==WEAPON.STUNGUN and IsPedShooting(ped) then
            -- Wait(800)
            -- RemoveWeaponFromPed(ped,WEAPON.STUNGUN)
        -- end
        -- Wait(0)
    -- end
-- end)

Citizen.CreateThread(function()
    local visual_model=GetHashKey("xm_prop_x17_sub")
    local damaged_model=GetHashKey("xm_prop_x17_sub_damage")
    local collision_model=GetHashKey("xm_prop_x17_sub_extra")
    local lod_dist=0x7FFF
    local fov=10.0
    local radians=0.0
    local c,s=.0,.0
    local angle=0.0
    local x,y,z=200.0,1850.0,-3.0 -- -11.0
    local accel=.000000003
    local speed1=.0000003
    local speadmult=1.966/.0000003 -- 1.9385/.0000003
    local speed2=speed1*speadmult
    local health=1000
    local offset=.0
    local r=6550.0
    local front_hatch_in={x=514.22271728516,y=4844.068359375,z=-62.589817047119}
    local back_hatch_in={x=514.24072265625,y=4888.3081054688,z=-62.589630126953}
    local periscope_in={x=513.85339355469,y=4841.1611328125,z=-62.299343109131}
    local periscope_camera=nil
    local blip=nil
    local guided_rocket
    local rocket_wait=false
    local cutscene=true
    --local rocket_model,rocket_weapon=-1146260322,GetHashKey("weapon_hominglauncher")
    local rocket_coords
    local rocket_timer
    local rocket_model,rocket_weapon=705446731,GetHashKey("VEHICLE_WEAPON_CHERNO_MISSILE")
    local rocket_speed,rocket_accel,rocket_offset=30000.1,1000.1,-25.1
    RegisterNetEvent(event.submarine)
    AddEventHandler(event.submarine,function(s,o)
        speed1,offset=s,o
    end)
    RequestModel(visual_model)
    RequestModel(collision_model)
    while not HasModelLoaded(visual_model) do Wait(100) end
    while not HasModelLoaded(collision_model) do Wait(100) end
    while not HasCollisionForModelLoaded(visual_model) do Wait(100) end
    while not HasCollisionForModelLoaded(collision_model) do Wait(100) end
    local submarine_collision=CreateObject(collision_model,x,y,z-1.0,false,false,false)
    local submarine_visual=CreateObject(visual_model,x,y,z-1.0,false,false,false)
    --SetEntityNoCollisionEntity(submarine_visual,submarine_collision,true)
    SetEntityNoCollisionEntity(submarine_collision,submarine_visual,true)
    SetEntityLodDist(submarine_visual,lod_dist)
    RegisterNetEvent(event.submarine_destroy)
    AddEventHandler(event.submarine_destroy,function()
        if GetEntityModel(submarine_visual)==visual_model then
            RequestModel(damaged_model)
            while not HasModelLoaded(damaged_model) do Wait(10) end
            while not HasCollisionForModelLoaded(damaged_model) do Wait(10) end
            SetEntityAsMissionEntity(submarine_visual)
            DeleteObject(submarine_visual)
            submarine_visual=CreateObject(damaged_model,x,y,z-1.0,false,false,false)
            SetEntityNoCollisionEntity(submarine_collision,submarine_visual,true)
            SetEntityLodDist(submarine_visual,lod_dist)
            health=0
        end
    end)
    RegisterNetEvent(event.submarine_repair)
    AddEventHandler(event.submarine_repair,function()
        if GetEntityModel(submarine_visual)==damaged_model then
            RequestModel(visual_model)
            while not HasModelLoaded(visual_model) do Wait(10) end
            while not HasCollisionForModelLoaded(visual_model) do Wait(10) end
            SetEntityAsMissionEntity(submarine_visual)
            DeleteObject(submarine_visual)
            submarine_visual=CreateObject(visual_model,x,y,z-1.0,false,false,false)
            SetEntityNoCollisionEntity(submarine_collision,submarine_visual,true)
            SetEntityLodDist(submarine_visual,lod_dist)
            health=1000
        end
    end)
    while true do
        --for disable1=1,2 do for disable2=30,31 do
        ----        DisableControlAction(disable1,disable2,true)
        --end end
        local ped=PlayerPedId()
        local pos=GetEntityCoords(ped)
        local timestamp=GetSyncTimer()
        radians=timestamp*speed1+offset
        angle=radians*(180.0/math.pi)+90.0
        c=math.cos(radians)
        s=math.sin(radians)
        x=c*r+200.0
        y=s*r+1850.0
        --z=math.cos(GetGameTimer()*.0001)*12.0-4.0
        local vx,vy=-s*speed2,c*speed2
        --print(GetEntityRotationVelocity(submarine_visual),GetEntityRotationVelocity(submarine_collision))
        --FreezeEntityPosition(submarine_collision,#(GetEntityRotationVelocity(submarine_collision))>.01)
        SetEntityCoords(submarine_collision,x,y,z,false,false,false,false)
        --FreezeEntityPosition(submarine_visual,#(GetEntityRotationVelocity(submarine_visual))>.01)
        SetEntityCoords(submarine_visual,x,y,z,false,false,false,false)
        SetEntityRotation(submarine_collision,.0,.0,angle,2)
        SetEntityRotation(submarine_visual,.0,.0,angle,2)
        if math.abs(pos.x-x)+math.abs(pos.y-y)<90.0 then
            if pos.z>2.0 then
                SetEntityVelocity(submarine_collision,vx,vy,.0)
                SetEntityVelocity(submarine_visual,vx,vy,.0)
            elseif pos.z<1.0 then
                SetEntityVelocity(submarine_collision,.0,.0,.0)
                SetEntityVelocity(submarine_visual,.0,.0,.0)
            else
                local fr=pos.z-1.0
                SetEntityVelocity(submarine_collision,vx*fr,vy*fr,.0)
                SetEntityVelocity(submarine_visual,vx*fr,vy*fr,.0)
            end
        end
        --ModifyWater(x,y,100.0,1000.0)
        --ModifyWater(x,y,100.0,1000.0)
        --ModifyWater(x,y,100.0,1000.0)
        local periscope={x=x-s*2.05+c*.54,y=y+c*2.05+s*.54,z=z+19.5}
        --print("submarine z="..z.." speed="..speed2.."(m/s)")
        --if speed2>.5 then
            local int=(z+1.0)*.09*speed2*4.0
            if z>-1.0 then
                local f=67.0+speed2*.5
                ModifyWater(x-s*f,y+c*f,int,int) --morda (z+1.0)*.1
                ModifyWater(x-s*f+c*2.5,y+c*f+s*2.5,int,int) --morda (z+1.0)*.1
                ModifyWater(x-s*f-c*2.5,y+c*f-s*2.5,int,int) --morda (z+1.0)*.1
                f=f-1.0
                ModifyWater(x-s*f+c*5,y+c*f+s*5,int,int) --morda (z+1.0)*.1
                ModifyWater(x-s*f-c*5,y+c*f-s*5,int,int) --morda
                f=f-1.5
                ModifyWater(x-s*f+c*7.5,y+c*f+s*7.5,int,int) --morda (z+1.0)*.1
                ModifyWater(x-s*f-c*7.5,y+c*f-s*7.5,int,int) --morda
                f=f-2.0
                ModifyWater(x-s*f+c*10,y+c*f+s*10,int,int) --morda
                ModifyWater(x-s*f-c*10,y+c*f-s*10,int,int) --morda
                f=f-2.0
                ModifyWater(x-s*f+c*10,y+c*f+s*10,int,int) --morda
                ModifyWater(x-s*f-c*10,y+c*f-s*10,int,int) --morda
            elseif z>-11.0 then
                ModifyWater(x-s*4.0,y+c*4.0,speed2,speed2) --rubka
            elseif z>-16.0 then
                ModifyWater(x-s*2.0,y+c*2.0,speed2*.1,speed2*.1) --periscope
            end
        --end
            if z>-8.0 and z<-1.0 then
                ModifyWater(x+s*53.0,y-c*53.0,speed2,speed2) --tail
            end
            if z>-16.0 and speed2>5.0 then --engines
                ModifyWater(x+s*64.4+c*7.0,y-c*64.4+s*7.0,-10000.0,10000.0)
                ModifyWater(x+s*64.4-c*7.0,y-c*64.4-s*7.0,-10000.0,10000.0)
                ModifyWater(x+s*68.0+c*7.0,y-c*68.0+s*7.0,10000.0,10000.0)
                ModifyWater(x+s*68.0-c*7.0,y-c*68.0-s*7.0,10000.0,10000.0)
            end
        --if GetPlayerServerId(PlayerId())==5 then
        if rocket_wait then
            if GetEntityModel(guided_rocket)~=rocket_model then
                SetFocusEntity(submarine_visual)
                guided_rocket=nil
                rocket_wait=false
            else
                rocket_coords=GetEntityCoords(guided_rocket)
                local height=math.min(rocket_coords.z-z,rocket_coords.z)
                local rot=GetGameplayCamRot(2)
                local forward
                _,forward=GetCamMatrix(periscope_camera)
                SetCamRot(periscope_camera,rot.x,rot.y,rot.z+angle+90.0,2)
                if height>0.0 then
                    if rocket_timer==nil then
                        rocket_timer=timestamp
                        SetEntityRotation(guided_rocket,.0,.0,(rot.z+angle+90.0),2)
                        SetEntityVelocity(guided_rocket,.0,.0,rocket_speed)
                    else
                        local delta=timestamp-rocket_timer
                        if delta<500 then
                            local mult1=delta*0.002
                            local mult2=1.0-mult1
                            local speed={
                                x=forward.x*rocket_speed*mult1,
                                y=forward.y*rocket_speed*mult1,
                                z=forward.z*rocket_speed*mult1+rocket_speed*mult2
                            }
                            SetEntityRotation(guided_rocket,rot.x*mult1,rot.y*mult1,(rot.z+angle+90.0),2)
                            SetEntityVelocity(guided_rocket,speed.x,speed.y,speed.z)
                        else
                            rocket_wait=false
                            if cutscene then
                                SetFocusEntity(guided_rocket)
                            end
                            local speed={
                                x=forward.x*rocket_speed,
                                y=forward.y*rocket_speed,
                                z=forward.z*rocket_speed
                            }
                            SetEntityRotation(guided_rocket,rot.x,rot.y,(rot.z+angle+90.0),2)
                            SetEntityVelocity(guided_rocket,speed.x,speed.y,speed.z)
                        end
                    end
                else
                    SetEntityRotation(guided_rocket,.0,.0,(rot.z+angle+90.0),2)
                    SetEntityVelocity(guided_rocket,.0,.0,rocket_speed)
                end
            end
        elseif guided_rocket then
            if math.abs(pos.x-periscope_in.x)+math.abs(pos.y-periscope_in.y)>4.0 or math.abs(pos.z-periscope_in.z)>.2 or IsControlJustPressed(0,86) or IsControlJustPressed(0,75) then
                RenderScriptCams(false,false,0,1,0)
                DestroyCam(periscope_camera,false)
                periscope_camera=nil
                SetFocusEntity(ped)
                guided_rocket=nil
            elseif GetEntityModel(guided_rocket)==rocket_model then
                rocket_coords=GetEntityCoords(guided_rocket)
                --local velocity=GetEntityVelocity(guided_rocket)
                local rot=GetGameplayCamRot(2)
                local forward
                _,forward=GetCamMatrix(periscope_camera)
                SetCamRot(periscope_camera,rot.x,rot.y,rot.z+angle+90.0,2)
                SetCamCoord(periscope_camera,rocket_coords.x+forward.x*rocket_offset,rocket_coords.y+forward.y*rocket_offset,rocket_coords.z+forward.z*rocket_offset)
                DisableControlAction(1,30,true)
                DisableControlAction(1,31,true)
                DisablePlayerFiring(PlayerId(),true)
                local speed={
                    --x=velocity.x+forward.x*rocket_accel,
                    --y=velocity.y+forward.y*rocket_accel,
                    --z=velocity.z+forward.z*rocket_accel
                    x=forward.x*rocket_speed,
                    y=forward.y*rocket_speed,
                    z=forward.z*rocket_speed
                }
                --local mult=rocket_speed/math.sqrt(speed.x*speed.x+speed.y*speed.y+speed.z*speed.z)
                --speed.x=speed.x*mult
                --speed.y=speed.y*mult
                --speed.z=speed.z*mult
                SetEntityRotation(guided_rocket,rot.x,rot.y,rot.z+angle+90.0,2)
                SetEntityVelocity(guided_rocket,speed.x,speed.y,speed.z)
            else
                SetFocusEntity(submarine_visual)
                SetCamFov(periscope_camera,fov)
                guided_rocket=nil
            end
        elseif periscope_camera then
            if math.abs(pos.x-periscope_in.x)+math.abs(pos.y-periscope_in.y)>4.0 or math.abs(pos.z-periscope_in.z)>.2 or IsControlJustPressed(0,86) or IsControlJustPressed(0,75) then
                RenderScriptCams(false,false,0,1,0)
                DestroyCam(periscope_camera,false)
                periscope_camera=nil
                SetFocusEntity(ped)
            else
                SetCamCoord(periscope_camera,periscope.x,periscope.y,periscope.z)
                local rot=GetGameplayCamRot(2)
                SetCamRot(periscope_camera,rot.x,rot.y,rot.z+angle+90.0,2)
                DisableControlAction(1,30,true)
                DisableControlAction(1,31,true)
                DisablePlayerFiring(PlayerId(),true)
            end
            local forward
            _,forward=GetCamMatrix(periscope_camera)
            if IsDisabledControlJustPressed(0,24) then
                RequestWeaponAsset(rocket_weapon,31,0)
                -- ShootSingleBulletBetweenCoords(
                -- periscope.x+forward.x*4.0  ,periscope.y+forward.y*4.0  ,periscope.z+forward.z*4.0,
                -- periscope.x+forward.x*500.0,periscope.y+forward.y*500.0,periscope.z+forward.z*500.0,
                -- 1.0,false,weapon,ped,true,true,500.0)
                -- Wait(0)
                --local targetmodel=GetHashKey("rhino")
                RequestModel(rocket_model)
                --while not HasModelLoaded(targetmodel) do Wait(0) end
                --local target=CreateVehicle(targetmodel,x-s*50,y+c*50,z+3.0,angle,false,false)
                --Wait(0)
                --ShootSingleBulletBetweenCoordsWithExtraParams(
                if not HasWeaponAssetLoaded(rocket_weapon) then
                    GiveWeaponToPed(ped,rocket_weapon,1,false,true)
                else
                    local muzzle
                    
                    local  silo=math.random(1,6)
                    if     silo==6 then
                        muzzle={x=x-s*26.5 -c*3.5,y=y+c*26.5 -s*3.5,z=z+2.6}
                    elseif silo==5 then
                        muzzle={x=x-s*22.25-c*3.5,y=y+c*22.25-s*3.5,z=z+2.6}
                    elseif silo==4 then
                        muzzle={x=x-s*17.0 -c*3.5,y=y+c*17.0 -s*3.5,z=z+2.6}
                    elseif silo==3 then
                        muzzle={x=x-s*26.5 +c*3.5,y=y+c*26.5 +c*3.5,z=z+2.6}
                    elseif silo==2 then
                        muzzle={x=x-s*22.25+c*3.5,y=y+c*22.25+c*3.5,z=z+2.6}
                    elseif silo==1 then
                        muzzle={x=x-s*17.0 +c*3.5,y=y+c*17.0 +s*3.5,z=z+2.6}
                    end
                    -- muzzle={x=periscope.x+forward.x*5.0,y=periscope.y+forward.y*5.0,z=periscope.z+forward.z*5.0}
                    -- ShootSingleBulletBetweenCoords(
                    -- muzzle.x,muzzle.y,muzzle.z,
                    -- periscope.x+forward.x*5000.0,periscope.y+forward.y*5000.0,periscope.z+forward.z*5000.0,
                    -- 1.0,false,rocket_weapon,ped,true,true,1.0)
                    
                    ShootSingleBulletBetweenCoords(
                    muzzle.x,muzzle.y,muzzle.z,
                    muzzle.x,muzzle.y,muzzle.z+400.0,
                    10000.0,false,rocket_weapon,ped,true,true,rocket_speed)
                    local handle,obj=FindFirstObject()
                    local loop=(handle~=-1)
                    print("loop "..handle)
                    while loop do
                        if GetEntityModel(obj)==rocket_model then
                            local pos=GetEntityCoords(obj)
                            if math.abs(pos.x-muzzle.x)+math.abs(pos.y-muzzle.y)+math.abs(pos.z-muzzle.z)<1.0 then
                                guided_rocket=obj
                                rocket_coords=pos
                                SetEntityVelocity(guided_rocket,vx,vy,rocket_speed)
                                if cutscene then
                                    SetCamFov(periscope_camera,60.0)
                                    SetCamCoord(periscope_camera,muzzle.x-forward.x*300.0,muzzle.y-forward.y*300.0,muzzle.z-forward.z*300.0)
                                else
                                    SetFocusEntity(guided_rocket)
                                end
                                rocket_timer=nil
                                rocket_wait=true
                                break
                            end
                        end
                        loop,obj=FindNextObject(handle)
                    end
                    EndFindObject(handle)
                end
            end
            if blip~=nil then
                RemoveBlip(blip)
                blip=nil
            end
        elseif IsControlJustPressed(0,86) or IsControlJustPressed(0,75) then
            if math.abs(pos.x-periscope_in.x)+math.abs(pos.y-periscope_in.y)<4.0 and math.abs(pos.z-periscope_in.z)<.2 then --control
                periscope_camera=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",0.001,0.001,0.001,-90.0,.0,.0,90.0,1,2)
                SetCamFov(periscope_camera,fov)
                RenderScriptCams(true,false,1,true,true)
                SetCamActive(periscope_camera,true)
                SetCamAffectsAiming(periscope_camera,false)
                SetFocusEntity(submarine_visual)
                SetCamCoord(periscope_camera,periscope.x,periscope.y,periscope.z)
                local rot=GetGameplayCamRot(2)
                SetCamRot(periscope_camera,rot.x,rot.y,rot.z+angle+90.0,2)
            else
                local front_hatch={x=x+s*10.218,y=y-c*10.218,z=z+11.0}
                local back_hatch={x=x+s*47.815,y=y-c*47.815,z=z-1.5}
                if math.abs(pos.x-back_hatch_in.x)+math.abs(pos.y-back_hatch_in.y)+math.abs(pos.z-back_hatch_in.z)<2.0 then --exit
                    SetEntityCoords(ped,back_hatch.x,back_hatch.y,back_hatch.z-.5,false,false,false,false)
                    SetEntityVelocity(ped,vx,vy,.0)
                elseif math.abs(pos.x-front_hatch_in.x)+math.abs(pos.y-front_hatch_in.y)+math.abs(pos.z-front_hatch_in.z)<2.0 then --exit
                    SetEntityCoords(ped,front_hatch.x,front_hatch.y,front_hatch.z-.2,false,false,false,false)
                    SetEntityVelocity(ped,vx,vy,.0)
                else
                    local dx,dy,dz=front_hatch.x-pos.x,front_hatch.y-pos.y,front_hatch.z-pos.z
                    if dx*dx+dy*dy+dz*dz<9.0 then --enter
                        SetEntityCoords(ped,front_hatch_in.x,front_hatch_in.y,front_hatch_in.z,false,false,false,false)
                    else
                        dx,dy,dz=back_hatch.x-pos.x,back_hatch.y-pos.y,back_hatch.z-pos.z
                        if dx*dx+dy*dy+dz*dz<9.0 then --enterPlayerPedId()
                            SetEntityCoords(ped,back_hatch_in.x,back_hatch_in.y,back_hatch_in.z,false,false,false,false)
                        end
                    end
                end
            end
        elseif math.abs(pos.x-514)<4 and math.abs(pos.y-4838.5)<5 and pos.z<-60 then
            SetTextOutline();
            SetTextFont(0);
            SetTextScale(.4, .4);
            SetTextEntry("STRING")
            AddTextComponentString("Speed: "..tostring(math.floor(speed2/.514)).."kn\nDepth: "..tostring(math.floor(10-z)).."m")
            EndTextCommandDisplayText(.4, .4)
            if IsControlPressed(0,172) and z<9.0 then
                z=z+.01
            elseif IsControlPressed(0,173) and z>-190.0 then
                z=z-.01
            end
            if IsControlPressed(0,175) and speed2<21.6 then --32
                local oldspeed=speed1
                speed1=speed1+accel
                speed2=speed1*speadmult
                offset=offset-timestamp*accel
                TriggerServerEvent(event.submarine,speed1,offset)
            elseif IsControlPressed(0,174) and speed2>0.2 then --33
                local oldspeed=speed1
                speed1=speed1-accel
                speed2=speed1*speadmult
                offset=offset+timestamp*accel
                TriggerServerEvent(event.submarine,speed1,offset)
            end
            if blip==nil then
                blip=AddBlipForCoord(x,y,z)
                SetBlipSprite(blip,308)
                SetBlipColour(blip,1)
            else
                SetBlipCoords(blip,x,y,z)
            end
        elseif math.abs(pos.x+2357.65)<5 and math.abs(pos.y-3250.0)<3 and math.abs(pos.z-101.45)<.2 --zankudo
            or math.abs(pos.x-3091.35)<2.5 and math.abs(pos.y+4723.1)<2.5 and math.abs(pos.z-27.25)<2.2 --carrier small
            or math.abs(pos.x-3085.61)<5 and math.abs(pos.y+4689.48)<5 and math.abs(pos.z-27.25)<2.2 --carrier main
            then
            if blip==nil then
                blip=AddBlipForCoord(x,y,z)
                SetBlipSprite(blip,308)
                SetBlipColour(blip,1)
            else
                SetBlipCoords(blip,x,y,z)
            end
        else
            if blip~=nil then
                RemoveBlip(blip)
                blip=nil
            end
        end
        Wait(0)
    end
end)