class ShoppingBasketModel{
  List<String> _imgurls;
  List<String> _titles;
  List<String> _prices;

  ShoppingBasketModel(this._imgurls, this._titles, this._prices);

  List<String> get prices => _prices;

  List<String> get titles => _titles;

  List<String> get imgurls => _imgurls;
}