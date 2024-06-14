import 'package:flutter/material.dart';
import 'package:wallpaper/Controller/ApiOperations.dart';
import 'package:wallpaper/UI/screens/fullScreen.dart';
import 'package:wallpaper/UI/widgets/Category.dart';
import 'package:wallpaper/UI/widgets/CustomAppBar.dart';
import 'package:wallpaper/UI/widgets/Search.dart';

import '../../Model/categoryModel.dart';
import '../../Model/photosModel.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

   List<PhotosModel> trendingWallList =[];
   List<CategoryModel> CatModList = [];
   bool isLoading = true;

   GetCatDetails() async {
     CatModList = await ApiOperations.getCategoriesList();

     setState(() {
       CatModList = CatModList;
     });
   }

  GetTrendingWallpapers() async{
    trendingWallList = await ApiOperations.getTrendingWallpapers();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {

    super.initState();
    GetCatDetails();
    GetTrendingWallpapers();
    //ApiOperations.getTrendingWallpapers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: CustomAppBar(word1: "Wallpaper",word2:"Aesthetic"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10) ,
              child: Search(),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin:EdgeInsets.symmetric(horizontal: 15) ,
                child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:CatModList.length,
                      itemBuilder: ((context,index)=>Category(categoryImgSrc: CatModList[index].catImgUrl,
                        categoryName: CatModList[index].catName))
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              height: 540,
             //height: MediaQuery.of(context).size.height,
             // width: 380,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 280,
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  ),
                  itemCount: trendingWallList.length,
                  itemBuilder: ((context,index)=>GridTile(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>fullScreen(imgUrl:  trendingWallList[index].imageSrc)));
                      },
                      child: Hero(
                        tag: trendingWallList[index].imageSrc,
                        child: Container(
                          height: 500,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              height: 500,
                                width: 50,
                                fit:BoxFit.cover,
                                trendingWallList[index].imageSrc
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
