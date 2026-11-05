--!strict
-- Cartridge Entry Point (Cartridge/init.luau)

local ServerLogic = require(script:WaitForChild("Server"))
local ClientLogic = require(script:WaitForChild("Client"))

local Cartridge = {}

Cartridge.Meta = {
	Id = "Blind_B",
	Title = "Neon Collapse Arena",
	Description = "Survive on the collapsing synthwave neon tiles and knock rivals off the grid!",
	StyleTag = "Synthwave_CyberArena",
	RoundDuration = 75,
	MinPlayers = 1,
	MaxPlayers = 12,
}

Cartridge.AtmosphereProfile = {
	StyleTag = "Synthwave_CyberArena",
	ClockTime = 1.5,
	Brightness = 1.8,
	Ambient = Color3.fromRGB(26, 9, 51),
	OutdoorAmbient = Color3.fromRGB(45, 16, 84),
	ColorShift_Top = Color3.fromRGB(0, 220, 255),
	ColorShift_Bottom = Color3.fromRGB(255, 0, 127),
	FogEnd = 450,
	FogStart = 80,
	FogColor = Color3.fromRGB(20, 6, 40),
	BloomIntensity = 1.2,
	BloomSize = 24,
	BloomThreshold = 0.85,
}

function Cartridge.InitServer(ctx: any)
	ServerLogic.InitServer(ctx, Cartridge.AtmosphereProfile)
end

function Cartridge.StartRound(ctx: any)
	ServerLogic.StartRound(ctx)
end

function Cartridge.StopRound(ctx: any)
	return ServerLogic.StopRound(ctx)
end

function Cartridge.Cleanup(ctx: any)
	ServerLogic.Cleanup(ctx)
end

function Cartridge.InitClient(clientCtx: any)
	ClientLogic.InitClient(clientCtx)
end

function Cartridge.CleanupClient(clientCtx: any)
	ClientLogic.CleanupClient(clientCtx)
end

return Cartridge
