import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokokita/controllers/cart_controller.dart';
import 'package:tokokita/utils/format.dart';

/// Halaman checkout sederhana. Dibuka dari CartPage dengan Get.off(),
/// sehingga halaman keranjang diganti dan tidak bisa dikembalikan.
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cart = Get.find<CartController>();

    // Ringkasan diambil sekali (snapshot) dari CartController
    final items = cart.itemTergrup;
    final totalItem = cart.totalItem;
    final totalHarga = cart.totalHarga;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        automaticallyImplyLeading: false, // tidak ada tombol kembali
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ringkasan Pesanan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Tidak ada item untuk di-checkout'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const Divider(),
                    itemBuilder: (context, index) {
                      final p = items[index].key;
                      final qty = items[index].value;
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.nama,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                Text('${rupiah(p.harga)} x $qty',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                          Text(rupiah(p.harga * qty)),
                        ],
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total ($totalItem item)',
                          style: const TextStyle(fontSize: 16)),
                      Text(
                        rupiah(totalHarga),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: items.isEmpty
                          ? null
                          : () {
                              cart.selesaikanPesanan();
                              // Kembali ke beranda & buang semua halaman sebelumnya
                              Get.offAllNamed('/');
                              Get.snackbar(
                                'Pesanan Berhasil!',
                                'Terima kasih, total ${rupiah(totalHarga)}',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                                margin: const EdgeInsets.all(10),
                              );
                            },
                      child: const Text('Bayar & Selesaikan Pesanan'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
