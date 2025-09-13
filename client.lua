local isBegging = false
local propObject = 0

RegisterCommand("hobosign", function()
    local playerPed = PlayerPedId()
    if isBegging then
        ClearPedTasks(playerPed)
        if DoesEntityExist(propObject) then
            DeleteEntity(propObject)
            propObject = 0
        end
        isBegging = false
        return
    end
    SendNUIMessage({
        action = "editSign"
    })
    SetNuiFocus(true, true)
end)

RegisterNUICallback("savesign", function(data, cb)
    if data.content then
        TriggerServerEvent("hobosign:saveSign", data)
    end
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNuiCallback('loaded', function(_, cb)
    DUILoaded = true
    cb('ok')
end)

AddStateBagChangeHandler('hobosign', nil, function(bagName, _, value)
    local playerId = GetPlayerFromStateBagName(bagName)
    if not playerId or not NetworkIsPlayerActive(playerId) then return end
    local isLocalPlayer = playerId == cache.playerId
    local playerPed = isLocalPlayer and cache.ped or GetPlayerPed(playerId)
    if not DoesEntityExist(playerPed) then return end
    if value.content then
        DUILoaded = false
        if not PlayersData[playerId] then
            PlayersData[playerId] = {}
        end
        PlayersData[playerId].duiObj = CreateDui(string.format("https://cfx-nui-%s/web/dist/index.html", GetCurrentResourceName(), math.random(100000, 999999)), 256, 256)
        PlayersData[playerId].duiHandle = GetDuiHandle(PlayersData[playerId].duiObj)
        PlayersData[playerId].txdid = "texture_" .. math.random(1, 100000)
        PlayersData[playerId].txd = CreateRuntimeTxd(PlayersData[playerId].txdid)
        PlayersData[playerId].textureid = "textureid_" .. math.random(1, 100000)
        PlayersData[playerId].texture = CreateRuntimeTextureFromDuiHandle(PlayersData[playerId].txd, PlayersData[playerId].textureid, PlayersData[playerId].duiHandle)
        while not DUILoaded do Wait(0) end
        SendDuiMessage(PlayersData[playerId].duiObj, json.encode({
            action = "sign",
            content = value.content
        }))
        if isLocalPlayer then 
            local animDict = "amb@world_human_bum_freeway@male@base"
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Wait(100)
            end
            -- Create the prop
            local propModel = GetHashKey(("bzzz_prop_carton_sign_%s"):format(value.id))
            RequestModel(propModel)
            while not HasModelLoaded(propModel) do
                Wait(100)
            end

            RemoveReplaceTexture("bzzz_prop_carton_signs", ('paper_%s'):format(value.id))
            AddReplaceTexture("bzzz_prop_carton_signs", ('paper_%s'):format(value.id), PlayersData[playerId].txdid, PlayersData[playerId].textureid)
            
            local playerCoords = GetEntityCoords(playerPed)
            local createdObject = CreateObject(propModel, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
            if createdObject ~= nil then
                propObject = createdObject
            else
                print("Failed to create prop object!")
                return
            end
            
            local boneIndex = GetPedBoneIndex(playerPed, 58868)
            AttachEntityToEntity(
                propObject, 
                playerPed, 
                boneIndex,
                0.19, 0.18, 0.0,
                5.0, 0.0, 40.0,
                true, true, false, true, 1, true
            )
            TaskPlayAnim(playerPed, animDict, "base", 8.0, -8, -1, 49, 0, false, false, false)
            isBegging = true
        end
    else
        if PlayersData[playerId] and PlayersData[playerId].duiObj then
            DestroyDui(PlayersData[playerId].duiObj)
            PlayersData[playerId] = nil
        end
    end
end)