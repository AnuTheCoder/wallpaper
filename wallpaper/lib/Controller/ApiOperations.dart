import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper/Model/categoryModel.dart';
import 'package:wallpaper/Model/photosModel.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpersList = [];
  static List<CategoryModel> cateogryModelList = [];

  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http.get(
        Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {
          "Authorization": "w8VPASDeG8FX3N0jGZgCwNRVpOSncYHYraK8OnofOTcZ9HO6LySPDPVL"
        }
    ).then((value) {
      Map<String , dynamic>jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        //Map<String, dynamic> src = element["src"];
        // print(src["portrait"]);
        trendingWallpapers.add(PhotosModel.fromAPI2APP(element));
      }
      );
    }
    );
    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async{
    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=100&page=1"),
        headers: {
          "Authorization": "w8VPASDeG8FX3N0jGZgCwNRVpOSncYHYraK8OnofOTcZ9HO6LySPDPVL"
        }
    ).then((value) {
      Map<String , dynamic>jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpersList.clear();
      photos.forEach((element) {
        searchWallpersList.add(PhotosModel.fromAPI2APP(element));
      }
      );
    }
    );
    return searchWallpersList;
  }



  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
      (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      // print("IMG SRC IS HERE");
      // print(photoModel.imageSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imageSrc, catName: catName));
    });

    return cateogryModelList;
  }
}