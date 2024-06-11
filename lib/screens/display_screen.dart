import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayScreen extends StatelessWidget {
  final List<dynamic> results;

  DisplayScreen({required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233, 246, 255),
      appBar: AppBar(
        title: Text('Hasil Pencarian',
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),),
        backgroundColor: Color.fromARGB(255, 40, 2, 116),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: results.isEmpty
        ? Center(
            child: Text(
              'Tidak ada data yang ditemukan.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              var result = results[index];
              return ListTile(
                leading: result['foto'] != null
                  ? Image.asset(
                      '${result['foto']}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.account_circle, size: 50),
                title: Text(result['nama'] ?? 'Nama tidak tersedia'),
                subtitle: Text('Jabatan: ${result['jabatan'] ?? 'Jabatan tidak tersedia'}'),
                trailing: IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Detail Kasus'),
                        content: Text('Kasus: ${result['kasus'] ?? 'Detail kasus tidak tersedia'}'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Tutup'),
                            onPressed: () {
                              Navigator.of(ctx).pop();  
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
    );
  }
}
