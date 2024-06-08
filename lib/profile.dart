import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snow_login/screens/edit_profile.dart';
import 'package:snow_login/screens/laporandata.dart';
import 'package:snow_login/screens/list_faq.dart';
import 'package:snow_login/screens/login_screen.dart';
import 'package:snow_login/model/user.dart';
import 'package:snow_login/screens/syarat_dan_ketentuan.dart';
import 'package:snow_login/screens/umpan_balik.dart'; 

class Profile extends StatefulWidget {
  final User user;

  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String _username;
  late String _email;

  @override
  void initState() {
    super.initState();
    _username = widget.user.userName ?? 'Nama Pengguna';
    _email = widget.user.email ?? 'user@example.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233, 246, 255),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('../asset/images/profile.jpeg'),
            ),
            const SizedBox(height: 20),
            Text(
              _username,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _email,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileButton(
              icon: Icons.edit,
              label: 'Edit Profile',
              onPressed: () async {
                Map<String, String?> result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      userId: widget.user.idUser!,
                      username: _username,
                      email: _email,
                    ),
                  ),
                );

                if (result.isNotEmpty) {
                  setState(() {
                    _username = result['username'] ?? _username;
                    _email = result['email'] ?? _email;
                  });
                }
              },
            ),
           
            const Divider(),
            _buildProfileButton(
              icon: Icons.history,
              label: 'Riwayat Pengaduan',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LaporanData()),
                );
              },
            ),
           
            const Divider(),
            _buildProfileButton(
              icon: Icons.support,
              label: 'FaQ',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListFaq()),
                );
              },
            ),
            const Divider(),
            _buildProfileButton(
              icon: Icons.feedback,
              label: 'Umpan Balik',
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UmpanBalik()),
                );
              },
            ),
            
            const Divider(),
            _buildProfileButton(
              icon: Icons.pages,
              label: 'Syarat dan ketentuan',
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SyaratDanKetentuan()),
                );
              },
            ),
            const Divider(),
            _buildProfileButton(
              icon: Icons.logout,
              label: 'Logout',
              onPressed: () {
                _logout();
              },
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildProfileButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black),
      label: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
