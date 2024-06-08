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
  List<Faq> filteredFaqList = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    futureFaqList = EventDb.getFaq();
    futureFaqList.then((faqList) {
      setState(() {
        filteredFaqList = faqList;
      });
    });
  }

  void filterFaqs(String query) {
    futureFaqList.then((faqList) {
      setState(() {
        filteredFaqList = faqList.where((faq) {
          final questionLower = faq.pertanyaan?.toLowerCase() ?? '';
          final searchLower = query.toLowerCase();
          return questionLower.contains(searchLower);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233, 246, 255),
      appBar: AppBar(
        title: isSearching 
            ? TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white, fontSize: 18),
                onChanged: (query) => filterFaqs(query),
              )
            : Text(
                'FAQ',
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
              leading: isSearching 
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    searchController.clear();
                    filterFaqs('');
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    searchController.clear();
                    filterFaqs('');
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
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

          return ListView.builder(
            itemCount: filteredFaqList.length,
            itemBuilder: (context, index) {
              final faq = filteredFaqList[index];
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
                  leading: const Icon(Icons.question_answer, color: Color.fromARGB(255, 254, 122, 54)),
                  trailing: const Icon(
                    Icons.expand_more,
                    color: Color.fromARGB(255, 254, 122, 54),
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
