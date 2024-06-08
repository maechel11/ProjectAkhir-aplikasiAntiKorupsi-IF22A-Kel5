import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api.dart';
import '../model/perbuatan_curang.dart';

class PerbuatanCurang extends StatefulWidget {
  const PerbuatanCurang({Key? key}) : super(key: key);

  @override
  _PerbuatanCurangState createState() => _PerbuatanCurangState();
}

class _PerbuatanCurangState extends State<PerbuatanCurang> {
  Future<List<TersangkaPerbuatanCurang>>? futureTersangkaPerbuatanCurang;
  List<TersangkaPerbuatanCurang> tersangka = [];
  List<TersangkaPerbuatanCurang> filteredTersangka = [];

  @override
  void initState() {
    super.initState();
    futureTersangkaPerbuatanCurang = fetchTersangkaPerbuatanCurang();
  }

  Future<List<TersangkaPerbuatanCurang>> fetchTersangkaPerbuatanCurang() async {
    try {
      final response = await http.get(Uri.parse(Api.tersangkaPerbuatanCurang));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<TersangkaPerbuatanCurang> tersangka = body
            .map((dynamic item) => TersangkaPerbuatanCurang.fromJson(item))
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
    List<TersangkaPerbuatanCurang> dummySearchList = [];
    dummySearchList.addAll(tersangka);
    if (query.isNotEmpty) {
      List<TersangkaPerbuatanCurang> dummyListData = [];
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
        title: Text('Perbuatan Curang',
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
      body: FutureBuilder<List<TersangkaPerbuatanCurang>>(
        future: futureTersangkaPerbuatanCurang,
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
                        '../asset/images/perbuatan_curang2.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Perbuatan Curang',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Perbuatan curang adalah tindakan yang dilakukan dengan maksud untuk menipu atau menyesatkan pihak lain demi keuntungan pribadi atau kelompok tertentu. Tindakan ini melibatkan penggunaan informasi atau sumber daya yang salah atau tidak etis untuk mencapai tujuan yang tidak sah.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Contoh Perbuatan Curang:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '1. Memanipulasi data atau laporan keuangan untuk menutupi kerugian atau untuk menunjukkan keuntungan yang tidak benar.\n'
                      '2. Menyalahgunakan posisi atau kekuasaan untuk mengamankan kontrak atau kesepakatan dengan cara yang tidak sah.\n'
                      '3. Melakukan praktik kartel atau kolusi dengan pesaing untuk menentukan harga atau membagi pasar.',
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
