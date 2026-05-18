import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class ProfileSecurityScreen extends StatefulWidget {
  const ProfileSecurityScreen({super.key});

  @override
  State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
}

class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final hpController = TextEditingController();

  String md5Hash = "";
  String shaHash = "";

  String oldMd5 = "";
  String oldSha = "";

  String status = "";

  void generateHash() {
    String data =
        namaController.text + emailController.text + hpController.text;

    var bytes = utf8.encode(data);

    String newMd5 = md5.convert(bytes).toString();
    String newSha = sha256.convert(bytes).toString();

    if (oldMd5.isEmpty) {
      oldMd5 = newMd5;
      oldSha = newSha;

      status = "Hash awal berhasil disimpan";
    } else {
      if (oldMd5 == newMd5 && oldSha == newSha) {
        status = "Data tidak berubah";
      } else {
        status = "Data telah berubah";
      }
    }

    setState(() {
      md5Hash = newMd5;
      shaHash = newSha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),

      appBar: AppBar(
        title: const Text("MD5 & SHA-256"),
        backgroundColor: const Color(0xff1E88E5),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),

              child: Column(
                children: [
                  buildField("Nama", Icons.person, namaController),

                  const SizedBox(height: 20),

                  buildField("Email", Icons.email, emailController),

                  const SizedBox(height: 20),

                  buildField("Nomor HP", Icons.phone, hpController),

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

                      onPressed: generateHash,

                      child: const Text(
                        "Generate Hash",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "MD5 Hash",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(md5Hash),

                  const SizedBox(height: 25),

                  const Text(
                    "SHA-256 Hash",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(shaHash),

                  const SizedBox(height: 25),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: status == "Data telah berubah"
                          ? Colors.red.shade100
                          : Colors.green.shade100,

                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Text(
                      status,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
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
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,

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
