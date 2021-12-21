import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interma/model/vaksin.dart';
import '../service/apiService.dart';

class VaksinViewUser extends StatefulWidget {
  @override
  _VaksinViewUserState createState() => _VaksinViewUserState();
}

class _VaksinViewUserState extends State<VaksinViewUser> {
  List data = List();

  Future getAllNama() async{
    var res = await http.get(Uri.parse("https://ivaksin.herokuapp.com/donatur"));
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarTitle(
      //   nama: "Data Donasi",
      //   preferredSize: Size.fromHeight(140),
      // ),

      appBar: AppBar(
        title: Text("Info Vaksinasi"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: new Padding(
            padding: new EdgeInsets.only(
              bottom: 10.0,
              left: 10.0,
              right: 10.0,
            ),
            child: Text("oke"),
          ),
        ),
        backgroundColor:Color(0xff29D890) ,
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
                  onTap: ()=>Get.to(DetailDonasi(data: data,)),
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Text(data.donatur.nama, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                    ],
                                  ),


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

                                      Text("+"+"${data.jumlah}", style: TextStyle(fontSize: 20, color: Colors.green),),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Icon(Icons.date_range, size: 20,),
                                          SizedBox(width: 10,),
                                          Text(data.tanggal, style: TextStyle(fontSize: 13),),
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
