import 'dart:async';

import 'package:flutter/material.dart';

import '../blocs/theme_bloc.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
// This widget is the root of your application.
  ThemeData themeData = blocTheme.themeData;
  late StreamSubscription themeStream;

  @override
  void initState() {
    super.initState();
    themeStream = blocTheme.themeDataStream.listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    themeStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = blocTheme;
    const iconRadius = 30.0;
    final materialColorRowHeight = size.width * .1;
    setColorLigthProfile() {
      const colorScheme = ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF245FA7),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFFD4E3FF),
        onPrimaryContainer: Color(0xFF001B3D),
        secondary: Color(0xFF555F71),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFFD9E3F8),
        onSecondaryContainer: Color(0xFF121C2B),
        tertiary: Color(0xFF6F5676),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFF8D8FE),
        onTertiaryContainer: Color(0xFF27132F),
        error: Color(0xFFBA1B1B),
        errorContainer: Color(0xFFFFDAD4),
        onError: Color(0xFFFFFFFF),
        onErrorContainer: Color(0xFF410001),
        background: Color(0xFFFDFBFF),
        onBackground: Color(0xFF1B1B1D),
        surface: Color(0xFFFDFBFF),
        onSurface: Color(0xFF1B1B1D),
        surfaceVariant: Color(0xFFE0E2EB),
        onSurfaceVariant: Color(0xFF43474F),
        outline: Color(0xFF74777F),
        onInverseSurface: Color(0xFFF1F0F4),
        inverseSurface: Color(0xFF2F3033),
        inversePrimary: Color(0xFFA6C8FF),
        shadow: Color(0xFF000000),
      );
      setState(() {
        theme.themeFromScheme(colorScheme);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Theme Example',
          style: TextStyle(
            color: theme.themeData.backgroundColor,
          ),
        ),
        leading: Container(
          alignment: Alignment.center,
          height: iconRadius,
          width: iconRadius,
          child: Icon(
            Icons.menu,
            color: theme.themeData.backgroundColor,
          ),
        ),
        actions: [
          Icon(
            Icons.account_circle_rounded,
            color: theme.themeData.backgroundColor,
          ),
          const SizedBox(width: 5.0),
          Icon(
            Icons.done,
            color: theme.themeData.errorColor,
          ),
          const SizedBox(width: 5.0),
          Icon(
            Icons.search,
            color: theme.themeData.secondaryHeaderColor,
          ),
          const SizedBox(width: 5.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Container(
              width: size.width,
              height: size.width * 0.45,
              color: theme.themeData.splashColor,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    theme.themeData.primaryColorDark, BlendMode.color),
                child: Image.asset(
                  'assets/theme/complete_design.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: size.width,
              height: 50.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _MenuItem(
                      size: size,
                      label: 'ColorScheme',
                      iconData: Icons.fingerprint,
                      function: () {
                        theme.setThemeDefaultScheme();
                      },
                    ),
                    _MenuItem(
                      size: size,
                      label: 'Profile',
                      iconData: Icons.account_circle_rounded,
                      emphasys: true,
                      function: () {
                        setColorLigthProfile();
                      },
                    ),
                    _MenuItem(
                      size: size,
                      label: 'menu 1',
                      iconData: Icons.search_off,
                    ),
                    _MenuItem(
                      size: size,
                      label: 'menu 2',
                      iconData: Icons.map,
                    ),
                    _MenuItem(
                      size: size,
                      label: 'menu 3',
                      iconData: Icons.local_airport_outlined,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: (size.height * 0.55).clamp(50.0, size.width),
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _CardButton(
                    width: size.width * 0.4,
                    label: 'Default',
                    description: 'Default theme for app',
                    iconData: Icons.edit,
                    function: () {
                      theme.defaultTheme();
                    },
                  ),
                  _CardButton(
                    width: size.width * 0.4,
                    label: 'Random',
                    description:
                        'Set random theme for app using a material color as seed',
                    iconData: Icons.edit_attributes,
                    function: () {
                      theme.setRandomThemeData();
                    },
                  ),
                  _CardButton(
                    width: size.width * 0.4,
                    label: 'Random',
                    description:
                        'Set random theme for app using a material color list',
                    iconData: Icons.edit_attributes_outlined,
                    function: () {
                      theme.changeThemeDataColor();
                    },
                  ),
                  _CardButton(
                    width: size.width * 0.4,
                    label: 'Black',
                    description: 'Set theme for app using a RGB',
                    iconData: Icons.edit_attributes_outlined,
                    emphasys: true,
                    function: () {
                      theme.setThemeFromRGB(40, 40, 40);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: materialColorRowHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 50),
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 100),
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 200),
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 300),
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 400),
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 500),
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 600),
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 700),
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 800),
                  _InfoButton(
                      materialColorRowHeight: materialColorRowHeight,
                      index: 900),
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Slider(
                    value: theme.themeData.primaryColor.red.toDouble(),
                    activeColor: Colors.red,
                    inactiveColor: Colors.red[50],
                    label: "${theme.themeData.primaryColor.red}",
                    max: 255,
                    min: 0,
                    divisions: 255,
                    onChanged: (value) {
                      theme.setThemeFromRGB(
                          value.round(),
                          theme.themeData.primaryColor.green,
                          theme.themeData.primaryColor.blue);
                    },
                  ),
                  Slider(
                    value: theme.themeData.primaryColor.green.toDouble(),
                    activeColor: Colors.green,
                    inactiveColor: Colors.green[50],
                    label: "${theme.themeData.primaryColor.green}",
                    max: 255,
                    min: 0,
                    divisions: 255,
                    onChanged: (value) {
                      theme.setThemeFromRGB(theme.themeData.primaryColor.red,
                          value.round(), theme.themeData.primaryColor.blue);
                    },
                  ),
                  Slider(
                    value: theme.themeData.primaryColor.blue.toDouble(),
                    activeColor: Colors.blue,
                    inactiveColor: Colors.blue[50],
                    label: "${theme.themeData.primaryColor.blue}",
                    max: 255,
                    min: 0,
                    divisions: 255,
                    onChanged: (value) {
                      theme.setThemeFromRGB(
                        theme.themeData.primaryColor.red,
                        theme.themeData.primaryColor.green,
                        value.round(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoButton extends StatelessWidget {
  const _InfoButton({
    Key? key,
    required this.materialColorRowHeight,
    required this.index,
  }) : super(key: key);
  final int index;

  final double materialColorRowHeight;

  @override
  Widget build(BuildContext context) {
    final theme = blocTheme;
    return Container(
      width: materialColorRowHeight,
      height: materialColorRowHeight,
      color: theme.materialColor[index] ?? theme.themeData.errorColor,
    );
  }
}

class _CardButton extends StatelessWidget {
  const _CardButton({
    required this.width,
    required this.label,
    required this.description,
    required this.iconData,
    this.function,
    this.emphasys = false,
    Key? key,
  }) : super(key: key);

  final double width;
  final String label, description;
  final void Function()? function;
  final IconData iconData;
  final bool emphasys;

  @override
  Widget build(BuildContext context) {
    final theme = blocTheme.themeData;
    return InkWell(
      onTap: function,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconData,
              size: width * 0.65,
              color: emphasys
                  ? theme.errorColor
                  : theme.buttonTheme.colorScheme?.primary,
            ),
            Text(
              label,
              style: theme.textTheme.headline1?.copyWith(fontSize: 18),
            ),
            SizedBox(
              width: width,
              height: width * 0.3,
              child: Text(
                description,
                style: theme.textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem(
      {Key? key,
      required this.size,
      required this.label,
      required this.iconData,
      this.function,
      this.emphasys = false})
      : super(key: key);

  final Size size;
  final String label;
  final IconData iconData;
  final bool emphasys;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    final theme = blocTheme;
    return InkWell(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.only(left: 2.0),
        padding: const EdgeInsets.all(2.0),
        width: size.width * 0.275,
        height: 60.0,
        decoration: BoxDecoration(
            color: theme.themeData.backgroundColor,
            border: Border(
                bottom: BorderSide(
                    color: theme.themeData.bottomAppBarColor, width: 2.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconData,
              color: emphasys
                  ? theme.themeData.errorColor
                  : theme.themeData.primaryColorDark,
            ),
            Text(
              label,
              style: emphasys
                  ? TextStyle(color: theme.themeData.errorColor)
                  : theme.themeData.textTheme.headline1,
            )
          ],
        ),
      ),
    );
  }
}
