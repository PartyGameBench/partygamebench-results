--!strict
-- ============================================================================
-- RGBenchSDK v1.0.0 · 参赛卡带接口与托管上下文类型声明（Read-Only Reference）
-- ============================================================================

export type AtmosphereProfile = {
	StyleTag: string,
	ClockTime: number?,
	Brightness: number?,
	Ambient: Color3?,
	OutdoorAmbient: Color3?,
	ColorShift_Top: Color3?,
	ColorShift_Bottom: Color3?,
	FogEnd: number?,
	FogStart: number?,
	FogColor: Color3?,
	AtmosphereDensity: number?,
	AtmosphereColor: Color3?,
	AtmosphereDecay: Color3?,
	BloomIntensity: number?,
	BloomSize: number?,
	BloomThreshold: number?,
}

export type CartridgeMeta = {
	Id: string,
	Title: string,
	Description: string,
	StyleTag: string,
	RoundDuration: number,
	MinPlayers: number,
	MaxPlayers: number,
}

export type ParticipantInfo = {
	UserId: number,
	Name: string,
	DisplayName: string,
	IsBot: boolean,
	Character: Model?,
	Player: Player?,
}

export type RoundResults = {
	WinnerUserIds: { number },
	Scores: { [number]: number },
	SummaryText: string?,
}

export type ManagedContext = {
	CartridgeId: string,
	MapRoot: Folder,
	Participants: { ParticipantInfo },

	-- 托管实例创建（回合结束自动销毁）
	CreateInstance: (self: ManagedContext, className: string, parent: Instance?) -> Instance,
	TrackInstance: <T>(self: ManagedContext, inst: T) -> T,

	-- 托管事件与协程（回合结束自动 Disconnect / task.cancel）
	TrackConnection: (self: ManagedContext, conn: RBXScriptConnection) -> RBXScriptConnection,
	Spawn: (self: ManagedContext, fn: (...any) -> (), ...any) -> thread,
	Delay: (self: ManagedContext, seconds: number, fn: () -> ()) -> thread,

	-- 视觉与环境风格应用（回合结束自动恢复大厅光照）
	ApplyAtmosphere: (self: ManagedContext, profile: AtmosphereProfile) -> (),

	-- 玩家传送与积分接口
	RegisterSpawnPoints: (self: ManagedContext, spawns: { BasePart | CFrame }) -> (),
	TeleportParticipantsToSpawns: (self: ManagedContext) -> (),
	AddScore: (self: ManagedContext, userId: number, delta: number, reason: string?) -> number,
	SetScore: (self: ManagedContext, userId: number, score: number) -> (),
	GetScores: (self: ManagedContext) -> { [number]: number },
	EliminateParticipant: (self: ManagedContext, userId: number, reason: string?) -> (),

	-- 双端安全网络信箱
	BroadcastToClients: (self: ManagedContext, eventType: string, payload: { [string]: any }) -> (),
	SendToClient: (self: ManagedContext, player: Player, eventType: string, payload: { [string]: any }) -> (),
	OnClientAction: (self: ManagedContext, callback: (player: Player, actionType: string, payload: { [string]: any }) -> ()) -> (),

	-- 主动提前结束回合
	FinishRound: (self: ManagedContext, results: RoundResults?) -> (),
}

export type ClientManagedContext = {
	CartridgeId: string,
	HudRoot: Frame,
	TrackInstance: <T>(self: ClientManagedContext, inst: T) -> T,
	TrackConnection: (self: ClientManagedContext, conn: RBXScriptConnection) -> RBXScriptConnection,
	Spawn: (self: ClientManagedContext, fn: (...any) -> (), ...any) -> thread,
	SendActionToServer: (self: ClientManagedContext, actionType: string, payload: { [string]: any }) -> (),
	OnServerEvent: (self: ClientManagedContext, callback: (eventType: string, payload: { [string]: any }) -> ()) -> (),
}

export type CartridgeModule = {
	Meta: CartridgeMeta,
	AtmosphereProfile: AtmosphereProfile,
	InitServer: (ctx: ManagedContext) -> (),
	StartRound: (ctx: ManagedContext) -> (),
	StopRound: (ctx: ManagedContext) -> RoundResults?,
	Cleanup: (ctx: ManagedContext) -> (),
	InitClient: ((clientCtx: ClientManagedContext) -> ())?,
	CleanupClient: ((clientCtx: ClientManagedContext) -> ())?,
}

return {}
