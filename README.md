# Instrapound

**Instrapound** is a Flutter-based mobile application designed with modern technologies and libraries to enhance the user experience. It includes features like OTP validation, MongoDB integration, and customizable UI components. This project demonstrates the capabilities of Flutter alongside backend support to deliver a powerful and user-friendly application.

## Warning

If you are having trouble with Email-OTP, you might need to use a VPN.

## Features

### 1. **OTP Integration**
Instrapound incorporates a secure OTP (One-Time Password) validation system using the `email_otp` package. This feature ensures:
- Verification of user actions like sign-ups and logins.
- Enhanced security for sensitive actions such as password resets or transaction approvals.

### 2. **MongoDB Backend Integration**
The app integrates with **MongoDB** using the `mongo_dart` library, enabling:
- Efficient storage and retrieval of user data.
- Support for handling unstructured and rapidly changing data.
- Scalability for larger datasets and real-time operations.

### 3. **Custom UI Components**
The user interface is designed to be intuitive and visually appealing with the help of:
- **Iconsax**: Provides a variety of stylish icons for UI elements.
- **Pinput**: Offers customizable PIN input fields for secure data entry.

### 4. **Internationalization (i18n)**
The app supports multiple languages using the **`intl`** package, offering:
- Adaptation of text formatting based on regional settings.
- A more inclusive user experience for global audiences.

### 5. **Secure Data Handling**
With the **`encrypt`** library, Instrapound secures sensitive user data:
- Encrypts information before storage or transmission.
- Protects user credentials and sensitive details like payment information.

### 6. **CAPTCHA Validation**
To enhance security further, the app uses **`local_captcha`** for CAPTCHA generation. This prevents automated bots from interacting with the app during sensitive processes like account creation or password recovery.

## Dependencies

The project relies on the following key dependencies:

- **Flutter SDK**: For building the mobile application.
- **get**: Simplified state management.
- **iconsax**: Stylish and functional icons.
- **local_captcha**: CAPTCHA generation for user validation.
- **pinput**: Custom PIN input widget.
- **email_otp**: Provides OTP functionality.
- **mongo_dart**: MongoDB driver for database integration.
- **encrypt**: Library for encrypting sensitive data.
- **shared_preferences**: Saves user preferences and app settings locally.
- **intl**: Handles internationalization and localization.

For a complete list of dependencies, refer to the [`pubspec.yaml`](https://github.com/MHN-1999/Instrapound/blob/main/pubspec.yaml) file.

## Installation

To run this project locally:

1. Clone the repository:
   ```bash
   git clone https://github.com/MHN-1999/Instrapound.git
   ```

2. Navigate to the project directory:
   ```bash
   cd Instrapound
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! If you'd like to contribute, follow these steps:
1. Fork the repository.
2. Create a new branch for your feature or bugfix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m 'Add new feature'
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Create a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/MHN-1999/Instrapound/blob/main/LICENSE) file for more details.

## Acknowledgements

- Thanks to the Flutter community for extensive resources and support.
- Special thanks to the contributors of the libraries used, making development faster and more efficient.

## Contacts

Email - decency.9991@gmail.com