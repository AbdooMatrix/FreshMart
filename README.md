# FreshMart
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/AbdooMatrix/FreshMart)

FreshMart is a full-stack online grocery store application featuring a cross-platform mobile frontend built with Flutter and a robust backend powered by Python's FastAPI framework. The application is designed to support multiple user roles, including customers, vendors, administrators, and delivery personnel, providing a tailored experience for each.

## Features

FreshMart is a feature-rich e-commerce platform with distinct functionalities for different user roles:

**Customer Experience:**
- **Product Browsing:** Discover products through a filterable and searchable grid interface.
- **Product Details:** View detailed information, including price, stock, and vendor details.
- **Shopping Cart:** Add, update quantities, and remove products from the cart.
- **Checkout:** A streamlined process to place orders with a specified shipping address.
- **Order Confirmation:** Receive a detailed summary after a successful order placement.

**Vendor Portal:**
- **Product Management:** Full CRUD (Create, Read, Update, Delete) capabilities for managing product inventory.

**Admin Dashboard:**
- **At-a-Glance Metrics:** Monitor key performance indicators like total users, active vendors, daily orders, and revenue.
- **User Management:** View and manage all user accounts across different roles.
- **Order Monitoring:** Track all system-wide orders with status filters.
- **Sales Analytics:** Access reports on sales trends, top-selling products, and other vital statistics.

**Delivery Panel:**
- **Agent Dashboard:** View personal performance metrics and manage online/offline status.
- **Active Order Management:** Accept new assignments, view orders in transit, and access customer and address details.
- **Delivery Timeline:** Track the progress of an order from assignment to completion.
- **Mark as Delivered:** Update order status upon successful delivery.

## Core Technologies

- **Frontend:**
  - **Framework:** [Flutter](https://flutter.dev/)
  - **Language:** [Dart](https://dart.dev/)
  - **Key Packages:** `http` for API communication, `google_fonts` for typography, `cached_network_image` for efficient image loading.

- **Backend:**
  - **Framework:** [FastAPI](https://fastapi.tiangolo.com/)
  - **Language:** [Python](https://www.python.org/)
  - **ORM:** [SQLAlchemy](https://www.sqlalchemy.org/)
  - **Data Validation:** [Pydantic](https://pydantic-docs.helpmanual.io/)

- **Database:**
  - [SQLite](https://www.sqlite.org/index.html) (for simplicity and ease of setup)

## Project Architecture

The application follows a modern client-server architecture:

### Backend (FastAPI)

Located in the `/backend` directory, the API server handles all business logic and data persistence.

- **`main.py`:** The main application entry point. It sets up the FastAPI app, includes routers, and seeds the database with sample data on startup.
- **`database.py`:** Configures the SQLite database connection using SQLAlchemy.
- **`/models`:** Defines SQLAlchemy ORM models (`Product`, `User`, `Order`, etc.) that map to database tables.
- **`/schemas`:** Contains Pydantic models for data validation, serialization, and API request/response structures.
- **`/crud`:** Implements the core database operations (Create, Read, Update, Delete) for each model.
- **`/routes`:** Defines the API endpoints for products, cart, and orders, linking HTTP methods to the corresponding CRUD functions.

### Frontend (Flutter)

Located in the `/frontend` directory, the mobile app provides the user interface for all roles.

- **`main.dart`:** The application's entry point, which defines the initial route and all navigation routes.
- **`/config`:** Contains global configuration, including API endpoint URLs (`api_config.dart`) and a mock session manager (`session.dart`).
- **`/models`:** Defines Dart data classes that mirror the backend's Pydantic schemas.
- **`/services`:** A layer responsible for making HTTP requests to the backend API and handling data serialization/deserialization.
- **`/screens`:** Contains all the UI screens, organized into subdirectories based on user role (`customer`, `vendor`, `admin`, `delivery`).
- **`/widgets`:** A collection of reusable, custom UI components like `ProductCard`, `PrimaryButton`, and `AppTopBar`.
- **`/theme`:** Centralizes the application's visual style, including colors, typography, and widget themes.

## Getting Started

To get FreshMart running locally, you'll need to set up both the backend and frontend services.

### Prerequisites

- [Python](https://www.python.org/downloads/) 3.8+
- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.0+

### Backend Setup

1.  **Navigate to the backend directory:**
    ```sh
    cd backend
    ```

2.  **Create and activate a virtual environment:**
    - On Windows:
      ```sh
      python -m venv venv
      .\venv\Scripts\activate
      ```
    - On macOS/Linux:
      ```sh
      python3 -m venv venv
      source venv/bin/activate
      ```

3.  **Install dependencies:**
    ```sh
    pip install -r requirements.txt
    ```

4.  **Run the server:**
    ```sh
    uvicorn main:app --reload
    ```
    The API will be available at `http://127.0.0.1:8000`. The server automatically deletes and re-seeds the `freshmart.db` file on startup for a clean state.

### Frontend Setup

1.  **Navigate to the frontend directory:**
    ```sh
    cd frontend
    ```

2.  **Get Flutter dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Ensure API Configuration:**
    The file `frontend/lib/config/api_config.dart` is configured to connect to `http://10.0.2.2:8000`. This is the special IP address for the Android emulator to access the host machine's `localhost`. If you are running on an iOS simulator or a physical device, update the `baseUrl` to your machine's local network IP address.

4.  **Run the application:**
    ```sh
    flutter run
    ```

The application will launch. You can use the buttons on the login screen to switch between `Customer`, `Vendor`, `Admin`, and `Delivery` roles.
