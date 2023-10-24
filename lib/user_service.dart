import 'package:flutter/material.dart';

class CocktailDetailPage extends StatelessWidget {
  final String cocktailName;
  final String cocktailDescription;
  final String cocktailFoto;
  final String  cocktailingre;
  
  const CocktailDetailPage(
      this.cocktailingre,
      this.cocktailFoto,
      this.cocktailName,
      this.cocktailDescription, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dettagli del Cocktail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Container(child: (Image.network(cocktailFoto)),

          ),
            Text(
              cocktailName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              cocktailDescription,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              cocktailingre,
              style: TextStyle(fontSize: 16),
              
            ), 
            Text(
              cocktailingre,
              style: TextStyle(fontSize: 16),

            ),
          ],
        ),
      ),
    );
  }
}


