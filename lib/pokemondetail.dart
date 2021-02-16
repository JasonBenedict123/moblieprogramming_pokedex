import 'package:flutter/material.dart';
import 'package:flutter_apppokedex/pokemon.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;
  PokeDetail({this.pokemon});
  bodyWidget(BuildContext context)=> Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width -20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
              Text("Height: ${pokemon.height}"),
              Text("Weight: ${pokemon.weight}"),
              Text("Types",
                style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.type.
                  map((t) => FilterChip(backgroundColor: Colors.blue[400],
                      label: Text(t,
                        style: TextStyle(color: Colors.white),), onSelected: (b){})).toList()
              ),
              Text("Weakness",
                style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.weaknesses.
                  map((t) => FilterChip(backgroundColor: Colors.deepOrange,
                      label: Text(t,
                          style: TextStyle(color: Colors.white)), onSelected: (b){})).toList()
              ),
              Text("Next Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.nextEvolution == null? <Widget> [Text("This is the final form")]
                      : pokemon.nextEvolution
                      .map((n) => FilterChip(backgroundColor: Colors.green,
                      label: Text(n.name, style: TextStyle(color: Colors.white)), onSelected: (b){})).toList()
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: pokemon.img, child: Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(pokemon.img)),
          ),
        ),
        ),
      )
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(pokemon.name),
        backgroundColor: Colors.red[900],
      ),
      body: bodyWidget(context),
    );
  }
}
