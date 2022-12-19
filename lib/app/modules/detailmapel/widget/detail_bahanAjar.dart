import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywistek/app/models/modul.dart';

class DetailBahanAjar extends StatelessWidget {
  final Modul modul;
  const DetailBahanAjar(this.modul, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      modul.icon,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      modul.namaFile as String,
                    ),
                  ],
                ),
              ),
              Text(
                modul.besarFile as String,
              ),
            ],
          )
        ],
      ),
    );
  }
}
