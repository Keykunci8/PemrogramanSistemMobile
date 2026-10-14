import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokokita/models/product.dart';

class CartController extends GetxController {
  // List reaktif yang menyimpan item di keranjang.
  // Produk yang sama dimasukkan berkali-kali sesuai jumlahnya (quantity).
  var cartItems = <Product>[].obs;

  // Total jumlah item di keranjang (untuk badge)
  int get totalItem => cartItems.length;

  // Total harga seluruh item di keranjang
  double get totalHarga {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.harga;
    }
    return total;
  }

  // Jumlah (quantity) satu produk di keranjang
  int jumlahDari(Product product) =>
      cartItems.where((item) => item == product).length;

  // Item keranjang yang sudah dikelompokkan: produk -> quantity
  List<MapEntry<Product, int>> get itemTergrup {
    final Map<Product, int> hasil = {};
    for (final item in cartItems) {
      hasil[item] = (hasil[item] ?? 0) + 1;
    }
    return hasil.entries.toList();
  }

  // Tambah produk ke keranjang (dari halaman detail), disertai snackbar
  void addToCart(Product product, {int quantity = 1}) {
    for (int i = 0; i < quantity; i++) {
      cartItems.add(product);
    }

    Get.snackbar(
      'Berhasil Ditambahkan!',
      '$quantity ${product.nama} masuk ke keranjang',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(10),
    );
  }

  // Tombol "+" pada halaman keranjang: tambah 1 unit (selama stok masih ada)
  void tambahJumlah(Product product) {
    if (product.stok <= 0) return;
    product.stok--;
    cartItems.add(product);
  }

  // Tombol "-" pada halaman keranjang: kurangi 1 unit (minimal 1, untuk
  // menghapus produk gunakan removeFromCart)
  void kurangiJumlah(Product product) {
    if (jumlahDari(product) <= 1) return;
    cartItems.remove(product); // RxList.remove hanya menghapus 1 kemunculan
    product.stok++;
  }

  // Hapus produk beserta seluruh jumlahnya dari keranjang
  void removeFromCart(Product product) {
    final jumlah = jumlahDari(product);
    if (jumlah == 0) return;

    cartItems.removeWhere((item) => item == product);
    product.stok += jumlah; // kembalikan stok

    Get.snackbar(
      'Dihapus',
      '${product.nama} dihapus dari keranjang',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(10),
    );
  }

  // Kosongkan keranjang (stok dikembalikan)
  void clearCart() {
    for (var item in cartItems) {
      item.stok++;
    }
    cartItems.clear();
  }

  // Kosongkan keranjang DENGAN dialog konfirmasi
  Future<void> konfirmasiKosongkan() async {
    if (cartItems.isEmpty) return;

    final bool? yakin = await Get.dialog<bool>(
      Builder(
        builder: (ctx) => AlertDialog(
          title: const Text('Kosongkan Keranjang?'),
          content: Text('Semua $totalItem item akan dihapus dari keranjang.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text(
                'Ya, Kosongkan',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );

    if (yakin == true) {
      clearCart();
      Get.snackbar(
        'Keranjang Dikosongkan',
        'Semua item telah dihapus',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(10),
      );
    }
  }

  // Dipanggil saat checkout selesai: keranjang dikosongkan, stok TIDAK
  // dikembalikan karena barang sudah dibeli.
  void selesaikanPesanan() {
    cartItems.clear();
  }
}
