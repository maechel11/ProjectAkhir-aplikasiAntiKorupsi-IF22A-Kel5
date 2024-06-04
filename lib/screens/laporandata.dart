import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengaduanModel {
  final String id; // Add an id field
  final String name;
  final String phone;
  final String email;
  final String accusedName;
  final String accusedAddress;
  final String reportDescription;

  PengaduanModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.accusedName,
    required this.accusedAddress,
    required this.reportDescription,
  });

  factory PengaduanModel.fromJson(Map<String, dynamic> json) {
    return PengaduanModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      accusedName: json['accused_name'] ?? '',
      accusedAddress: json['accused_address'] ?? '',
      reportDescription: json['report_description'] ?? '',
    );
  }
}

class LaporanData extends StatefulWidget {
  const LaporanData({Key? key}) : super(key: key);

  @override
  State<LaporanData> createState() => _LaporanDataState();
}

class _LaporanDataState extends State<LaporanData> {
  late Future<List<PengaduanModel>> futureReports;
  List<PengaduanModel> allReports = [];
  List<PengaduanModel> filteredReports = [];

  @override
  void initState() {
    super.initState();
    futureReports = fetchDataFromDatabase();
  }

  Future<List<PengaduanModel>> fetchDataFromDatabase() async {
    final response = await http.get(Uri.parse('http://192.168.56.1/api_mobile/view_data.php'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      allReports = jsonResponse.map((report) => PengaduanModel.fromJson(report)).toList();
      filteredReports = allReports;
      return allReports;
    } else {
      throw Exception('Failed to load reports');
    }
  }

  void filterReports(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredReports = allReports;
      });
    } else {
      setState(() {
        filteredReports = allReports.where((report) {
          return report.accusedName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  Future<void> deleteReport(String reportId) async {
    final response = await http.post(
      Uri.parse('http://192.168.56.1/api_mobile/delete_report.php'),
      body: {'id': reportId},
    );

    if (response.statusCode == 200) {
      setState(() {
        filteredReports.removeWhere((report) => report.id == reportId);
      });
    } else {
      throw Exception('Failed to delete report');
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Laporan Data'),
      backgroundColor: Color.fromARGB(255, 6, 176, 223),
    ),
    body: FutureBuilder<List<PengaduanModel>>(
      future: futureReports,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search by Name',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    filterReports(query);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredReports.length,
                  itemBuilder: (context, index) {
                    PengaduanModel pengaduan = filteredReports[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      elevation: 4,
                      color: Color.fromARGB(232, 39, 213, 196), // Set light blue color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Laporan : ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red)),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => deleteReport(pengaduan.id),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text('Data Pelapor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
                            Divider(color: Colors.white),
                            SizedBox(height: 5),
                            Text('Nama: ${pengaduan.name}', style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text('Phone: ${pengaduan.phone}', style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text('Email: ${pengaduan.email}', style: TextStyle(fontSize: 16)),
                            SizedBox(height: 15),
                            Text('Data Pelaku', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
                            Divider(color: Colors.white),
                            SizedBox(height: 5),
                            Text('Nama Pelaku: ${pengaduan.accusedName}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 5),
                            Text('Lokasi : ${pengaduan.accusedAddress}', style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text('Deskripsi Korupsi: ${pengaduan.reportDescription}', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    ),
  );
}
}