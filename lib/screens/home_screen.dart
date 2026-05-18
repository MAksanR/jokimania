import 'package:flutter/material.dart';
import 'profile_security_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xff1E88E5),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Pesanan",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Halo, Pelanggan",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Selamat datang kembali!",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const Icon(Icons.notifications_none, size: 30),
                ],
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff1565C0), Color(0xff42A5F5)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "AIR BERSIH",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      "UNTUK HIDUP SEHAT",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Teruji kualitasnya, aman untuk keluarga tercinta.",
                      style: TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset('assets/galon.png', width: 120),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  menuItem(context, Icons.water_drop, "Pesan"),

                  menuItem(context, Icons.history, "Riwayat"),

                  menuItem(context, Icons.card_giftcard, "Poin"),

                  menuItem(context, Icons.security, "Keamanan"),
                ],
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.verified_user,
                      size: 60,
                      color: Color(0xff1E88E5),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Kualitas Terjamin",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Air kami melalui proses filtrasi standar tinggi untuk hasil yang bersih, jernih dan sehat.",
                          ),
                        ],
                      ),
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

  Widget menuItem(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        if (title == "Keamanan") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileSecurityScreen()),
          );
        }
      },

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),

            child: Icon(icon, color: const Color(0xff1E88E5)),
          ),

          const SizedBox(height: 8),

          Text(title),
        ],
      ),
    );
  }
}
