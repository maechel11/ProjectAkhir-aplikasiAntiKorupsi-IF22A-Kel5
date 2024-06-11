import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api.dart';
import '../model/berita.dart';
import 'pages/page1.dart';

class BeritaList extends StatefulWidget {
  @override
  _BeritaListState createState() => _BeritaListState();
}

class _BeritaListState extends State<BeritaList> {
  Future<List<Berita>> fetchBerita() async {
    final response = await http.get(Uri.parse(Api.berita));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((berita) => Berita.fromJson(berita)).toList();
    } else {
      throw Exception('Gagal memuat berita');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Berita>>(
      future: fetchBerita(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Tidak ada data ditemukan'));
        } else {
          List<Berita> beritaList = snapshot.data!;
          int itemCount = beritaList.length < 5 ? beritaList.length : 5;

          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final berita = beritaList[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(berita.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(berita.judul),
                  subtitle: Text(berita.tanggal),
                  onTap: () {
                    if (berita.kategori == 'kategori1') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Page1(berita: berita),
                        ),
                      );
                    } else if (berita.kategori == 'kategori2') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Page1(berita: berita),
                        ),
                      );
                    } else if (berita.kategori == 'kategori3') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Page1(berita: berita),
                        ),
                      );
                    } else if (berita.kategori == 'kategori4') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Page1(berita: berita),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Page1(berita: berita),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BeritaList(),
  ));
}
