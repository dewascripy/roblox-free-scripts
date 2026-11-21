-- ROBLOX EGG HATCH SYSTEM
-- Original Roblox Studio Educational Script

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local egg = workspace:WaitForChild("Egg")
local petsFolder = ServerStorage:WaitForChild("Pets")

local prompt = Instance.new("ProximityPrompt")
prompt.ActionText = "Hatch Egg"
prompt.ObjectText = "Mystery Egg"
prompt.HoldDuration = 0.5
prompt.MaxActivationDistance = 10
prompt.Parent = egg

local cooldown = {}

local function getRandomPet()
    local pets = petsFolder:GetChildren()

    if #pets == 0 then
        warn("No pets available!")
        return nil
    end

    return pets[math.random(1, #pets)]
end

Players.PlayerAdded:Connect(function(player)
    local inventory = Instance.new("Folder")
    inventory.Name = "PetInventory"
    inventory.Parent = player
end)

prompt.Triggered:Connect(function(player)
    if cooldown[player] then
        return
    end

    cooldown[player] = true

    local pet = getRandomPet()

    if pet then
        local inventory = player:FindFirstChild("PetInventory")

        if inventory then
            local newPet = Instance.new("StringValue")
            newPet.Name = pet.Name
            newPet.Value = pet.Name
            newPet.Parent = inventory

            print(player.Name .. " hatched: " .. pet.Name)
        end
    end

    task.wait(2)
    cooldown[player] = nil
end)

Players.PlayerRemoving:Connect(function(player)
    cooldown[player] = nil
end)

print("Egg Hatch System Loaded!")
