// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/AllProducts.dart';
import 'package:store/Specialoffermodel.dart';
import 'package:store/TopBannersModel.dart';
import 'PageViewModel.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: home_page(),
  ));
}

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {

  late Future<List<PageViewModel>> pageViewFuture;
  late Future<List<SpecialOfferModel>> specialOfferFuture;
  late Future<List<TopBannersModel>> topBannerModel;

  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageViewFuture = sendReqPageView();
    specialOfferFuture = sendReqSpecialOffer();
    topBannerModel = sendReqTopBanners();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Divider(),
      appBar: AppBar(
        title: Text("DigiKala"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
          children: [
            Container(
              height: 180,
              child: FutureBuilder<List<PageViewModel>>(
                future: pageViewFuture,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    List<PageViewModel>? model = snapshot.data;
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                          controller: pageController,
                            allowImplicitScrolling: true,
                            itemCount: model!.length,
                            itemBuilder: (context, position){
                              return PageViewItems(model[position]);
                            }
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: model.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.red,
                              dotColor: Colors.white,
                              dotHeight: 10,
                              dotWidth: 10,
                              spacing: 3,
                            ),
                          ),
                        ),
                      ]
                    );
                  }else{
                    return Center(
                      child: LinearProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              height: 250,
              color: Colors.red,
              child: FutureBuilder<List<SpecialOfferModel>>(
                future: specialOfferFuture,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    List<SpecialOfferModel>? model = snapshot.data;
                    return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: model!.length,
                        itemBuilder: (context,position){
                          if(position == 0)
                            return Container(
                              height: 400,
                              width: 200,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15 ,left:10, right: 10),
                                    child: Image.asset("images/box.png",height: 180),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 1),
                                    child: Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: Colors.white)
                                        ),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AllProducts()));
                                        },
                                        child: Text("مشاهده همه", style: TextStyle(color: Colors.white),),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          else return Special_offer_items(model[position]);
                        });
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
            Container(
              height: 300,
              width: double.infinity,
              child: FutureBuilder<List<TopBannersModel>>(
                future: topBannerModel,
                builder: (context,snapshot){
                  if(snapshot.hasData) {
                    List<TopBannersModel>? model = snapshot.data;
                    return  Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 140,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                      child: Image.network(model![0].Imgurl,fit: BoxFit.fill))
                                ),
                                Container(
                                    height: 140,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        child: Image.network(model![1].Imgurl,fit: BoxFit.fill))
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    height: 140,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        child: Image.network(model[2].Imgurl,fit: BoxFit.fill))
                                ),
                                Container(
                                    height: 140,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        child: Image.network(model[3].Imgurl,fit: BoxFit.fill))
                                )
                              ],
                            ),
                          )
                        ],
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
            )
          ],
          ),
        ),
      ),
    );
  }

  Container Special_offer_items(SpecialOfferModel specialOfferModel){
    return Container(
      height: 300,
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular( 15 )),
        child: Container(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                    child: Image.network(specialOfferModel.imgUrl,height: 100,fit: BoxFit.fill ,)),
                Text(specialOfferModel.productname,textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(specialOfferModel.price.toString() + ' تومان',style: TextStyle(color: Colors.grey,fontSize: 14),),
                )
              ],
            ),
          )
        )
        ),
      );
  }

  Future<List<PageViewModel>> sendReqPageView() async{
    List<PageViewModel> model = [];

    var respons = await Dio().get("https://api.digikala.com/v1/");

    for (var item in respons.data['data']['header_banners']) {
      model.add(PageViewModel(item['id'],item['image']));
    }

    return model;
    }

  Padding PageViewItems(PageViewModel pageViewModel){
    return Padding(
      padding: EdgeInsets.only(top: 10,left: 5,right: 5),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child: Image.network(pageViewModel.Imgurl,fit: BoxFit.fill,)),
      ),
    );
  }
  }

Future<List<SpecialOfferModel>> sendReqSpecialOffer() async{
  List<SpecialOfferModel> model = [];

  var respons = await Dio().get("https://api.digikala.com/v1/");
  for (var item in respons.data['data']['incredible_products']['products']) {
    model.add(SpecialOfferModel(item['id'],item['title_fa'],item['properties']['min_price_in_last_month'],item['images']['main']['url'][0]));
  }

  return model;
}

Future<List<TopBannersModel>> sendReqTopBanners() async{
  List<TopBannersModel> model = [];

  var respons = await Dio().get("https://api.digikala.com/v1/");

  for (var item in respons.data['data']['top_banners']) {
    model.add(TopBannersModel(item['image']));
  }

  print(model);

  return model;
}