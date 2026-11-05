--!strict
-- Cartridge Client HUD & Feedback Logic (Cartridge/Client.luau)

local Client = {}

function Client.InitClient(clientCtx: any)
	-- Build HUD inside clientCtx.HudRoot and listen to server updates via clientCtx:OnServerEvent(...)
	clientCtx:OnServerEvent(function(_eventType: string, _payload: { [string]: any })
		-- Update HUD
	end)
end

function Client.CleanupClient(_clientCtx: any)
	-- Custom client cleanup if needed
end

return Client
