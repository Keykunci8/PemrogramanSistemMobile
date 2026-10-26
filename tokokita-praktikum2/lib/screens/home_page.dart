import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokokita/controllers/cart_controller.dart';
import 'package:tokokita/models/product.dart';
import 'package:tokokita/services/product_service.dart';
import 'package:tokokita/screens/product_detail_screen.dart';
import 'package:tokokita/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Ambil CartController yang sudah di-put
  final CartController cartController = Get.find<CartController>();

  // Deklarasi variabel Future untuk menampung data produk dari API
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat ulang data produk dari API
  void _loadData() {
    setState(() {
      _futureProducts = ProductService.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TOMBOL REFRESH UKURAN KECIL (SMALL)
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          _loadData();
          Get.snackbar(
            "Refresh Berhasil",
            "Memuat ulang data produk dari API...",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.black87,
            colorText: Colors.white,
          );
        },
        backgroundColor: Colors.blue.withOpacity(0.85), // Agak sedikit transparan agar tidak mencolok
        elevation: 2, // Shadow lebih tipis
        child: const Icon(Icons.refresh, size: 18, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header / App Bar Sederhana
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TokoKita',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Belanja jadi lebih mudah',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Ikon Keranjang dengan Badge Obx
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart, size: 26),
                            onPressed: () => Get.toNamed('/cart'),
                          ),
                          Positioned(
                            right: 4,
                            top: 4,
                            child: Obx(() => cartController.totalItem == 0
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${cartController.totalItem}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.toNamed('/login');
                        },
                        icon: const Icon(Icons.login, size: 18),
                        label: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bagian Daftar Produk menggunakan FutureBuilder & RefreshIndicator
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _loadData();
                  },
                  child: FutureBuilder<List<Product>>(
                    future: _futureProducts,
                    builder: (context, snapshot) {
                      // 1. Kondisi Loading (Menunggu data dari API)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // 2. Kondisi Terjadi Error
                      if (snapshot.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error_outline,
                                    color: Colors.red, size: 60),
                                const SizedBox(height: 12),
                                Text(
                                  'Gagal memuat produk:\n${snapshot.error}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: _loadData,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Coba Lagi'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      // 3. Kondisi Jika Data Kosong
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('Tidak ada produk tersedia.'),
                        );
                      }

                      // 4. Kondisi Sukses: Menampilkan Data Produk Asli
                      final products = snapshot.data!;
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return InkWell(
                            onTap: () async {
                              await Get.to(
                                  () => ProductDetailScreen(product: product));
                              setState(() {}); // Refresh UI saat kembali
                            },
                            child: ProductCard(product: product),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}