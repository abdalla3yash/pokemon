import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokemon/pokemondetail.dart';

import 'package:pokemon/pokemon.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokehub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);
    pokehub = PokeHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon'),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: pokehub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokehub.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetail(
                                          pokemon: poke,
                                        )));
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(poke.img))),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text('A'),
              ),
              accountName: Text('Abdalla Ayash'),
              accountEmail: Text('abdo3yash@gmail.com'),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('M'),
                )
              ],
            ),
            ListTile(
                title: Text('About App'),
                trailing: Icon(Icons.info_outline),
                onTap: () {}),
            Divider(),
            ListTile(
              title: Text('Close'),
              trailing: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
