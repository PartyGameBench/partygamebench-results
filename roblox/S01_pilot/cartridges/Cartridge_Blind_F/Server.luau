--!strict
-- Cartridge Server Logic (Cartridge/Server.luau)

local Server = {}

function Server.InitServer(ctx: any, atmosphereProfile: any)
	ctx:ApplyAtmosphere(atmosphereProfile)

	-- Starter procedural platform & spawn pad inside ctx.MapRoot
	local baseTile = ctx:CreateInstance("Part", ctx.MapRoot) :: Part
	baseTile.Name = "NeonCenterTile"
	baseTile.Size = Vector3.new(24, 2, 24)
	baseTile.Position = Vector3.new(0, 12, 0)
	baseTile.Anchored = true
	baseTile.Material = Enum.Material.Neon
	baseTile.Color = Color3.fromRGB(0, 220, 255)

	ctx:RegisterSpawnPoints({ baseTile })
end

function Server.StartRound(ctx: any)
	ctx:TeleportParticipantsToSpawns()
	-- Start round loop using ctx:Spawn(function() ... end)
end

function Server.StopRound(ctx: any)
	return {
		WinnerUserIds = {},
		Scores = ctx:GetScores(),
		SummaryText = "Round finished!",
	}
end

function Server.Cleanup(_ctx: any)
	-- Additional custom state reset if needed (ctx automatically cleans up tracked instances/threads)
end

return Server
