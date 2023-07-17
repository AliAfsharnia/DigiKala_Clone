import 'package:flutter/material.dart';
import 'package:store/ShopBasket.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle( ),
      color: Colors.red,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2 - 20,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.home),color: Colors.white),
                  IconButton(onPressed: (){}, icon: Icon(Icons.person),color: Colors.white)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/2 - 20,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white)),
                  IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => shopBasket())); }, icon: Icon(Icons.shopping_bag),color: Colors.white,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
