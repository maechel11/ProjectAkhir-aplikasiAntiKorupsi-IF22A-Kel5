import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/penggelapan.dart';
import './screens/penyuapan.dart';
import './screens/kerugian_keuangan_negara.dart';
import './screens/gratifikasi.dart';
import './screens/pemerasan.dart';
import './screens/perbuatan_curang.dart';

class Kategori extends StatefulWidget {
  const Kategori({Key? key}) : super(key: key);

  @override
  State<Kategori> createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  final List<Map<String, String>> categories = [
    {'name': 'Penggelapan', 'image': '../asset/images/penggelapan2.jpg'},
    {'name': 'Penyuapan', 'image': '../asset/images/penyuapan2.jpg'},
    {
      'name': 'Kerugian Keuangan Negara',
      'image': '../asset/images/kerugian_negara2.jpg'
    },
    {'name': 'Gratifikasi', 'image': '../asset/images/gratifikasi3.jpg'},
    {'name': 'Pemerasan', 'image': '../asset/images/pemerasan2.jpg'},
    {
      'name': 'Perbuatan Curang',
      'image': '../asset/images/perbuatan_curang2.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233, 246, 255),
      appBar: AppBar(
        title:  Text('Kategori Korupsi',  
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),),
       backgroundColor: Color.fromARGB(255, 40, 2, 116),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: const EdgeInsets.all(8.0),
              ),
              onPressed: () {
                navigateToScreen(categories[index]['name']!);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      categories[index]['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    categories[index]['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateToScreen(String categoryName) {
    switch (categoryName) {
      case 'Penggelapan':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Penggelapan()),
        );
        break;
      case 'Penyuapan':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Penyuapan()),
        );
        break;
      case 'Kerugian Keuangan Negara':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const KerugianKeuanganNegara()),
        );
        break;
      case 'Gratifikasi':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Gratifikasi()),
        );
        break;
      case 'Pemerasan':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Pemerasan()),
        );
        break;
      case 'Perbuatan Curang':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PerbuatanCurang()),
        );
        break;
      default:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(categoryName),
              content: Text('Kategori: $categoryName'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
    }
  }
}
