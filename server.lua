local SignID = 0
RegisterNetEvent("vox_hobosign:saveSign", function(data)
    local stateBag = Player(source).state
    SignID = SignID + 1
    if SignID > 10 then SignID = 1 end
    data.id = SignID
    stateBag:set("hobosign", data, true)
end)