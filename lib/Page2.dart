import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';
import 'package:url_launcher/url_launcher.dart';

// Importer innehåller alla paket och lokala filer
// som denna sida behöver för att fungera.

class Page2 extends StatelessWidget {
  // Page2 är en "stateless widget" eftersom den enbart visar information
  // och inte hanterar sitt eget interna tillstånd.
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    // build()-metoden definierar widgetens layout och utseende.
    return Scaffold(
      // Scaffold ger en grundläggande Material Design-struktur,
      // med en appbar överst och en "body" för innehållet.
      appBar: AppBar(
        // AppBar är den övre listen som visar sidans titel och ikoner.
        title: const Text('Månen'), // Sidans titel
        actions: [
          // actions-listan innehåller interaktiva widgets som placeras
          // på höger sida av appbaren.
          IconButton(
            // En klickbar ikon som växlar mellan ljust och mörkt tema.
            icon: Icon(
              // Ikonen ändras baserat på om det nuvarande temat är ljust eller mörkt.
              Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                  ? Icons.wb_sunny
                  : Icons.nights_stay,
            ),
            onPressed: () {
              // Denna funktion anropar ThemeProvider för att ändra temat.
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        // body innehåller det huvudsakliga innehållet.
        // Center-widgeten centrerar sin child-widget på skärmen.
        child: Padding(
          // Padding ger ett avstånd på 16 pixlar runt innehållet.
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Column ordnar sina barnwidgets vertikalt.
            mainAxisAlignment: MainAxisAlignment.center, // Centrerar innehållet vertikalt.
            children: <Widget>[
              // Widgets i denna lista visas i en kolumn.
              Image.asset(
                // Visar en bild som är sparad lokalt i projektet.
                'assets/images/moon.jpg',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 20), // Lägger till ett vertikalt mellanrum.
              const Text(
                // En statisk text-widget för att visa information.
                'Månen är jordens enda naturliga satellit.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                // En lyft, interaktiv knapp.
                onPressed: () {
                  // Använder go_router för att navigera tillbaka till startsidan ('/').
                  context.go('/');
                },
                child: const Text('Tillbaka till solen'),
              ),

              const SizedBox(height: 10),
              TextButton(
                // En klickbar text-widget som fungerar som en länk.
                onPressed: () async {
                  const url = 'https://sv.wikipedia.org/wiki/M%C3%A5nen';
                  // Försöker öppna den angivna URL:en i en webbläsare.
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Kunde inte öppna $url';
                  }
                },
                child: const Text('Läs mer på Wikipedia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}