import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api.dart';
import '../model/pemerasan.dart';

class Pemerasan extends StatefulWidget {
  const Pemerasan({Key? key}) : super(key: key);

  @override
  _PemerasanState createState() => _PemerasanState();
}

class _PemerasanState extends State<Pemerasan> {
  Future<List<TersangkaPemerasan>>? futureTersangkaPemerasan;
  List<TersangkaPemerasan> tersangka = [];
  List<TersangkaPemerasan> filteredTersangka = [];

  @override
  void initState() {
    super.initState();
    futureTersangkaPemerasan = fetchTersangkaPemerasan();
  }

  Future<List<TersangkaPemerasan>> fetchTersangkaPemerasan() async {
    try {
      final response = await http.get(Uri.parse(Api.tersangkaPemerasan));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<TersangkaPemerasan> tersangka = body
            .map((dynamic item) => TersangkaPemerasan.fromJson(item))
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
    List<TersangkaPemerasan> dummySearchList = [];
    dummySearchList.addAll(tersangka);
    if (query.isNotEmpty) {
      List<TersangkaPemerasan> dummyListData = [];
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
        title: Text('Pemerasan',
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
      body: FutureBuilder<List<TersangkaPemerasan>>(
        future: futureTersangkaPemerasan,
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
                        '../asset/images/pemerasan2.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Pemerasan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Pemerasan adalah tindakan memaksa seseorang untuk memberikan sesuatu atau melakukan sesuatu dengan ancaman atau kekerasan. Pemerasan sering kali melibatkan penyalahgunaan kekuasaan atau posisi untuk mendapatkan keuntungan pribadi dengan cara yang tidak sah.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Contoh Pemerasan:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '1. Mengancam akan mengungkap rahasia seseorang kecuali jika diberikan uang.\n'
                      '2. Memaksa pedagang untuk membayar "uang keamanan" agar bisnis mereka tidak diganggu.\n'
                      '3. Pegawai negeri memaksa warga membayar sejumlah uang untuk mendapatkan pelayanan yang seharusnya gratis.',
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
                      decoration: InputDecoration(
                        hintText: 'Cari tersangka...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
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
