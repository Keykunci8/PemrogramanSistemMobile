import 'package:flutter/material.dart';
import 'package:get/get.dart'; // 1. Import GetX
import 'package:tokokita/controllers/cart_controller.dart'; // 2. Import CartController
import 'package:tokokita/screens/cart_page.dart';
import 'package:tokokita/screens/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 3. Daftarkan CartController di sini menggunakan Get.put() agar aktif sejak MainPage dimuat
  final CartController cartController = Get.put(CartController());

  int _selectedIndex = 0;

  // Daftar halaman yang terhubung ke BottomNavigationBar
  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const ProfilePlaceholderPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack menjaga state HomePage (daftar produk & stok) saat pindah tab
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Halaman Placeholder Profil
class ProfilePlaceholderPage extends StatelessWidget {
  const ProfilePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya')),
      body: const Center(
        child: Text(
          'Halaman Profil',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}