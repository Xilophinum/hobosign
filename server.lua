local SignID = 0
local SignsMap = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'}
RegisterNetEvent("hobosign:saveSign", function(data)
    print(json.encode(data, {indent=true}))
    local stateBag = Player(source).state
    SignID = SignID + 1
    if SignID > 10 then SignID = 1 end
    data.id = SignsMap[SignID]
    stateBag:set("hobosign", data, true)
end)