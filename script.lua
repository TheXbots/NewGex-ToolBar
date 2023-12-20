local Admins = {"xbotgalore4321", "masterperson451", "whoareyou77777", "fiveironfan2006", "ninjosh45", "oskizwnh", "Thehockey007"}
local Prefix = "/"
local BadgeService = game:GetService("BadgeService")
local DataStoreservice = game:GetService("DataStoreService")
local LeaderstatsDataStore = DataStoreservice:GetOrderedDataStore("LeaderstatsDataStore")

local function awardBadge(player, badgeId)
	-- Fetch badge information
	local success, badgeInfo = pcall(function()
		return BadgeService:GetBadgeInfoAsync(badgeId)
	end)

	if success then
		-- Confirm that badge can be awarded
		if badgeInfo.IsEnabled then
			-- Award badge
			local awardSuccess, result = pcall(function()
				return BadgeService:AwardBadge(player.UserId, badgeId)
			end)

			if not awardSuccess then
				-- the AwardBadge function threw an error
				warn("Error while awarding badge:", result)
			elseif not result then
				-- the AwardBadge function did not award a badge
				warn("Failed to award badge.")
			end
		end
	else
		warn("Error while fetching badge info: " .. badgeInfo)
	end
end

game.Players.PlayerAdded:Connect(function(plr)
	for _,v in pairs(Admins) do
		if plr.Name == v then
			plr.Chatted:Connect(function(msg)
				local loweredString = string.lower(msg)
				local args = string.split(loweredString," ")
				local unargs = string.split(msg, " ")
				if args[1] == Prefix.."kills" then
					for _,player in pairs(game:GetService("Players"):GetPlayers()) do
						if string.sub(string.lower(player.Name), 1, string.len(args[2])) == string.lower(args[2]) then
							player.leaderstats.Kills.Value = args[3]
						end
					end
				end
				if args[1] == Prefix.."sword" then
					for _,player in pairs(game:GetService("Players"):GetPlayers()) do
						if string.sub(string.lower(player.Name), 1, string.len(args[2])) == string.lower(args[2]) then
							if args[4] == "18927316236" and player.Name ~= "xbotgalore4321" then
								
							elseif args[4] == "18927316236" and player.Name == "xbotgalore4321" then
								player.leaderstats.Sword.Value = unargs[3]
								player.Equipped.Value = args[4]
							elseif args[4] ~= "18927316236" then
								player.leaderstats.Sword.Value = unargs[3]
								player.Equipped.Value = args[4]
							end
						end
					end
				end
				if args[1] == Prefix.."badge" then
					for _,player in pairs(game:GetService("Players"):GetPlayers()) do
						if string.sub(string.lower(player.Name), 1, string.len(args[2])) == string.lower(args[2]) then
							awardBadge(player.UserId, args[3])
						end
					end
				end
				if args[1] == Prefix.."kill" then
					for _,player in pairs(game:GetService("Players"):GetPlayers()) do
						if string.sub(string.lower(player.Name), 1, string.len(args[2])) == string.lower(args[2]) then
							player.Character.Humanoid.Health = 0
						end
					end
				end
				if args[1] == Prefix.."speed" then
					for _,player in pairs(game:GetService("Players"):GetPlayers()) do
						if string.sub(string.lower(player.Name), 1, string.len(args[2])) == string.lower(args[2]) then
							player.Character.Humanoid.WalkSpeed = tonumber(args[3])
						end
					end
				end
				if args[1] == Prefix.."souls" then
					for _,player in pairs(game:GetService("Players"):GetPlayers()) do
						if string.sub(string.lower(player.Name), 1, string.len(args[2])) == string.lower(args[2]) then
							local character = player.Character
							local soulsteal
							local kills
							local test = false
							for i,v in pairs(character:GetChildren()) do
								if v.Name:match("SoulSteal") then
									soulsteal = v
									test = true
									end
								end
							local test2 = false
							if test == true then 
								print("SoulSteal Found") 
							else
								warn("SoulSteal Failed")
								for i,v in pairs(game.Players:GetPlayerFromCharacter(character).Backpack:GetChildren()) do
									if v.Name:match("SoulSteal") then
										soulsteal = v
										test2 = true
										print("SoulSteal Found")
									end
								end
							end
							if test == true or test2 == true then
								local boolean = false
								for i,v in pairs(soulsteal:GetChildren()) do
									if v.Name == 'Kills' then 
										kills = v 
										boolean = true
										print("Kills variable found!")
									end
								end
								if boolean == true then
									kills.Value = args[3]
								end
							else
								print("Soulsteal not found.")
							end
						end
					end
				end
			end)
		end
	end
end)
