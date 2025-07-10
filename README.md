# Paywize Wallet App – Home Assignment

This Flutter-based wallet application simulates real-time balance updates, transaction handling, and responsive UI design across **mobile**, **tablet**, and **web** platforms.

---

## Features

- **Real-Time Wallet Balance** (simulated WebSocket (Used Stream for Mocking) updates every 3 seconds)
- **Payout Functionality** with balance check and confirmation dialog
- **Transaction History List** with pull-to-refresh support
- **Transaction Detail Screen** with animated transitions and raw JSON view
- **Fully Responsive Layout** for:
  - Mobile
  - Tablet
  - Web (adaptive using `LayoutBuilder` & `MediaQuery`)

---

## Project Structure

| Path                                | Description                             |
|-------------------------------------|-----------------------------------------|
| `lib/`                              | Root Flutter source directory           |
| ├── `blocs/`                        | Business Logic Components (BLoC)        |
| │   ├── `wallet_bloc.dart`         | Main BLoC for wallet state              |
| │   ├── `wallet_event.dart`        | Events for wallet actions               |
| │   └── `wallet_state.dart`        | State representation                    |
| ├── `helper/`                       | Shared helpers and theming              |
| │   └── `theme.dart`               | Custom theme data                       |
| ├── `models/`                       | Data model classes                      |
| │   └── `transaction_model.dart`   | Defines `TransactionModel`              |
| ├── `repositories/`                 | Data fetching or simulation layer       |
| │   └── `wallet_repository.dart`   | Simulated wallet repository             |
| ├── `screens/`                      | UI screens for the app                  |
| │   ├── `wallet_screen.dart`       | Main wallet screen                      |
| │   └── `transaction_details_screen.dart` | Detail screen for transactions     |
| ├── `widgets/`                      | Reusable UI components                  |
| │   ├── `balance_card.dart`        | Shows the wallet balance                |
| │   ├── `transaction_list.dart`    | List of all transactions                |
| │   └── `transaction_tile.dart`    | Individual transaction UI tile          |
| └── `main.dart`                     | App entry point                         |





## Output Previews

| Mobile | Tablet | Web |
|--------|--------|-----|
| <img src="https://github.com/user-attachments/assets/ed530020-f0ad-4b9a-858c-154b3da30470" width="200"/> | <img src="https://github.com/user-attachments/assets/856d9e08-1b0d-44e2-bc35-e1f6288d6a20" width="300"/> | <img src="https://github.com/user-attachments/assets/025a4081-ca6b-4a0f-b406-d4277b6bffaf" width="400"/> |

---

## Demo Video

▶️ [Click to watch demo](https://github.com/iamsathishz/paywize/blob/master/assets/demo.mp4)

## Tech Stack

- **Flutter 3.29.3 or above**
- **Dart**
- **BLoC (flutter_bloc)** for state management
- **Responsive UI** via `LayoutBuilder`, `MediaQuery`, `Flexible`, `ConstrainedBox`
- **Intl** for date formatting

---

## 🚀 How to Run

```bash
# Clone the repo
git clone git@github.com:iamsathishz/paywize.git
cd paywize

# Get packages
flutter pub get

# Run the app
flutter run -d chrome        # For web
flutter run -d android       # For Android
flutter run -d ios           # For iOS
