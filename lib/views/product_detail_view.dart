import 'package:flutter/material.dart';
import 'package:marketyo_developer_challenge/components/appbar_provider.dart';
import 'package:marketyo_developer_challenge/view_models/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductDetailView extends StatefulWidget {
  final int id;

  const ProductDetailView({Key key, this.id}) : super(key: key);
  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Future<bool> request;
  @override
  void initState() {
    super.initState();
    request =
        Provider.of<ProductViewModel>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final int index = widget.id;
    return SafeArea(
      child: Scaffold(
        appBar: AppBarProvider.marketyoAppBarWithReturn(context, scaffoldKey),
        body: FutureBuilder(
            future: request,
            builder: (context, snapshot) {
              return Consumer<ProductViewModel>(
                  builder: (context, productController, _) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.network(
                              productController.products[index].image
                                      .substring(0, 4) +
                                  's' +
                                  productController.products[index].image
                                      .substring(4),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50,
                        ),
                        buildContainer(context, 'Ürün İsmi:',
                            productController.products[index].name),
                        buildContainer(context, 'Detay:',
                            productController.products[index].detail),
                        buildContainer(context, 'Bilgi:',
                            productController.products[index].info),
                        buildContainer(context, 'Fiyat:',
                            productController.products[index].price),
                        buildContainer(context, 'Hero:',
                            productController.products[index].hero),
                        buildContainer(context, 'Teklif:',
                            productController.products[index].offer),
                      ],
                    ),
                  );
                } else if (snapshot.hasData == false ||
                    snapshot.hasData == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SizedBox();
              });
            }),
      ),
    );
  }

  Container buildContainer(BuildContext context, String title, String field) {
    return Container(
      height: MediaQuery.of(context).size.height / 14,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
      child: Card(
        color: Color(0xFF0C7254),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  field == null ? "Eksik bilgi." : field,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
