import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:interma/model/vaksin.dart';
import 'package:interma/service/apiService.dart';
import 'package:interma/viewUser/appBarTitle.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class EditVaksinView extends StatefulWidget {
  final Vaksin data;

  const EditVaksinView({Key key, this.data}) : super(key: key);

  @override
  _EditVaksinViewState createState() => _EditVaksinViewState();
}

class _EditVaksinViewState extends State<EditVaksinView> {
  final formKey = GlobalKey<FormState>();
  String id;
  String date;
  List data = List();



  // Future getAllNama() async{
  //   var res = await http.get(Uri.parse("https://ivaksin.herokuapp.com/donatur"));
  //   var resBody = json.decode(res.body);
  //   setState(() {
  //     data = resBody;
  //   });
  // }

  String _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 50),
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
    id = widget.data.idVaksin.toString();
    _selectedDate = widget.data.tanggal.toString();
    // getAllNama();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nama = new TextEditingController(text: widget.data.nama);
    TextEditingController _alamat = new TextEditingController(text: widget.data.alamat);
    TextEditingController _kouta = new TextEditingController(text: widget.data.kouta);
    TextEditingController _telp = new TextEditingController(text: widget.data.telp);
    TextEditingController _location = new TextEditingController(text: widget.data.location);
    TextEditingController _tanggal = new TextEditingController(text: widget.data.tanggal);

    return Scaffold(
        appBar: AppBarTitle(
          nama: "Edit Vaksinasi",
          preferredSize: Size.fromHeight(140),
        ),
        body: InkWell(
          onTap: null,
          child: Container(
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
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox( width: 20,),
                              Text(
                                  _selectedDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Color(0xFF000000))
                              ),]
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
                    controller: nama,
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



                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text("Konfirmasi"),
                              content: Text("Apakah Anda Yakin ingin menghapus data ini?"),
                              actions: [
                                FlatButton(
                                    onPressed: (){
                                      Get.back();
                                    },
                                    child: Text("No")),
                                FlatButton(onPressed:(){
                                  ApiService.deleteVaksin(
                                      id: widget.data.idVaksin.toString()).whenComplete((){
                                    Get.back();
                                    Get.back();
                                  });},
                                    child: Text("Yes")),
                              ],
                            );
                          });
                        },
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffFF616D),
                          ),
                          height: 60,
                          child: Center(child: Text("Hapus", style: TextStyle(color: Colors.white),)),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          ApiService.editVaksin(id: widget.data.idVaksin.toString() , nama:nama.text, kouta: _kouta.text, telp: _telp.text,location: _location.text, tanggal: _selectedDate, kota: " ", alamat: _alamat.text ).then((value) => {
                            Toast.show("Berhasil", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM),
                          }).whenComplete(() => Get.back(result: 'success'));
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xff61D2C4),
                          ),
                          height: 60,
                          child: Center(
                            child: Text(
                              "Simpan", style: TextStyle(color: Colors.white,),
                            ),
                          ),

                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
