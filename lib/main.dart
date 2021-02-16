import 'package:flutter/material.dart';
import 'package:flutter_apppokedex/pokemondetail.dart';
import 'package:flutter_apppokedex/pokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
  home : HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async{
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    print(pokeHub.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text('Pokédex'),
        centerTitle : true ,
        backgroundColor: Colors.red[900],
      ),
      body : pokeHub == null?Center(child: CircularProgressIndicator(),) : GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon.map((poke)=> Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>PokeDetail(
                        pokemon: poke,
                      )));
            },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.cover,
                              image: NetworkImage(poke.img))),
                    ),
                    Text(poke.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold ) ,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )).toList(),
      ),
      drawer: Drawer(),
    );
  }
}