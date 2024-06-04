import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snow_login/model/uud.dart'; // Pastikan path model sudah benar
import '../config/api.dart';

class UUD extends StatefulWidget {
  const UUD({Key? key}) : super(key: key);

  @override
  State<UUD> createState() => _UUDState();
}

class _UUDState extends State<UUD> {
  late Future<List<Uud>> _uudList;
  List<Uud> _filteredUudList = [];
  List<Uud> _fullUudList = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _uudList = fetchUudList();
    _searchController.addListener(_onSearchChanged);
  }

  Future<List<Uud>> fetchUudList() async {
    final response =
        await http.get(Uri.parse(Api.uud));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Uud> uudList = jsonResponse.map((uud) => Uud.fromJson(uud)).toList();
      setState(() {
        _fullUudList = uudList;
        _filteredUudList = uudList;
      });
      return uudList;
    } else {
      throw Exception('Failed to load UUD');
    }
  }

  void _onSearchChanged() {
    List<Uud> results = [];
    if (_searchController.text.isEmpty) {
      results = _fullUudList;
    } else {
      results = _fullUudList
          .where((uud) =>
              uud.title
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              uud.shortDescription
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              uud.fullDescription
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredUudList = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar UUD Korupsi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Uud>>(
              future: _uudList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: _filteredUudList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10.0),
                        elevation: 4, // Add elevation for a shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          title: Text(
                            _filteredUudList[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                  height: 4.0), // Add spacing between elements
                              Text(
                                _filteredUudList[index].shortDescription,
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 8.0), // Add more spacing
                              Text(
                                _filteredUudList[index].fullDescription,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: const Color.fromARGB(255, 33, 33, 33),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Navigasi ke halaman detail UUD
                          },
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
