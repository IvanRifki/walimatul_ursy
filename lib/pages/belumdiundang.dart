import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BelumDiundangPage extends StatelessWidget {
  const BelumDiundangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                color: Colors.grey[600],
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                'Belum Diundang',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[900],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Mohon maaf, halaman ini hanya dapat diakses oleh tamu undangan resmi.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
