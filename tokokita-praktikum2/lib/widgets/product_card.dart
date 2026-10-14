import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';
import 'category_tag.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // Variabel penampung status favorit
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    print('1. initState() dipanggil');
  }

  @override
  Widget build(BuildContext context) {
    print('2. build() dipanggil');

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: widget.product),
            ),
          );
        },
        leading: SizedBox(
          width: 50,
          height: 50,
          child: Image.network(
            widget.product.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, color: Colors.grey),
              );
            },
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.product.nama,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            // Menggunakan widget custom CategoryTag dengan parameter berbeda
            CategoryTag(
              label: widget.product.harga > 50000 ? 'Premium' : 'Reguler',
              color: widget.product.harga > 50000 ? Colors.purple : Colors.green,
            ),
          ],
        ),
                subtitle: Text('Rp ${widget.product.harga.toStringAsFixed(0)}'),
        
        // TOMBOL FAVORIT (Ganti ikon sampah jadi ikon hati)
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            // Memanggil setState agar build() dipanggil ulang
            setState(() {
              isFavorite = !isFavorite;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('3. dispose() dipanggil');
    super.dispose();
  }
}