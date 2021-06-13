import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperhub/data/data.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/widget/widget.dart';

class CategorieScreen extends StatefulWidget {
  final String categorieName;
  CategorieScreen({this.categorieName});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<WallpaperModel> wallpaper = new List();

  getCategorieWallpaper(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=30",
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getCategorieWallpaper(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: wallpaperList(wallpaper: wallpaper, context: context),
      ),
    );
  }
}
