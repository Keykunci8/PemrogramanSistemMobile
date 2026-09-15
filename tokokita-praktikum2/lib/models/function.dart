String cekStatusStok(int stok) {
  if (stok > 10) {
    return 'Tersedia';
  } else if (stok > 0) {
    return 'Stok Terbatas';
  } else {
    return 'Habis';
  }
}

double hitungDiskon(String kategori) {
  switch (kategori.toLowerCase()) {
    case 'jasa fotokopi & cetak':
      return 5.0; // Diskon 5%
    case 'alat tulis kantor (atk)':
      return 10.0; // Diskon 10%
    case 'aksesoris hp/komputer':
      return 15.0; // Diskon 15%
    default:
      return 0.0; // Tidak ada diskon
  }
}

void main() {
  print('=== UJI POIN 1: Status Stok (if-else) ===');
  int stokProduk = 5;
  String status = cekStatusStok(stokProduk);
  print('Stok saat ini ($stokProduk) -> Status: $status\n');


  print('=== UJI POIN 2: Perulangan FOR (Total Belanja) ===');
  List<double> daftarHarga = [15000.0, 25000.0, 50000.0, 10000.0];
  double totalBelanja = 0.0;

  for (int i = 0; i < daftarHarga.length; i++) {
    totalBelanja += daftarHarga[i];
  }
  print('Daftar harga item: $daftarHarga');
  print('Total Belanjaan: Rp $totalBelanja\n');


  print('=== UJI POIN 3: Perulangan WHILE (Simulasi Pengurangan Stok) ===');
  int stokSimulasi = 3;
  print('Stok awal: $stokSimulasi');

  while (stokSimulasi > 0) {
    stokSimulasi--; // Kurangi stok 1 per 1
    print('1 barang dibeli. Sisa stok: $stokSimulasi');
  }
  print('Stok telah habis!\n');


  print('=== UJI POIN 4: Switch-Case Diskon Kategori ===');
  String kategoriDipilih = 'Alat Tulis Kantor (ATK)';
  double diskon = hitungDiskon(kategoriDipilih);
  print('Kategori: $kategoriDipilih');
  print('Besaran Diskon: $diskon%\n');
}