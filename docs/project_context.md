# TikTok Shop 饰品选品测款系统｜项目上下文

## 1. 项目一句话说明

这是一个 TikTok Shop 饰品选品测款系统，当前主类目是饰品，主要市场为 MY/TH。项目目标是使用 Kalodata 数据、n8n、PostgreSQL 和自动化流程，筛选可测商品，并生成短视频测款任务，最终形成“选品 → 内容测款 → 复盘 → 放大/淘汰”的业务闭环。

---

## 2. 项目目标

项目不是为了单纯做自动化工具，而是服务 TikTok Shop 跨境电商业务。

核心目标：

1. 从 Kalodata 数据中筛选有潜力的商品和视频。
2. 用评分模型判断商品是否值得测试。
3. 把 WINNER / WATCHLIST 商品转化为短视频测款任务。
4. 通过内容测试验证商品是否真实有商业价值。
5. 逐步建设 trend_tracking 趋势跟踪能力，判断商品/视频是在上升、持平还是衰退。
6. 最终沉淀为 TikTok Shop 饰品选品测款方法论、周报、服务或工具。

---

## 3. 当前业务方向

当前主线：

* TikTok Shop
* 跨境电商
* 饰品类目
* 选品测款
* 短视频内容测试
* AI + n8n 自动化辅助运营

当前重点不是大规模接实时 API，也不是复杂看板，而是先把 Kalodata Excel 人工导入、评分、生成内容任务、真实测款这条链路跑稳定。

---

## 4. 当前技术环境

### 生产环境

n8n 和 PostgreSQL 生产环境运行在远程服务器，不在本地电脑生产运行。

服务器主要负责：

* 运行 n8n
* 运行 PostgreSQL
* 存储真实 workflow
* 存储历史执行数据
* 执行业务流程

### 本地环境

本地项目目录：

```text
D:\n8n-infra
```

本地目录只是项目仓库、开发整理环境和文档管理区，不是生产环境。

本地目录主要负责：

* 存放 workflow JSON
* 存放 SQL 文件
* 存放脚本
* 存放项目文档
* 存放备份文件
* 给 Codex 做本地整理和开发使用

---

## 5. 当前版本状态

### V05.5

V05.5 已稳定运行，主要负责 TikTok Shop 饰品选品评分。

当前已完成：

* Kalodata Excel 数据导入验证
* 选品评分逻辑验证
* WINNER / WATCHLIST / REJECTED 判断
* 20 条样本验收
* 55+ executions
* 0 failure

V05.5 的核心作用：

```text
Kalodata 数据
→ 清洗
→ 评分
→ 判断商品/视频是否值得测试
→ 输出 WINNER / WATCHLIST / REJECTED
```

---

### V06 Lite

V06 Lite 已完成，主要负责内容测款任务生成。

当前已完成：

* 从 V05.5 的 WINNER / WATCHLIST 中读取候选项
* 为 WINNER 生成更高优先级内容任务
* 为 WATCHLIST 生成轻量测试任务
* 写入 content_test_tasks 表

V06 Lite 的核心作用：

```text
WINNER / WATCHLIST
→ 生成短视频测款任务
→ 输出内容角度、测试类型、优先级和脚本方向
```

---

## 6. 当前核心数据源

当前数据源主要来自：

```text
Kalodata Excel 人工导出
```

暂未接入实时 API。

当前阶段不追求一步到位接入实时数据，优先保证：

1. Excel 导入稳定。
2. 字段映射规范。
3. 数据去重准确。
4. 评分逻辑稳定。
5. 内容任务能生成。
6. 后续可以基于多次导入建设趋势跟踪。

---

## 7. 当前核心表

### tiktok_selection_results

选品评分结果主表。

主要用途：

* 存储视频/商品相关数据
* 存储播放、点赞、评论、分享等互动数据
* 存储利润相关字段
* 存储评分结果
* 存储 WINNER / WATCHLIST / REJECTED 决策结果

关键字段包括：

* video_id
* title
* author
* views
* likes
* comments
* shares
* like_rate
* comment_rate
* share_rate
* score
* selected
* sell_price
* product_cost
* shipping_cost
* platform_fee
* gross_profit
* net_profit
* margin_rate
* viral_score
* commercial_score
* profit_score
* base_score
* final_score
* decision
* winner_reason
* created_at

---

### product_master

商品主表。

主要用途：

* 存储商品基础信息
* 记录商品来源平台
* 记录商品国家/市场
* 记录商品价格、销量、GMV 等基础指标

关键字段包括：

* source_platform
* source_product_id
* product_name
* country
* price
* sales
* gmv

---

### content_test_tasks

内容测款任务表。

主要用途：

* 存储从 WINNER / WATCHLIST 生成的短视频测款任务
* 记录测试优先级
* 记录内容角度
* 记录脚本方向
* 记录任务状态

关键字段包括：

* id
* video_id
* product_name
* country
* content_angle
* test_type
* priority_level
* short_video_script
* test_plan
* status

---

## 8. 当前评分逻辑

V05.5 当前评分逻辑：

```text
final_score = base_score * 0.2
            + viral_score * 0.25
            + commercial_score * 0.25
            + profit_score * 0.3
```

当前 WINNER 判断方向：

```text
final_score >= 75
profit_score >= 60
commercial_score >= 50
net_profit >= 8
base_score >= 60 或 viral_score >= 70
```

结果分为：

* WINNER：优先测款
* WATCHLIST：观察/轻量测试
* REJECTED：暂不测试

---

## 9. 下一步重点方向

当前下一步重点不是重构整个系统，而是建设 trend_tracking V01。

trend_tracking V01 的目标：

1. 每次导入 Kalodata Excel 时，保留当天快照。
2. 对同一个 video_id / product_id 进行连续追踪。
3. 计算 1 日、3 日、7 日增长率。
4. 判断趋势状态：

   * RISING
   * STABLE
   * DECLINING
   * UNKNOWN
5. 辅助判断商品/视频是否正在起势、已经见顶，或只是播放高但不卖货。

trend_tracking V01 的业务价值：

```text
从“单次快照选品”
升级为
“连续趋势观察”
```

---

## 10. 当前不做的事情

当前阶段暂不优先做：

1. 不优先接 TikTok 官方 API。
2. 不优先接复杂实时数据源。
3. 不优先做复杂数据看板。
4. 不优先重构整个 n8n 系统。
5. 不优先做多账号矩阵。
6. 不优先做复杂云端部署改造。

当前阶段重点是：

```text
Kalodata Excel
→ 稳定导入
→ 稳定评分
→ 稳定生成测款任务
→ 连续追踪趋势
→ 真实内容测款
```

---

## 11. Codex 使用边界

Codex 可以做：

1. 整理本地项目结构。
2. 生成 README。
3. 生成 docs 文档。
4. 整理 workflows 清单。
5. 检查 workflow JSON 文件。
6. 检查 SQL 文件。
7. 编写 migration SQL。
8. 编写 rollback SQL。
9. 编写 Kalodata Excel 导入脚本。
10. 编写 trend_tracking V01 相关脚本。
11. 生成测试样本。
12. 检查评分逻辑是否和文档一致。
13. 输出项目进度和下一步任务。

Codex 暂时不要做：

1. 不要连接服务器。
2. 不要修改生产数据库。
3. 不要重启 n8n。
4. 不要删除任何文件。
5. 不要直接修改生产 workflow。
6. 不要执行 DROP / DELETE / TRUNCATE 等危险 SQL。
7. 不要擅自重构整个项目。
8. 不要改变 V05.5 和 V06 Lite 已有业务逻辑。

---

## 12. 当前本地项目目录建议结构

建议 D:\n8n-infra 保持如下结构：

```text
D:\n8n-infra
├─ workflows
│  ├─ v05_5
│  ├─ v06_lite
│  └─ archive
│
├─ sql
│  ├─ migrations
│  ├─ rollback
│  └─ schema
│
├─ scripts
│  ├─ import
│  ├─ trend_tracking
│  └─ utils
│
├─ docs
│  ├─ project_context.md
│  ├─ project_overview.md
│  ├─ current_status_2026_06.md
│  ├─ next_tasks.md
│  └─ workflows_inventory.md
│
├─ backup
│
└─ README.md
```

注意：如果当前目录结构和建议结构不一致，Codex 只应先输出整理建议，不要直接移动、删除或重命名文件。

---

## 13. 当前最高优先级任务

### P0：整理本地项目结构

目标：

* 看清 D:\n8n-infra 当前有哪些文件
* 标注每个文件用途
* 找出重复、废弃、可归档文件
* 输出项目总览和当前状态

### P1：建设 trend_tracking V01

目标：

* 新增趋势快照表
* 支持多次 Kalodata Excel 导入
* 计算 1 日、3 日、7 日增长
* 判断趋势状态
* 为选品和内容测款提供趋势依据

### P2：标准化 Kalodata Excel 导入

目标：

* 统一字段映射
* 处理空值
* 处理重复 video_id / product_id
* 输出导入日志
* 输出失败行记录

### P3：检查评分逻辑

目标：

* 检查 V05.5 评分公式是否与文档一致
* 检查 WINNER / WATCHLIST / REJECTED 判断是否一致
* 输出 score_audit_report.md

---

## 14. 给 Codex 的默认工作原则

每次执行任务前，Codex 需要遵守：

1. 先阅读本文件。
2. 先理解当前项目背景。
3. 不要默认连接服务器。
4. 不要默认修改生产环境。
5. 修改文件前先说明计划。
6. 不确定的地方先输出问题或假设。
7. 优先做最小可行修改。
8. 不做大规模重构。
9. 不删除文件。
10. 所有修改都要说明原因、影响和测试方式。

---

## 15. 当前项目一句话战略

用已有电商经验 + Kalodata 数据 + n8n 自动化 + 内容测款，把 TikTok Shop 饰品选品从“凭感觉”升级为“数据筛选 + 内容验证 + 趋势追踪”的闭环系统。
