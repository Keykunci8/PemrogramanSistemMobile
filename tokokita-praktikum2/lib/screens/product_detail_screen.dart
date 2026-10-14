import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nama),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // <-- Benerin di sini
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // <-- Dan di sini
                children: [
                  Text(
                    product.nama,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${product.harga.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Chip(
                    label: Text(product.kategori),
                    backgroundColor: Colors.deepPurple.shade50,
                  ),
                  const SizedBox(height: 8),
                  Text('Stok tersedia: ${product.stok}'),
                  const SizedBox(height: 16),
                  const Text(
                    'Deskripsi Produk:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.deskripsi ?? 'Tidak ada deskripsi untuk produk ini.',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}