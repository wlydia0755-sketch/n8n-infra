# Workflows 清单

更新时间：2026-06-25

## 盘点说明

本清单仅基于本地 `D:\n8n-infra\workflows` 文件名、文件时间和现有文档进行整理。本次未修改 workflow 文件，未读取 `.env` 或 `.env.*`，未连接服务器。

## 已发现文件

| 文件 | 类型 | 修改时间 | 大小 | 可能版本/用途 | 当前建议 |
|---|---|---:|---:|---|---|
| `workflows/tiktok_selection_pipeline_V05_5_validation_passed.json` | n8n workflow JSON | 2026-05-24 16:44:00 | 121484 bytes | V05.5 当前验收通过版本，负责选品评分 | 保留为当前主版本 |
| `workflows/tiktok_selection_pipeline_v05_stable_profit_viral_engine.json` | n8n workflow JSON | 2026-05-23 23:19:52 | 91718 bytes | 疑似 V05 / V05.5 前置稳定版本，利润与传播评分引擎 | 待确认是否归档 |
| `workflows/tiktok_content_monetization_V06_lite.json` | n8n workflow JSON | 2026-05-24 17:45:49 | 23652 bytes | V06 Lite 内容测款任务生成 | 保留为当前主版本 |
| `workflows/tiktok_data_import_v01_kalodata_excel.json` | n8n workflow JSON | 2026-05-23 23:19:04 | 10294 bytes | Kalodata Excel 导入 V01 | 待确认是否仍为当前导入流程 |
| `workflows/candidate_generation_v01.json` | n8n workflow JSON | 2026-05-24 12:42:15 | 10001 bytes | 候选生成 V01，可能与 V05/V06 前后链路有关 | 待确认用途 |
| `workflows/postgres_test_connection.json` | n8n workflow JSON | 2026-05-23 23:17:13 | 1675 bytes | PostgreSQL 连接测试 workflow | 建议后续移入 test/archive，当前不移动 |
| `workflows/kalodata_all_video_MY_jewelry_30d_20260524.xlsx` | Excel 数据文件 | 2026-05-26 14:54:28 | 23571 bytes | Kalodata MY 饰品 30 天全视频导出，疑似样本数据 | 建议后续移入样本目录，当前不移动 |
| `workflows/kalodata_video_staging_20260524221533_MY.xlsx` | Excel 数据文件 | 2026-05-24 22:17:05 | 12877 bytes | Kalodata MY 暂存/测试导入文件 | 建议后续移入样本目录，当前不移动 |

## 版本判断

### V05.5

当前明确版本文件：

```text
workflows/tiktok_selection_pipeline_V05_5_validation_passed.json
```

依据：

- `docs/project_context.md` 明确说明 V05.5 已稳定运行。
- `docs/v05.5_validation_report.md` 记录 20 条样本验收，结果为 5 WINNER、5 WATCHLIST、10 REJECTED。
- 文件名包含 `V05_5_validation_passed`。

### V06 Lite

当前明确版本文件：

```text
workflows/tiktok_content_monetization_V06_lite.json
```

依据：

- `docs/project_context.md` 明确说明 V06 Lite 已完成。
- `docs/v06_lite_validation_report.md` 记录从 V05.5 的 10 条 WINNER / WATCHLIST 生成 10 条 content_test_tasks。
- 文件名包含 `V06_lite`。

### 其他可能版本

| 文件 | 可能版本 | 待确认点 |
|---|---|---|
| `tiktok_selection_pipeline_v05_stable_profit_viral_engine.json` | V05 或 V05.5 前置版 | 是否已被 V05.5 替代 |
| `tiktok_data_import_v01_kalodata_excel.json` | 导入 V01 | 是否仍是当前导入入口 |
| `candidate_generation_v01.json` | 候选生成 V01 | 是否并入 V05.5 或 V06 Lite |
| `postgres_test_connection.json` | 测试 workflow | 是否仍需保留在主 workflow 清单 |

## 疑似重复、废弃或需要归档文件

以下只是建议，不代表已处理：

1. `tiktok_selection_pipeline_v05_stable_profit_viral_engine.json`
   - 疑似旧版本或前置稳定版。
   - 建议确认是否归档到 `workflows/archive`。

2. `postgres_test_connection.json`
   - 连接测试用途明显，不属于正式业务链路。
   - 建议后续归档到 test 或 archive。

3. `kalodata_all_video_MY_jewelry_30d_20260524.xlsx`
   - Excel 数据文件混放在 workflows 目录。
   - 建议后续移入样本数据目录。

4. `kalodata_video_staging_20260524221533_MY.xlsx`
   - 暂存/测试导入文件混放在 workflows 目录。
   - 建议后续移入样本数据目录。

5. `candidate_generation_v01.json`
   - 用途需确认。
   - 若已被 V05.5/V06 Lite 覆盖，可考虑归档。

## 建议的后续目录结构

待确认后可考虑：

```text
workflows
├─ v05_5
├─ v06_lite
├─ import
├─ test
└─ archive
```

样本 Excel 建议不要长期放在 `workflows` 下，可另建：

```text
data_sample
└─ kalodata
```

本次未执行上述移动。

## 执行边界

本清单只作为本地 workflows 文件盘点和后续整理建议，不代表任何文件应立即移动、删除、重命名、归档或版本切换。

后续如需调整 workflows 目录结构、移动 Excel 样本、归档测试 workflow 或切换主版本，必须先输出建议清单、风险说明和待确认问题，并等待人工确认后再执行。

本次只补充文档说明，不移动、不删除、不重命名任何文件，不修改 workflow JSON。
