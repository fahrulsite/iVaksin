import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:interma/model/vaksin.dart';
import 'package:interma/viewUser/appBarTitle2.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service/apiService.dart';

class VaksinViewUser extends StatefulWidget {
  @override
  _VaksinViewUserState createState() => _VaksinViewUserState();
}

class _VaksinViewUserState extends State<VaksinViewUser> {
  List data = List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              child: Stack(
                  children: [
                    Positioned(
                      top: 80,
                      right: -80,
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 4,
                        width: MediaQuery
                            .of(context)
                            .size
                            .height / 4,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15)
                        ),
                      ),
                    ),

                    Positioned(
                      top: -100,
                      right: -80,
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 3,
                        width: MediaQuery
                            .of(context)
                            .size
                            .height / 3,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15)
                        ),
                      ),
                    ),

                    Positioned(
                      top: 20,
                      left: 20,
                      child: InkWell(
                        onTap: ()=>Get.back(),
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 8,
                          width: MediaQuery
                              .of(context)
                              .size
                              .height / 8,
                          child: Icon(Icons.arrow_back, color: Colors.white, size: 40,),
                        ),
                      ),
                    ),

                    Positioned(
                        top: -50,
                        left: 120,
                        // margin: EdgeInsets.only(left: 50),
                        child: Column(
                          children: [
                            SizedBox(height: 100,),
                            Text("Data Vaksinasi", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),),
                          ],
                        )),
                  ]),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xff61D2C4),
                      Color(0xff29D890),
                    ]
                ),

              ),

            ),
          ],
        ),
      ),

      body: FutureBuilder<List<Vaksin>>(
        future: ApiService.getListVaksin(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else{
            List<Vaksin> listVaksin = snapshot.data;
            return ListView.builder(
              itemCount: listVaksin?.length ?? 0,
              itemBuilder: (BuildContext context, int index){
                var data = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: (data.kouta=="0")?Color(0xffFFCDCD):Colors.white,
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 16,),
                              Image.asset("assets/image/imgRS.png", width: 70,),

                              SizedBox(height: 8,),
                              Text(data.nama, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                              SizedBox(height: 3,),
                              Text(data.alamat, style: TextStyle(fontSize: 13, )),

                              SizedBox(height: 15,),
                              Text("Jadwal : ${data.tanggal}", style: TextStyle(fontSize: 15, )),
                              Text("Tersedia", style: TextStyle(fontSize: 15, )),
                              Text((data.kouta != "0" ) ? data.kouta :  "Penuh", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),

                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton.icon(onPressed: (){
                                    launch("tel://${data.telp}");
                                  }, icon: Icon(Icons.call, color: Colors.white,), label: Text("Hubungi"), color: Colors.blue,shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),textColor: Colors.white),
                                  RaisedButton.icon(onPressed: (){
                                    launch("http://${data.location}");
                                  }, icon: Icon(Icons.location_on, color: Colors.white,), label: Text("Cek Lokasi"), color: Colors.blue,shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),textColor: Colors.white,),
                                ],
                              ),

                              SizedBox(height: 20,),

                            ],
                          );
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    // height: 100,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: (data.kouta != "0" )? Colors.blue : Colors.red,
                                      borderRadius: BorderRadius.circular(120),
                                    ),
                                    child: Center(child: Text(data.kouta, style: TextStyle(color: Colors.white, fontSize: 20),)),
                                  ),
                                  SizedBox(width: 15,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data.nama, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined, size: 15, color: Colors.red,),
                                          Text(data.alamat, style: TextStyle(fontSize: 15, )),

                                        ],
                                      )

                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Icon(Icons.date_range, size: 15,),
                                          SizedBox(width: 7,),
                                          Text(data.tanggal, style: TextStyle(fontSize: 10),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      )
      );
  }
}
