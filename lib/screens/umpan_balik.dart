import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UmpanBalik extends StatefulWidget {
  @override
  _UmpanBalikState createState() => _UmpanBalikState();
}

class _UmpanBalikState extends State<UmpanBalik> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 246, 255),
      appBar: AppBar(
        title: Text(
          'Umpan Balik',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 40, 2, 116),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Berikan Umpan Balik Anda',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, 
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tulis umpan balik Anda di sini...',
                  hintStyle:TextStyle(
                  color: Color.fromARGB(255, 254, 122, 54),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Umpan balik tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Umpan balik terkirim')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Kirim',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 40, 2, 116), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
