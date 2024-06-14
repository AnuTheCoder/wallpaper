import 'package:flutter/material.dart';
import 'package:wallpaper/Controller/ApiOperations.dart';
import 'package:wallpaper/Model/photosModel.dart';
import 'package:wallpaper/UI/screens/fullScreen.dart';
import '../widgets/CustomAppBar.dart';

class SearchScreen extends StatefulWidget {
  String query;

  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PhotosModel> searchResults = [];
  bool isLoading = true;

  GetSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(
          word1: "Aesthetic",
          word2: "Wallpaper",
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Container(
            //     padding: EdgeInsets.symmetric(horizontal: 10),
            //     child: Search()),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              height: 750,
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
                itemCount: searchResults.length,
                itemBuilder: ((context, index) => GridTile(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>fullScreen(
                            imgUrl: searchResults[index].imageSrc,
                          )));
                        },
                        child: Hero(
                          tag: searchResults[index].imageSrc,
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
                                  fit: BoxFit.cover,
                                  searchResults[index].imageSrc),
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
