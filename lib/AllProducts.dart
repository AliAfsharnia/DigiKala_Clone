import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store/BottomNav.dart';
import 'package:store/Specialoffermodel.dart';
import 'package:store/singleProduct.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override

  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late Future<List<SpecialOfferModel>> specialOfferFuture;

  void initState() {
    // TODO: implement initState
    super.initState();

    specialOfferFuture = sendReqSpecialOffer();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),backgroundColor: Colors.grey),
      bottomNavigationBar: BottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('محصولات شگفت انگیز'),


      ),
      body: Container(
        child: FutureBuilder<List<SpecialOfferModel>>(
          future: specialOfferFuture,
          builder: (context,snapshot){
            if(snapshot.hasData) {
              List<SpecialOfferModel>? model = snapshot.data;
              return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children:  List.generate(model!.length, (index) => generateItem(model[index],context),)

              );
            } else {
              return Center(
                child: LinearProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

InkWell generateItem(SpecialOfferModel specialOfferModel, BuildContext context){
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => singleProduct(specialOfferModel)));
    },
    child: Card(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 10,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                     borderRadius: BorderRadius.circular(10),
                      child: Image.network(specialOfferModel.imgUrl ,)),
                ),
                Text(specialOfferModel.productname,textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(specialOfferModel.price.toString() + ' تومان',style: TextStyle(color: Colors.grey,fontSize: 14),),
                )
              ],
            ),
          ),
    ),
  );
}


Future<List<SpecialOfferModel>> sendReqSpecialOffer() async{
  List<SpecialOfferModel> model = [];

  var respons = await Dio().get("https://api.digikala.com/v1/");
  for (var item in respons.data['data']['incredible_products']['products']) {
    model.add(SpecialOfferModel(item['id'],item['title_fa'],item['properties']['min_price_in_last_month'],item['images']['main']['url'][0]));
  }

  return model;
}