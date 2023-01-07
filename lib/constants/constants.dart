import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  Constants._();

  static TextStyle appBarTextStyle = GoogleFonts.montserrat(fontSize: 24);
  static TextStyle haberBaslikStyle = const TextStyle(
      fontSize: 25, fontFamily: 'PlayFair', fontWeight: FontWeight.w700);
  static TextStyle sicaklik = GoogleFonts.audiowide(fontSize: 52);
  static TextStyle durum = GoogleFonts.audiowide(fontSize: 36);
  static TextStyle havaBaslik =
      GoogleFonts.audiowide(fontSize: 48, color: Colors.red);
}
