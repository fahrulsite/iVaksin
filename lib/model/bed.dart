class Bed {
  int status;
  List<Data> data;
  Null error;

  Bed({this.status, this.data, this.error});

  Bed.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String name;
  String address;
  int availableBed;
  int bedQueue;
  String hotline;
  String bedDetailLink;
  String hospitalCode;
  int updatedAtMinutes;
  String lat;
  String lon;

  Data(
      {this.name,
        this.address,
        this.availableBed,
        this.bedQueue,
        this.hotline,
        this.bedDetailLink,
        this.hospitalCode,
        this.updatedAtMinutes,
        this.lat,
        this.lon});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    availableBed = json['available_bed'];
    bedQueue = json['bed_queue'];
    hotline = json['hotline'];
    bedDetailLink = json['bed_detail_link'];
    hospitalCode = json['hospital_code'];
    updatedAtMinutes = json['updated_at_minutes'];
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['available_bed'] = this.availableBed;
    data['bed_queue'] = this.bedQueue;
    data['hotline'] = this.hotline;
    data['bed_detail_link'] = this.bedDetailLink;
    data['hospital_code'] = this.hospitalCode;
    data['updated_at_minutes'] = this.updatedAtMinutes;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
