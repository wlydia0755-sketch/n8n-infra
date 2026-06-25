# 当前状态（2026-06）

更新时间：2026-06-25

## 总体状态

当前项目已完成从 Kalodata Excel 到选品评分，再到内容测款任务生成的基础链路验证。

```text
Kalodata Excel
-> V05.5 选品评分
-> WINNER / WATCHLIST / REJECTED
-> V06 Lite 内容测款任务生成
```

本地 `D:\n8n-infra` 当前主要承担项目仓库与整理环境职责，不是生产环境。

## V05.5 状态

V05.5 是当前稳定的选品评分版本。

| 项目 | 状态 |
|---|---|
| 主要 workflow | `workflows/tiktok_selection_pipeline_V05_5_validation_passed.json` |
| 验收日期 | 2026-05-24 |
| 样本数量 | 20 条 |
| 验收结果 | 通过 |
| WINNER | 5 |
| WATCHLIST | 5 |
| REJECTED | 10 |
| 生产状态 | 远程生产环境运行情况需以服务器为准，本次未连接确认 |

已知能力：

- Kalodata Excel 数据导入验证。
- 选品评分逻辑验证。
- WINNER / WATCHLIST / REJECTED 判断。
- 为 V06 Lite 提供候选输入。

## V06 Lite 状态

V06 Lite 是当前内容测款任务生成版本。

| 项目 | 状态 |
|---|---|
| 主要 workflow | `workflows/tiktok_content_monetization_V06_lite.json` |
| 验收/确认日期 | 待以 `docs/v06_lite_validation_report.md` 为准 |
| 输入 | V05.5 输出的 10 条 WINNER / WATCHLIST |
| 输出 | 10 条 `content_test_tasks` |
| WINNER 处理 | priority_test，每个商品建议 3 条短视频 |
| WATCHLIST 处理 | light_test，每个商品建议 1 条短视频 |
| 验收结果 | 初步通过 |

已知能力：

- 从 V05.5 读取 WINNER / WATCHLIST 候选项。
- 生成内容角度、脚本方向、测试类型、优先级和测试计划。
- 将选品结果转化为内容测款任务。

## 数据和表状态

根据 `docs/project_context.md`，当前核心表包括：

| 表 | 用途 |
|---|---|
| `tiktok_selection_results` | 保存选品评分、互动指标、利润字段和决策结果 |
| `product_master` | 保存商品基础信息 |
| `content_test_tasks` | 保存短视频内容测款任务 |

本次未连接数据库，未验证真实表结构和生产数据状态。

## 当前项目进度

| 阶段 | 状态 | 说明 |
|---|---|---|
| Kalodata Excel 人工导入 | 已验证基础链路 | 仍需标准化字段映射和导入日志 |
| V05.5 选品评分 | 已验收 | 当前主稳定版本 |
| V06 Lite 内容任务生成 | 已验收 | 可进入真实小规模内容测试 |
| trend_tracking V01 | 未开始/待建设 | 下一阶段最高优先级 |
| 项目文档整理 | 本次已补齐基础文档 | 后续需随版本持续更新 |
| 文件结构规范化 | 仅完成盘点 | 尚未移动、删除或重命名任何文件 |

## 当前风险和不确定项

- V05.5 和 V06 Lite 的生产运行状态未在本次确认，因为本次未连接服务器。
- 本地 workflow 文件与远程生产 n8n 中真实 workflow 是否完全一致，待确认。
- `workflows` 中存在 Excel 数据文件，是否应长期保留在该目录待确认。
- `sql`、`scripts` 目录当前未发现文件，后续 trend_tracking V01 可能需要补齐。
- 验收报告读取时出现编码显示异常，但关键信息已由 `project_context.md` 和报告结构交叉确认。

## 本次未做事项

- 未连接服务器。
- 未读取 `.env` 或 `.env.*`。
- 未执行 SQL。
- 未启动、停止或重启 n8n。
- 未修改 workflow、sql、scripts 中的业务文件。
- 未移动、删除或重命名任何文件。
