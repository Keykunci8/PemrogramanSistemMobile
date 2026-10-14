import 'package:flutter/material.dart';
import 'models/product.dart';
import 'widgets/product_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TokoKita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TokoKita'),
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
  final List<Product> products = [
    Product(
      id: 'BRG-01',
      nama: 'Pulpen Kokoro',
      harga: 15000.0,
      imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-81ztq-me3mjcie1og31b',
      kategori: 'Alat Tulis Kantor (ATK)',
      stok: 25,
      deskripsi: 'Pulpen gel hitam 0.5mm',
    ),
    Product(
      id: 'BRG-02',
      nama: 'Pensil 2B',
      harga: 5000.0,
      imageUrl: 'https://img.mbizmarket.co.id/products/thumbs/800x800/2023/03/30/8d0f685d5f292dd3293652094b936c3b.jpg',
      kategori: 'Alat Tulis Kantor (ATK)',
      stok: 50,
      deskripsi: 'Pensil kayu standar ujian',
    ),
    Product(
      id: 'BRG-03',
      nama: 'Buku Tulis Campus 36 Lembar',
      harga: 7500.0,
      imageUrl: 'https://tse4.mm.bing.net/th/id/OIP.7Wl3XevDGwCjCob0HfL2gQHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
      kategori: 'Alat Tulis Kantor (ATK)',
      stok: 5,
      deskripsi: 'Buku bergaris tebal',
    ),
    Product(
      id: 'BRG-04',
      nama: 'Penghapus Joyko',
      harga: 3000.0,
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2919/2919586.png',
      kategori: 'Alat Tulis Kantor (ATK)',
      stok: 0,
      deskripsi: 'Penghapus kualitas bagus',
    ),
    Product(
      id: 'BRG-05',
      nama: 'Mouse Wireless',
      harga: 120000.0,
      imageUrl: 'https://circuitzone.com/wp-content/uploads/2024/12/Picture1-6.png',
      kategori: 'Aksesoris HP/Komputer',
      stok: 12,
      deskripsi: 'Mouse silent click ekonomis',
    ),
    Product(
      id: 'BRG-06',
      nama: 'Flashdisk 32GB SanDisk',
      harga: 122000.0,
      imageUrl: 'https://cf.shopee.co.id/file/2afff4aa3a52ba60d753265809d6b2e8',
      kategori: 'Aksesoris HP/Komputer',
      stok: 8,
      deskripsi: 'USB 3.0 kecepatan tinggi',
    ),
    Product(
      id: 'BRG-07',
      nama: 'Fotokopi A4 (per lembar)',
      harga: 300.0,
      imageUrl: 'https://images.unsplash.com/photo-1568667256549-094345857637?w=500',
      kategori: 'Jasa Fotokopi & Cetak',
      stok: 1000,
      deskripsi: 'Layanan fotokopi A4 per lembar',
    ),
    Product(
      id: 'BRG-08',
      nama: 'Cetak Foto 4R',
      harga: 5000.0,
      imageUrl: 'https://images.unsplash.com/photo-1552168324-d612d77725e3?w=500',
      kategori: 'Jasa Fotokopi & Cetak',
      stok: 100,
      deskripsi: 'Kertas foto glossy berkualitas',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}