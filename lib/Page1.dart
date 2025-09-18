import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';
import 'package:url_launcher/url_launcher.dart';

// Importer innehåller alla paket och filer som denna sida behöver.
// Här importeras ramverk Flutter, navigering med go_router, state management
// med provider, min egen tema-provider och url_launcher för att öppna länkar.

class Page1 extends StatelessWidget {
  // Page1 är en "stateless widget" eftersom den inte har något internt tillstånd som ändras
  // Den ärver från StatelessWidget och returnerar en Scaffold i
  // sin build-metod, vilket ger den grundläggande Material Design-strukturen.
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    // build-metoden beskriver hur widgeten ska se ut.
    return Scaffold(
      appBar: AppBar(
        // AppBar är den övre listen i appen.
        title: const Text('Solen'),
        actions: [
          // actions-listan innehåller widgets som visas till höger om titeln i AppBar.
          IconButton(
            // En interaktiv knapp som ser ut som en ikon.
            icon: Icon(
              // Ikonen för knappen ändras dynamiskt baserat på det aktuella temat.
              // Den lyssnar på ThemeProvider för att veta om det är ljust eller mörkt tema.
              Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                  ? Icons.wb_sunny // Sol-ikon för ljust tema
                  : Icons.nights_stay, // Måne-ikon för mörkt tema
            ),
            onPressed: () {
              // Denna kod körs när knappen trycks.
              // Den anropar toggleTheme()-metoden i ThemeProvider, vilket
              // byter tema och meddelar hela appen om ändringen.
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        // body-avsnittet är huvudområdet under AppBar. Center-widgeten
        // centrerar sin enda child-widget.
        child: Padding(
          // Padding ger ett avstånd (16.0 pixlar) mellan innehållet och skärmens kanter.
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Column organiserar alla sina widgets vertikalt, från topp till botten.
            mainAxisAlignment: MainAxisAlignment.center, // Centrerar innehållet vertikalt.
            children: <Widget>[
              // Här är alla widgets som visas inuti kolumnen.

              Image.asset(
                // Image.asset används för att visa en bild från din lokala
                // projektmapp. Den laddar bilden från den angivna sökvägen.
                'assets/images/sun.jpg',
                width: 250, // Ställer in bildens bredd
                height: 250, // Ställer in bildens höjd
              ),
              const SizedBox(height: 20), // Ger ett fast utrymme på 20 pixlar.
              const Text(
                // En enkel text-widget som visar en beskrivning av solen.
                'Solen är stjärnan i centrum av vårt solsystem.',
                textAlign: TextAlign.center, // Centrerar texten
                style: TextStyle(fontSize: 18), // Ställer in typsnittsstorlek
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                // En Material Design-knapp som har skugga och lyfts upp från ytan.
                onPressed: () {
                  // Denna kod körs när knappen trycks.
                  // context.go('/page2') använder go_router för att navigera
                  // till den sida som är definierad med sökvägen 'page2'.
                  context.go('/page2');
                },
                child: const Text('Se månen'), // Texten som visas på knappen
              ),

              const SizedBox(height: 10),
              TextButton(
                // En enkel, klickbar text-knapp utan bakgrundsfärg.
                onPressed: () async {
                  // Denna kod körs när knappen trycks.
                  const url = 'https://sv.wikipedia.org/wiki/Solen';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    // Kontrollerar om länken är giltig och kan öppnas.
                    await launchUrl(Uri.parse(url)); // Öppnar länken i en webbläsare
                  } else {
                    // Om länken inte kan öppnas, kastas ett fel.
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