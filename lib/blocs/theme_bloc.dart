import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../interfaces/bloc_interface.dart';
import '../pages/theme_page.dart';
import '../router.dart';
import 'voice_bloc.dart';

final blocTheme = BlocTheme();

class BlocTheme extends Bloc {
  @override
  BlocTheme() {
    voiceBloc.addCommand('changeTheme', () {
      setRandomThemeData();
    });
    defaultTheme();
    AppRoutes.addRoute('theme', const ThemePage());
    voiceBloc.addCommand('goTheme', () {
      AppRoutes.routeTo('theme');
    });
  }

  final _themeDataController = BehaviorSubject<ThemeData>();

  set themeData(ThemeData themeDataTmp) {
    _themeDataController.sink.add(themeDataTmp);
  }

  ThemeData get themeData => _themeDataController.value;

  Stream<ThemeData> get themeDataStream => _themeDataController.stream;

  @override
  dispose() {
    _themeDataController.close();
  }

  int _index = 0;
  MaterialColor materialColor = Colors.purple;

  final materialColorList = <MaterialColor>[
    Colors.orange,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  void changeThemeDataColor() {
    _index = _index + 1;
    if (_index >= materialColorList.length) {
      _index = 0;
    }
    materialColor = materialColorList[_index];
    themeData = ThemeData(primarySwatch: materialColor);
  }

  Color colorRandom() {
    return ThemeHelpers.colorRandom();
  }

  bool validateHexColor(String colorHex) {
    return ThemeHelpers.validateHexColor(colorHex);
  }

  ThemeData themeDataFromMaterialColor(MaterialColor materialColorTmp) {
    materialColor = materialColorTmp;
    return ThemeData(primarySwatch: materialColorTmp);
  }

  void setRandomThemeData() {
    final Color randomColor = colorRandom();
    materialColor = ThemeHelpers.materialColorFromRGB(
        randomColor.red, randomColor.green, randomColor.blue);
    themeData = themeDataFromMaterialColor(materialColor);
  }

  void setThemeFromRGB(int r, int g, int b) {
    materialColor = ThemeHelpers.materialColorFromRGB(r, g, b);
    themeData = themeDataFromMaterialColor(materialColor);
  }

  void defaultTheme() {
    materialColor = Colors.purple;
    themeData = ThemeData(primarySwatch: materialColor);
  }

  void themeFromScheme(ColorScheme colorScheme) {
    materialColor = ThemeHelpers.materialColorFromColor(colorScheme.primary);
    themeData = ThemeData(colorScheme: colorScheme);
  }

  void setThemeDefaultScheme() {
    themeFromScheme(ThemeHelpers.darkColorScheme);
  }
}

class ThemeHelpers {
  static Color colorRandom() {
    var random = Random();
    int r = random.nextInt(255);
    int g = random.nextInt(255);
    int b = random.nextInt(255);
    return Color.fromRGBO(r, g, b, 1);
  }

  static bool validateHexColor(String colorHex) {
    bool colorValido = false;

    Pattern colorPattern = r'^#(?:[0-9a-fA-F]{3}){1,2}$';
    RegExp regExp = RegExp(colorPattern as String);
    if (regExp.hasMatch(colorHex)) {
      colorValido = true;
    }
    return colorValido;
  }

  /// get darker or ligther the color
  static Color getDarker(Color color, {double amount = .1}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  static Color getLighter(Color color, {double amount = .1}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  static MaterialColor materialColorFromRGB(int r, g, b) {
    MaterialColor color = Colors.purple;
    try {
      Map<int, Color> colorMap = {
        50: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .55),
        100: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .45),
        200: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .35),
        300: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .25),
        400: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .1),
        500: Color.fromRGBO(r, g, b, 1.0),
        600: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .1),
        700: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .15),
        800: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .25),
        900: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .375),
      };

      color = MaterialColor(
          int.parse(
              Color.fromRGBO(r, g, b, 1.0)
                  .toString()
                  .replaceAll('Color(', '')
                  .replaceAll(')', '')
                  .substring(2),
              radix: 16),
          colorMap);
    } catch (e) {
      color = Colors.orange;
    }

    return color;
  }

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA6C8FF),
    onPrimary: Color(0xFF003063),
    primaryContainer: Color(0xFF00468B),
    onPrimaryContainer: Color(0xFFD4E3FF),
    secondary: Color(0xFFBDC7DC),
    onSecondary: Color(0xFF273141),
    secondaryContainer: Color(0xFF3D4758),
    onSecondaryContainer: Color(0xFFD9E3F8),
    tertiary: Color(0xFFDBBDE1),
    onTertiary: Color(0xFF3E2845),
    tertiaryContainer: Color(0xFF563E5D),
    onTertiaryContainer: Color(0xFFF8D8FE),
    error: Color(0xFFFFB4A9),
    errorContainer: Color(0xFF930006),
    onError: Color(0xFF680003),
    onErrorContainer: Color(0xFFFFDAD4),
    background: Color(0xFF1B1B1D),
    onBackground: Color(0xFFE3E2E6),
    surface: Color(0xFF1B1B1D),
    onSurface: Color(0xFFE3E2E6),
    surfaceVariant: Color(0xFF43474F),
    onSurfaceVariant: Color(0xFFC3C6CF),
    outline: Color(0xFF8E919A),
    onInverseSurface: Color(0xFF1B1B1D),
    inverseSurface: Color(0xFFE3E2E6),
    inversePrimary: Color(0xFF245FA7),
    shadow: Color(0xFF000000),
  );

  static MaterialColor materialColorFromColor(Color color) {
    return materialColorFromRGB(color.red, color.green, color.blue);
  }
}
