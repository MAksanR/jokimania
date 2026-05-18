import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final namaController = TextEditingController();

  final emailController = TextEditingController();

  final hpController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> registerUser() async {
    try {
      String password = passwordController.text;

      var bytes = utf8.encode(password);

      String md5Hash = md5.convert(bytes).toString();

      String shaHash = sha256.convert(bytes).toString();

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim().toLowerCase(),

            password: password,
          );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'nama': namaController.text.trim(),

            'email': emailController.text.trim().toLowerCase(),

            'nomor_hp': hpController.text.trim(),

            'md5': md5Hash,

            'sha256': shaHash,
          });

      if (!mounted) return;

      showDialog(
        context: context,

        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            title: const Text("Registrasi Berhasil"),

            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "MD5 Hash",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(md5Hash),

                  const SizedBox(height: 20),

                  const Text(
                    "SHA-256 Hash",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(shaHash),
                ],
              ),
            ),

            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1E88E5),
                ),

                onPressed: () {
                  Navigator.pop(context);

                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },

                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Terjadi error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),

      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            Image.asset('assets/logo.png', width: 180),

            const SizedBox(height: 30),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(25),
                ),

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildField("Nama", Icons.person, namaController),

                      const SizedBox(height: 20),

                      buildField("Email", Icons.email, emailController),

                      const SizedBox(height: 20),

                      buildField("Nomor HP", Icons.phone, hpController),

                      const SizedBox(height: 20),

                      buildField(
                        "Password",
                        Icons.lock,
                        passwordController,
                        isPassword: true,
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

                          onPressed: registerUser,

                          child: const Text(
                            "Daftar",

                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField(
    String hint,

    IconData icon,

    TextEditingController controller, {

    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,

      obscureText: isPassword,

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: Icon(icon),

        filled: true,

        fillColor: Colors.blue.shade50,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
