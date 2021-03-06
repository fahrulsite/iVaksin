import 'dart:convert';
import 'package:interma/model/bed.dart';
import 'package:interma/model/vaksin.dart';
import 'package:http/http.dart' as http;
class ApiService{
  static final _URL_VAKSIN = Uri.parse("https://ivaksin.herokuapp.com/vaksin");

//=======================GET============================
  static Future<List<Vaksin>> getListVaksin() async {

    final response = await http.get(_URL_VAKSIN); //data json
    if (response.statusCode == 200) {
      final items = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print(response.body+" responbody-vaksin");
      List<Vaksin> listVaksin = items.map<Vaksin>((json) {
        return Vaksin.fromJson(json);
      }).toList();

      return listVaksin;
    } else {
      return [];
    }
  }

  static Future<List<Data>> getListBed(String req) async {
    final _URL_BED = Uri.parse("https://bed.ina-covid.com/api/bed?prov=${req}");
    final response = await http.get(_URL_BED); //data json
    // print(response.body+" responbody");
    if (response.statusCode == 200) {
      print("oke");
      // final items = jsonDecode(response.body).cast<Map<String, dynamic>>();
      //
      final bed = Bed.fromJson(jsonDecode(response.body));
      print('data ${bed.data?.length.toString()}');
      print(bed);
      return bed.data;

      // List<Data> listBed = items.map<Data>((json) {
      //   return Bed.fromJson(json);
      // }).toList();
      // print(listBed);
      // return listBed;
    } else {
      return [];
    }
  }

//=======================POST============================

  static Future<List<Vaksin>> createVaksin({String nama, String alamat, String kota, String kouta, String telp, String location, String tanggal}) async {
    final response = await http.post(_URL_VAKSIN,
      body: {
        'nama' :nama,
        'alamat': alamat,
        'kota': kota,
        'kouta': kouta,
        'telp': telp,
        'location': location,
        'tanggal': tanggal,
      },
    ); //data json

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }


  //=========================EDIT=======
  static Future<List<Vaksin>> editVaksin({String id, String nama, String alamat, String kota, String kouta, String telp, String location, String tanggal}) async {
    final response = await http.put( Uri.parse( "https://ivaksin.herokuapp.com/vaksin/$id}"),
      body: {
        'nama' :nama,
        'alamat': alamat,
        'kota': kota,
        'kouta': kouta,
        'telp': telp,
        'location': location,
        'tanggal': tanggal,
      },
    ); //data json

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  //=============DELETE=============
  static Future<List<Vaksin>> deleteVaksin({String id}) async {
    final response = await http.delete( Uri.parse( "https://ivaksin.herokuapp.com/vaksin/$id}")); //data json

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}