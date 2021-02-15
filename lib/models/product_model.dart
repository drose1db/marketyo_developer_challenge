class ProductModel {
  String name;
  String detail;
  String price;
  String info;
  String offer;
  String hero;
  String image;

  ProductModel(
      {this.name,
      this.detail,
      this.price,
      this.hero,
      this.image,
      this.info,
      this.offer});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    detail = json['detail'];
    price = json['price'];
    hero = json['hero'];
    info = json['info'];
    offer = json['offer'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['price'] = this.price;
    data['hero'] = this.hero;
    data['info'] = this.info;
    data['offer'] = this.offer;
    data['image'] = this.image;
    return data;
  }
}
