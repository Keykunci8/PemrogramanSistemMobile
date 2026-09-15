class Product {
  final String id;
  final String nama;
  final double harga;
  final String imageUrl;
  final String kategori;
  int stok;
  final String? deskripsi; 
  Product({
    required this.id,
    required this.nama,
    required this.harga,
    required this.imageUrl,
    required this.kategori,
    required this.stok,
    this.deskripsi,
  });

  String get infoProduk {
    String teksDeskripsi = deskripsi ?? 'Tidak ada deskripsi';
    return '''
ID Produk    : $id
Nama Produk  : $nama
Harga        : Rp $harga
Stok         : $stok unit
Kategori     : $kategori
Gambar URL   : $imageUrl
Deskripsi    : $teksDeskripsi''';
  }
}

class DiscountedProduct extends Product {
  final double persenDiskon;

  DiscountedProduct({
    required String id,
    required String nama,
    required double harga,
    required String imageUrl,
    required String kategori,
    required int stok,
    String? deskripsi,
    required this.persenDiskon,
  }) : super(
          id: id,
          nama: nama,
          harga: harga,
          imageUrl: imageUrl,
          kategori: kategori,
          stok: stok,
          deskripsi: deskripsi,
        );

  double get hargaAkhir {
    double potongan = harga * (persenDiskon / 100);
    return harga - potongan;
  }

  @override
  String get infoProduk {
    return '''
${super.infoProduk}
Diskon       : $persenDiskon%
Harga Akhir  : Rp $hargaAkhir''';
  }
}

void main() {
  print('==================================================');
  print('          INFORMASI PRODUK TOKO KITA              ');
  print('==================================================\n');

  Product produk1 = Product(
    id: 'BRG-1',
    nama: 'Pulpen Kokoro',
    harga: 15000.0,
    imageUrl: 'https://images.unsplash.com/photo-1585336261026-8f5786372969?w=500',
    kategori: 'Alat Tulis Kantor (ATK)',
    stok: 25,
    deskripsi: 'Pulpen gel enak dipakai menulis',
  );

  DiscountedProduct produkDiskon = DiscountedProduct(
    id: 'BRG-2',
    nama: 'Fotokopi A4 (per lembar)',
    harga: 300.0,
    imageUrl: 'https://images.unsplash.com/photo-1568667256549-094345857637?w=500',
    kategori: 'Jasa Fotokopi & Cetak',
    stok: 1000,
    deskripsi: null,
    persenDiskon: 5.0,
  );

  print('--- PRODUK UTAMA ---\n');
  print(produk1.infoProduk);
  print('\n--------------------------------------------------\n');

  print('--- PRODUK DISKON ---\n');
  print(produkDiskon.infoProduk);
  print('\n--------------------------------------------------\n');
}