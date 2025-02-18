# Clean Architecture With UIKit Template

這是一個基於 Clean Architecture 原則設計的iOS應用程序模板。
它提供了一個堅實的基礎，可以用來構建可擴展、可維護和可測試的iOS應用程序。

## 功能特點

- 架構設計：
    - 將專案劃分為不同的層級，實現關注點分離，提升程式碼的可讀性與可維護性。
- UI整合：
    - 同時支援UIKit和SwiftUI，展示如何在Clean Architecture架構下進行UI開發。
- 測試：
    - 包含單元測試（Unit Tests）和整合測試（Integration Tests），確保應用程式的可靠性與正確性。

## Clean Architecture 架構

- Application（應用層）
    - 負責應用程式的生命週期管理與依賴注入。
- Infrastructure（基礎設施層）
    - 管理第三方服務整合、日誌記錄、網路請求與本地存儲。
    - 提供外部服務（例如API、資料庫管理器）的實作。
- Data（數據層）
    - 定義儲存庫（Repositories） 和數據來源（例如遠端 API、本地資料庫）。
    - 將原始數據轉換為Domain Model。
- Domain（領域層）
    - 包含核心業務邏輯與Use Case。
    - 定義Entity，並透過儲存庫處理數據。
- Presentation（展示層）
    - 管理UI元件（UIKit中的ViewControllers或SwiftUI的Views）。
    - 與ViewModel互動，以更新UI顯示處理後的數據。
- Mock（模擬層）
    - 提供儲存庫與服務的模擬實作，方便測試。
    - 用於單元測試，以模擬真實的應用場景。