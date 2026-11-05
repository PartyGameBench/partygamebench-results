# 赛题任务包模板（含玩法机制与视觉风格命题）

## 1. 赛题元信息
- **赛题 ID**：`T01_Example`
- **玩法类型**：`Survival` / `ScoreRush` / `Territory` / `Asymmetric`
- **标准局时**：`75 秒`
- **参战人数范围**：`4 ~ 16 人`（支持平台 `BotActor` 同等参战）

---

## 2. 核心玩法与全栈逻辑要求
1. **回合主循环**：
   - 描述开局、阶段升温（如第 25 秒、第 50 秒难度升级）、淘汰或计分规则。
2. **服务端权威判定 (`server.luau`)**：
   - 所有机关运动、碰撞检测、得分增减（`ctx:AddScore`）与淘汰判定（`ctx:Eliminate`）必须在服务端执行。
3. **客户端交互与专属 HUD (`client.luau`)**：
   - 在 `clientCtx.GuiRoot` 内绘制本局专属状态提示（如个人得分、危险倒计时预警、阶段升级横幅）。

---

## 3. 视觉与空间风格命题（Visual Style Brief）
> 模型必须在 `manifest.luau` 的 `AtmosphereProfile` 与 `server.luau` 的 `BuildArena(ctx)` 中纯代码实现以下视觉风格，玩家将在局后对场景审美独立投票：

- **主题美学定位**：（例如：*深海霓虹生物实验室 / 高饱和多巴胺糖果工坊 / 工业复古熔岩竖井*）
- **主副材质与配色规范**：
  - 主体结构材质与色板：
  - 高亮机关/危险区材质与色板（需具备视觉预警辨识度）：
- **光影与后处理参数要求 (`AtmosphereProfile`)**：
  - 环境光冷暖倾向、雾效浓度、`Bloom` 辉光与对比度要求。
- **动态视觉反馈 (`ctx.FX` & Tween)**：
  - 机关触发、得分或淘汰时的粒子、音效与几何体补间动效要求。

---

## 4. 交付文件约束
严格输出以下 3 个 Luau 模块代码块，仅调用 `RGBenchSDK` 注入的 `ctx` / `clientCtx` 接口，严禁直接修改全局 `Workspace` 或 `Lighting`：
1. `manifest.luau`
2. `server.luau`
3. `client.luau`
