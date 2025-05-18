import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> sampleImages = [
  'assets/weddingassets/pwfoto/pw9.jpg',
  'assets/weddingassets/pwfoto/pw1.jpg',
  'assets/weddingassets/pwfoto/pw8.jpg',
  'assets/weddingassets/pwfoto/pw2.jpg',
  'assets/weddingassets/pwfoto/pw3.jpg',
  'assets/weddingassets/pwfoto/pw4.jpg',
  'assets/weddingassets/pwfoto/pw5.jpg',
  'assets/weddingassets/pwfoto/pw6.jpg',
  'assets/weddingassets/pwfoto/pw7.jpg',
];

Text TeksBiasa(String text, BuildContext context) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: MediaQuery.of(context).size.width * 0.03,
      color: Colors.brown[900],
    ),
  );
}

Text TeksBiasaBold(String text, BuildContext context) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: MediaQuery.of(context).size.width * 0.03,
      fontWeight: FontWeight.bold,
      color: Colors.brown[900],
    ),
  );
}

Text TeksWaktuBold(String text, BuildContext context) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.bold,
      color: Colors.brown[900],
    ),
  );
}

Text TeksNamaPengantin(String text, BuildContext context) {
  return Text(
    text,
    style: GoogleFonts.msMadi(
      fontSize: MediaQuery.of(context).size.width * 0.1,
      fontWeight: FontWeight.bold,
      color: Colors.brown[700],
    ),
  );
}

// Function
Future<void> updateSouvenirStatus(int row, String status) async {
  final url = Uri.parse(
      'https://script.google.com/macros/s/AKfycbw3frcqFCwJiPkxBJ5yTmuu5mDLp7qhQZPMQoQglbrUbzLlxdDTbAQ7-jqySyPJ3DHS/exec'); // Ini URL APP SCRIPT

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "row": row,
      "status": status,
    }),
  );

  if (response.statusCode == 200) {
    print("✅ Sukses: ${response.body}");
  } else {
    print("❌ Gagal update: ${response.statusCode}");
  }
}

Future fetchSheetDataPlain(String guestName) async {
  final response = await http.get(
    Uri.parse(
      'https://opensheet.elk.sh/1IFycFK3i-AzaZepz0C03dpkoMxemwrBQ45WjwKYVmEU/TamuUndanganwithCode',
    ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<Map<String, dynamic>> sheetDataTamu =
        data.cast<Map<String, dynamic>>();

    final foundGuest = sheetDataTamu.firstWhere(
      (item) => item['Kode Undangan'].toString() == guestName,
      orElse: () => {},
    );

    // foundGuest.isEmpty ? 'kosong' : foundGuest;
    if (foundGuest.isEmpty) {
      return 'kosong';
    } else {
      print('Souvenirnya bang: ${foundGuest['Souvenir']}');

      return foundGuest;
    }

    // return foundGuest;

    // if (foundGuest.isEmpty) {
    //   // Redirect ke halaman lain kalau tidak ditemukan
    //   if (mounted) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (_) => BelumDiundangPage()), // ganti sesuai halamanmu
    //     );
    //   }
    //   return;
    // }

    //   setState(() {
    //     guestCode = foundGuest['Kode Undangan'];
    //     guestNameAfterDecode =
    //         '${foundGuest['Title']} ${foundGuest['Nama Undangan']}';
    //     isLoading = false;
    //   });
    // } else {
    //   setState(() {
    //     guestNameAfterDecode = '';
    //     isLoading = false;
    //   });
  }
}
