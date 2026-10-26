import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokokita/controllers/cart_controller.dart';
import 'package:tokokita/models/product.dart';
import 'package:tokokita/screens/checkout_page.dart';
import 'package:tokokita/utils/format.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instance yang sama dengan Home & Detail (lintas halaman)
    final CartController cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: Obx(() {
        if (cart.cartItems.isEmpty) {
          return const Center(
            child: Text(
              'Keranjang masih kosong',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final entries = cart.itemTergrup;

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: entries.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) => _CartItemTile(
                  product: entries[index].key,
                  qty: entries[index].value,
                  cart: cart,
                ),
              ),
            ),
            _ringkasan(cart),
          ],
        );
      }),
    );
  }

  // Bagian bawah: total harga + tombol Kosongkan & Checkout
  Widget _ringkasan(CartController cart) {
    return Container(
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
                Text('Total (${cart.totalItem} item)',
                    style: const TextStyle(fontSize: 16)),
                Text(
                  rupiah(cart.totalHarga),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: cart.konfirmasiKosongkan,
                    icon: const Icon(Icons.delete_sweep, color: Colors.red),
                    label: const Text(
                      'Kosongkan',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    // Get.off(): setelah checkout tidak bisa kembali ke keranjang
                    onPressed: () => Get.off(() => const CheckoutPage()),
                    icon: const Icon(Icons.payment),
                    label: const Text('Checkout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final Product product;
  final int qty;
  final CartController cart;

  const _CartItemTile({
    required this.product,
    required this.qty,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    const kecil = BoxConstraints(minWidth: 32, minHeight: 32);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.imageUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 56,
                height: 56,
                color: Colors.grey[200],
                child: const Icon(Icons.shopping_bag, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.nama,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${rupiah(product.harga)} x $qty',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  rupiah(product.harga * qty),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ),
          // Pengatur quantity
          IconButton(
            padding: EdgeInsets.zero,
            constraints: kecil,
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: qty > 1 ? () => cart.kurangiJumlah(product) : null,
          ),
          Text('$qty',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: kecil,
            icon: const Icon(Icons.add_circle_outline),
            onPressed: product.stok > 0 ? () => cart.tambahJumlah(product) : null,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: kecil,
            tooltip: 'Hapus dari keranjang',
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => cart.removeFromCart(product),
          ),
        ],
      ),
    );
  }
}
