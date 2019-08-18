import 'package:flutter/material.dart';
import 'package:phutball/game.dart';
class MenuScreen extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      body: (
        Center(
          child: Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.all(70.0),
          width: double.infinity,
          constraints: BoxConstraints.expand(),

          child: Column(
            children: <Widget>[
              Text("Phutball", style: TextStyle(fontSize: 55), textAlign: TextAlign.center,),
              new Container(
                margin: const EdgeInsets.only(top: 90.0),
                child: Column(children: <Widget>[             
                  MaterialButton(
                    child: Text('Play', style: TextStyle(fontSize: 25)),
                    padding: EdgeInsets.all(10),
                    color: Colors.blueAccent,
                    shape: StadiumBorder(),
                    elevation: 7,
                    onPressed: (){
                      Navigator.push(
                        ctxt,
                        new MaterialPageRoute(builder: (ctxt) => new ModeSelectScreen()),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: MaterialButton(                
                      child: Text('About', style: TextStyle(fontSize: 25)),
                      padding: EdgeInsets.all(10),
                      color: Colors.blueAccent,
                      shape: StadiumBorder(),
                      elevation: 2,
                      onPressed:null,
                    ),
                  )
                ],
                ),
              )           
            ],     
          )     
         ),
        )    
      )
    );
  }
}

class ModeSelectScreen extends StatelessWidget { //select gamemode screen
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Mode Select'),
        
        elevation: 0.0,
      ),
      body: (
        Center(
          child: Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(
                    ctxt,
                    new MaterialPageRoute(builder: (ctxt) => new LocalMultiplayer()),
                  );
                },
                child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: FlutterLogo(size: 60,),
                      title: Text('Local Multiplayer'),
                      subtitle: Text('quackquakcuqkacuqkuackqukcuhwhri'),
                    ),
                  ],
                ),
              )    
              ),
            ],          
         ),
        )    
      )
      )
    );
  }
}