import 'package:flutter/material.dart';
import 'package:marketyo_developer_challenge/components/appbar_provider.dart';
import 'package:marketyo_developer_challenge/view_models/product_view_model.dart';
import 'package:marketyo_developer_challenge/views/login_view.dart';
import 'package:marketyo_developer_challenge/views/product_detail_view.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatefulWidget {
  final bool isLoggedIn;

  const ProductsView({Key key, this.isLoggedIn}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
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
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBarProvider.marketyoAppBar(context, scaffoldKey),
            body: FutureBuilder(
                future: request,
                builder: (context, snapshot) {
                  return Consumer<ProductViewModel>(
                      builder: (context, productController, _) {
                    if (snapshot.hasData) {
                      return Container(
                        child: GridView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2,
                                    childAspectRatio:
                                        size.width / (size.height / 1.25),
                                    mainAxisSpacing: 2),
                            itemCount: productController.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 5.0, left: 5, top: 5),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.isLoggedIn
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailView(
                                                  id: index,
                                                ),
                                              ),
                                            )
                                          : _showAlertDialog(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      width: size.width / 2.2,
                                      height: size.height / 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.transparent,
                                                    blurRadius: 2,
                                                    offset: Offset(0, 15),
                                                  ),
                                                ],
                                              ),
                                              width: size.width / 2.2,
                                              height: size.height / 5,
                                              child: Image.network(
                                                productController
                                                        .products[index].image
                                                        .substring(0, 4) +
                                                    's' +
                                                    productController
                                                        .products[index].image
                                                        .substring(4),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: size.height / 200,
                                            color: Color(0xFF0C7254),
                                          ),
                                          Text(
                                            productController
                                                .products[index].name,
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w900,
                                                fontSize: 17,
                                                color: Color(0xFF0C7254),
                                                letterSpacing: 1.35),
                                          ),
                                          Text(
                                            productController
                                                .products[index].price,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 17,
                                                color: Color(0xFF0C7254),
                                                letterSpacing: 1.35),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else if (snapshot.hasData == false ||
                        snapshot.hasData == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox();
                  });
                })),
      ),
    );
  }
}

_showAlertDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    height: MediaQuery.of(context).size.height / 15,
    color: Color(0xFF0C7254),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            padding: EdgeInsets.all(12),
            icon: Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        Text(
          "Vazgeç",
          style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ],
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    onPressed: () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
          (route) => false);
    },
    height: MediaQuery.of(context).size.height / 15,
    color: Color(0xFF0C7254),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            padding: EdgeInsets.all(12),
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                  (route) => false);
            }),
        Text(
          "Tamam",
          style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ],
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.warning_amber_outlined),
                color: Color(0xFF0C7254),
                onPressed: () {},
              ),
              Text(
                'Ürün detay sayfasını görüntülemek için Kullanıcı Adı ve Şifre alanlarını doldurmalısınız. Tekrar giriş yap?',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 15,
                  color: Color(0xFF0C7254),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    color: Color(0xFF0C7254),
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 3,
                    child: cancelButton,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 100,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                        (route) => false);
                  },
                  child: Container(
                    color: Color(0xFF0C7254),
                    height: MediaQuery.of(context).size.height / 15,
                    child: continueButton,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
