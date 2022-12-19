import 'package:flutter/material.dart';
import 'package:mywistek/app/models/jadwal.dart';
import 'package:mywistek/app/modules/detailmapel/views/detailmapel_view.dart';
import 'package:mywistek/app/modules/detailmapel/widget/detailmapel_bar.dart';
import 'package:mywistek/utils/colors.dart';

class JadwalList extends StatelessWidget {
  final String scrollKey;
  final List<Jadwal> jadwalList;
  const JadwalList(this.scrollKey, this.jadwalList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        key: PageStorageKey(scrollKey),
        padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
        // itemBuilder: (_, index) => BidderCard(jadwalList[index]),
        itemBuilder: (_, index) => Container(
          height: 400,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      right: 20,
                      left: 20,
                      bottom: 10,
                    ),
                    color: Colors.blue,
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          jadwalList[index].namaMatkul as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //apply padding to all four sides
                        Text(
                          "${jadwalList[index].jamMulai} - ${jadwalList[index].jamSelesai}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                      top: 15,
                      right: 20,
                      left: 20,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Nama Guru : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                jadwalList[index].namaDosen as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.library_books,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Kode MTK : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${jadwalList[index].kodeMatkul}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.offline_pin,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'SKS : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              jadwalList[index].sks as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.room_rounded,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'No Ruang : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              jadwalList[index].noRuang as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.black38,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Kel Praktek : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              jadwalList[index].kelPraktek as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailMapel(jadwalList[index]),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: AppColors.btnHijau,
                            fixedSize: const Size(115, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Text(
                            "MASUK KELAS",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        separatorBuilder: (_, index) => SizedBox(height: 15),
        itemCount: jadwalList.length,
      ),
    );
  }
}
