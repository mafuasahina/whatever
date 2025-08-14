local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function grace()
    for _, child in ipairs(workspace:WaitForChild("Beacons"):GetChildren()) do
        if child.Name == "Part" then
            workspace:WaitForChild("Script"):WaitForChild("BeaconPickup"):FireServer(child)
        end
    end

    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            if obj.Name:sub(1,4) == "Send" or obj.Name:sub(1,4) == "Kill" then
                obj:Destroy()
            end
        end
    end

    for _, item in ipairs(workspace:GetChildren()) do
        if item.Name ~= "Beacons" and not item:IsA("BaseScript") then
            if item.Name == "Rooms" then
                for _, child in ipairs(item:GetChildren()) do
                    child:Destroy()
                end
            else
                item:Destroy()
            end
        end
    end
end

local function grace2()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")

    local roomsFolder = workspace:WaitForChild("Rooms")
    local roomModels = {}

    for _, model in ipairs(roomsFolder:GetChildren()) do
        if model:IsA("Model") then
            local num = tonumber(model.Name)
            if num then
                table.insert(roomModels, { model = model, number = num })
            end
        end
    end

    for _, room in ipairs(roomModels) do
        local roomModel = room.model
        local vault = roomModel:FindFirstChild("VaultEntrance")

        if vault then
            ReplicatedStorage.TriggerPrompt:FireServer(
                vault:FindFirstChild("Hinged")
                    :FindFirstChild("Cylinder")
                    :FindFirstChild("ProximityPrompt")
            )
            ReplicatedStorage.Events.EnteredSaferoom:FireServer()
        else
            local toDestroy = {}
            for _, descendant in ipairs(roomModel:GetDescendants()) do
                if descendant:IsA("BaseScript") then
                    local target = descendant
                    while target.Parent ~= roomModel do
                        target = target.Parent
                    end
                    toDestroy[target] = true
                end
            end
            for target in pairs(toDestroy) do
                target:Destroy()
            end
        end
    end

    local safeRoom = roomsFolder:FindFirstChild("SafeRoom", true)
    local deathTimer = workspace:FindFirstChild("DEATHTIMER")

    table.sort(roomModels, function(a, b)
        return a.number < b.number
    end)

    if safeRoom and safeRoom:IsA("Model") and not safeRoom:IsDescendantOf(roomModels[#roomModels].model) and deathTimer.Value <= 0 then
        local vaultDoor = safeRoom:FindFirstChild("VaultDoor")
        local scale = safeRoom:FindFirstChild("Scale")
        local hitbox = scale and scale:FindFirstChild("hitbox")

        if hitbox and hitbox:IsA("BasePart") then
            root.CFrame = hitbox.CFrame * CFrame.Angles(0, math.rad(225), 0)
            workspace.CurrentCamera.CFrame = root.CFrame
        end
    else
        local index = #roomModels

        if safeRoom and safeRoom:IsA("Model") and not deathTimer:GetAttribute("AUTOGO") then
            index = math.min(11, #roomModels)
            task.delay(3, function()
                if safeRoom and safeRoom:IsA("Model") then
                    safeRoom:Destroy()
                end
            end)
        end

        local highestModel = roomModels[index] and roomModels[index].model
        local exit = highestModel and highestModel:FindFirstChild("Exit")

        if exit and exit:IsA("BasePart") then
            root.CFrame = exit.CFrame * CFrame.Angles(0, math.rad(45), 0)
            workspace.CurrentCamera.CFrame = root.CFrame
        end
    end

    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            if obj.Name:sub(1,4) == "Send" or obj.Name:sub(1,4) == "Kill" then
                obj:Destroy()
            end
        end
    end
end

local hbGrace1, hbGrace2

local Window = Rayfield:CreateWindow({
    Name = "Grace",
    LoadingTitle = "Grace whatever",
    LoadingSubtitle = "by mafuyu",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MyRayfieldUI",
        FileName = "Config1"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main", "home")

MainTab:CreateToggle({
    Name = "Grace Reprieve [ONLY ACTIVATE IN REPRIEVE]",
    CurrentValue = false,
    Flag = "GraceReprieve",
    Callback = function(Value)
        if Value then
            hbGrace1 = RunService.Heartbeat:Connect(grace)
        else
            if hbGrace1 then hbGrace1:Disconnect() hbGrace1 = nil end
        end
    end,
})

MainTab:CreateToggle({
    Name = "Grace Regular [ONLY ACTIVATE IN A NORMAL GAME]",
    CurrentValue = false,
    Flag = "GraceRegular",
    Callback = function(Value)
        if Value then
            hbGrace2 = RunService.Heartbeat:Connect(grace2)
        else
            if hbGrace2 then hbGrace2:Disconnect() hbGrace2 = nil end
        end
    end,
})

MainTab:CreateButton({
    Name = "Create Lobby with OP Modifiers",
    Callback = function()
        pcall(function()
            ReplicatedStorage.CreateLobby:FireServer({
                a=1,
                p=50,
                s=3,
                m={ms={II=true,QU=true,Ep=4,ei=true,oq=true,uR=true,wT=true,TQ=true,rq=10,YQ=3,tr=true,rI=true,ii=3,UO=true,CS=3,IR=true,RO=true,Ty=true,qi=true,im=true,Op=true,tQ=true,pe=true,iP=true,uY=true,MI=true,uy=true,Qr=true,iu=true,ir=true,KA=2,QP=true,WR=true,rt=true,TP=true,Ou=true,UT=5,yw=true,pp=true,To=true,Qi=true,Rw=true,Wt=true,Up=true,Er=true,uu=true,qY=true,RF=true,DR=true,PW=true,HE=true,it=true,iS=true,yE=true,wy=true,eW=3},
                vav=false,
                v=false
                },
                _m=1,
                c=1
            })
        end)
    end,
})
