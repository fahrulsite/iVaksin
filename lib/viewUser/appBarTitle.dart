import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarTitle extends StatelessWidget implements PreferredSizeWidget  {
  final String nama;
  final Size preferredSize;
  AppBarTitle({this.nama, this.preferredSize});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        children: [
          Container(
            height: 160,
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

                  Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Column(
                        children: [
                          SizedBox(height: 100,),
                          Text(nama, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),),
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
    );
  }

}
