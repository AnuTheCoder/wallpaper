import 'package:flutter/material.dart';
import 'package:wallpaper/Controller/ApiOperations.dart';
import 'package:wallpaper/UI/screens/fullScreen.dart';
import 'package:wallpaper/UI/widgets/CustomAppBar.dart';

import '../../Model/photosModel.dart';

class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;
  CategoryScreen({super.key, required this.catImgUrl, required this.catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  List<PhotosModel> categoryResults = [];
  bool isLoading = true;
  GetCatResults() async{
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);
    setState(() {
      isLoading = false;
    });
}


  @override

  void initState(){
    GetCatResults();
    super.initState();
  }

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
            Stack(
              children: [
                Image.network(
                    height:180,
                    width:MediaQuery.of(context).size.width,
                    fit:BoxFit.cover,
                   widget.catImgUrl
                ),
              Container(
                height:180,
                width:MediaQuery.of(context).size.width,
                color: Colors.black38,
              ),
                Positioned(
                  top: 60,
                  left: 180,
                  child: Column(
                    children: [
                      Text("Category",
                      style: TextStyle(
                      color: Colors.white,fontSize: 12
                      ),
                      ),
                      Text(widget.catName,
                        style: TextStyle(
                            color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500
                        ),)
                    ],
                  ),
                )
              ],
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 6,vertical: 8),
              height: 560,
              //height: MediaQuery.of(context).size.height,
              // width: 380,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 268,
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemCount: categoryResults.length,
                itemBuilder: ((context,index)=>GridTile(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>fullScreen(
                        imgUrl: categoryResults[index].imageSrc,
                      )));
                    },
                    child: Hero(
                      tag: categoryResults[index].imageSrc,
                      child: Container(
                        height: 500,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              height: 450,
                              width: 50,
                              fit:BoxFit.cover,
                              categoryResults[index].imageSrc,
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
