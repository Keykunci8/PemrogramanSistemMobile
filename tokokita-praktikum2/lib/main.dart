import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokokita/controllers/cart_controller.dart';
import 'package:tokokita/screens/cart_page.dart';
import 'package:tokokita/screens/login_screen.dart';
import 'package:tokokita/screens/main_page.dart';

void main() {
  // Inisialisasi CartController secara global di sini
  // permanent: true agar controller tidak ikut terhapus saat halaman diganti (Get.off)
  Get.put(CartController(), permanent: true);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan GetMaterialApp murni dengan getPages
    return GetMaterialApp(
      title: 'TokoKita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MainPage()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/cart', page: () => const CartPage()),
      ],
    );
  }
}