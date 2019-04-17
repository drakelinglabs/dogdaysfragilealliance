resource_type 'gametype' { name = 'Dog Days Fragile Alliance' }

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
--resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description 'Dog Days Fragile Alliance'

client_scripts {
'weapons.lua',
'events.lua',
'gang_economy.lua',
'vehicle_windows.lua',
'upgrades.lua',
'enumerator.lua',
'min_cl.lua',
--'ddfacl.lua',
}
server_scripts {
'events.lua',
'gang_economy.lua',
'sv_patches.lua',
'weapons.lua',
'min_sv.lua',
--'ddfasv.lua',
}

ui_page 'ui.html'

-- NUI Files
files {
'weaponicons/bodyarmor.png',
'weaponicons/bzgas.png',
'weaponicons/grenade.png',
'weaponicons/stickybomb.png',
'weaponicons/proxmine.png',
'weaponicons/pistol.png',
'weaponicons/vintagepistol.png',
'weaponicons/snspistol.png',
'weaponicons/combatpistol.png',
'weaponicons/heavypistol.png',
'weaponicons/appistol.png',
'weaponicons/50pistol.png',
'weaponicons/mk2pistol.png',
'weaponicons/heavyrevolver.png',
'weaponicons/dbshotgun.png',
'weaponicons/sawedshotgun.png',
'weaponicons/pumpshotgun.png',
'weaponicons/bullpupshotgun.png',
'weaponicons/heavyshotgun.png',
'weaponicons/assaultshotgun.png',
'weaponicons/machinepistol.png',
'weaponicons/minismg.png',
'weaponicons/microsmg.png',
'weaponicons/smg.png',
'weaponicons/assaultsmg.png',
'weaponicons/mk2smg.png',
'weaponicons/combatpdw.png',
'weaponicons/assaultrifle.png',
'weaponicons/bullpuprifle.png',
'weaponicons/carbinerifle.png',
'weaponicons/specialcarbine.png',
'weaponicons/mk2carbinerifle.png',
'weaponicons/advancedrifle.png',
'weaponicons/mk2assaultrifle.png',
'weaponicons/mg.png',
'weaponicons/combatmg.png',
'weaponicons/mk2mg.png',
'weaponicons/sniperrifle.png',
'weaponicons/marksmanrifle.png',
'weaponicons/heavysniper.png',
'weaponicons/mk2heavysniper.png',
'weaponicons/grenadelauncher.png',
'weaponicons/musket.png',
'weaponicons/parachute.png',
'weaponicons/compactrifle.png',
'weaponicons/mk2snspistol.png',
'weaponicons/doubleaction.png',

'spawns/unknown.png',
'spawns/thug.png',
'spawns/driver.png',
'spawns/dealer.png',
'spawns/robber.png',
'spawns/security.png',
'spawns/resident.png',
'spawns/hitman.png',
'spawns/heister.png',
'spawns/elite.png',
'spawns/ballas.png',
'spawns/family.png',
'spawns/helipilot.png',
'spawns/lostmc.png',
'spawns/chaser.png',
'spawns/paramedic.png',
'spawns/firefighter.png',
'spawns/racer.png',
'spawns/anarchist.png',
'ui.html',
'pdown.ttf',
}