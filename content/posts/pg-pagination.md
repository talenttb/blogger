+++
title = "pg-pagination"
author = ["Liyu"]
date = 2026-10-21
draft = false
[taxonomies]
  tags = ["postgres"]
+++

## 在 pg 上做的分頁方式 {#在-pg-上做的分頁方式}


### 位置式分類 {#位置式分類}


#### offset / limit {#offset-limit}


#### row_number function {#row-number-function}


#### Deferred join {#deferred-join}


### keyset 分類 {#keyset-分類}


#### where id (單欄或是多欄等混合條件搜尋) + offset / limit {#where-id--單欄或是多欄等混合條件搜尋--plus-offset-limit}

**\***


### 範圍分類 {#範圍分類}


#### 自己定義 id 範圍 {#自己定義-id-範圍}


#### 時間範圍 {#時間範圍}


#### 內建 ctid (PG 14+) {#內建-ctid--pg-14-plus}


### 狀態、快照 {#狀態-快照}


#### Server-side cursor {#server-side-cursor}

只適合在報表要看哪一頁且在 server 處理


#### `pg_export_snapshot()` {#pg-export-snapshot}

直接使用內建的 function，區塊可平行


#### UNLOGGED table 建立清單 {#unlogged-table-建立清單}

接著搭配前面的 keyset or range 查詢


#### MATERIALIZED {#materialized}


## 取捨 {#取捨}


### 簡易檢核表？ {#簡易檢核表}

-   [ ] 需要頁數
    要精準嗎？指定到某一頁？

    快到慢(粗略到精準)

    1.  pg_class.reltuples

    2.  EXPLAIN Plan Rows(可 WHERE；CREATE STATISTICS、SET STATISTICS 加強)

    3.  pg_stats histogram_bounds(百分比跳頁，不可 WHERE[^fn:1])

    4.  TABLESAMPLE SYSTEM(可 WHERE，看資料所以準，稀少條件誤差大；tsm_system_rows/time 控成本)
-   [ ] 排序能否建 index
    如果不能建 index，通常是情境或是資料的類型要調整
-   [ ] 對象是誰
    人、API、報表等

[^fn:1]: [cluade chat](https://claude.ai/artifact/TtLrVSAWPjAhLyYg2WK3qR#b791aa39-6d9e.mka7drd4bsd.11873)
