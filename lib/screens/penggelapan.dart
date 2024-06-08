import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/api.dart';
import '../model/penggelapan.dart';

class Penggelapan extends StatefulWidget {
  const Penggelapan({Key? key}) : super(key: key);

  @override
  _PenggelapanState createState() => _PenggelapanState();
}

class _PenggelapanState extends State<Penggelapan> {
  Future<List<TersangkaPenggelapan>>? futureTersangkaPenggelapan;
  List<TersangkaPenggelapan> tersangka = [];
  List<TersangkaPenggelapan> filteredTersangka = [];

  @override
  void initState() {
    super.initState();
    futureTersangkaPenggelapan = fetchTersangkaPenggelapan();
  }

  Future<List<TersangkaPenggelapan>> fetchTersangkaPenggelapan() async {
    try {
      final response = await http.get(Uri.parse(Api.tersangkaPenggelapan));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<TersangkaPenggelapan> tersangka = body
            .map((dynamic item) => TersangkaPenggelapan.fromJson(item))
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
    List<TersangkaPenggelapan> dummySearchList = [];
    dummySearchList.addAll(tersangka);
    if (query.isNotEmpty) {
      List<TersangkaPenggelapan> dummyListData = [];
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
        title: Text('Penggelapan',
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
      body: FutureBuilder<List<TersangkaPenggelapan>>(
        future: futureTersangkaPenggelapan,
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
                        '../asset/images/penggelapan2.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Penggelapan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Penggelapan adalah tindakan kriminal di mana seseorang mengalihkan kepemilikan aset atau harta benda milik orang lain untuk keperluan pribadi tanpa izin. Ini sering terjadi dalam konteks keuangan, seperti di tempat kerja atau dalam hubungan bisnis.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Contoh Penggelapan:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '1. Seorang pegawai yang mengambil uang dari kas perusahaan untuk kepentingan pribadi.\n'
                      '2. Pengalihan dana organisasi non-profit untuk penggunaan pribadi oleh anggota pengurus.\n'
                      '3. Penipuan yang dilakukan oleh seorang akuntan yang mengubah laporan keuangan untuk mencuri uang.',
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
                                    'Tanggal: ${suspect.tanggal.toString()}',
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
