import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interma/adminView/vaksin/tambahVaksinView.dart';
import 'package:interma/model/vaksin.dart';
import 'package:interma/service/apiService.dart';
import 'package:interma/viewUser/appBarTitle.dart';
import 'package:http/http.dart' as http;

import 'editVaksinView.dart';

class AdminVaksinView extends StatefulWidget {
  @override
  _AdminVaksinViewState createState() => _AdminVaksinViewState();
}

class _AdminVaksinViewState extends State<AdminVaksinView> {
  _getRequests() async{}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTitle(
          nama: "Data Tempat Vaksin",
          preferredSize: Size.fromHeight(140),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new TambahVaksinView()),)
                .then((_){
              setState(() {

              });
            });
          },
          backgroundColor: Color(0xff61D2C4),
        ),

        body: FutureBuilder<List<Vaksin>>(
          future: ApiService.getListVaksin(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }else{
              List<Vaksin> listVaksin = snapshot.data;
              print(snapshot.data);
              return ListView.builder(
                itemCount: listVaksin?.length ?? 0,
                itemBuilder: (BuildContext context, int index){
                  var data = snapshot.data[index];
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new EditVaksinView(data: data,)),)
                          .then((_){
                            setState(() {

                            });
                      });
                    },
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
                  );
                },
              );
            }
          },
        )
    );
  }
}
