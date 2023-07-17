import 'package:flutter/material.dart';
import 'package:store/Specialoffermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class singleProduct extends StatelessWidget {
  SpecialOfferModel specialOfferModel;
  List<String> ProductImgurls = [];
  List<String> ProductTitles = [];
  List<String> ProductPrices = [];


  singleProduct(this.specialOfferModel);

  @override
  Widget build(BuildContext context) {
    ReadFromeSP();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Image.network(specialOfferModel.imgUrl,fit: BoxFit.fill),
              Text(specialOfferModel.productname,textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text(specialOfferModel.price.toString() + ' تومان',style: TextStyle(color: Colors.grey,fontSize: 22),),
              ),
              Expanded(child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: (){
                      SaveDataToSP();
                    }, child: Text('افزودن به سبد جرید'),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> ReadFromeSP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    ProductImgurls = prefs.getStringList("ProductImgurls") ?? [];
    ProductTitles = prefs.getStringList("ProductTitles") ?? [];
    ProductPrices = prefs.getStringList("ProductPrices") ?? [];

  }
  Future<void> SaveDataToSP() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    ProductImgurls.add(specialOfferModel.imgUrl);
    ProductTitles.add(specialOfferModel.productname);
    ProductPrices.add(specialOfferModel.price.toString());

    prefs.setStringList("ProductImgurls",  ProductImgurls);
    prefs.setStringList("ProductTitles",  ProductTitles);
    prefs.setStringList("ProductPrices", ProductPrices);

  }
}
