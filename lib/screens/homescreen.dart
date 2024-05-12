import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snow_login/utils/info.dart';



class homescreen extends StatefulWidget {
  final String? imagePath;
  final String? judul;
  final String? tanggal;
   final List<Berita> beritaList = [
    Berita(
      '../assets/images/', // Ubah path sesuai dengan lokasi gambar di folder asset
      'Universitas Teknokrat Indonesia',
      'Tanggal 1',
    ),
    Berita(
      'assets/images/berita2.jpg', // Ubah path sesuai dengan lokasi gambar di folder asset
      'Judul Berita 2',
      'Tanggal 2',
    ),
    Berita(
      'assets/images/berita3.jpg', // Ubah path sesuai dengan lokasi gambar di folder asset
      'Judul Berita 3',
      'lampung berduka, denganskdjadjajdfhkjasfajbfajk djassndadj',
    ),
    Berita(
      'assets/images/berita4.jpg', // Ubah path sesuai dengan lokasi gambar di folder asset
      'Judul Berita 4',
      'Tanggal 4',
    ),
    Berita(
      'assets/images/berita5.jpg', // Ubah path sesuai dengan lokasi gambar di folder asset
      'Judul Berita 5',
      'Tanggal 5',
    ),
  ];

   homescreen({
    Key? key,
    this.imagePath,
    this.judul,
    this.tanggal,
  }) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}


class _homescreenState extends State<homescreen> {
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
            Padding( 
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Handle button tap
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  minimumSize: Size(80, 80),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
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
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        '../asset/images/petakorupsi.jpeg', 
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Jarak antara Tombol dan Text
                              Text(
                                'Peta Korupsi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                        ),
                        
                        SizedBox(
                          width: 40,
                        ),

                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Handle button tap
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  minimumSize: Size(80, 80),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
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
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        '../asset/images/faq.jpeg', 
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Jarak antara Tombol dan Text
                              Text(
                                'Pengaduan',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                        ),

                        SizedBox(
                          width: 40,
                        ),

                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Handle button tap
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  minimumSize: Size(80, 80),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
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
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        '../asset/images/profilepejabat.jpeg', 
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Jarak antara Tombol dan Text
                              Text(
                                'Profile Pejabat',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                        ),

                        SizedBox(
                          width: 40,
                        ),

                        Column(
                                                    children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Handle button tap
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  minimumSize: Size(80, 80),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
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
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        '../asset/images/instansi.jpeg', 
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Jarak antara Tombol dan Text
                              Text(
                                'Instansi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                        ),

                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 25,
                    ),

                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                                                    children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Handle button tap
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  minimumSize: Size(80, 80),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
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
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        '../asset/images/laporan.jpeg', 
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Jarak antara Tombol dan Text
                              Text(
                                'Laporan Data',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                        ),

                        SizedBox(
                          width: 40,
                        ),

                        Column(
                            children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Handle button tap
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  minimumSize: Size(80, 80),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
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
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        '../asset/images/uud.jpeg', 
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Jarak antara Tombol dan Text
                              Text(
                                'UUD',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                        ),

                        SizedBox(
                          width: 40,
                        ),

                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Handle button tap
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  minimumSize: Size(80, 80),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
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
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        '../asset/images/pelaporan.jpeg', 
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Jarak antara Tombol dan Text
                              Text(
                                'FAQ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                        ),

                        SizedBox(
                          width: 40,
                        ),

                        Column(
                            children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Handle button tap
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  minimumSize: Size(80, 80),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
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
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        '../asset/images/aboutme.jpeg', 
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5), // Jarak antara Tombol dan Text
                              Text(
                                'Tentang Kami',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                        ),
                        
                      ],
                    ),
                  ],
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
                        '../asset/images/', 
                        'Judul 4', 
                        'Tanggal 4'),
                    BeritaTerkini(
                        '../asset/images/', 
                        'Judul 5', 
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



