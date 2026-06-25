# n8n Infra

本仓库是 TikTok Shop 饰品选品测款系统的本地项目仓库和文档整理环境，不是生产运行环境。

生产环境中的 n8n 与 PostgreSQL 运行在远程服务器。本地 `D:\n8n-infra` 仅用于保存 workflow JSON、SQL、脚本、项目文档和本地整理结果。本次盘点未连接服务器、未读取 `.env` 或 `.env.*`、未修改 workflow / SQL / script 业务文件。

## 项目目标

用 Kalodata Excel 数据、n8n、PostgreSQL 和自动化流程，建立 TikTok Shop 饰品类目的选品测款闭环：

```text
Kalodata Excel
-> 数据清洗与评分
-> WINNER / WATCHLIST / REJECTED
-> 内容测款任务
-> 内容测试复盘
-> 趋势追踪与放大/淘汰
```

## 当前版本

### V05.5

V05.5 是当前已验证的选品评分版本。

- 主要文件：`workflows/tiktok_selection_pipeline_V05_5_validation_passed.json`
- 状态：已通过 20 条样本验收
- 结果：5 个 WINNER、5 个 WATCHLIST、10 个 REJECTED
- 说明：用于从 Kalodata 数据中完成清洗、评分和选品判断

### V06 Lite

V06 Lite 是当前已验证的内容测款任务生成版本。

- 主要文件：`workflows/tiktok_content_monetization_V06_lite.json`
- 状态：已完成初步验收
- 结果：从 V05.5 的 10 个 WINNER / WATCHLIST 生成 10 条 `content_test_tasks`
- 说明：WINNER 生成 priority_test，WATCHLIST 生成 light_test

## 当前目录

```text
D:\n8n-infra
├─ docs
├─ workflows
├─ sql
├─ scripts
├─ backup              # 本次未盘点
├─ .git                # 本次未盘点
├─ .env                # 敏感文件，本次未读取
├─ .env.example        # 按本次要求未读取
├─ .gitignore
├─ control.bat
└─ docker-compose.yml  # 仅做结构化非敏感盘点
```

## 文档索引

- `docs/project_context.md`：项目背景和工作边界
- `docs/project_overview.md`：项目结构与目录用途总览
- `docs/current_status_2026_06.md`：2026 年 6 月当前状态
- `docs/next_tasks.md`：下一步任务建议
- `docs/workflows_inventory.md`：workflow 与相关文件清单
- `docs/v05.5_validation_report.md`：V05.5 验收记录
- `docs/v06_lite_validation_report.md`：V06 Lite 验收记录

## 下一步重点

当前优先级建议：

1. 完成项目结构确认和 workflow 清单确认。
2. 标准化 Kalodata Excel 导入字段和样本目录。
3. 建设 `trend_tracking V01`，从单次快照选品升级为连续趋势观察。
4. 检查 V05.5 评分逻辑与文档的一致性。
5. 设计内容测款复盘闭环。

## 安全边界

- 不连接服务器。
- 不修改生产数据库。
- 不重启 n8n。
- 不删除任何文件。
- 不修改 workflow 业务逻辑。
- 不读取、输出或修改 `.env` / `.env.*` 内容。
- 发现重复、废弃或疑似归档文件时，仅先记录建议，待确认后再处理。
