--loadstring(game:HttpGet("https://raw.githubusercontent.com/mafuasahina/whatever/main/grace"))()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield '))()
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

local roomsFolder = workspace:FindFirstChild("Rooms")
local roomModels = {}

local function isValidRoom(model)
	return model:IsA("Model") and tonumber(model.Name) ~= nil
end

local function processRoom(roomModel)
	for _, obj in ipairs(roomModel:GetChildren()) do
		if obj.Name ~= "Exit" and obj.Name ~= "VaultEntrance" and obj.Name ~= "SafeRoom" then
			obj:Destroy()
		end
	end
	roomModel.ChildAdded:Connect(function(obj)
		if obj.Name ~= "Exit" and obj.Name ~= "VaultEntrance" and obj.Name ~= "SafeRoom" then
			obj:Destroy()
		end
	end)
end

local function updateRoomList()
	roomModels = {}
	for _, model in ipairs(roomsFolder:GetChildren()) do
		if isValidRoom(model) then
			table.insert(roomModels, { model = model, number = tonumber(model.Name) })
		end
	end
	table.sort(roomModels, function(a, b)
		return a.number < b.number
	end)
end

local function processAllRooms()
	for _, room in ipairs(roomModels) do
		processRoom(room.model)
	end
end

local function cleanupRemotes()
	for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
		if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction"))
			and obj.Name ~= "byebyemyFRIENDbacktothelobby"
			and obj.Name ~= "TriggerPrompt"
			and obj.Name ~= "EnteredSaferoom" then
			obj:Destroy()
		end
	end
end

local function teleportLogic()
	local player = game.Players.LocalPlayer
	local character = player.Character
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local deathTimer = workspace:FindFirstChild("DEATHTIMER")
	local safeRoom = roomsFolder:FindFirstChild("SafeRoom", true)

	if safeRoom and safeRoom:IsA("Model") then
		local vault = safeRoom.Parent:FindFirstChild("VaultEntrance")
		local hinged = vault and vault:FindFirstChild("Hinged")
		local cylinder = hinged and hinged:FindFirstChild("Cylinder")
		local prompt = cylinder and cylinder:FindFirstChild("ProximityPrompt")
		if prompt then
			task.delay(0.1, function()
				ReplicatedStorage.TriggerPrompt:FireServer(prompt)
				ReplicatedStorage.Events.EnteredSaferoom:FireServer()
			end)
		end
	end

	if safeRoom
		and safeRoom:IsA("Model")
		and #roomModels > 0
		and not safeRoom:IsDescendantOf(roomModels[1].model)
		and deathTimer
		and deathTimer.Value <= 0 then

		local scale = safeRoom:FindFirstChild("Scale")
		local hitbox = scale and scale:FindFirstChild("hitbox")
		if hitbox and hitbox:IsA("BasePart") then
			sethiddenproperty(root, "PhysicsRepRootPart", hitbox)
			root.CFrame = hitbox.CFrame
		end

	elseif #roomModels > 0 then
		local nextRoom = roomModels[#roomModels].number - 1

		if safeRoom and safeRoom:IsA("Model") and deathTimer and not deathTimer:GetAttribute("AUTOGO") then
			local safeRoomNumber = nil
			for _, room in ipairs(roomModels) do
				if safeRoom:IsDescendantOf(room.model) then
					safeRoomNumber = room.number
					break
				end
			end

			if safeRoomNumber then
				nextRoom = math.min(safeRoomNumber + 11, nextRoom)
			end
		end

		character:WaitForChild("RoomDetectActor"):WaitForChild("UpdateRoom"):FireServer(nextRoom)
	end
end

local hbGrace
local childAddedConn
local childRemovedConn

local Window = Rayfield:CreateWindow({
	Name = "Grace",
	LoadingTitle = "Grace whatever",
	LoadingSubtitle = "by mafuyu",
	Discord = {
		Enabled = false,
		Invite = "",
		RememberJoins = false,
	},
	KeySystem = false,
})

local MainTab = Window:CreateTab("Main", "home")

local Section = MainTab:CreateSection("Grace Regular [NORMAL OR ZEN GAMEMODE]")

MainTab:CreateToggle({
	Name = "Autofarm",
	CurrentValue = false,
	Flag = "GraceRegular",
	Callback = function(Value)
		if Value then
			workspace:FindFirstChild("Game"):FindFirstChild("Ready"):FireServer()
			updateRoomList()
			processAllRooms()
			cleanupRemotes()

			childAddedConn = roomsFolder.ChildAdded:Connect(function(child)
				if isValidRoom(child) then
					table.insert(roomModels, { model = child, number = tonumber(child.Name) })
					table.sort(roomModels, function(a, b)
						return a.number < b.number
					end)
					processRoom(child)
				end
			end)

			childRemovedConn = roomsFolder.ChildRemoved:Connect(function(child)
				for i = #roomModels, 1, -1 do
					if roomModels[i].model == child then
						table.remove(roomModels, i)
						break
					end
				end
			end)

			hbGrace = RunService.Heartbeat:Connect(teleportLogic)
		else
			if hbGrace then
				hbGrace:Disconnect()
				hbGrace = nil
			end
			if childAddedConn then
				childAddedConn:Disconnect()
				childAddedConn = nil
			end
			if childRemovedConn then
				childRemovedConn:Disconnect()
				childRemovedConn = nil
			end
			roomModels = {}
		end
	end,
})

MainTab:CreateButton({
	Name = "Create Lobby with OP Modifiers",
	Callback = function()
		pcall(function()
			local args = {
				{
					a = 3,
					p = 1 / 0,
					s = 3,
					m = {
						ms = {
							FO = true,
							Wk = true,
							uR = true,
							rw = 2,
							wR = true,
							Rp = true,
							Uo = true,
							sF = true,
							qo = 10,
							wr = true,
							Tw = true,
							Sh = true,
							iO = true,
							OT = true,
							PP = 3,
							FL = true,
							YT = 3,
							wW = true,
							TP = true,
							yW = true,
							pr = true,
							Ss = true,
							uW = true,
							yO = true,
							Wr = true,
							Yr = true,
							Ss2 = true,
							ry = true,
							FE = true,
							Ss1 = true,
							DE = true,
							qy = true,
							RQ = 4,
							WY = true,
							Wi = true,
							TQ = true,
							PY = true,
							gD = 4,
							tT = true,
							qi = true,
							IY = true,
							Uu = true,
							IqB = 3,
							QI = true,
							IqS = true,
							re = true,
							IQ = true,
							rP = true,
							CH = true,
							ei = true,
							PR = true,
							Eu = true,
							qQ = true,
							pQ = true,
							wQ = true,
							op = true,
							MIM = true,
							fP = true,
							yR = true,
							Qt = true,
							yQ = 3,
							Wq = true,
							qT = true,
							Pi = 99,
							Oi = true,
							yw = true,
							OY = 3,
							Ti = true,
							TW = true,
							Wt = true,
							di = 2,
							WO = true,
							IU = true,
							UQ = true,
							WP = true,
							ou = true,
							CD = 3,
							wE = 5,
						},
						vav = true,
						v = false,
					},
					_m = 1,
					c = 1,
				},
			}
			ReplicatedStorage:WaitForChild("CreateLobby"):FireServer(unpack(args))
		end)
	end,
})

local Section2 = MainTab:CreateSection("REPRIEVE")

local reprieveValue = 5000

local reprieveButton

local function parseValue(val)
	local a, b = val:match("^(-?%d+)/(-?%d+)$")
	if a and b then
		return tonumber(a) / tonumber(b)
	end
	return tonumber(val)
end

MainTab:CreateInput({
	Name = "XP/Bricks Value",
	PlaceholderText = "5000",
	RemoveTextAfterFocusLost = false,
	Callback = function(val)
		local num = parseValue(val)
		if num then
			reprieveValue = num
			local display = num == math.huge and "inf" or num == -math.huge and "-inf" or num ~= num and "nan" or tostring(num)
			local lvl = num == math.huge and "inf" or num == -math.huge and "-inf" or num ~= num and "nan" or tostring(math.floor(num / 100))
			reprieveButton:Set("Get XP/Bricks [lvls: " .. lvl .. ", bricks: " .. display .. "]")
		end
	end,
})

reprieveButton = MainTab:CreateButton({
	Name = "Get XP/Bricks [lvls: 50, bricks: 5000]",
	Callback = function()
		pcall(function()
			for _, child in ipairs(workspace:WaitForChild("Beacons"):GetChildren()) do
				if child.Name == "Part" then
					workspace:WaitForChild("Script"):WaitForChild("BeaconPickup"):FireServer(child)
				end
			end
			task.wait(1)
			pcall(function()
				for _, f in next, getgc() do
					if type(f) == "function" then
						local i = getinfo(f)
						if i and i.source == "=Workspace.Rooms.1.Script.timre" then
							setupvalue(f, 1, reprieveValue)
							setupvalue(f, 2, reprieveValue)
						end
					end
				end
			end)
			workspace:WaitForChild("Script"):WaitForChild("ClaimAwards"):FireServer()
			ReplicatedStorage:WaitForChild("KillClient"):InvokeServer()
		end)
	end,
})

local Section3 = MainTab:CreateSection("MISC")

MainTab:CreateButton({
	Name = "Return to Lobby",
	Callback = function()
		pcall(function()
			ReplicatedStorage:WaitForChild("byebyemyFRIENDbacktothelobby"):FireServer()
		end)
	end,
})

MainTab:CreateButton({
	Name = "Buy crown [uses 100 keys]",
	Callback = function()
		pcall(function()
			ReplicatedStorage:WaitForChild("BuyKCrown"):InvokeServer()
		end)
	end,
})

MainTab:CreateButton({
	Name = "Get badges [kills you]",
	Callback = function()
		local HttpService = game:GetService("HttpService")
		local BadgeGotRemote = ReplicatedStorage:WaitForChild("BadgeGot")
		local httpRequest = http_request or request
		local universeId = game.GameId

		local function getAllBadgeIds()
			local badgeIds, cursor, url = {}, ""
			repeat
				url = ("https://badges.roproxy.com/v1/universes/%d/badges?limit=100&sortOrder=Asc%s "):format(
					universeId,
					cursor ~= "" and "&cursor=" .. cursor or ""
				)
				local response = httpRequest({ Url = url, Method = "GET" })
				if not response or response.StatusCode ~= 200 then break end
				local data = HttpService:JSONDecode(response.Body)
				for i = 1, #data.data do
					badgeIds[#badgeIds + 1] = data.data[i].id
				end
				cursor = data.nextPageCursor or ""
			until cursor == ""
			return badgeIds
		end

		local allBadges = getAllBadgeIds()
		for i = 1, #allBadges do
			BadgeGotRemote:FireServer(allBadges[i])
		end
	end,
})
