import 'package:flutter/material.dart';
import 'package:mywistek/app/models/absensi.dart';
import 'package:mywistek/app/models/modul.dart';
import 'package:mywistek/app/modules/detailmapel/widget/detail_bahanAjar.dart';

class ListBahanAjar extends StatelessWidget {
  // final String scrollKey;
  // final List<Modul> detailMapel;
  // const ListBahanAjar(this.scrollKey, this.detailMapel, {Key? key})
  //     : super(key: key);
  final String scrollKey;
  final List<Absensi> detailMapel;
  const ListBahanAjar(this.scrollKey, this.detailMapel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Comming Son"),
    );
    // return ListView.separated(
    //   key: PageStorageKey(scrollKey),
    //   padding: const EdgeInsets.only(top: 10, right: 7, left: 7),
    //   itemBuilder: (_, index) => DetailBahanAjar(detailMapel[index]),
    //   separatorBuilder: (_, index) => SizedBox(height: 10),
    //   itemCount: detailMapel.length,
    // );
  }
}
