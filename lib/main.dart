import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP1 App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF9C27B0),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const CurrencyConverterPage(),
    );
  }
}

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _montantController =
      TextEditingController(text: '100');

  int _selectedOption = 2;

  String _resultat = '';

  static const double TAUX = 3.4;

  @override
  void dispose() {
    _montantController.dispose();
    super.dispose();
  }

  void _convertir() {
    final double? montant = double.tryParse(_montantController.text);

    if (montant == null) {
      setState(() {
        _resultat = 'Montant invalide';
      });
      return;
    }

    double resultat;
    String devise;

    if (_selectedOption == 1) {
      // Dinar -> Euro
      resultat = montant / TAUX;
      devise = 'euros';
    } else {
      // Euro -> Dinar
      resultat = montant * TAUX;
      devise = 'dinars';
    }

    setState(() {
      _resultat =
          'Le résultat est ${resultat.toStringAsFixed(3)} $devise !';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TP1 App',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label "Montant"
            const Text(
              'Montant',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 4),

            // Champ de saisie (EditText)
            TextField(
              controller: _montantController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Bouton radio 1 : Dinar -> Euro
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _selectedOption,
                  activeColor: Colors.purple,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                ),
                const Text(
                  'Dinar  ➡  Euro',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Bouton radio 2 : Euro -> Dinar
            Row(
              children: [
                Radio<int>(
                  value: 2,
                  groupValue: _selectedOption,
                  activeColor: Colors.purple,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                ),
                Text(
                  'Euro  ➡  Dinar',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Résultat (TextView)
            Center(
              child: Text(
                _resultat,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Bouton CONVERTIR
            Center(
              child: SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: _convertir,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCE93D8),
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'CONVERTIR',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}