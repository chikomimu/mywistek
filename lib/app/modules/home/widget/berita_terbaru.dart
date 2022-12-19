import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mywistek/app/models/berita.dart';

class BeritaTerbaru extends StatelessWidget {
  final List<Berita> listBerita = Berita.generateBerita();
  BeritaTerbaru({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 165,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(listBerita[index].bgImg),
              ),
            ),
          ),
          separatorBuilder: (_, index) => const SizedBox(width: 10),
          itemCount: listBerita.length,
        ),
      ),
    );
  }
}
