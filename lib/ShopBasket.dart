import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ShopingBasketModel.dart';

class shopBasket extends StatefulWidget {
  const shopBasket({Key? key}) : super(key: key);

  @override
  State<shopBasket> createState() => _shopBasketState();
}

class _shopBasketState extends State<shopBasket> {

  StreamController<ShoppingBasketModel> streamController = new StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromPrefs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("سبد خرید"),
      ),
      body: Container(
        child: StreamBuilder<ShoppingBasketModel>(
          stream:  streamController.stream,
          builder: (context,snapShot){
            if(snapShot.hasData){
              ShoppingBasketModel? model = snapShot.data;
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: model!.imgurls.length,
                itemBuilder: (context,position){
                  return generateItem(model.imgurls[position], model.titles[position], model.prices[position]);
                },
              );
            } else {
              return Center(
                child: LinearProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }
          },
        )
      ),
      );
  }

  String titleCheck(String title){

    if(title.length>30)
      title = '... ' + title.substring(0,30) ;

    return title;
  }

  Card generateItem(String imgUrl,String title, String price){
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      elevation: 10,
      child: Container(

        width: MediaQuery.of(context).size.width - 30,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(titleCheck(title)),
                ) ,
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(price.toString() + ' تومان',style: TextStyle(color: Colors.grey,fontSize: 18),)
                ),
              ],
            ),
            Image.network(imgUrl,fit: BoxFit.contain,height: 150,width: 150),
          ],
        ),
      ),
    );
  }

  Future<void> getDataFromPrefs()async {
  List<String> ProductImgurls = [];
  List<String> ProductTitles = [];
  List<String> ProductPrices = [];

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  ProductImgurls = prefs.getStringList("ProductImgurls") ?? [];
  ProductTitles = prefs.getStringList("ProductTitles") ?? [];
  ProductPrices = prefs.getStringList("ProductPrices") ?? [];

  var model = ShoppingBasketModel(ProductImgurls, ProductTitles, ProductPrices);

  streamController.add(model);
  }
}

