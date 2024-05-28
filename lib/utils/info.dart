import 'package:flutter/material.dart';
import 'package:get/get.dart';


class info{
  static void snackbar(String message){
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: Duration(milliseconds: 1700),
    );
  }
}



class Berita {
  final String imagePath;
  final String judul;
  final String tanggal;

  Berita(this.imagePath, this.judul, this.tanggal);
}

class BeritaList extends StatelessWidget {
  final List<Berita> beritaList = [
    Berita(
      '../asset/images/petakorupsi.jpeg',
      'Judul Berita 1',
      'Tanggal 1',
    ),
    Berita(
      '../asset/images/petakorupsi.jpeg',
      'Judul Berita 2',
      'Tanggal 2',
    ),
    Berita(
      '../asset/images/petakorupsi.jpeg',
      'Judul Berita 3',
      'lampung berduka, denganskdjadjajdfhkjasfajbfajk djassndadj',
    ),
    Berita(
      '../asset/images/petakorupsi.jpeg',
      'Judul Berita 4',
      'Tanggal 4',
    ),
    Berita(
      '../asset/images/petakorupsi.jpeg',
      'Judul Berita 5',
      'Tanggal 5',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: beritaList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(beritaList[index].imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(beritaList[index].judul),
              subtitle: Text(beritaList[index].tanggal),
              onTap: () {
                // Action when item is tapped
              },
            ),
          );
        },
      );
  }
}

void main() {
  runApp(MaterialApp(
    home: BeritaList(),
  ));
}