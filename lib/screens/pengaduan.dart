import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api.dart';

class Pengaduan extends StatefulWidget {
  const Pengaduan({Key? key}) : super(key: key);

  @override
  State<Pengaduan> createState() => _PengaduanState();
}

class _PengaduanState extends State<Pengaduan> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _accusedNameController = TextEditingController();
  final _accusedAddressController = TextEditingController();
  final _reportDescriptionController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text;
      final phone = _phoneController.text;
      final email = _emailController.text;
      final date = _dateController.text;
      final accusedName = _accusedNameController.text;
      final accusedAddress = _accusedAddressController.text;
      final reportDescription = _reportDescriptionController.text;

      try {
        final response = await http.post(
          Uri.parse(Api.report),
          body: jsonEncode({
            'name': name,
            'phone': phone,
            'email': email,
            'date': date,
            'accusedName': accusedName,
            'accusedAddress': accusedAddress,
            'reportDescription': reportDescription,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Laporan berhasil disampaikan!')),
          );
          _clearFields();
        } else {
          final responseData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengirim laporan: ${responseData["message"]}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim laporan: $e')),
        );
      }
    }
  }

  void _clearFields() {
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _dateController.clear();
    _accusedNameController.clear();
    _accusedAddressController.clear();
    _reportDescriptionController.clear();
  }

  Future<void> _showConfirmationDialog() async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin bahwa semua data yang diisi adalah benar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Ya'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
          ),
        ],
      ),
    );

    if (isConfirmed == true) {
      _submitForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaduan Korupsi'),
        backgroundColor: Color.fromARGB(255, 6, 176, 223),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'Data Pelapor',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 10),
              _buildTextFormField(_nameController, 'Nama', 'Silakan masukkan nama Anda'),
              SizedBox(height: 10),
              _buildTextFormField(_phoneController, 'Telepon', null, keyboardType: TextInputType.phone),
              SizedBox(height: 10),
              _buildTextFormField(_emailController, 'Email', 'Silakan masukkan alamat email Anda', keyboardType: TextInputType.emailAddress),
              SizedBox(height: 20),
              Text(
                'Data Pelaku',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 10),
              _buildTextFormField(_accusedNameController, 'Nama Pelaku Korupsi', 'Silakan masukkan nama pelaku korupsi'),
              SizedBox(height: 10),
              _buildTextFormField(_accusedAddressController, 'Lokasi', 'Silakan masukkan Lokasi Terjadinya Korupsi', maxLines: 2),
              SizedBox(height: 10),
              _buildTextFormField(_reportDescriptionController, 'Deskripsi Korupsi', 'Silakan masukkan deskripsi korupsi', maxLines: 4),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showConfirmationDialog,
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  textStyle: TextStyle(fontSize: 18),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label, String? errorMessage, {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (errorMessage != null && (value == null || value.isEmpty)) {
          return errorMessage;
        }
        if (label == 'Email' && value != null && !value.contains('@')) {
          return 'Alamat email tidak valid';
        }
        return null;
      },
    );
  }
}
