import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:snow_login/config/api.dart';

class ProfilePejabat extends StatefulWidget {
  const ProfilePejabat({Key? key}) : super(key: key);

  @override
  State<ProfilePejabat> createState() => _ProfilePejabatState();
}

class _ProfilePejabatState extends State<ProfilePejabat> {
  List _pejabat = [];
  List _filteredPejabat = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(Api.pejabat));
    if (response.statusCode == 200) {
      setState(() {
        _pejabat = json.decode(response.body);
        _filteredPejabat = List.from(_pejabat);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _searchPejabat(String query) {
    query = query.toLowerCase(); // Ubah query menjadi huruf kecil
    setState(() {
      _filteredPejabat = _pejabat.where((pejabat) {
        final nama = pejabat['nama'].toLowerCase(); // Gunakan nama yang telah diubah ke huruf kecil
        final jabatan = pejabat['jabatan'].toLowerCase(); // Gunakan jabatan yang telah diubah ke huruf kecil
        final kasus = pejabat['kasus'].toLowerCase(); // Gunakan kasus yang telah diubah ke huruf kecil
        return nama.contains(query) || jabatan.contains(query) || kasus.contains(query);
      }).toList();
    });

    print('Filtered Pejabat: $_filteredPejabat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pejabat Terlibat Korupsi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchPejabat,
              decoration: InputDecoration(
                labelText: 'Cari Nama / Jabatan / Kasus',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _filteredPejabat.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredPejabat.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            leading: Container(
                              width: 70,  // Increased width
                              height: 150, // Increased height
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage(_filteredPejabat[index]['foto']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              _filteredPejabat[index]['nama'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _filteredPejabat[index]['jabatan'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Kasus: ${_filteredPejabat[index]["kasus"]}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
