import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywistek/app/models/tugas.dart';

class DetailTugas extends StatelessWidget {
  final Tugas tugas;
  const DetailTugas(this.tugas, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
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
                      tugas.icon,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      tugas.judul as String,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 35, top: 5),
            child: Row(
              children: [
                Text(
                  tugas.mulai as String,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  " | ",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  tugas.mulai as String,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
