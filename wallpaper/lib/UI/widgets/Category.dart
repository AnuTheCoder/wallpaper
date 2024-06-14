import 'package:flutter/material.dart';
import 'package:wallpaper/UI/screens/CategoryScreen.dart';

class Category extends StatelessWidget {
  String categoryName;
  String categoryImgSrc;
  Category({super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen(catImgUrl: categoryImgSrc, catName: categoryName)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius : BorderRadius.circular(10),
              child: Image.network(
                height: 100,
                  width : 90,
                  fit:BoxFit.cover,
                  categoryImgSrc),
            ),
            Container(
              height: 100,
              //width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:Colors.black26
              ),
            ),
            Positioned(
              left: 35 ,
              top: 5,
              child: Text(
                categoryName,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 12
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
