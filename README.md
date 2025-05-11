# KobiPay Frontend (kobipay_fe)

A Flutter-based frontend application for KobiPay, designed to manage and display transaction histories with a clean and user-friendly interface.

---

## Setup Instructions

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/your-repo/kobipay_fe.git
   cd kobipay_fe
   ```

2. **Install Dependencies**:
   Ensure you have Flutter installed. Then, run:

   ```bash
   flutter pub get
   ```

3. **Run the Application**:
   Use the following command to run the app on your connected device or emulator:

   ```bash
   flutter run
   ```

4. **Build for Production**:
   To build the app for production:

   ```bash
   flutter build apk
   ```

---

## Libraries Used

Here are the key libraries used in this project:

- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: For state management using the BLoC pattern.
- **[equatable](https://pub.dev/packages/equatable)**: Simplifies state comparison in BLoC.
- **[http](https://pub.dev/packages/http)**: For making HTTP requests to fetch remote data.
- **[google_fonts](https://pub.dev/packages/google_fonts)**: For custom fonts.
- **[fl_chart](https://pub.dev/packages/fl_chart)**: For rendering charts (e.g., pie charts).
- **[flutter_svg](https://pub.dev/packages/flutter_svg)**: For rendering SVG assets.
- **[json_serializable](https://pub.dev/packages/json_serializable)**: For JSON serialization and deserialization.

---

## Design and State Management Decisions

### Design

- **UI/UX**: The app follows a clean and minimalistic design with a focus on readability and usability.
- **Color Palette**: A consistent color palette is used, defined in `consts.dart` for easy maintenance.
- **Animations**: Subtle animations, such as fade-in effects for transaction cards, enhance the user experience.

### State Management

- **BLoC Pattern**: The app uses the `flutter_bloc` package for state management. This ensures a clear separation of concerns between the UI and business logic.
  - **TransactionBloc**: Manages the state of transaction data, including loading, success, and error states.
  - **Events**: Includes events for fetching transactions from local JSON, remote APIs, and mock lists.
  - **States**: Includes `TransactionLoading`, `TransactionLoaded`, and `TransactionError` states to handle different scenarios.

---

## API Simulation

The app simulates API calls using the following methods in `KobiPayTransactionApi`:

- **Local JSON**: Transactions are fetched from a local JSON file (`assets/transactions.json`) using the `rootBundle`.
- **Mock List**: A predefined list of transactions is used for quick testing.
- **Remote API**: A placeholder for fetching transactions from a remote server using the `http` package.

### How It Works

- The `TransactionBloc` listens for events such as `FetchTransactionsFromLocalJson` or `FetchTransactionsFromRemote`.
- Based on the event, the corresponding method in `KobiPayTransactionApi` is called to fetch the data.
- The fetched data is then emitted as a `TransactionLoaded` state or a `TransactionError` state if an error occurs.

---

## Running App Demo

[Watch the Demo Video](https://drive.google.com/file/d/1dsEKdC5o8YO7Z6SBg55a3xaB5rEb9Eh1/view?usp=sharing)

> **Note**: Click the link above to view the app demo video hosted on Google Drive.

---

## Contribution

Feel free to fork this repository and submit pull requests for improvements or bug fixes.
