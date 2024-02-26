local isDead = false
RegisterNetEvent('majestic-deathscreen:openUI', function(time)
    isDead = true
    SendNUIMessage({action = "DSMenu", open = true, time = time})
    if Config.Blur then
        TriggerScreenblurFadeIn()
    end
    disableSounds()
    while isDead do
        Citizen.Wait(0)
        DisableAllControlActions(0)
        if Config.Controls.Mouse == true then
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
        end
        for k, v in pairs(Config.Controls.Enable) do
            EnableControlAction(0, v, true)
        end
    end
end)

RegisterNetEvent('majestic-deathscreen:revive', function()
    isDead = false
    SendNUIMessage({action = "DSMenu", open = false})
    if Config.Blur then
        TriggerScreenblurFadeOut()
    end
    enableSounds()
end)

RegisterNetEvent('majestic-deathscreen:die', function(time)
    isDead = true
    SendNUIMessage({action = "DSMenu", open = true, time = time})
    if Config.Blur then
        TriggerScreenblurFadeIn()
    end
    disableSounds()
    while isDead do
        Citizen.Wait(0)
        DisableAllControlActions(0)
        if Config.Controls.Mouse == true then
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
        end
        for k, v in pairs(Config.Controls.Enable) do
            EnableControlAction(0, v, true)
        end
    end
end)



RegisterNetEvent('majestic-deathscreen:res', function()
    SendNUIMessage({action = "res"})
end)

RegisterNetEvent('majestic-deathscreen:updateRes', function(time)
    SendNUIMessage({action = "updateRes", time = time})
end)

RegisterCommand('test',function()
    TriggerEvent('majestic-deathscreen:updateRes', 0)
end)

function disableSounds()
    StartAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
    SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE",false)
    SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM",false)
    SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN",false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",false)
    StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
    SetAudioFlag("PoliceScannerDisabled",true)
    SetAudioFlag("DisableFlightMusic",true)
    SetPlayerCanUseCover(PlayerId(),false)
    SetRandomEventFlag(false)
    SetDeepOceanScaler(0.0)
end

function enableSounds()
    StopAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
    SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE",true)
    SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM",true)
    SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN",true)
    SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",true)
    StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
    SetAudioFlag("PoliceScannerDisabled",false)
    SetAudioFlag("DisableFlightMusic",false)
    SetPlayerCanUseCover(PlayerId(),true)
    SetRandomEventFlag(true)
    SetDeepOceanScaler(1.0)
end