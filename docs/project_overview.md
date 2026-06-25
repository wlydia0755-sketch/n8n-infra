# 项目总览

更新时间：2026-06-25

## 一句话说明

本项目是 TikTok Shop 饰品选品测款系统。本地 `D:\n8n-infra` 是项目仓库、文档管理和整理环境；生产 n8n 与 PostgreSQL 位于远程服务器。

## 本次盘点范围

本次仅盘点项目业务文件和文档文件：

- `docs`
- `workflows`
- `sql`
- `scripts`
- `docker-compose.yml` 的非敏感结构信息
- `README.md`
- `.gitignore`
- `control.bat`

本次明确排除：

- `.env`
- `.env.*`
- `backup`
- `n8n_data`
- `postgres_data`
- `data`
- `logs`
- `.git`
- `node_modules`

## 当前主要目录和文件

```text
D:\n8n-infra
├─ docs
│  ├─ project_context.md
│  ├─ v05.5_validation_report.md
│  ├─ v06_lite_validation_report.md
│  ├─ project_overview.md
│  ├─ current_status_2026_06.md
│  ├─ next_tasks.md
│  └─ workflows_inventory.md
├─ workflows
│  ├─ candidate_generation_v01.json
│  ├─ kalodata_all_video_MY_jewelry_30d_20260524.xlsx
│  ├─ kalodata_video_staging_20260524221533_MY.xlsx
│  ├─ postgres_test_connection.json
│  ├─ tiktok_content_monetization_V06_lite.json
│  ├─ tiktok_data_import_v01_kalodata_excel.json
│  ├─ tiktok_selection_pipeline_V05_5_validation_passed.json
│  └─ tiktok_selection_pipeline_v05_stable_profit_viral_engine.json
├─ sql
├─ scripts
├─ .gitignore
├─ control.bat
└─ docker-compose.yml
```

## 目录用途

| 路径 | 当前用途 | 状态 |
|---|---|---|
| `docs` | 项目上下文、验收报告、总览、状态和任务文档 | 正在补齐 |
| `workflows` | n8n workflow JSON，以及当前混放的 Kalodata Excel 样本/暂存文件 | 需要进一步分类，暂不移动 |
| `sql` | 预期保存 migration、rollback、schema 等 SQL 文件 | 当前未发现文件 |
| `scripts` | 预期保存导入、趋势追踪、工具脚本 | 当前未发现文件 |
| `backup` | 备份目录 | 本次按要求未盘点 |
| `.git` | Git 元数据 | 本次按要求未盘点 |
| `docker-compose.yml` | 本地容器编排文件；仅用于结构参考 | 已做非敏感结构盘点 |
| `control.bat` | 本地控制脚本，疑似用于容器或服务控制 | 未执行 |
| `.gitignore` | Git 忽略规则 | 项目配置文件 |

## docker-compose 非敏感结构摘录

仅记录结构，不记录任何密码、token、key、真实账号、真实域名或连接串。

| 项 | 结构信息 |
|---|---|
| services | 发现 `postgres`、`n8n` 相关服务结构 |
| images | PostgreSQL 15 镜像、n8n latest 镜像 |
| ports | 存在端口映射字段，具体值未记录 |
| volumes | 存在卷挂载/卷定义字段，具体值未记录 |
| environment | 存在数据库与 n8n 认证相关字段，值均未读取/未保存 |

## 当前业务链路

```text
Kalodata Excel 人工导出
-> n8n 导入/清洗
-> V05.5 评分
-> WINNER / WATCHLIST / REJECTED
-> V06 Lite 生成内容测款任务
-> content_test_tasks
-> 后续真实内容测款与复盘
```

## 疑似重复、废弃或需归档项

以下仅为建议清单，未移动、未删除、未重命名：

| 文件 | 判断 | 建议 |
|---|---|---|
| `workflows/tiktok_selection_pipeline_v05_stable_profit_viral_engine.json` | 疑似 V05 或 V05.5 前置稳定版 | 待确认是否归档到旧版本 |
| `workflows/tiktok_selection_pipeline_V05_5_validation_passed.json` | V05.5 当前验收通过版本 | 保留为当前主版本 |
| `workflows/postgres_test_connection.json` | 疑似连接测试 workflow | 待确认是否保留在 workflows 或归档到 test |
| `workflows/candidate_generation_v01.json` | 疑似候选生成早期 workflow | 待确认是否仍在使用 |
| `workflows/kalodata_all_video_MY_jewelry_30d_20260524.xlsx` | Kalodata 样本/导出数据，混放在 workflows 中 | 建议后续另建 data_sample 或 import_samples，当前不移动 |
| `workflows/kalodata_video_staging_20260524221533_MY.xlsx` | Kalodata 暂存/样本数据，混放在 workflows 中 | 建议后续另建 data_sample 或 import_samples，当前不移动 |

## 风险和不确定项

- 本次未读取 workflow JSON 内容，因此 workflow 内部节点、凭据引用和业务逻辑未做一致性审计。
- 本次未读取 `.env`、`.env.*`，因此无法确认本地配置完整性。
- `sql` 与 `scripts` 当前未发现业务文件，可能是尚未建立，也可能在排除目录或其他位置，待确认。
- `docker-compose.yml` 仅做结构化摘录，未记录敏感值。
