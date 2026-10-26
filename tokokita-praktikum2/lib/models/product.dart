class Product {
  final int id;
  final String nama;       // Tetap pakai 'nama' agar product_card & cart tidak error
  final double harga;      // Tetap pakai 'harga'
  final String imageUrl;   // Tetap pakai 'imageUrl'
  final String kategori;
  int stok;
  final String? deskripsi; // Tetap pakai 'deskripsi'

  Product({
    required this.id,
    required this.nama,
    required this.harga,
    required this.imageUrl,
    required this.kategori,
    this.stok = 10,        // Default stok untuk API
    this.deskripsi,
  });

  // Factory untuk memetakan JSON dari Fake Store API ke properti lama kamu
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nama: json['title'] ?? '',     // API 'title' dimasukkan ke 'nama'
      harga: (json['price'] as num).toDouble(), // API 'price' ke 'harga'
      imageUrl: json['image'] ?? '', // API 'image' ke 'imageUrl'
      kategori: json['category'] ?? '',
      stok: 10,                      // Fake Store API tidak ada stok, kita set default 10
      deskripsi: json['description'], // API 'description' ke 'deskripsi'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': nama,
      'price': harga,
      'image': imageUrl,
      'category': kategori,
      'description': deskripsi,
    };
  }

  String get infoProduk {
    String teksDeskripsi = deskripsi ?? 'Tidak ada deskripsi';
    return '''
ID Produk     : $id
Nama Produk   : $nama
Harga         : Rp $harga
Stok          : $stok unit
Kategori      : $kategori
Gambar URL    : $imageUrl
Deskripsi     : $teksDeskripsi''';
  }
}

class DiscountedProduct extends Product {
  final double persenDiskon;

  DiscountedProduct({
    required super.id,
    required super.nama,
    required super.harga,
    required super.imageUrl,
    required super.kategori,
    super.stok,
    super.deskripsi,
    required this.persenDiskon,
  });

  double get hargaAkhir {
    double potongan = harga * (persenDiskon / 100);
    return harga - potongan;
  }

  @override
  String get infoProduk {
    return '''
${super.infoProduk}
Diskon        : $persenDiskon%
Harga Akhir   : Rp $hargaAkhir''';
  }
}