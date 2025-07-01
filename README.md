# country_visit_planner

A Flutter app that helps users plan and track visits to countries with filtering, sorting, and visit details — supporting local data storage and a wishlist.


## 📦 Download APK
    https://i.diawi.com/6kDasX
You can directly download the latest android APK 


    

## 🚀 How to Run

Follow these steps to run the app locally:

### 1️⃣ Clone the repository
    git clone https://github.com/Musadkhan/country_visit_planner.git

### 2️⃣ Install dependencies
    flutter pub get

### 3️⃣ Generate Hive type adapters
    flutter packages pub run build_runner build --delete-conflicting-outputs

### 4️⃣ Run the app
    flutter run

  ***  Make sure you have an emulator or physical device connected ***

### Run tests
    flutter test
  



🧱 Architecture Explanation

The Country Visit Planner app follows a Clean Architecture approach, ensuring a clear separation between the UI, logic, data models, and storage. The Presentation Layer consists of UI screens and widgets organized under the /presentation folder. It leverages the Provider package for state management, enabling reactive UI updates and separation of concerns.

The Controller Layer handles the core business logic, including data fetching, filtering, sorting, and user interactions. This layer includes CountryController, VisitedController, and FilterController, each responsible for managing a specific part of the application's logic.

In the Model Layer, data models like CountryResponseModel and VisitedCountryModel are used to structure API data and visit-related information. These models are shared across the app for API parsing, local storage, and UI representation.

For offline Storage uses Hive, a lightweight key-value database, to persist user-specific data such as visited countries and wishlist items. This allows the app to function offline and ensures fast, local read/write operations.




⚖️ Trade-offs & Known Limitations

The Country Visit Planner app aims to offer a clean and maintainable structure, but some trade-offs were made due to external constraints. One notable limitation is the lack of pagination. The app fetches the complete list of countries in a single call from the REST Countries API, as the API itself does not support pagination or partial data requests.

Additionally, search and filter operations are performed on the full dataset in-memory. While efficient for the current scale, it may need optimization for handling larger data. The app currently uses Hive for local storage, which is suitable for lightweight use but may not scale well for more complex relational data needs.
