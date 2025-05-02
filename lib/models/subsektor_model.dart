class SubSektor {
  final int id;
  final int sektorId;
  final String nama;
  final String gambarUrl;
  final String keterangan;
  final int jumlahPengusaha;

  SubSektor({
    required this.id,
    required this.sektorId,
    required this.nama,
    required this.gambarUrl,
    required this.keterangan,
    required this.jumlahPengusaha,
  });

  factory SubSektor.fromJson(Map<String, dynamic> json) {
    return SubSektor(
      id: json['id'],
      sektorId: json['sektor_id'],
      nama: json['nama'],
      gambarUrl: json['gambar_url'],
      keterangan: json['keterangan'],
      jumlahPengusaha: json['jumlah_pengusaha'],
    );
  }
}