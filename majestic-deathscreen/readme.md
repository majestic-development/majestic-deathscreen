## 1. Replace inside dead.lua (qb-ambulancejob > client > dead.lua) once done go to the buttom of this text and do the rest.

emsNotified = false

CreateThread(function()
	while true do
        local sleep = 1000
		if isDead or InLaststand then
            sleep = 5
            local ped = PlayerPedId()
            -- DisableAllControlActions(0)
            -- EnableControlAction(0, 1, true)
			-- EnableControlAction(0, 2, true)
			-- EnableControlAction(0, 245, true)
            -- EnableControlAction(0, 38, true)
            -- EnableControlAction(0, 0, true)
            -- EnableControlAction(0, 322, true)
            -- EnableControlAction(0, 288, true)
            -- EnableControlAction(0, 213, true)
            -- EnableControlAction(0, 249, true)
            -- EnableControlAction(0, 46, true)
            -- EnableControlAction(0, 47, true)

            if isDead then
                if not isInHospitalBed then
                    if deathTime > 0 then
                        DrawTxt(0.93, 1.44, 1.0,1.0,0.6, Lang:t('info.respawn_txt', {deathtime = math.ceil(deathTime)}), 255, 255, 255, 255)
                    else
                        DrawTxt(0.865, 1.44, 1.0, 1.0, 0.6, Lang:t('info.respawn_revive', {holdtime = hold, cost = Config.BillCost}), 255, 255, 255, 255)
                    end
                end

                if IsPedInAnyVehicle(ped, false) then
                    loadAnimDict("veh@low@front_ps@idle_duck")
                    if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                        TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                    end
                else
                    if isInHospitalBed then
                        if not IsEntityPlayingAnim(ped, inBedDict, inBedAnim, 3) then
                            loadAnimDict(inBedDict)
                            TaskPlayAnim(ped, inBedDict, inBedAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    else
                        if not IsEntityPlayingAnim(ped, deadAnimDict, deadAnim, 3) then
                            loadAnimDict(deadAnimDict)
                            TaskPlayAnim(ped, deadAnimDict, deadAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    end
                end

                SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
            elseif InLaststand then
                sleep = 5

                if LaststandTime > Config.MinimumRevive then
                  --  DrawTxt(0.94, 1.44, 1.0, 1.0, 0.6, Lang:t('info.bleed_out', {time = math.ceil(LaststandTime)}), 255, 255, 255, 255)
                    TriggerEvent('meteo-deathscreen:die',LaststandTime)
                else
                  --  DrawTxt(0.845, 1.44, 1.0, 1.0, 0.6, Lang:t('info.bleed_out_help', {time = math.ceil(LaststandTime)}), 255, 255, 255, 255)
                    TriggerEvent('meteo-deathscreen:die',LaststandTime)
                    if not emsNotified then
                        DrawTxt(0.91, 1.40, 1.0, 1.0, 0.6, Lang:t('info.request_help'), 255, 255, 255, 255)
                    else
                        DrawTxt(0.90, 1.40, 1.0, 1.0, 0.6, Lang:t('info.help_requested'), 255, 255, 255, 255)
                    end

                    if IsControlJustPressed(0, 47) and not emsNotified then
                        TriggerServerEvent('hospital:server:ambulanceAlert', Lang:t('info.civ_down'))
                        emsNotified = true
                    end
                end

                if not isEscorted then
                    if IsPedInAnyVehicle(ped, false) then
                        loadAnimDict("veh@low@front_ps@idle_duck")
                        if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                            TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    else
                        loadAnimDict(lastStandDict)
                        if not IsEntityPlayingAnim(ped, lastStandDict, lastStandAnim, 3) then
                            TaskPlayAnim(ped, lastStandDict, lastStandAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    end
                else
                    if IsPedInAnyVehicle(ped, false) then
                        loadAnimDict("veh@low@front_ps@idle_duck")
                        if IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                            StopAnimTask(ped, "veh@low@front_ps@idle_duck", "sit", 3)
                        end
                    else
                        loadAnimDict(lastStandDict)
                        if IsEntityPlayingAnim(ped, lastStandDict, lastStandAnim, 3) then
                            StopAnimTask(ped, lastStandDict, lastStandAnim, 3)
                        end
                    end
                end
            end
		end
        Wait(sleep)
	end
end)


## THEN CONTINUE TO qb-ambulancejob - client - main.lua and replace these two

1. search for RegisterNetEvent('hospital:client:Revive, function() and replace this event with the one below

RegisterNetEvent('hospital:client:Revive', function()
    local player = PlayerPedId()

    if isDead or InLaststand then
        local pos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
        isDead = false
        SetEntityInvincible(player, false)
        SetLaststand(false)
    end

    if isInHospitalBed then
        loadAnimDict(inBedDict)
        TaskPlayAnim(player, inBedDict, inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
        SetEntityInvincible(player, true)
        canLeaveBed = true
    end

    TriggerServerEvent('hospital:server:RestoreWeaponDamage')
    SetEntityMaxHealth(player, 200)
    SetEntityHealth(player, 200)
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    ResetAll()
    ResetPedMovementClipset(player, 0.0)
    TriggerServerEvent('hud:server:RelieveStress', 100)
    TriggerServerEvent('hospital:server:SetDeathStatus', false)
    TriggerServerEvent('hospital:server:SetLaststandStatus', false)
    emsNotified = false
    QBCore.Functions.Notify(Lang:t('info.healthy'))
    TriggerEvent('majestic-deathscreen:revive')
end)


## 2. look for RegisterNetEvent('hospital:client:RespawnAtHospital', function() and replace that whole event with the one below

RegisterNetEvent('hospital:client:RespawnAtHospital', function()
    TriggerEvent('majestic-deathscreen:revive')
    TriggerServerEvent("hospital:server:RespawnAtHospital")
    if exports["qb-policejob"]:IsHandcuffed() then
        TriggerEvent("police:client:GetCuffed", -1)
    end
    TriggerEvent("police:client:DeEscort")
end)
