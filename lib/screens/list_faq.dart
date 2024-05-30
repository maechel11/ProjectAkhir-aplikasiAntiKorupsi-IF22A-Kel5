import 'package:flutter/material.dart';
import 'package:snow_login/event/event_db.dart';
import 'package:snow_login/model/faq.dart';
import 'package:google_fonts/google_fonts.dart';

class ListFaq extends StatefulWidget {
  const ListFaq({super.key});

  @override
  State<ListFaq> createState() => _ListFaqState();
}

class _ListFaqState extends State<ListFaq> {
  late Future<List<Faq>> futureFaqList;

  @override
  void initState() {
    super.initState();
    futureFaqList = EventDb.getFaq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ Pengecekan Pejabat Korupsi',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Aksi ketika ikon pencarian ditekan
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Faq>>(
        future: futureFaqList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No FAQs found.'));
          }

          final faqList = snapshot.data!;

          return ListView.builder(
            itemCount: faqList.length,
            itemBuilder: (context, index) {
              final faq = faqList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                child: ExpansionTile(
                  title: Text(
                    faq.pertanyaan ?? 'No Question',
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
                        faq.jawaban ?? 'No Answer',
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
