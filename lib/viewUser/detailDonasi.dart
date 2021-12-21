import 'package:flutter/material.dart';
import 'package:interma/model/vaksin.dart';
import 'package:interma/viewUser/appBarTitle.dart';
class DetailDonasi extends StatelessWidget {
  final Vaksin data;

  const DetailDonasi({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTitle(
        preferredSize: Size.fromHeight(140),
          nama: "Detail Donasi",
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Nama        :", style: TextStyle(fontSize: 20,),),
                    SizedBox(width: 20,),
                    // Text(data., style: TextStyle(fontSize: 20, ),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Alamat       :", style: TextStyle(fontSize: 20,),),
                    SizedBox(width: 20,),
                    // Text(data.donatur.alamat, style: TextStyle(fontSize: 20, ),),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Kontak       :", style: TextStyle(fontSize: 20,),),
                    SizedBox(width: 20,),
                    // Text(data.donatur.kontak, style: TextStyle(fontSize: 20, ),),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Tanggal       :", style: TextStyle(fontSize: 20,),),
                    SizedBox(width: 20,),
                    Text(data.tanggal, style: TextStyle(fontSize: 20, ),),
                  ],
                ),
                SizedBox(height: 20,),
                // Text("Rp "+data.jumlah.toString(), style: TextStyle(color: Colors.green, fontSize: 40, fontWeight: FontWeight.w500))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
