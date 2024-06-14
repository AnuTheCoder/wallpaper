import 'package:flutter/material.dart';
import '../screens/SearchScreen.dart';

class Search extends StatelessWidget {
  Search({super.key});

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color:Colors.red,
          width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search Wallpapers",
                      errorBorder :InputBorder.none,
                      focusedBorder : InputBorder.none,
                      focusedErrorBorder : InputBorder.none,
                      disabledBorder : InputBorder.none,
                      enabledBorder : InputBorder.none,
                      border : InputBorder.none,
                    ),
                  ),
            ),
            InkWell(
              onTap: (){
               Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen(query: _searchController.text)));
      },
                child: Icon(Icons.search))
          ],
        ),
           // Icon(Icons.search)
      ),
    );
  }
}
