import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        secondary: secondaryColorLightTheme,
        primary: primaryColor,
      ),
  textTheme: GoogleFonts.openSansTextTheme(ThemeData.light().textTheme)
      .copyWith(bodyText2: const TextStyle(color: textColorLightTheme)),
  appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
  inputDecorationTheme: const InputDecorationTheme(
    border: textFieldOutlineInputBorderLightTheme,
    enabledBorder: textFieldOutlineInputBorderLightTheme,
    focusedBorder: textFieldOutlineInputBorderLightTheme,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.amber,
  ),
  elevatedButtonTheme: elevatedButtonThemeData,
);

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: primaryColor,
        secondary: secondaryColorDarkTheme,
      ),
  textTheme: GoogleFonts.openSansTextTheme(ThemeData.dark().textTheme)
      .copyWith(bodyText2: const TextStyle(color: textColorDarkTheme)),
  appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    border: textFieldOutlineInputBorderDarkTheme,
    enabledBorder: textFieldOutlineInputBorderDarkTheme,
    focusedBorder: textFieldOutlineInputBorderDarkTheme,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: textColorDarkTheme,
  ),
  elevatedButtonTheme: elevatedButtonThemeData,
);

const textFieldOutlineInputBorderLightTheme = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
  borderSide: BorderSide(
    color: Color(0xFFE7E9EC),
  ),
);

final textFieldOutlineInputBorderDarkTheme =
    textFieldOutlineInputBorderLightTheme.copyWith(
  borderSide: const BorderSide(
    color: bodyTextColorDarkTheme,
  ),
);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: TextButton.styleFrom(
    backgroundColor: primaryColor,
    padding: const EdgeInsets.all(defaultPadding),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(defaultBorderRadius * 5),
      ),
    ),
  ),
);
