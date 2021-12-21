class Admin {
  int idAdmin;
  String nama;
  String username;
  String password;

  Admin({this.idAdmin, this.nama, this.username, this.password});

  Admin.fromJson(Map<String, dynamic> json) {
    idAdmin = json['id_admin'];
    nama = json['nama'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_admin'] = this.idAdmin;
    data['nama'] = this.nama;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}