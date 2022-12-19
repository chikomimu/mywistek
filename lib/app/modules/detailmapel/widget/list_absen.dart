import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mywistek/app/models/absensi.dart';
import 'package:mywistek/app/modules/detailmapel/widget/detail_absen.dart';
import 'package:mywistek/utils/colors.dart';
// import 'package:tabbar/app/modules/detailmapel/widget/detailmapel_bar.dart';
// import 'package:tabbar/app/modules/home/widget/bidder_card.dart';

class DetailList extends StatefulWidget {
  final String scrollKey;
  final List<Absensi> detailMapel;
  const DetailList(this.scrollKey, this.detailMapel, {super.key});

  @override
  State<DetailList> createState() => _DetailListState(detailMapel, scrollKey);
}

class _DetailListState extends State<DetailList> {
  _DetailListState(this.detailMapel, this.scrollKey);
  final List<Absensi> detailMapel;
  final String scrollKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: ListView.separated(
          key: PageStorageKey(scrollKey),
          padding: const EdgeInsets.only(top: 10, right: 7, left: 7),
          itemBuilder: (_, index) => DetailAbsen(detailMapel[index]),
          separatorBuilder: (_, index) => SizedBox(height: 15),
          itemCount: detailMapel.length,
        ),
      ),
    );
  }
}
