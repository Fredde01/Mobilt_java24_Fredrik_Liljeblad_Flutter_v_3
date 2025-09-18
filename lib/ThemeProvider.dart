import 'package:flutter/material.dart';

// Importen ovanför ger tillgång till Material-ramverket, inklusive
// viktiga klasser som "ChangeNotifier" och "ThemeMode".

class ThemeProvider with ChangeNotifier {
  // Klassen ThemeProvider hanterar tillståndet (state) för appens tema.
  // "with ChangeNotifier" är en mixin som ger klassen möjlighet att
  // meddela andra widgets när dess data ändras.

  ThemeMode _themeMode = ThemeMode.light;
  // Denna privata variabel (_themeMode) lagrar det aktuella temat.
  // Den initieras till "ThemeMode.light", vilket betyder att appen
  // startar med ett ljust tema som standard.

  ThemeMode get themeMode => _themeMode;
  // Detta är en "getter" som gör det möjligt för andra
  // widgets att läsa av det aktuella temat utan att kunna ändra det direkt.

  void toggleTheme() {
    // Denna metod ändrar temat från ljust till mörkt, eller tvärtom.
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    // Denna rad använder en "ternary operator". Den kontrollerar om
    // _themeMode är ljust. Om det är sant, sätts temat till mörkt;
    // annars sätts det till ljust.

    notifyListeners(); // Meddela alla lyssnare om ändringen,
    // när den anropas, meddelar den alla
    // widgets som "lyssnar" på denna provider att en ändring har skett.
    // Detta tvingar dem att byggas om (rebuild) med de nya temafärgerna,
    // vilket skapar den synliga temaeffekten i appen.
  }
}