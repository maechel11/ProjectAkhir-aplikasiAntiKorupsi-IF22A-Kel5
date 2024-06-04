import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snow_login/event/event_db.dart';
import 'package:snow_login/model/tentangkami.dart';

class TentangKami extends StatefulWidget {
  const TentangKami({super.key});

  @override
  State<TentangKami> createState() => _TentangKamiState();
}

class _TentangKamiState extends State<TentangKami> {
late Future<List<Tentang>> futureTentangKami;

  @override
  void initState() {
    super.initState();
    futureTentangKami = EventDb.getTentang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentang Kami',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 6, 176, 223),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<List<Tentang>>(
        future: futureTentangKami,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('-'));
          }

          final tentangKami = snapshot.data!;

          return ListView.builder(
            itemCount: tentangKami.length,
            itemBuilder: (context, index) {
              final tentangkami = tentangKami[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                child: ExpansionTile(
                  title: Text(
                    tentangkami.judul ?? 'No Question',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        tentangkami.jawaban ?? 'No Answer',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                  leading: const Icon(Icons.question_answer, color: Colors.teal),
                  trailing: const Icon(
                    Icons.expand_more,
                    color: Colors.teal,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}