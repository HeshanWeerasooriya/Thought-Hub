import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        secondary: secondaryColorLightTheme,
        primary: primaryColor,
      ),
  appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
  inputDecorationTheme: const InputDecorationTheme(
    border: textFieldOutlineInputBorderLightTheme,
    enabledBorder: textFieldOutlineInputBorderLightTheme,
    focusedBorder: textFieldOutlineInputBorderLightTheme,
  ),
  textSelectionTheme: TextSelectionThemeData(
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
  appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    border: textFieldOutlineInputBorderDarkTheme,
    enabledBorder: textFieldOutlineInputBorderDarkTheme,
    focusedBorder: textFieldOutlineInputBorderDarkTheme,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.amber,
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
        Radius.circular(defaultBorderRadius),
      ),
    ),
  ),
);
