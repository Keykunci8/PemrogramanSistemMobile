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
      return 0.0;
  }
}

double hitungTotalBelanja(List<double> daftarHarga) {
  double total = 0.0;
  for (int i = 0; i < daftarHarga.length; i++) {
    total += daftarHarga[i];
  }
  return total;
}

void simulasiPenjualan(int stokAwal) {
  int stok = stokAwal;
  print('--- Memulai Simulasi Penjualan Barang ---');
  while (stok > 0) {
    print('1 barang dibeli (Stok tersisa: ${stok - 1})');
    stok--;
  }
  print('Semua stok barang telah habis!\n');
}

void main() {
  print('=========================================');
  print('       SIMULASI TRANSAKSI TOKO           ');
  print('=========================================\n');

  String kategori = 'aksesoris hp/komputer';
  int stokBarang = 3;
  List<double> keranjangHarga = [15000.0, 25000.0, 10000.0]; 

  // A. Cek Status Stok Barang
  String statusStok = cekStatusStok(stokBarang);
  print('Kategori Barang : $kategori');
  print('Stok Barang      : $stokBarang ($statusStok)\n');

  // B. Hitung Total Belanja
  double totalAwal = hitungTotalBelanja(keranjangHarga);
  print('Item di Keranjang : $keranjangHarga');
  print('Total Belanja Awal: Rp $totalAwal');

  // C. Hitung Diskon dan Total Akhir
  double persenDiskon = hitungDiskon(kategori);
  double nilaiDiskon = totalAwal * (persenDiskon / 100);
  double totalAkhir = totalAwal - nilaiDiskon;

  print('Diskon Kategori   : $persenDiskon% (-Rp $nilaiDiskon)');
  print('Total Pembayaran  : Rp $totalAkhir\n');

  // D. Jalankan Simulasi Pengurangan Stok Sampai Habis
  simulasiPenjualan(stokBarang);
}

