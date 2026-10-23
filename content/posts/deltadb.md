+++
title = "deltadb"
author = ["Liyu"]
date = 2026-10-23
draft = false
[taxonomies]
  tags = ["DeltaDB"]
+++

## DeltaDB 初探 {#deltadb-初探}

看到有人分享這個專案[^fn:1]，簡單的紀錄我的想法


### 簡介背景 {#簡介背景}

這個是 `ZED` 這個 IDE 新推出共用編輯的新實作，目前是個獨立 APP


### 情境 {#情境}

-   git repo 中的 remote url 負責確認協同者能看到，然後會依賴 cloudflare 中各種 services 啟動同步做分發
-   使用上想像成是 undo tree 或是 google docs 等線上同步服務，但是顆粒度&amp;可以看到的內容更豐富

    <div class="heron">

    agent 改到一半都可以任意回溯的版本；
    每次對話 agent 有改程式就會 commit，然後我們對應的 restore

    </div>

<div class="me">

累～

</div>


### Collaborative Editing（共同編輯） {#collaborative-editing-共同編輯}

悲觀式的就不提了，應該沒有在發展了

基本演算法分類

-   Operational Transformation
-   CRDT
-   Diff Sync

這個 deltadb 我覺得就是 event sourcing 操作紀錄+共用演算法

[^fn:1]: [官網介紹](https://delta.dev/deltadb)
