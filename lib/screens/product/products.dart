import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/bloc/client/client_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/products/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localizations.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var products = [
    {
      "id": 1,
      "name": "MacBook Pro 2024 M2",
      "in-stock": true,
      "price": 65000.00,
      "photo":
          "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
    },
    {
      "id": 2,
      "name": "REVOLA",
      "in-stock": true,
      "price": 7500.00,
      "photo":
          "https://www.shutterstock.com/image-photo/modern-car-wheel-high-definition-600nw-2302034581.jpg",
    },
    {
      "id": 3,
      "name": "Vites Topuzu",
      "in-stock": true,
      "price": 155.00,
      "photo": "https://m.media-amazon.com/images/I/71tc-FDoZ4L._AC_SX679_.jpg",
    },
    {
      "id": 4,
      "name": "Küçük Ağa",
      "in-stock": true,
      "price": 221.80,
      "photo":
          "https://i.dr.com.tr/cache/500x400-0/originals/0000000145836-1.jpg",
    },
    {
      "id": 5,
      "name": "Çim Biçme Makinesi",
      "in-stock": true,
      "price": 5997.00,
      "photo": "https://m.media-amazon.com/images/I/818nUzGCGRL._AC_SX522_.jpg",
    },
    {
      "id": 6,
      "name": "Nutuk",
      "in-stock": true,
      "price": 181.25,
      "photo":
          "https://img.kitapyurdu.com/v1/getImage/fn:11788244/wh:true/wi:220",
    },
    {
      "id": 7,
      "name": "Profesyonel Yabani Ot Fırçası",
      "in-stock": true,
      "price": 455.00,
      "photo":
          "https://m.media-amazon.com/images/I/81LuFYU9ePL._AC_SL1000_.jpg",
    },
    {
      "id": 8,
      "name": "Futbol Topu - Şampiyonlar Ligi",
      "in-stock": true,
      "price": 1500.00,
      "photo":
          "https://contents.mediadecathlon.com/p2673824/k25d8e4de2dcf872e88bb9d5f33487cc0/sq/futbol-topu-sampiyonlar-ligi-2024-5-numara-adidas.jpg?format=auto&f=969x969",
    },
    {
      "id": 9,
      "name": "Basketbol Topu",
      "in-stock": true,
      "price": 755.00,
      "photo":
          "https://contents.mediadecathlon.com/p2591881/k/sq/basketbol-topu-7-numara-sari-siyah-resist-900-basketbol.jpg?format=auto&f=969x969",
    },
    {
      "id": 10,
      "name": "Cort Akustik Gitar",
      "in-stock": true,
      "price": 5550.70,
      "photo": "https://m.media-amazon.com/images/I/61fPooC-2LL._AC_SY879_.jpg",
    },
    {
      "id": 11,
      "name": "DeFacto Eşofman Altı Erkek",
      "in-stock": true,
      "price": 550.00,
      "photo": "https://m.media-amazon.com/images/I/61kouR1q+vL._AC_SY741_.jpg",
    },
    {
      "id": 12,
      "name": "Cort AD810OP Akustik Gitar",
      "in-stock": true,
      "price": 5203.90,
      "photo": "https://m.media-amazon.com/images/I/71aHoX9sr9L._AC_SY879_.jpg",
    },
    {
      "id": 13,
      "name": " Düz Beyaz Erkek T-Shirt ",
      "in-stock": true,
      "price": 329.99,
      "photo":
          "https://statics.boyner.com.tr/mnresize/1100/-/productimages/5002736917_100_01_900_1254.jpg",
    },
    {
      "id": 14,
      "name": "Cort Elektro Gitar X100 OPBB",
      "in-stock": true,
      "price": 7288.90,
      "photo": "https://m.media-amazon.com/images/I/61mMW2u-PfL._AC_SY879_.jpg",
    },
    {
      "id": 15,
      "name": "Eraser Kapatıcı ",
      "in-stock": true,
      "price": 309.99,
      "photo": "https://m.media-amazon.com/images/I/61vWUDVGNjL._AC_SX679_.jpg",
    },
    {
      "id": 16,
      "name": " Hawk Gaming Oyuncu Koltuğu",
      "in-stock": true,
      "price": 6900.00,
      "photo": "https://m.media-amazon.com/images/I/618dEWc51GL._AC_SY879_.jpg",
    },
    {
      "id": 17,
      "name": " HyperX Cloud II Oyuncu Kulaklığı",
      "in-stock": true,
      "price": 6599.00,
      "photo": "https://m.media-amazon.com/images/I/61fsEVFmu6L._AC_SX679_.jpg",
    },
    {
      "id": 18,
      "name": "Logitech G G305 Oyuncu Mouse",
      "in-stock": true,
      "price": 1247.30,
      "photo": "https://m.media-amazon.com/images/I/51VpABY-b6L._AC_SX679_.jpg",
    },
    {
      "id": 19,
      "name": "LOreal Paris Telescopic Maskara ",
      "in-stock": true,
      "price": 259.0,
      "photo":
          "https://m.media-amazon.com/images/I/61qmkbOoLnL.__AC_SX300_SY300_QL70_ML2_.jpg",
    },
    {
      "id": 20,
      "name": "Kürk Mantolu Madonna",
      "in-stock": true,
      "price": 18.10,
      "photo":
          "https://i.dr.com.tr/cache/500x400-0/originals/0000000058245-1.jpg",
    },
    {
      "id": 21,
      "name": "İphone 14 Pro 256GB",
      "in-stock": true,
      "price": 69000.00,
      "photo":
          "https://www.notebookcheck-tr.com/typo3temp/_processed_/8/e/csm_Bild_Apple_iPhone_14_Pro-3956_797631d4b6.jpg",
    },
  ];

  late ProductsCubit productsCubit;
  late CartCubit cartCubit;
  late ClientCubit clientCubit;

  @override
  void initState() {
    super.initState();
    productsCubit = context.read<ProductsCubit>();
    cartCubit = context.read<CartCubit>();
    clientCubit = context.read<ClientCubit>();
  }

  void toggleDarkMode() {
    if (clientCubit.state.darkMode) {
      clientCubit.changeDarkMode(darkMode: false);
    } else {
      clientCubit.changeDarkMode(darkMode: true);
    }
  }

  @override
  Widget build(BuildContext context) {  
    Color textColor = Colors.black; //Theme.of(context).textTheme.bodyText1!.color!; //todo Color textColor = Theme.of(context).textTheme.bodyText1!.color!;
    return Scaffold(
      appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 5, 40, 70),
  
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
               GoRouter.of(context).go('/home');
          },
        ),
        title: Text(AppLocalizations.of(context).getTranslate("products"),  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: toggleDarkMode,
              icon: Icon(
                  clientCubit.state.darkMode ? Icons.sunny : Icons.nightlight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: IconButton(
              onPressed: () {
                if (clientCubit.state.language == "tr") {
                  clientCubit.changeLanguage(language: "en");
                } else {
                  clientCubit.changeLanguage(language: "tr");
                }
              },
              icon: Icon(Icons.language),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: IconButton(
              onPressed: () => GoRouter.of(context).go('/favorites'),
              icon: Icon(Icons.favorite),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => GoRouter.of(context).go('/cart'),
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return SizedBox.expand(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  GoRouter.of(context)
                      .push("/product/${products[index]["id"].toString()}");
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.all(14.0),
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Image.network(
                        products[index]["photo"].toString(),
                        fit: BoxFit.contain,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              products[index]["name"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (productsCubit.isFavorite(
                              int.parse(products[index]["id"].toString())))
                            IconButton(
                              onPressed: () {
                                productsCubit.removeFromFavorites(int.parse(
                                    products[index]["id"].toString()));
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            )
                          else
                            IconButton(
                              onPressed: () {
                                productsCubit.addToFavorites(products[index]);
                              },
                              icon: const Icon(Icons.favorite_border),
                            ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      if (products[index]["in-stock"] as bool)
                        ElevatedButton.icon(
                          onPressed: () {
                            cartCubit.sepeteEkle(
                              id: int.parse(products[index]["id"].toString()),
                              photo: products[index]["photo"].toString(),
                              ad: products[index]["name"].toString(),
                              sayi: 1,
                              fiyat: products[index]["price"] as double,
                            );

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  AppLocalizations.of(context)
                                      .getTranslate("cart"),
                                ),
                                content: Text(
                                  AppLocalizations.of(context)
                                      .getTranslate("added-to-cart"),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            GoRouter.of(context).go('/cart'),
                                        child: Text("Sepete Git"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            GoRouter.of(context).pop(),
                                        child: Text("X"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          label: Text(
                            AppLocalizations.of(context)
                                .getTranslate("add_to_basket"),
                            style: TextStyle(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 3, 23, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      if (products[index]["in-stock"] as bool)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.check_box),
                                Text(
                                  AppLocalizations.of(context)
                                      .getTranslate("in-stock"),
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              products[index]["price"].toString() + " ₺",
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            const Icon(Icons.error),
                            Text(
                              AppLocalizations.of(context)
                                  .getTranslate("not-available"),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
