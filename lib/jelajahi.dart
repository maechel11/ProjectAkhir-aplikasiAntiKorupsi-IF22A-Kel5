import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api.dart';
import '../model/berita.dart';
import '../screens/pages/page1.dart'; 

class Jelajahi extends StatefulWidget {
  const Jelajahi({super.key});

  @override
  State<Jelajahi> createState() => _JelajahiState();
}

class _JelajahiState extends State<Jelajahi> {
  List<Berita> beritaList = [];
  List<Berita> filteredBeritaList = [];
  TextEditingController searchController = TextEditingController();
  Future<void>? _futureBerita;

  final Map<String, Widget Function(Berita)> categoryToPage = {
    'kategori1': (berita) => Page1(berita: berita),
  };

  @override
  void initState() {
    super.initState();
    _futureBerita = fetchBerita();
    searchController.addListener(() {
      filterBerita();
    });
  }

  Future<void> fetchBerita() async {
    try {
      final response = await http.get(Uri.parse(Api.berita));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        setState(() {
          beritaList = jsonResponse.map((berita) => Berita.fromJson(berita)).toList();
          filteredBeritaList = beritaList;
        });
      } else {
        throw Exception('Gagal memuat berita');
      }
    } catch (e) {
      print("Error fetching berita: $e");
    }
  }

  void filterBerita() {
    setState(() {
      filteredBeritaList = beritaList.where((berita) {
        return berita.judul.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    });
  }

  void navigateToPage(Berita berita) {
    final pageBuilder = categoryToPage[berita.kategori];
    if (pageBuilder != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageBuilder(berita),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233, 246, 255),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'JELAJAHI',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: _futureBerita,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (filteredBeritaList.isEmpty) {
                  return Center(child: Text('Tidak ada data ditemukan'));
                } else {
                  return ListView.builder(
                    itemCount: filteredBeritaList.length,
                    itemBuilder: (context, index) {
                      final berita = filteredBeritaList[index];
                      if (index == 0) {
                        return GestureDetector(
                          onTap: () => navigateToPage(berita),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(
                                children: [
                                  Image.network(
                                    berita.imagePath,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          berita.tanggal,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          berita.judul,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
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
                            onTap: () => navigateToPage(berita),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: Jelajahi(),
  ));
}
