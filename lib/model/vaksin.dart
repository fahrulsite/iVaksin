class Vaksin {
  int idVaksin;
  String nama;
  String alamat;
  String kota;
  String kouta;
  String telp;
  String location;
  String tanggal;

  Vaksin(
      {this.idVaksin,
        this.nama,
        this.alamat,
        this.kota,
        this.kouta,
        this.telp,
        this.location,
        this.tanggal});

  Vaksin.fromJson(Map<String, dynamic> json) {
    idVaksin = json['id_vaksin'];
    nama = json['nama'];
    alamat = json['alamat'];
    kota = json['kota'];
    kouta = json['kouta'];
    telp = json['telp'];
    location = json['location'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_vaksin'] = this.idVaksin;
    data['nama'] = this.nama;
    data['alamat'] = this.alamat;
    data['kota'] = this.kota;
    data['kouta'] = this.kouta;
    data['telp'] = this.telp;
    data['location'] = this.location;
    data['tanggal'] = this.tanggal;
    return data;
  }
}