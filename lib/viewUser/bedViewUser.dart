import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:interma/model/bed.dart';
import 'package:interma/model/vaksin.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service/apiService.dart';

class BedViewUser extends StatefulWidget {
  @override
  _BedViewUserState createState() => _BedViewUserState();
}

class _BedViewUserState extends State<BedViewUser> {
  // List data = List();
  List dataLoc =List();
  String selectedLoc = "yogyakarta";
  Future myFuture;

  Future fetchLoc() async {
      var jsonText = await rootBundle.loadString('assets/location.json');
      setState(() => dataLoc = json.decode(jsonText));
      print("location ${dataLoc.length}");
      return 'success';
  }

  @override
  void initState() {
    super.initState();
    fetchLoc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
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
                              Text("Ketersediaan Kamar", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),),
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
        // appBar: AppBar(
        //   title: Text("Info Vaksinasi"),
        //   bottom: PreferredSize(
        //     preferredSize: const Size.fromHeight(60.0),
        //     child: new Padding(
        //       padding: new EdgeInsets.only(
        //         bottom: 10.0,
        //         left: 10.0,
        //         right: 10.0,
        //       ),
        //       child: Text("oke"),
        //     ),
        //   ),
        //   backgroundColor:Color(0xff29D890) ,
        // ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 10,),
                  DropdownButton(items: dataLoc.map((item){
                    return DropdownMenuItem(
                      child: Text(item['name']),
                      value: item['value'],
                    );
                  }).toList(),
                    value: selectedLoc.toString(),
                    onChanged: (newVal){
                      setState((){
                        selectedLoc = newVal;
                        print(selectedLoc.toString());
                      });
                    },
                  ),

                ],
              ),
            ),




            Expanded(
              child: FutureBuilder<List<Data>>(
                future: ApiService.getListBed(selectedLoc.toString()),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }else{
                    List<Data> listBed = snapshot.data;
                    return ListView.builder(
                      itemCount: listBed?.length,
                      itemBuilder: (BuildContext context, int index){
                        var data = snapshot.data[index];
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: (data.availableBed==0)?Color(0xffFFCDCD):Colors.white,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(height: 16,),
                                        Image.asset("assets/image/imgRS.png", width: 70,),

                                        SizedBox(height: 8,),
                                        Flexible(child: Text(data.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,textAlign: TextAlign.center, maxLines: 3,)),
                                        SizedBox(height: 3,),
                                        Flexible(child: Text(data.address, style: TextStyle(fontSize: 13,  ), overflow: TextOverflow.ellipsis,maxLines: 3, textAlign: TextAlign.center,)),

                                        SizedBox(height: 15,),
                                        // Text("Jadwal : ${data.}", style: TextStyle(fontSize: 15, )),
                                        Text("Tersedia", style: TextStyle(fontSize: 15, )),
                                        Text((data.availableBed != 0 ) ? data.availableBed.toString() :  "Penuh", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),

                                        Container(
                                          width: MediaQuery.of(context).size.width *0.8,
                                          padding: const EdgeInsets.only(top: 16.0),
                                          child: new RaisedButton(
                                            child: new Text(
                                                "Info Detail",
                                                style: new TextStyle(
                                                  color: Colors.white,
                                                )
                                            ),
                                            colorBrightness: Brightness.dark,
                                            onPressed: () {
                                              null;
                                            },
                                            color: Colors.green,
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            RaisedButton.icon(onPressed: (){
                                              launch("tel://${data.hotline}");
                                            }, icon: Icon(Icons.call, color: Colors.white,), label: Text("Hubungi"), color: Colors.blue,shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))),textColor: Colors.white),
                                            RaisedButton.icon(onPressed: (){
                                              launch("http://www.google.com/maps/search/${data.name}");
                                            }, icon: Icon(Icons.location_on, color: Colors.white,), label: Text("Cek Lokasi"), color: Colors.blue,shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))),textColor: Colors.white,),
                                          ],
                                        ),

                                        SizedBox(height: 20,),

                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            // height: 100,
                            // width: MediaQuery.of(context).size.width * 0.95,
                            child: Card(
                              child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: (data.availableBed != 0 )? Colors.blue : Colors.red,
                                              borderRadius: BorderRadius.circular(120),
                                            ),
                                            child: Center(child: Text(data.availableBed.toString(), style: TextStyle(color: Colors.white, fontSize: 20),)),
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(data.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on_outlined, size: 15, color: Colors.red,),
                                                    Expanded(child: Text(data.address, style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,)),
                                                  ],
                                                )

                                              ],
                                            ),
                                          )
                                        ],
                                      ),
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
              ),
            ),
          ],
        )
    );
  }
}
