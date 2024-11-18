Password Encryption using Flutter

## Project Overview

This project demonstrates how to securely handle password creation and validation using Flutter, including password hashing with the **SHA-256** algorithm. It enforces strong password rules to ensure security, such as requiring uppercase, lowercase, special characters, and numbers. The application provides real-time feedback on the strength of the password (weak, medium, or strong) based on these rules.

The focus of this project is on:
- Password input and validation.
- Password hashing (using the **crypto** package in Flutter).
- Displaying password strength (weak, medium, strong) to guide the user.
- Real-time user feedback when the password doesn't meet security requirements.

---

## Key Concepts

### Password Hashing

- **Hashing** is a process where a password is transformed into a fixed-length string of characters, which is nearly impossible to reverse. This ensures that the actual password is never stored or transmitted.
- In this project, we use the **SHA-256 hashing algorithm** from the `crypto` package to hash the password before storing it.
- Hashing is essential for securing user data and protecting it in case the database is compromised.

### Password Strength Validation

- The project implements password strength validation to ensure that passwords meet certain complexity criteria, such as including uppercase and lowercase letters, special characters, and numbers.
- This ensures that users create strong passwords that are difficult to guess or crack.
- The user is given real-time feedback on the strength of their password (Weak, Medium, or Strong) as they enter it.

---

## System Requirements

To run this project, ensure you have the following installed on your system:
- **Linux (Kali Linux or any other Linux distribution)**
- **Flutter SDK** (3.0 or above)
- **Dart** (installed alongside Flutter)
- A basic understanding of the terminal is helpful, but detailed instructions are provided below for beginners.

---

## Installation and Setup

Follow these steps to get started with the project on a **Linux system**.

### Step 1: Install Flutter

1. **Open Terminal**.
2. Download Flutter using Git:
   ```bash
   sudo apt update
   sudo apt install git curl
   git clone https://github.com/flutter/flutter.git -b stable --depth 1
   ```
3. Add Flutter to your system's PATH by editing your `.bashrc` or `.zshrc` file:
   - Open `.bashrc` (or `.zshrc` if you use zsh):
     ```bash
     nano ~/.bashrc
     ```
   - Add this line at the end of the file:
     ```bash
     export PATH="$PATH:$HOME/flutter/bin"
     ```
   - Save the file and reload it:
     ```bash
     source ~/.bashrc
     ```

4. Check Flutter installation:
   ```bash
   flutter --version
   ```

5. Install required dependencies:
   ```bash
   sudo apt install libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev
   ```

6. Run `flutter doctor` to check for any missing dependencies:
   ```bash
   flutter doctor
   ```

### Step 2: Create and Setup a Flutter Project

1. In your terminal, navigate to a directory where you want to create the project:
   ```bash
   cd ~/projects
   ```
2. Create a new Flutter project:
   ```bash
   flutter create password_encryption_flutter
   ```
3. Navigate to the newly created project directory:
   ```bash
   cd password_encryption_flutter
   ```

4. Open the project in your preferred code editor (e.g., **VSCode** or **Atom**), or you can edit the files using a terminal-based editor like `nano`.

5. **Install the `crypto` package** for password hashing:
   - Open the `pubspec.yaml` file (this file manages project dependencies).
   - Under `dependencies`, add:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       crypto: ^3.0.5
     ```
   - Save the file, then run:
     ```bash
     flutter pub get
     ```
     This installs the required `crypto` package.

### Step 3: Run the Flutter Project

1. Connect an Android emulator or use Linux desktop to run the Flutter app.
2. Use this command to run the project:
   ```bash
   flutter run
   ```

   This will start the Flutter application in **debug mode**.

### Step 4: Test the Password Encryption

1. When the app runs, you will be presented with a password input field.
2. Enter a password that includes:
   - At least one **uppercase** letter (e.g., `A`).
   - At least one **lowercase** letter (e.g., `a`).
   - At least one **number** (e.g., `1`).
   - At least one **special character** (e.g., `@`, `#`, `$`).
3. As you type, the app will display whether the password is **weak**, **medium**, or **strong**. The password will only be hashed when it meets all the required criteria.

4. The app will show the **hashed password** using the SHA-256 algorithm, ensuring that the password is securely handled.

---

## Conclusion

This project demonstrates how to securely handle user passwords in a Flutter application. By combining password hashing and strength validation, we ensure that users can create strong, secure passwords that are properly encrypted before being stored. This provides protection against common attack vectors and ensures the security of sensitive user data.
