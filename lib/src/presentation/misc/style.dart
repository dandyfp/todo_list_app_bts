import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;

import 'package:todo_list_app_bts/src/presentation/misc/constant.dart';

// TextStyle
// Regular - 400
// Medium - 500
// SemiBold - 600
// Bold - 700

TextStyle blackRegularTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

TextStyle blackMediumTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

TextStyle blackSemiBoldTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

TextStyle blackBoldTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

TextStyle whiteRegularTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: ghostWhite,
);

TextStyle whiteMediumTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: ghostWhite,
);

TextStyle whiteSemiBoldTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w600,
  color: ghostWhite,
);

TextStyle whiteBoldTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
  color: ghostWhite,
);

Widget showLoading = Platform.isIOS
    ? const CupertinoActivityIndicator()
    : const CircularProgressIndicator();

Widget showLoadingWhite = Platform.isIOS
    ? const CupertinoActivityIndicator(color: ghostWhite)
    : const CircularProgressIndicator(color: ghostWhite);
