# MedTrak — iOS Medicine Tracker (SwiftUI)

MedTrak is a lightweight SwiftUI app for tracking daily medications. It lets you add meds with dosage and schedule, view today's tasks at a glance, browse all meds, and (optionally) set local reminders.

---

## Highlights (TL;DR for recruiters)

- **What it is:** An iOS app that helps users remember and track their meds.
- **Why it matters:** Missed doses are common; MedTrak reduces cognitive load with a simple daily checklist and calendar.
- **What I built:** Full SwiftUI app + MVVM state, custom UI components, and groundwork for notifications & data persistence.
- **Tech:** Swift, SwiftUI, MVVM, Xcode. Designed for iOS 16+.

---

## Screens / Assets

The project includes app artwork in `Other/Assets.xcassets` (e.g., pill icons and a start screen image). For the GitHub README:

1. Run the app in the iOS Simulator (iPhone 15 or similar).
2. Capture screenshots of **Start**, **Home (Today)**, **Add Med**, and **All Meds** views.
3. Save to `docs/screenshots/` and reference them below.

_Example placeholder:_

```
![Start](docs/screenshots/start.png)
![Home](docs/screenshots/home.png)
![Add Med](docs/screenshots/add.png)
![All Meds](docs/screenshots/all.png)
```

---

## Features

- **Onboarding / Start**: Friendly intro screen with CTA (`StartView.swift`).
- **Home (Today)**: Daily greeting, today's meds checklist, quick add. (`HomeView.swift`)
- **Add Medication**: Name, dosage, start date, days of week, end date, quantity, and more. (`AddMeds View.swift`)
- **All Meds**: Full list organized with filters. (`AllMeds.swift`)
- **Custom Tab Bar**: Minimal custom tab bar with SF Symbols. (`Models/Tab Bar.swift`)
- **(Optional) Local Notifications**: Work-in-progress scaffolding for reminders. (`Views/Notifications.swift`)
- **Keyboard-aware layout**: Utility for input forms. (`Models/keyboardAdaptive.swift`)

> Data model: see `Models/MedicinesModel.swift` (`medicineModel` includes `title`, `Doasage`, `pillDate`, `totalPill`, `remainingPill`, `daysOfTheWeek`, `endDate`, `isMedTaken`).

---

## Architecture

- **Pattern:** MVVM with `ObservableObject` state (`MedsViewModel`) injected via `@EnvironmentObject` in `Medicine_TrackerApp.swift`.
- **Views:** SwiftUI view hierarchy in `Views/` (Home, Add, All, Start).
- **ViewModel:** `ViewModel/MedicinesViewModel.swift` holds the meds array, sorting/filter helpers, and (in this version) persistence hooks.
- **Models:** `Models/` includes the data model, tab bar, and utilities.
- **Assets:** `Other/Assets.xcassets` for images and app icons.

**Potential improvements (technical):**

- Move persistence to **Core Data** or **SwiftData** with background saves.
- Rework notifications: request authorization on first run, schedule `UNCalendarNotificationTrigger`s when meds are created.
- Add **WidgetKit** for upcoming doses.
- Add **iCloud sync** + multi-device support.
- Accessibility: Dynamic Type, VoiceOver, and high-contrast checks.

---

## Requirements

- **Xcode**: 15+ (Swift 5.9+ recommended)
- **iOS**: 16+ (targets SwiftUI APIs present in this project)

---

## Getting Started (Developers)

1. Open `MedTrak/Medicine Tracker.xcodeproj` in Xcode.
2. Select an iPhone simulator (e.g., iPhone 15) and **Run**.
3. To test notifications (optional):
   - In `Notifications.swift`, enable `NotificationManager` (currently commented scaffolding).
   - Request permission on first launch and schedule sample reminders.
4. To persist data between launches:
   - This version includes hooks in `MedsViewModel` for saving/loading.
   - For production, migrate to Core Data/SwiftData (see Roadmap).

---

## Tests

- UITests and unit test targets are scaffolded under:
  - `Medicine TrackerTests/`
  - `Medicine TrackerUITests/`
- Add cases for model validation (e.g., day-of-week schedules) and ViewModel helpers (sorting, filtering, remaining pills).

---

## Project Structure

```
MedTrak/
└── Medicine Tracker/
    ├── Medicine_TrackerApp.swift         # App entry; injects MedsViewModel
    ├── ViewModel/
    │   └── MedicinesViewModel.swift      # ObservableObject, meds array, helpers
    ├── Models/
    │   ├── MedicinesModel.swift          # medicineModel definition
    │   ├── Tab Bar.swift                 # Custom tab bar
    │   ├── AddMedsPictureButtons.swift   # (WIP) image helpers
    │   └── keyboardAdaptive.swift        # Keyboard-aware layout utils
    ├── Views/
    │   ├── StartView.swift               # Onboarding
    │   ├── HomeView.swift                # Today overview
    │   ├── AddMeds View.swift            # Add Medication form
    │   ├── AllMeds.swift                 # All medications
    │   ├── Calender View.swift           # (WIP) calendar UI
    │   └── ContentView.swift             # Main navigation
    └── Other/
        └── Assets.xcassets/              # App icons & imagery
```

---

## Roadmap

- [ ] Core Data / SwiftData persistence
- [ ] Robust local notifications per dose schedule
- [ ] Calendar view (weekly/monthly) with adherence stats
- [ ] Refill reminders when `remainingPill` is low
- [ ] CSV import/export & HealthKit (where appropriate)
- [ ] Accessibility + Localization (EN → ES, FR, etc.)

---

## 👤 Author

- **Krushna**
- LinkedIn: https://www.linkedin.com/in/krushna-bhanushali

---
