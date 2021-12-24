import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:interma/service/apiService.dart';
import 'dart:convert';
import 'package:interma/viewUser/appBarTitle.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class TambahVaksinView extends StatefulWidget {
  @override
  _TambahVaksinViewState createState() => _TambahVaksinViewState();
}

class _TambahVaksinViewState extends State<TambahVaksinView> {

  String id;
  String date;
  List data = List();
  //
  // Future getAllNama() async{
  //   var res = await http.get(Uri.parse("https://ivaksin.herokuapp.com/donatur"));
  //   var resBody = json.decode(res.body);
  //   setState(() {
  //     data = resBody;
  //   });
  // }

  String _selectedDate = 'Tap to select date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year -40),
      lastDate: DateTime(DateTime.now().year +3),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMMMMd("en_US").format(d);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllNama();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController _nama = new TextEditingController();
    TextEditingController _alamat = new TextEditingController();
    // TextEditingController _kota = new TextEditingController();
    TextEditingController _kouta = new TextEditingController();
    TextEditingController _telp = new TextEditingController();
    TextEditingController _location = new TextEditingController();
    TextEditingController _tanggal = new TextEditingController();

    return Scaffold(
        appBar: AppBarTitle(
          nama: "Tambah Data",
          preferredSize: Size.fromHeight(140),
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                InkWell(
                  onTap: (){
                    _selectDate(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0xffF1F4FA),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                _selectedDate,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xFF000000))
                            ),
                            SizedBox( width: 20,),
                            Icon(Icons.date_range),]
                      ),
                    ),

                  ),
                ),

                SizedBox(
                  height: 20,
                ),


                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Nama",
                      labelText: "Nama"
                  ),
                  validator: (e) {
                    if (e.isEmpty) {
                      return 'Nama';
                    }
                    ;
                  },
                  controller: _nama,
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Alamat",
                      labelText: "Alamat"
                  ),
                  validator: (e) {
                    if (e.isEmpty) {
                      return 'Alamat';
                    }
                    ;
                  },
                  controller: _alamat,
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.black26),
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Stack(
                //         children: [
                //           Text('Nama'),
                //
                //           DropdownButtonHideUnderline(
                //             child: DropdownButton(
                //               value: id,
                //               hint: Text("Pilih Nama Donatur"),
                //               items: data.map((item) {
                //                 return DropdownMenuItem(
                //                   child: Text(item["nama"]),
                //                   value: item["id_donatur"].toString(),
                //                 );
                //               }).toList(),
                //               onChanged: (String newVal) {
                //                 setState(() {
                //                   id = newVal;
                //                   print(id.toString());
                //                 });
                //               },
                //             ),
                //           ),]
                //     ),
                //   ),
                // ),

                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Kouta",
                      labelText: "Kouta"
                  ),
                  validator: (e) {
                    if (e.isEmpty) {
                      return 'Kouta';
                    }
                    ;
                  },
                  controller: _kouta,
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Kontak",
                      labelText: "Kontak"
                  ),
                  validator: (e) {
                    if (e.isEmpty) {
                      return 'Kontak';
                    }
                    ;
                  },
                  controller: _telp,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Lokasi",
                      labelText: "Lokasi"
                  ),
                  validator: (e) {
                    if (e.isEmpty) {
                      return 'Lokasi';
                    }
                    ;
                  },
                  controller: _location,
                ),
                SizedBox(
                  height: 20,
                ),



                InkWell(
                  onTap: ()=>ApiService.createVaksin(nama: _nama.text, alamat: _alamat.text, kota: "" , kouta: _kouta.text, telp: _telp.text, location: _location.text, tanggal: _selectedDate.toString() ).then((value) => {
                    Toast.show("Berhasil", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM),
                  }).whenComplete(() => Get.back()),
                  child: Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xff61D2C4),
                    ),
                    height: 60,
                    child: Center(
                      child: Text(
                        "SIMPAN", style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
