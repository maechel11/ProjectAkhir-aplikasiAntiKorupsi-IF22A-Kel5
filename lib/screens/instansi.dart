import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:snow_login/config/api.dart';
import 'package:snow_login/model/instansi.dart'; 

class InstansiList extends StatefulWidget {
  const InstansiList({Key? key}) : super(key: key);

  @override
  State<InstansiList> createState() => _InstansiListState();
}

class _InstansiListState extends State<InstansiList> {
  late Future<List<Instansi>> _instansiList;
  List<Instansi> _filteredInstansi = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _instansiList = fetchInstansiData();
    _searchController.addListener(() {
      _updateSearchQuery(_searchController.text);
    });
  }

  static Future<List<Instansi>> fetchInstansiData() async {
    final response = await http.get(Uri.parse(Api.instansi));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Instansi.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _updateSearchQuery(String query) async {
    final data = await fetchInstansiData();
    setState(() {
      _filteredInstansi = data.where((instansi) {
        return instansi.namaInstansi.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233, 246, 255),
      appBar: AppBar(
        title: Text('Daftar Instansi Korupsi',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari Instansi',
                prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 45, 45, 45)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Instansi>>(
              future: _instansiList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else if (snapshot.hasData) {
                  if (_filteredInstansi.isEmpty && _searchController.text.isEmpty) {
                    _filteredInstansi = snapshot.data!;
                  }
                  return ListView.builder(
                    itemCount: _filteredInstansi.length,
                    itemBuilder: (context, index) {
                      var instansi = _filteredInstansi[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15.0),
                          leading: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.account_balance,
                              size: 40.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                instansi.namaInstansi,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                instansi.keterangan,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Lokasi: ${instansi.lokasi}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Tahun Korupsi: ${instansi.tahunKorupsi}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text("No data available"));
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: InstansiList(),
  ));
}
