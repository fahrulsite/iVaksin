import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interma/adminView/adminLogin.dart';
import 'package:interma/viewUser/vaksinViewUser.dart';
class Chooser extends StatefulWidget {
  @override
  _ChooserState createState() => _ChooserState();
}

class _ChooserState extends State<Chooser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Column(
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

                  Center(child: Column(
                    children: [
                      SizedBox(height: 100,),
                      Text('Interma', style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w400),),
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
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)  ),
              ),

            ),
          ],
        ),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              // onTap: ()=>Get.to(VaksinViewUser()),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/donasi.png', height: 30,),
                      SizedBox(height: 20,),
                      Text("Ketersediaan Tempat Tidur")
                    ],
                ),),
              ),
            ),

            InkWell(
              onTap: ()=>Get.to(VaksinViewUser()),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/penyaluran.png', height: 30,),
                      SizedBox(height: 20,),
                      Text("Info Vaksinasi")
                    ],
                  ),),
              ),
            ),

            InkWell(
              onTap: ()=>Get.to(AdminLogin()),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people),
                      SizedBox(height: 20,),
                      Text("Admin")
                    ],
                  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
