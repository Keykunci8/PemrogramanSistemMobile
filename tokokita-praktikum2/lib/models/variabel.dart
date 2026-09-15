void main() {
  const String namaToko = 'Toko Kita';

  final String kodeUnik = 'BRG-1';

  var hargaDiskon = 50000;

  int stok = 25;
  double harga = 15000;
  String namaProduk = 'Pulpen Kokoro';
  bool statusTersedia = true;

  print('Nama Toko        : $namaToko');
  print('Nama Produk      : $namaProduk');
  print('Harga            : Rp $harga');
  print('Stok             : $stok');
  print('Status Tersedia  : $statusTersedia');
  print('Kode Unik        : $kodeUnik');
  print('Harga Diskon     : Rp $hargaDiskon');
  print('-----------------------------\n');

  List<String> kategori = [
    'Jasa Fotokopi & Cetak',
    'Alat Tulis Kantor (ATK)',
    'Aksesoris HP/Komputer'
  ];

  Map<String, dynamic> produk1 = {
    'nama': 'Fotokopi A4 (per lembar)',
    'kategori': 'Jasa Fotokopi & Cetak',
    'harga': 300.0,
    'stok': 1000,
  };

  print('Daftar Kategori : $kategori');
  print('Data Mentah Map : $produk1');
  print('Nama : ${produk1['nama']}');
  print('Kategori : ${produk1['kategori']}');
}