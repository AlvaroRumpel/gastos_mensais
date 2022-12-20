import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastos_mensais/pages/main_page.dart';
import 'package:gastos_mensais/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gastos Mensais',
      theme: ThemeData(
        fontFamily: GoogleFonts.quicksand().fontFamily,
        primarySwatch: AppColors.white,
        appBarTheme: AppBarTheme(
          color: AppColors.primary.shade500,
          titleTextStyle: GoogleFonts.quicksand(
            color: AppColors.white.shade500,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            letterSpacing: 4,
          ),
          centerTitle: false,
        ),
        sliderTheme: const SliderThemeData().copyWith(
          valueIndicatorColor: AppColors.primary.shade500,
          valueIndicatorTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: AppColors.primary.shade100,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
