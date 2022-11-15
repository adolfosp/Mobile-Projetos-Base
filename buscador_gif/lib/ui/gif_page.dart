import 'package:flutter/material.dart';
import 'package:share/share.dart';


class GifPage extends StatelessWidget {

  final Map _gifData;

  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              Share.share(_gifData["images"]["fixed_height"]["url"]);
            }, icon: Icon(Icons.share))
          ],
          title: Text(_gifData["title"]),
          backgroundColor: Colors.black,
        ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
