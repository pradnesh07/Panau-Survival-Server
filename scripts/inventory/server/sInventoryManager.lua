class 'sInventoryManager'


function sInventoryManager:__init()

    self.inventories = {}

    Events:Subscribe("ModuleUnload", self, self.Unload)
    Events:Subscribe("PlayerQuit", self, self.PlayerQuit)

    Network:Subscribe("InventoryRequest", self, self.InventoryRequest)

end

function sInventoryManager:PlayerQuit(args)

    if self.inventories[tostring(args.player:GetSteamId().id)] then
        self.inventories[tostring(args.player:GetSteamId().id)]:Unload()
        self.inventories[tostring(args.player:GetSteamId().id)] = nil
    end

end

function sInventoryManager:Unload()

    Events:Fire("InventoryUnload")

    for player in Server:GetPlayers() do
        player:SetValue("Inventory", nil)
    end

end

function sInventoryManager:InventoryRequest(args, player)

    if self.inventories[tostring(player:GetSteamId().id)] then
        self.inventories[tostring(player:GetSteamId().id)]:Unload()
        self.inventories[tostring(player:GetSteamId().id)] = nil
    end

    self.inventories[tostring(player:GetSteamId().id)] = sInventory(player)

end

InventoryManager = sInventoryManager()