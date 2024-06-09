import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/bloc/client/client_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/products/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localizations.dart';

class Fashion extends StatefulWidget {
  const Fashion({Key? key}) : super(key: key);

  @override
  State<Fashion> createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  var products = [
    {
      "id": 11,
      "name": "DeFacto Eşofman Altı Erkek",
      "in-stock": true,
      "price": 550.00,
      "photo": "https://m.media-amazon.com/images/I/61kouR1q+vL._AC_SY741_.jpg",
    },
    {
      "id": 13,
      "name": " Düz Beyaz Erkek T-Shirt ",
      "in-stock": true,
      "price": 329.99,
      "photo":
          "https://statics.boyner.com.tr/mnresize/1100/-/productimages/5002736917_100_01_900_1254.jpg",
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
    Color textColor = Colors.black; //Theme.of(context).textTheme.bodyText1!.color!; //todo

    return Scaffold(
      appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 5, 40, 70),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go("/home");
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
