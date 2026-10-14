import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokokita/controllers/cart_controller.dart';
import 'package:tokokita/models/product.dart';
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

  // Sumber Data Produk (15 produk dummy asli TokoKita)
  // static: daftar produk (dan stoknya) tidak ter-reset saat HomePage dibuat ulang
  static final List<Product> products = [
    Product(
      id: 'BRG-01',
      nama: 'Pulpen Kokoro',
      harga: 15000.0,
      imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-81ztq-me3mjcie1og31b',
      kategori: 'Alat Tulis Kantor (ATK)',
      stok: 5,
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
      stok: 8,
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
      stok: 4,
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
    Product(
      id: 'BRG-09',
      nama: 'Spidol Whiteboard Snowman',
      harga: 9000.0,
      imageUrl: 'https://id-test-11.slatic.net/p/a8abd7836b6dbb8ce18b7a5ca6fdb3f7.jpg',
      kategori: 'Alat Tulis Kantor (ATK)',
      stok: 30,
      deskripsi: 'Spidol papan tulis tinta hitam',
    ),
    Product(
      id: 'BRG-10',
      nama: 'Stapler Kenko',
      harga: 18000.0,
      imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7r990-lxja9yio5mru8f',
      kategori: 'Alat Tulis Kantor (ATK)',
      stok: 7,
      deskripsi: 'Stapler kecil praktis untuk kertas tipis',
    ),
    Product(
      id: 'BRG-11',
      nama: 'Kabel Data USB Type-C 1m',
      harga: 25000.0,
      imageUrl: 'https://assets.umart.com.au/newsite/images/202407/source_img/USB-Cables-Generic-Braided-USB-3-2-Type-C-to-USB-Type-C-4K-60Hz-100W-Cable-1m-CB-TC-Video-1M-100W-2.jpg',
      kategori: 'Aksesoris HP/Komputer',
      stok: 20,
      deskripsi: 'Kabel fast charging dan transfer data',
    ),
    Product(
      id: 'BRG-12',
      nama: 'Earphone Wired',
      harga: 35000.0,
      imageUrl: 'https://th.bing.com/th?id=OIF.EZ055Rjr6ZUhpGSjcOl%2bog&r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
      kategori: 'Aksesoris HP/Komputer',
      stok: 3,
      deskripsi: 'Earphone jack 3.5mm dengan mikrofon',
    ),
    Product(
      id: 'BRG-13',
      nama: 'Powerbank 10000mAh',
      harga: 150000.0,
      imageUrl: 'https://limango-res.cloudinary.com/images/f_auto,fl_progressive,q_auto,t_product-large-720,/v1/product/9224096/1/sweet-access-powerbank-10-000-mah-in-schwarz.jpg',
      kategori: 'Aksesoris HP/Komputer',
      stok: 15,
      deskripsi: 'Powerbank slim dengan dua port USB',
    ),
    Product(
      id: 'BRG-14',
      nama: 'Jilid Spiral',
      harga: 8000.0,
      imageUrl: 'https://img.mbizmarket.co.id/products/thumbs/800x800/2023/01/30/a8de19e190346ff8150823bf62d9225f.jpg',
      kategori: 'Jasa Fotokopi & Cetak',
      stok: 200,
      deskripsi: 'Jilid spiral kawat untuk laporan dan makalah',
    ),
    Product(
      id: 'BRG-15',
      nama: 'Print Dokumen Warna A4',
      harga: 1000.0,
      imageUrl: 'https://picsum.photos/seed/brg15/500',
      kategori: 'Jasa Fotokopi & Cetak',
      stok: 500,
      deskripsi: 'Cetak dokumen berwarna per lembar',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              // Daftar Produk dengan Navigasi Get.to() dan pembaruan state stok
              Expanded(
                // Obx: daftar (termasuk stok) ikut ter-refresh saat isi keranjang berubah
                child: Obx(() {
                  // ignore: unnecessary_statements
                  cartController.totalItem;
                  return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return InkWell(
                      onTap: () async {
                        // Menggunakan Get.to() dan menunggu kembali untuk memperbarui tampilan stok
                        await Get.to(() => ProductDetailScreen(product: product));
                        setState(() {}); // Memperbarui UI beranda setelah kembali dari detail
                      },
                      child: ProductCard(product: product),
                    );
                  },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}