import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_progetto/user_service.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _cocktailList = [];
  Set<String> _favorites = Set<String>();

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _searchCocktails(String query) async {
    final apiUrl = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$query';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        _cocktailList = json.decode(response.body)['drinks'];
      });
    } else {
      _cocktailList = [];
    }
  }

  void _toggleFavorite(String cocktailName) {
    setState(() {
      if (_favorites.contains(cocktailName)) {
        _favorites.remove(cocktailName);
      } else {
        _favorites.add(cocktailName);
      }
    });
  }

  bool _isFavorite(String cocktailName) {
    return _favorites.contains(cocktailName);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cocktail App"),
      ),
      body: _currentIndex == 0
          ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: "Inserisci almeno una lettera"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String query = _searchController.text;
              if (query.isNotEmpty) {
                _searchCocktails(query);
              }
            },
            child: Text("Cerca"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cocktailList.length,
              itemBuilder: (context, index) {
                final cocktail = _cocktailList[index];
                final cocktailName = cocktail['strDrink'];
                final cocktailingre = cocktail ["strIngredient1"];
                final cocktailDescription = cocktail['strInstructions'];
                final isFavorite = _isFavorite(cocktailName);

                return Card(
                  child: ListTile(
                    leading: Image.network(cocktail['strDrinkThumb']),
                    title: Text(cocktailName),
                    subtitle: Text(cocktail['strCategory']),
                    trailing: IconButton(
                      icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                      onPressed: () {
                        _toggleFavorite(cocktailName);
                      },
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CocktailDetailPage(cocktail["strIngredient1"],cocktail['strDrinkThumb'],cocktailName, cocktailDescription),));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      )
          : Center(
        child: Text("Contenuto dei Preferiti"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cerca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Preferiti',
          ),
        ],
      ),
    );
  }
}
