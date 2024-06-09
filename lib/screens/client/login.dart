import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: unused_import
import '../home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 5, 40, 70),
          title: Center(
            child: Text(
              'Login',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.normal,
              ),
            ),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://img.freepik.com/premium-vector/flat-color-modern-isometric-illustration-online-shopping_145666-23.jpg?w=740',
                    fit: BoxFit.cover,
                  ),
                ),
                // Email Alanı
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.blueGrey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 42, 44, 46)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 42, 44, 46)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Şifre Alanı
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 42, 44, 46)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Giriş Butonu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final String email = _emailController.text.trim();
                      final String password = _passwordController.text.trim();
            
                      if (email.isEmpty || password.isEmpty) {
                        setState(() {
                          _errorMessage =
                              'E-posta ve şifre alanları boş bırakılamaz.';
                        });
                        return;
                      }
            
                      try {
                        await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
            
                        GoRouter.of(context).go('/home');
                      } catch (e) {
                        String errorMessage =
                            "Bir hata oluştu. Lütfen tekrar deneyin.";
            
                        if (e is FirebaseAuthException) {
                          switch (e.code) {
                            case 'user-not-found':
                              errorMessage =
                                  'Bu e-posta adresi ile kayıtlı kullanıcı bulunamadı.';
                              break;
                            case 'wrong-password':
                              errorMessage = 'Yanlış şifre girdiniz.';
                              break;
                            case 'invalid-email':
                              errorMessage = 'Geçersiz e-posta adresi formatı.';
                              break;
                            case 'user-disabled':
                              errorMessage = 'Bu kullanıcı devre dışı bırakıldı.';
                              break;
                            default:
                              errorMessage = 'Bilgiler hatalı veya geçersiz.';
                              break;
                          }
                        }
            
                        setState(() {
                          _errorMessage = errorMessage;
                        });
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 5, 40, 70),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Kayıt Olma Linki
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go('/register');
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                  ],
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
