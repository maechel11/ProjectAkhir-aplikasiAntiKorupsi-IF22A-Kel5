import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:snow_login/screens/instansi.dart';
import 'package:snow_login/screens/laporandata.dart';
import 'package:snow_login/screens/list_faq.dart';
import 'package:snow_login/screens/pengaduan.dart';
import 'package:snow_login/screens/peta_korupsi.dart';
import 'package:snow_login/screens/profile_pejabat.dart';
import 'package:snow_login/screens/tentang_kami.dart';
import 'package:snow_login/screens/uud.dart';
import 'berita_viral.dart';




class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
           
            
              Padding(
                padding: const EdgeInsets.only(left: 0),
  
                child: Expanded(
                  child: 
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("../asset/images/petakorupsi.jpeg"),
                    fit: BoxFit.cover, // Atur sesuai kebutuhan Anda
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), // Ubah nilai opacity sesuai keinginan untuk membuat gambar menjadi redup
                      BlendMode.darken, // Mode blending yang membuat gambar menjadi redup
                    ),
                  ),
                ),

                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Aplikasi Pengecekan dan Pelaporan',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: Colors.white.withOpacity(0.3),
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Korupsi di Indonesia',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Georgia',
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
                  ),
                ),
              ),
               SizedBox(
                          height: 15,
                        ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Cari...',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // Implement search functionality here
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        // Implement filter functionality here
                      },
                    ),
                  ),
                ],
              ),
            ),
            // p
            Container(
            padding: EdgeInsets.only(top: 25, bottom: 10, left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildCustomIconButton('Peta Korupsi', '../asset/images/petakorupsi.jpeg', PetaKorupsi(), context),
                    BuildCustomIconButton('Pengaduan', '../asset/images/faq.jpeg', Pengaduan(), context),
                    BuildCustomIconButton('Profile Pejabat', '../asset/images/profilepejabat.jpeg',ProfilePejabat(),  context),
                    BuildCustomIconButton('Instansi', '../asset/images/instansi.jpeg', Instansi(), context),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildCustomIconButton('Laporan Data', '../asset/images/laporan.jpeg',LaporanData(),  context),
                    BuildCustomIconButton('UUD', '../asset/images/uud.jpeg',UUD(),  context),
                    BuildCustomIconButton('FAQ', '../asset/images/pelaporan.jpeg',ListFaq(),  context),
                    BuildCustomIconButton('Tentang Kami', '../asset/images/aboutme.jpeg',TentangKami(),  context),
                  ],
                ),
              ],
            ),
          ),
                SizedBox(
                  height: 15,
                ),
                // slider
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text("Berita/Artikel", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: 170,
            child: ListView(
              children: [
                CarouselSlider(
                  items: [
                    BeritaTerkini(
                        '../asset/images/maxresdefault.jpeg', 
                        'Kasus Korupsi PT Timah Gapai 271 Triliun', 
                        'Tanggal 1'),
                    BeritaTerkini(
                        '../asset/images/kasusKorup.png', 
                        'Kasus Korupsi Terbesar di Indonesia: Sorotan Skandal Harvey Moeis', 
                        'Tanggal 2'),
                    BeritaTerkini(
                        '../asset/images/mentriKorup.webp', 
                        'INFOGRAFIK: Deretan Menteri Indonesia yang Terjerat Kasus Korupsi', 
                        'Tanggal 3'),
                    BeritaTerkini(
                        '../asset/images/Korupsi3.jpeg', 
                        'Ketua KPK Ungkap 26 Provinsi Terlibat Korupsi, Jabar Paling Banyak', 
                        'Tanggal 4'),
                    BeritaTerkini(
                        '../asset/images/Korupsi1.webp', 
                        'Menggugah Kesadaran: Memahami Dampak dan Bahaya Korupsi', 
                        'Tanggal 5'),
                  ], 
                  options: CarouselOptions(
                    height: 170,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16/9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8
                  ),
                )
              ],
            ),
          ),
          
                // end slider
                SizedBox(
                  height: 15,
                ),
                
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text("Berita Viral", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: 300,
            child: 
          BeritaList()
          )

          // berita viral

          // berita viral end
                
              ],
            ),
            )
        
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
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.transparent,
                  ],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  stops: [0.1, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    judul,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    tanggal,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      // alignment: Alignment(1, 1),
    );
  }
  
}

List<Map> _fragment = [
  {'title': 'Data Mahasiswa', 'View': PetaKorupsi()},
  {'title': 'Data Dosen', 'View': Pengaduan()},
  {'title': 'Data Dosen', 'View': ProfilePejabat()},
  {'title': 'Data Dosen', 'View': Instansi()},
  {'title': 'Data Dosen', 'View': LaporanData()},
  {'title': 'Data Dosen', 'View': UUD()},
  {'title': 'Data Dosen', 'View': ListFaq()},
  {'title': 'Data Dosen', 'View': TentangKami()},
];

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
            borderRadius: BorderRadius.circular(5),
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
          child: Image.asset(
            imagePath,
            width: 50, // Sesuaikan ukuran gambar sesuai kebutuhan
            height: 50,
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
