import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class TextStyles {
  static final title = GoogleFonts.poppins(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: AppColors.black500,
  );

  static final primaryStyleFont = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.grey300,
  );

  static final smallFont = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.red600,
  );

  static final fontInnerPrimaryButton = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 2,
  );

  static final fontInnerGoogleButton = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black600,
    letterSpacing: 2,
  );
}
