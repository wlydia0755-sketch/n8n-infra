# 下一步任务

更新时间：2026-06-25

## 执行原则

- 先确认，再修改。
- 后续任务只允许先做文档、设计、清单、SQL 草稿、rollback 草稿和测试样本。
- 只在本地仓库做文档整理和方案设计。
- 不连接生产服务器。
- 不读取 `.env` / `.env.*`。
- 不执行数据库迁移。
- 不运行脚本。
- 不删除文件。
- 不移动或删除文件。
- 不修改 V05.5 / V06 Lite 已验收核心 workflow。
- 不修改 V05.5 和 V06 Lite 已验证业务逻辑。
- 不接 TikTok API。
- 不做复杂看板。
- 不重构整个 n8n 系统。
- 任何疑似重复、废弃或归档操作，先形成建议清单并等待人工确认。

## 人工确认边界

如涉及以下事项，必须先输出建议清单、风险说明和待确认问题，并等待人工确认后再执行：

- workflow 归档、移动、重命名或版本切换。
- Excel 样本迁移、移动、重命名或清理。
- 数据库执行、migration 执行、rollback 执行或任何生产数据操作。
- 脚本运行、定时任务运行或自动化任务触发。
- 生产部署、服务器连接、n8n 重启或远程环境变更。

在未获得人工确认前，相关任务只能停留在文档、设计、清单、SQL 草稿、rollback 草稿和测试样本层面。

## P0：完成项目结构确认

目标：把本地仓库从“能用”整理到“可维护、可交接”。

建议任务：

1. 确认 `workflows` 中每个 JSON 是否仍在使用。
2. 确认两个 Kalodata Excel 文件是否是样本、暂存导入文件或历史测试数据。
3. 确认 `postgres_test_connection.json` 是否仍需要保留在主 workflows 目录。
4. 确认是否建立 `workflows/archive`、`workflows/v05_5`、`workflows/v06_lite` 等目录。
5. 确认是否建立 `data_sample` 或 `import_samples` 存放样本 Excel。

产出：

- 更新 `docs/workflows_inventory.md`
- 输出可归档建议
- 待人工确认后再讨论是否移动文件；默认不移动、不删除、不重命名

## P1：建设 trend_tracking V01

目标：从单次快照选品升级为连续趋势观察。

建议任务：

1. 设计趋势快照表，例如 `tiktok_video_metric_snapshots`。
2. 每次导入 Kalodata Excel 时保存当天快照。
3. 按 `video_id` / `product_id` 做连续追踪。
4. 计算 1 日、3 日、7 日增长率。
5. 生成趋势状态：`RISING`、`STABLE`、`DECLINING`、`UNKNOWN`。
6. 输出 migration SQL、rollback SQL 和基础测试样本。
7. 在不改变 V05.5 评分逻辑的前提下，为后续评分提供趋势辅助字段。

产出建议：

- `docs/trend_tracking_v01_design.md`
- `sql/migrations/...trend_tracking_v01.sql` 草稿
- `sql/rollback/...trend_tracking_v01_rollback.sql` 草稿
- 测试样本或脚本设计草稿

注意：该阶段只允许输出 SQL 草稿、rollback 草稿和测试样本，不执行 migration，不连接数据库，不运行脚本。

## P2：标准化 Kalodata Excel 导入

目标：减少人工导入不稳定性。

建议任务：

1. 梳理 Kalodata Excel 字段映射。
2. 定义必填字段、可选字段和默认值。
3. 处理空值、数字格式、国家/市场字段。
4. 处理重复 `video_id` / `product_id`。
5. 输出导入日志和失败行记录。
6. 将样本 Excel 与 workflow JSON 分目录存放，待确认后执行。

产出建议：

- `docs/kalodata_import_spec.md`
- `scripts/import/...` 草稿或伪代码
- 导入错误样例和校验清单

注意：该阶段只允许整理字段规范、导入设计、测试样本和脚本草稿，不运行导入脚本，不移动 Excel 文件。

## P3：检查评分逻辑

目标：确认 V05.5 评分公式和文档一致。

建议任务：

1. 读取 V05.5 workflow JSON 的评分节点配置。
2. 对照 `docs/project_context.md` 中的公式：

```text
final_score = base_score * 0.2
            + viral_score * 0.25
            + commercial_score * 0.25
            + profit_score * 0.3
```

3. 检查 WINNER 判断条件是否一致。
4. 输出 `docs/score_audit_report.md`。

注意：该任务只读 workflow，不修改业务逻辑。

## P4：真实内容测款复盘闭环

目标：把 V06 Lite 生成的内容任务接入实际运营复盘。

建议任务：

1. 明确 content_test_tasks 的执行状态流转。
2. 设计内容测试结果字段。
3. 明确短视频发布后的数据回填方式。
4. 形成 WINNER 放大、WATCHLIST 观察、REJECTED 淘汰的复盘标准。

注意：该阶段只允许设计复盘字段、状态流转和人工回填规范，不连接 TikTok，不接 API，不自动发布内容，不修改生产数据库，不运行自动化任务。

## 当前暂不建议做

- 不接 TikTok 官方 API。
- 不做复杂看板。
- 不重构整个 n8n 系统。
- 不改生产部署。
- 不做文件移动、删除或重命名，先完成确认清单并等待人工确认。
