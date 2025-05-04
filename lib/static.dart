import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
