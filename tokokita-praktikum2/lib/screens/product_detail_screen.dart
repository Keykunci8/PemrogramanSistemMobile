import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokokita/controllers/cart_controller.dart';
import 'package:tokokita/models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CartController cartController = Get.find<CartController>();
  int _jumlah = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.nama ?? 'Detail Produk'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.network(
                  product.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.shopping_bag, size: 80, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.nama ?? '-',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Rp ${product.harga.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategori: ${product.kategori ?? "-"}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Stok: ${product.stok}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: product.stok == 0 ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text(
                'Deskripsi Produk',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                product.deskripsi ?? 'Tidak ada deskripsi.',
                style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.4),
              ),
              const SizedBox(height: 24),

              // Pengatur Jumlah Item (- / +)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _jumlah > 1
                        ? () => setState(() => _jumlah--)
                        : null,
                    icon: const Icon(Icons.remove_circle_outline, size: 28),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '$_jumlah',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: product.stok > _jumlah
                        ? () => setState(() => _jumlah++)
                        : null,
                    icon: const Icon(Icons.add_circle_outline, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Tombol Tambah ke Keranjang
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: product.stok > 0
                      ? () {
                          // 1. Kurangi stok produk sesuai jumlah yang dibeli
                          product.stok -= _jumlah;

                          // 2. Kembali dulu ke halaman utama. Get.back() TIDAK boleh
                          //    dipanggil setelah snackbar muncul, karena Get.back()
                          //    akan menutup snackbar yang sedang tampil.
                          Get.back();

                          // 3. Baru masukkan ke keranjang (memicu Get.snackbar)
                          cartController.addToCart(product, quantity: _jumlah);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Tambah ke Keranjang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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