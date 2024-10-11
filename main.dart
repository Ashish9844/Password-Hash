import 'package:flutter/material.dart';
import 'dart:convert';  // For utf8.encode
import 'package:crypto/crypto.dart';  // For sha256 hashing

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Password Hashing Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Password Strength Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _passwordController = TextEditingController();
  String _hashedPassword = '';
  String _enteredPassword = '';
  String _passwordStrength = 'Weak';  // Initialize as weak

  // Function to hash the password using SHA-256
  String hashPassword(String password) {
    var bytes = utf8.encode(password);  // Convert password to bytes
    var hashed = sha256.convert(bytes);  // Perform hashing
    return hashed.toString();
  }

  // Function to check password strength and enforce strict rules
  String checkPasswordStrength(String password) {
    final lengthValid = password.length >= 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChars = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Enforce password requirements (length, uppercase, lowercase, digits, special chars)
    if (!lengthValid || !hasUppercase || !hasLowercase || !hasDigits || !hasSpecialChars) {
      return 'Invalid';  // Return 'Invalid' if any of the criteria are not met
    }

    // Determine strength based on score
    int strengthScore = 0;

    if (lengthValid) strengthScore++;
    if (hasUppercase) strengthScore++;
    if (hasLowercase) strengthScore++;
    if (hasDigits) strengthScore++;
    if (hasSpecialChars) strengthScore++;

    if (strengthScore >= 4) return 'Strong';  // Strong if all criteria are met
    if (strengthScore == 3) return 'Medium';  // Medium if some criteria are met
    return 'Weak';                            // Weak if minimal criteria are met
  }

  // Function to hash and show the password
  void _hashAndShowPassword() {
    setState(() {
      _enteredPassword = _passwordController.text;
      _passwordStrength = checkPasswordStrength(_passwordController.text);  // Update password strength
      
      // Only hash the password if it is valid
      if (_passwordStrength != 'Invalid') {
        _hashedPassword = hashPassword(_passwordController.text);
      } else {
        _hashedPassword = '';  // Clear the hash if the password is invalid
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter a Password',
              style: TextStyle(fontSize: 22),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true, // Hide the password input
              onChanged: (password) {
                setState(() {
                  _passwordStrength = checkPasswordStrength(password); // Update strength as user types
                });
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Secure Password must include (Uppercase, Lowercase, Special characters, and Numbers)',
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              _passwordStrength == 'Invalid' 
                ? 'Password is invalid. It must include special characters(!@#\$%^&*()_+).'
                : 'Password Strength: $_passwordStrength',  // Display password strength
              style: TextStyle(
                fontSize: 16,
                color: _passwordStrength == 'Strong'
                    ? Colors.green
                    : (_passwordStrength == 'Medium' ? Colors.orange : (_passwordStrength == 'Invalid' ? Colors.red : Colors.black)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hashAndShowPassword,
              child: const Text('LOGIN'),
            ),
            const SizedBox(height: 20),
            if (_hashedPassword.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Entered Password:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SelectableText(
                    _enteredPassword,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hashed Password:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SelectableText(
                    _hashedPassword,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
