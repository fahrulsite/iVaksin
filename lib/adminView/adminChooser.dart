import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interma/adminView/donasi/adminVaksinView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminChooser extends StatefulWidget {
  @override
  _AdminChooserState createState() => _AdminChooserState();
}

bool isLogin = true;
class _AdminChooserState extends State<AdminChooser> {

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setBool("status", false);
      preferences.commit();
      isLogin = false;
      print(preferences.getBool("status"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffFBFDFF),
        height: 500,
        child: Stack(
          children: [
            Container(
              height: 180,
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
                        left: 30,
                        top: 63,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Halo!!', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),),
                            Text('Selamat Datang Di Interma', style: GoogleFonts.aldrich(color: Colors.white, fontSize: 15),),
                          ],
                        )),

                    // Positioned(
                    //     right: 30,
                    //     top: 63,
                    //     child: Container(
                    //       width: 50,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           image: DecorationImage(
                    //               image: NetworkImage("https://www.spring.org.uk/images/man1.jpg"),
                    //               fit: BoxFit.fill
                    //           )
                    //       ),
                    //     )
                    //
                    // ),
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

            Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Container(
                  height: 600,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              // onTap: ()=>Get.to(AdminDonaturView()),
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.people_alt_rounded, color: Colors.black),
                                      SizedBox(height: 20,),
                                      Text("Donatur")
                                    ],
                                  ),),
                              ),
                            ),

                            InkWell(
                              onTap: ()=> Get.to(AdminVaksinView()),
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/image/donasi.png', height: 30,),
                                      SizedBox(height: 20,),
                                      Text("Donasi")
                                    ],
                                  ),),
                              ),
                            ),


                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              // onTap: ()=>Get.to(AdminPenerimaView()),
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.people_alt_rounded, color: Colors.black),
                                      SizedBox(height: 20,),
                                      Text("Penerima")
                                    ],
                                  ),),
                              ),
                            ),

                            InkWell(
                              // onTap: ()=>Get.to(AdminPenyaluranView()),
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/image/penyaluran.png', height: 30,),
                                      SizedBox(height: 20,),
                                      Text("Penyaluran")
                                    ],
                                  ),),
                              ),
                            ),
                          ],
                        ),

                        InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                title: Text("Konfirmasi"),
                                content: Text("Apakah Anda Yakin ingin keluar?"),
                                actions: [
                                  FlatButton(
                                      onPressed: (){
                                        Get.back();
                                      },
                                      child: Text("No")),
                                  FlatButton(onPressed:(){
                                    signOut();
                                    SystemNavigator.pop();
                                  },
                                      child: Text("Yes")),
                                ],
                              );
                            });
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Card(
                              color: Color(0xffFF616D),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Keluar", style: TextStyle(color: Colors.white),)
                                ],
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

