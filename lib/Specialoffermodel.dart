class SpecialOfferModel{
  var _id;
  String _productname;
  var _price;
  String _imgUrl;


  SpecialOfferModel(
      this._id, this._productname, this._price, this._imgUrl);

  String get imgUrl => _imgUrl;

  get price => _price;

  String get productname => _productname;

  get id => _id;
}