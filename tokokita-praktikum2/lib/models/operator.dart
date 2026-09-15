void main() {
  double hargaSatuan = 15000.0;
  int jumlahBeli = 3;
  int stokAwal = 25;

  double totalHarga = hargaSatuan * jumlahBeli; // Perkalian
  int sisaStok = stokAwal - jumlahBeli;         // Pengurangan
  double hargaRataRata = totalHarga / jumlahBeli; // Pembagian
  int sisaBagi = stokAwal % jumlahBeli;         // Modulo / Sisa bagi

  print('Total Harga ($jumlahBeli item): Rp $totalHarga');
  print('Sisa Stok: $sisaStok');
  print('Harga Rata-rata: Rp $hargaRataRata');
  print('Sisa Bagi Stok: $sisaBagi');

  double hargaProdukA = 15000.0;
  double hargaProdukB = 25000.0;

  print('\n');
  print('Apakah harga A sama dengan B? ${hargaProdukA == hargaProdukB}');
  print('Apakah harga A lebih murah dari B? ${hargaProdukA < hargaProdukB}');
  print('Apakah harga B lebih mahal atau sama dengan A? ${hargaProdukB >= hargaProdukA}');

  int stok = 25;
  double harga = 15000.0;
  bool tokoBuka = true;

  bool layakTampil = (stok > 0) && (harga > 0);

  bool bisaTransaksi = tokoBuka || (stok > 0);

  bool tokoTutup = !tokoBuka;

  print('\n');
  print('Apakah produk layak tampil? $layakTampil');
  print('Apakah bisa melakukan transaksi? $bisaTransaksi');
  print('Apakah toko tutup? $tokoTutup');
}