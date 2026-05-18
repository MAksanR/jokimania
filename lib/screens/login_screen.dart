import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> loginUser() async {
    String email = emailController.text.trim().toLowerCase();

    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan password wajib diisi")),
      );

      return;
    }

    if (!email.contains("@")) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Format email tidak valid")));

      return;
    }

    try {
      var bytes = utf8.encode(password);

      String md5Hash = md5.convert(bytes).toString();

      String shaHash = sha256.convert(bytes).toString();

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Email tidak ditemukan")));

        return;
      }

      var userData = snapshot.docs.first.data() as Map<String, dynamic>;

      String savedMd5 = userData['md5'];

      String savedSha = userData['sha256'];

      if (md5Hash == savedMd5 && shaHash == savedSha) {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,

          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Password salah")));
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: const Color(0xffF5F9FF),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              const SizedBox(height: 30),

              Image.asset('assets/logo.png', width: 220),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(25),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),

                      blurRadius: 10,
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    TextField(
                      controller: emailController,

                      decoration: InputDecoration(
                        hintText: "Email",

                        prefixIcon: const Icon(Icons.email),

                        filled: true,

                        fillColor: Colors.blue.shade50,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: passwordController,

                      obscureText: true,

                      decoration: InputDecoration(
                        hintText: "Password",

                        prefixIcon: const Icon(Icons.lock),

                        filled: true,

                        fillColor: Colors.blue.shade50,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,

                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1E88E5),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        onPressed: loginUser,

                        child: const Text(
                          "Login",

                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Text("Belum punya akun? "),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },

                          child: const Text(
                            "Daftar",

                            style: TextStyle(
                              color: Color(0xff1E88E5),

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
