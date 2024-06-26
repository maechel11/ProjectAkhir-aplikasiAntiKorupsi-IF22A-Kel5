import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snow_login/model/peta_korupsi.dart';  
import '../config/api.dart';

class PetaKorupsi extends StatefulWidget {
  const PetaKorupsi({Key? key}) : super(key: key);

  @override
  State<PetaKorupsi> createState() => _PetaKorupsiState();
}

class _PetaKorupsiState extends State<PetaKorupsi> {
  late Future<List<CorruptionCase>> corruptionCases;
  List<CorruptionCase> filteredCases = [];
  String searchQuery = '';

  Future<List<CorruptionCase>> fetchCorruptionCases() async {
    final response = await http.get(Uri.parse(Api.petaKorupsi));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => CorruptionCase.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    corruptionCases = fetchCorruptionCases();
    corruptionCases.then((cases) {
      setState(() {
        filteredCases = cases;
      });
    });
  }

  void updateSearchQuery(String newQuery) {
    corruptionCases.then((cases) {
      setState(() {
        searchQuery = newQuery;
        filteredCases = cases.where((caseData) {
          return caseData.provinsiName
                  .toLowerCase()
                  .contains(newQuery.toLowerCase()) ||
              caseData.kotaName
                  .toLowerCase()
                  .contains(newQuery.toLowerCase()) ||
              caseData.pelakuName
                  .toLowerCase()
                  .contains(newQuery.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Color.fromARGB(255,233, 246, 255),
    appBar: AppBar(
            title: Text(
              'Data Korupsi',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 40, 2, 116) ,
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
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Color.fromARGB(255,233, 246, 255),
            child: TextField(
              onChanged: (value) {
                updateSearchQuery(value);
              },
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                hintText: 'Cari',
                hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CorruptionCase>>(
              future: corruptionCases,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  List<CorruptionCase> cases = filteredCases;
                  Map<String, Map<String, List<String>>> dataMap = {};

                  for (var caseData in cases) {
                    if (!dataMap.containsKey(caseData.provinsiName)) {
                      dataMap[caseData.provinsiName] = {};
                    }
                    if (!dataMap[caseData.provinsiName]!
                        .containsKey(caseData.kotaName)) {
                      dataMap[caseData.provinsiName]![caseData.kotaName] = [];
                    }
                    dataMap[caseData.provinsiName]![caseData.kotaName]!
                        .add(caseData.pelakuName);
                  }

                  return ListView.builder(
                    itemCount: dataMap.keys.length,
                    itemBuilder: (context, provinsiIndex) {
                      String provinsiName =
                          dataMap.keys.elementAt(provinsiIndex);
                      Map<String, List<String>> kabupatenKota =
                          dataMap[provinsiName]!;
                      return ExpansionTile(
                        title: Text(provinsiName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 254, 122, 54))),
                        children: kabupatenKota.keys.map((kotaName) {
                          List<String> pelakuList = kabupatenKota[kotaName]!;
                          return ExpansionTile(
                            title: Text(kotaName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            children: pelakuList.map((pelaku) {
                              return InkWell(
                                onTap: () {
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.account_balance,
                                          size: 40, color: Color.fromARGB(255, 254, 122, 54)),
                                      const SizedBox(width: 8.0),
                                      Text(pelaku),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      );
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
  runApp(const MaterialApp(
    home: PetaKorupsi(),
  ));
}
