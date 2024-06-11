import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:snow_login/screens/instansi.dart';
import 'package:snow_login/screens/pengaduan.dart';
import 'package:snow_login/screens/peta_korupsi.dart';
import 'package:snow_login/screens/profile_pejabat.dart';
import 'package:snow_login/screens/tentang_kami.dart';
import 'package:snow_login/screens/uud.dart';
import 'berita_viral.dart';
import 'display_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  void _navigateAndDisplaySearch(BuildContext context) async {
    final String typedText = _controller.text;
    final response = await http.get(Uri.parse('http://localhost/api_mobile/search.php?term=$typedText'));

    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(response.body);
      if (results.isEmpty) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Pencarian Tidak Ditemukan'),
            content: Text('Tidak ada data yang sesuai dengan kata kunci yang Anda masukkan.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DisplayScreen(results: results)),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load data: ${response.statusCode}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("../asset/images/banner.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 11.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Cari...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                            ),
                            onSubmitted: (value) => _navigateAndDisplaySearch(context),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => _navigateAndDisplaySearch(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BuildCustomIconButton('Data Korupsi', '../asset/images/petakorupsi.jpeg', PetaKorupsi(), context),
                    SizedBox(width: 10),
                    BuildCustomIconButton('Pengaduan', '../asset/images/faq.jpeg', Pengaduan(), context),
                    SizedBox(width: 10),
                    BuildCustomIconButton('Profile Pejabat', '../asset/images/profilepejabat.jpeg', ProfilePejabat(), context),
                    SizedBox(width: 10),
                    BuildCustomIconButton('Instansi', '../asset/images/instansi.jpeg', InstansiList(), context),
                    SizedBox(width: 10),
                    BuildCustomIconButton('UUD', '../asset/images/uud.jpeg', UUD(), context),
                    SizedBox(width: 10),
                    BuildCustomIconButton('Tentang Kami', '../asset/images/aboutme.jpeg', TentangKami(), context),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 10),
            CarouselSlider(
              items: [
                BeritaTerkini(
                    '../asset/images/K1.webp',
                    'Korupsi adalah musuh bersama, mari lawan dengan integritas',
                    ''),
                BeritaTerkini(
                    '../asset/images/K2.webp',
                    'Korupsi menghancurkan masa depan, mari cegah sekarang',
                    ''),
                BeritaTerkini(
                    '../asset/images/K3.webp',
                    'Dengan integritas, kita bisa melawan korupsi',
                    ''),
                BeritaTerkini(
                    '../asset/images/K4.webp',
                    'Korupsi menghancurkan mimpi, berantas demi generasi mendatang',
                    ''),
                BeritaTerkini(
                    '../asset/images/K5.webp',
                    'Korupsi adalah racun bagi bangsa, mari bersihkan bersama',
                    ''),
              ],
              options: CarouselOptions(
                height: 180,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Berita Viral",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: BeritaList(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class BeritaTerkini extends StatelessWidget {
  final String img;
  final String judul;
  final String tanggal;

  BeritaTerkini(this.img, this.judul, this.tanggal);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                judul,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget BuildCustomIconButton(String text, String imagePath, Widget view, BuildContext context) {
  return GestureDetector(
    onTap: () {
      navigateToView(view, context);
    },
    child: Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal[300],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

void navigateToView(Widget view, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => view),
  );
}
