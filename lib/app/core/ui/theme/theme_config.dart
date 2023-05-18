import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class ThemeConfig {
  ThemeConfig._();

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.quicksandTextTheme(),
        primarySwatch: AppColors.primary,
        appBarTheme: AppBarTheme(
          color: AppColors.primary.shade500,
          titleTextStyle: GoogleFonts.quicksand(
            color: AppColors.white.shade500,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            letterSpacing: 4,
          ),
          iconTheme: IconThemeData(
            color: AppColors.white.shade500,
          ),
          elevation: 2,
          centerTitle: false,
        ),
        sliderTheme: const SliderThemeData().copyWith(
          valueIndicatorColor: AppColors.primary.shade500,
          valueIndicatorTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: AppColors.black.shade500,
          ),
          floatingLabelStyle: TextStyle(
            color: AppColors.primary.shade500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.black.shade500),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.black.shade500),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primary.shade500),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary.shade500,
            foregroundColor: AppColors.white,
            textStyle: GoogleFonts.quicksand(),
          ),
        ),
        scaffoldBackgroundColor: AppColors.primary.shade100,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.white.shade100,
          elevation: 8,
          indicatorColor: AppColors.primary,
          iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
            (value) {
              if (value.contains(MaterialState.selected)) {
                return const IconThemeData(
                  color: AppColors.white,
                );
              }
              return const IconThemeData(
                color: AppColors.black,
              );
            },
          ),
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (value) {
              if (value.contains(MaterialState.selected)) {
                return GoogleFonts.quicksand(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                );
              }
              return GoogleFonts.quicksand(
                color: AppColors.black,
              );
            },
          ),
        ),
        useMaterial3: true,
      );
}
