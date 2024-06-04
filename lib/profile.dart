import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snow_login/screens/laporandata.dart';
import 'package:snow_login/screens/list_faq.dart';
import 'package:snow_login/screens/pengaduan.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('../asset/images/profile.jpeg'), // Ganti dengan path gambar profil Anda
            ),
            const SizedBox(height: 20),
            Text(
              'Nama Pengguna',
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
              'user@example.com',
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
              onPressed: () {
                // Aksi saat tombol ditekan
              },
            ),
            const Divider(),
            _buildProfileButton(
              icon: Icons.notifications,
              label: 'Notifikasi',
              onPressed: () {
                // Aksi saat tombol ditekan
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
                // Aksi saat tombol ditekan
              },
            ),
            const Divider(),
            _buildProfileButton(
              icon: Icons.settings,
              label: 'Pengaturan Akun',
              onPressed: () {
                // Aksi saat tombol ditekan
              },
            ),
            const Divider(),
            _buildProfileButton(
              icon: Icons.support,
              label: 'Bantuan',
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
                // Aksi saat tombol ditekan
              },
            ),
            const Divider(),
            _buildProfileButton(
              icon: Icons.logout,
              label: 'Logout',
              onPressed: () {
                // Aksi saat tombol ditekan
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
}
