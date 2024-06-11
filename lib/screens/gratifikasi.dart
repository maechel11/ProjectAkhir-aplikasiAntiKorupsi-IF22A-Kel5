import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api.dart';
import '../model/gratifikasi.dart';

class Gratifikasi extends StatefulWidget {
  const Gratifikasi({Key? key}) : super(key: key);

  @override
  _GratifikasiState createState() => _GratifikasiState();
}

class _GratifikasiState extends State<Gratifikasi> {
  Future<List<TersangkaGratifikasi>>? futureTersangkaGratifikasi;
  List<TersangkaGratifikasi> tersangka = [];
  List<TersangkaGratifikasi> filteredTersangka = [];

  @override
  void initState() {
    super.initState();
    futureTersangkaGratifikasi = fetchTersangkaGratifikasi();
  }

  Future<List<TersangkaGratifikasi>> fetchTersangkaGratifikasi() async {
    try {
      final response = await http.get(Uri.parse(Api.tersangkaGratifikasi));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<TersangkaGratifikasi> tersangka = body
            .map((dynamic item) => TersangkaGratifikasi.fromJson(item))
            .toList();
        setState(() {
          this.tersangka = tersangka;
          this.filteredTersangka = tersangka;
        });
        return tersangka;
      } else {
        throw Exception('Failed to load tersangka: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load tersangka');
    }
  }

  void filterSearchResults(String query) {
    List<TersangkaGratifikasi> dummySearchList = [];
    dummySearchList.addAll(tersangka);
    if (query.isNotEmpty) {
      List<TersangkaGratifikasi> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.nama.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredTersangka = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredTersangka = tersangka;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233, 246, 255),
      appBar: AppBar(
        title: Text('Gratifikasi',
         style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          ),
          backgroundColor: Color.fromARGB(255, 40, 2, 116),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<List<TersangkaGratifikasi>>(
        future: futureTersangkaGratifikasi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        '../asset/images/gratifikasi3.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Gratifikasi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Gratifikasi adalah pemberian dalam arti luas, yakni meliputi pemberian uang, barang, rabat (discount), komisi, pinjaman tanpa bunga, tiket perjalanan, fasilitas penginapan, perjalanan wisata, pengobatan cuma-cuma, dan fasilitas lainnya. Gratifikasi yang diterima oleh pegawai negeri atau penyelenggara negara dianggap sebagai suap apabila berhubungan dengan jabatan dan berlawanan dengan kewajiban atau tugasnya.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Contoh Gratifikasi:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '1. Pemberian hadiah ulang tahun kepada pejabat negara.\n'
                      '2. Pemberian komisi kepada pegawai negeri terkait proyek tertentu.\n'
                      '3. Pemberian fasilitas liburan kepada pegawai negeri atau pejabat negara.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Para Tersangka:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      decoration: const InputDecoration(
                        labelText: "Cari Tersangka",
                        hintText: "Cari Tersangka",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredTersangka.length,
                      itemBuilder: (context, index) {
                        final suspect = filteredTersangka[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: ListTile(
                              title: Text(
                                suspect.nama,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jabatan: ${suspect.jabatan}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Tanggal: ${suspect.tanggal}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Deskripsi: ${suspect.deskripsi}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
