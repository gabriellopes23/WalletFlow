<div align="center">

<img src="https://img.shields.io/badge/Platform-iOS-black?style=for-the-badge&logo=apple&logoColor=white"/>
<img src="https://img.shields.io/badge/SwiftUI-blue?style=for-the-badge&logo=swift&logoColor=white"/>
<img src="https://img.shields.io/badge/Architecture-MVVM-purple?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Persistence-UserDefaults-orange?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge"/>

# 💸 WalletFlow

### A modern personal finance management app built entirely with SwiftUI
**Track expenses, income, spending categories, and monthly financial summaries — all in one place.**

</div>

---

## 📖 About the Project

WalletFlow was developed as a personal project to deepen my iOS engineering skills and demonstrate practical, real-world knowledge of **SwiftUI** and **MVVM architecture**. Every screen, component, and data flow was crafted from scratch — no third-party UI libraries, no Storyboards.

The goal was simple: build a complete, portfolio-quality app that solves a real problem. WalletFlow lets users take full control of their personal finances by tracking transactions, visualizing spending patterns, and receiving smart notifications — all with a polished, dark-mode-ready interface.

This project covers the full iOS development lifecycle: from state management and local persistence to biometric authentication and custom chart rendering.

---

## ✨ Features

### 🔐 Authentication & Security
- User Registration & Login System
- Face ID / Biometric Authentication
- Privacy & Security Settings
- Hide Balance Feature

### 💳 Transaction Management
- Add, Edit & Delete Transactions
- Income & Expense Tracking
- Recent Transactions Feed
- Full Transaction History Screen
- Delete All Data option

### 📊 Analytics & Insights
- Apple Charts Framework
- Spending by Category (Pie Chart)
- Monthly Expense Analysis
- Visual monthly progress bar

### 🔔 Notifications
- Expense Alerts
- Monthly Summary Notifications
- Customizable Notification Settings

### 👤 User Profile
- Profile Overview with transaction stats
- Help & Support Screen
- Privacy Policy Screen
- Notifications management

---

## 📱 Screenshots

### Home & Dashboard

<table>
<tr>
<td align="center">
<img width="250" src="https://github.com/user-attachments/assets/406bc6e1-c553-4e49-934b-7de8fea25a90" />
<br>
<b>Home Light</b>
</td>

<td align="center">
<img width="250" src="https://github.com/user-attachments/assets/ec661f16-2e91-4205-8a1a-eeb179bfd617" />
<br>
<b>Home Dark</b>
</td>

<td align="center">
<img width="250" src="https://github.com/user-attachments/assets/54299ed1-d5b9-4912-8bd6-0a09119a9d93" />
<br>
<b>Swipe Actions</b>
</td>
</tr>
</table>

---

### 📊 Statistics

<table>
<tr>
<td align="center">
<img width="250" src="https://github.com/user-attachments/assets/698d02a2-99cd-4e22-b4fc-1e7430e58ec3" />
<br>
<b>Stats Light</b>
</td>

<td align="center">
<img width="250" src="https://github.com/user-attachments/assets/daaf97e7-eb53-427e-9b89-ded8ab789b8c" />
<br>
<b>Stats Dark</b>
</td>
</tr>
</table>

---

### 👤 Profile

<table>
<tr>
<td align="center">
<img width="250" src="https://github.com/user-attachments/assets/0fd1f70b-fbe7-40e5-9ed5-c3833a1cc898" />
<br>
<b>Profile Light</b>
</td>

<td align="center">
<img width="250" src="https://github.com/user-attachments/assets/7fbceef2-63e5-4150-8ad7-72c1e32bf90f" />
<br>
<b>Profile Dark</b>
</td>
</tr>
</table>

> 🌗 WalletFlow fully supports both **Light** and **Dark** mode out of the box.

---

## 🛠 Tech Stack

| Technology | Usage |
|---|---|
| **SwiftUI** | Entire UI layer — no UIKit, no Storyboard |
| **MVVM Architecture** | Clean separation of concerns |
| **ObservableObject** | Reactive state management |
| **@StateObject / @EnvironmentObject** | Dependency injection across views |
| **UserDefaults + JSONEncoder/Decoder** | Local persistent storage |
| **Local Notifications (UserNotifications)** | Expense alerts & monthly summaries |
| **NavigationStack** | Modern iOS 16+ navigation |
| **Sheet Presentation** | Modal flows for adding/editing transactions |
| **LocalAuthentication** | Face ID / Biometric authentication |

---

## 🏗 Architecture

WalletFlow follows the **MVVM (Model-View-ViewModel)** pattern, ensuring a clean, testable, and scalable codebase.

```
WalletFlow/
├── Models/
│   ├── Transaction.swift          # Core data model
│   ├── TransactionType.swift      # Income / Expense enum
│   └── Category.swift             # Spending categories
│
├── ViewModels/
│   ├── TransactionViewModel.swift # CRUD + business logic
│   ├── StatsViewModel.swift       # Chart & analytics logic
│   └── AuthViewModel.swift        # Auth & Face ID logic
│
├── Views/
│   ├── Home/
│   │   ├── HomeView.swift
│   │   ├── BalanceCardView.swift
│   │   └── TransactionRowView.swift
│   ├── Stats/
│   │   ├── StatsView.swift
│   │   ├── PieChartView.swift
│   │   └── MonthlyBarView.swift
│   ├── Profile/
│   │   ├── ProfileView.swift
│   │   ├── NotificationsView.swift
│   │   └── PrivacyView.swift
│   └── Shared/
│       ├── CustomTextField.swift
│       └── LoadingView.swift
│
├── Persistence/
│   └── StorageManager.swift       # UserDefaults abstraction
│
└── WalletFlowApp.swift
```

---

## 🧠 Architecture Deep Dive

```
┌──────────────────────────────────────────┐
│                   VIEW                   │
│         (SwiftUI — Declarative UI)       │
│                                          │
│  Observes ViewModel via @StateObject /   │
│  @EnvironmentObject. Sends user actions. │
└──────────────┬───────────────────────────┘
               │ User Actions / Bindings
               ▼
┌──────────────────────────────────────────┐
│               VIEW MODEL                 │
│    (ObservableObject — Business Logic)   │
│                                          │
│  Processes actions, updates @Published   │
│  state, coordinates with Model layer.    │
└──────────────┬───────────────────────────┘
               │ Read / Write
               ▼
┌──────────────────────────────────────────┐
│                  MODEL                   │
│     (Structs + StorageManager)           │
│                                          │
│  Plain Swift structs. Encoded/decoded    │
│  via JSONEncoder → UserDefaults.         │
└──────────────────────────────────────────┘
```

---

## 🚧 Challenges & Learnings

Building WalletFlow from the ground up pushed me through many real-world iOS engineering challenges:

**State Management**
Managing reactive state across multiple views using `@StateObject`, `@EnvironmentObject`, and `@Published` — ensuring data flows cleanly without prop-drilling.

**MVVM in SwiftUI**
Designing a ViewModel layer that stays decoupled from SwiftUI's view lifecycle while remaining reactive and testable.

**CRUD Operations**
Implementing full Create, Read, Update, and Delete flows for transactions with proper list diffing and UI updates.

**Data Persistence**
Architecting a `StorageManager` abstraction over `UserDefaults` with `JSONEncoder`/`JSONDecoder` for type-safe, codable model storage.

**SwiftUI Navigation**
Working with `NavigationStack`, sheets, and programmatic navigation in iOS 16+ — understanding the push/pop lifecycle and state restoration.

**Dynamic Charts**
Building custom pie charts and monthly bar visualizations purely in SwiftUI using `Canvas`, `Path`, and `GeometryReader` — no third-party charting libraries.

**Face ID Integration**
Integrating `LocalAuthentication` framework with proper error handling and fallback flows for unsupported devices.

**Local Notifications**
Scheduling and managing `UNUserNotificationCenter` requests for real-time expense alerts and monthly summaries.

**Reusable Components**
Building a shared component library (custom text fields, cards, buttons, modifiers) that stays consistent across the entire app.

---

## 🔮 Future Improvements

- [ ] iCloud sync for cross-device data
- [ ] Budget limits & overspending alerts
- [ ] Recurring transaction support
- [ ] CSV / PDF export
- [ ] Multiple currency support
- [ ] Widget support (WidgetKit)
- [ ] Siri Shortcuts integration
- [ ] Unit & UI tests

---

## ⚙️ Installation

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/WalletFlow.git

# 2. Open in Xcode
cd WalletFlow
open WalletFlow.xcodeproj

# 3. Select a simulator or your device
# 4. Build & Run (⌘ + R)
```

**Requirements:**
- Xcode 15+
- iOS 16.0+
- Swift 5.9+

> No external dependencies or package managers required. Pure SwiftUI.

---

## 👨‍💻 Author

**Gabriel Lopes**

iOS Developer passionate about building clean, user-centered mobile experiences with Swift and SwiftUI.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat-square&logo=linkedin)](https://linkedin.com/in/yourprofile)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat-square&logo=github)](https://github.com/yourusername)
[![Email](https://img.shields.io/badge/Email-Contact-red?style=flat-square&logo=gmail)](mailto:youremail@gmail.com)

---

<div align="center">

### ⭐ If you found this project useful, leave a star — it helps a lot!

*Built with 💜 using SwiftUI · MVVM · UserDefaults · Local Notifications · Face ID*

**WalletFlow — Take control of your finances.**

</div>
