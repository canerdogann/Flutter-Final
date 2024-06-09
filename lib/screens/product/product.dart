import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/bloc/cart/cart_cubit.dart';
import 'package:flutter_advanced_dev/bloc/products/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  void addToCart(BuildContext context, Map<String, dynamic> product) {
    final cartCubit = context.read<CartCubit>();
    cartCubit.sepeteEkle(
      id: product["id"] as int,
      photo: product["photo"].toString(),
      ad: product["name"].toString(),
      sayi: 1,
      fiyat: product["price"] as double,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sepet"),
        content: Text("Ürün sepete eklendi."),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Tamam"),
          ),
        ],
      ),
    );
  }

  void toggleFavorite(BuildContext context, Map<String, dynamic> product) {
    final productsCubit = context.read<ProductsCubit>();

    if (productsCubit.isFavorite(product["id"] as int)) {
      productsCubit.removeFromFavorites(product["id"] as int);
    } else {
      productsCubit.addToFavorites(product);
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Favoriler"),
        content: Text("Ürün favorilere eklendi."),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Tamam"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     Color textColor = Colors.black; //Theme.of(context).textTheme.bodyText1!.color!; //todo

    return Scaffold(
      appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 5, 40, 70),

        title: Text(product["name"].toString(),  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              product["photo"].toString(),
              fit: BoxFit.contain,
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"].toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product["description"].toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${product["price"]} ₺",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => addToCart(context, product),
                        icon: Icon(Icons.shopping_cart),
                        label: Text("Sepete Ekle"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => toggleFavorite(context, product),
                        icon: product["in-stock"]
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                      ),
                      if (product["in-stock"])
                        Row(
                          children: [
                            const Icon(Icons.check_box),
                            SizedBox(width: 4),
                            Text(
                              "Stokta",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            const Icon(Icons.error),
                            SizedBox(width: 4),
                            Text(
                              "Stokta Yok",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Map<String, dynamic> getProductById(String? productId) {
  final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "MacBook Pro 2024 M2",
      "description": "MacBook Pro 2024 M2",
      "photo":
          "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
      "price": 65000.00,
      "in-stock": true,
    },
    {
      "id": 2,
      "name": "REVOLA",
      "description": "REVOLA",
      "photo":
          "https://www.shutterstock.com/image-photo/modern-car-wheel-high-definition-600nw-2302034581.jpg",
      "price": 7500.00,
      "in-stock": true,
    },
    {
      "id": 3,
      "name": "Vites Topuzu",
      "description": "Vitez Topuzu",
      "photo": "https://m.media-amazon.com/images/I/71tc-FDoZ4L._AC_SX679_.jpg",
      "price": 155.00,
      "in-stock": true,
    },
    {
      "id": 4,
      "name": "Küçük Ağa",
      "description": "Küçük Ağa Kitap",
      "photo":
          "https://i.dr.com.tr/cache/500x400-0/originals/0000000145836-1.jpg",
      "price": 221.80,
      "in-stock": true,
    },
    {
      "id": 5,
      "name": "Çim Biçme Makinesi",
      "description": "Çim Biçme Makinesi",
      "photo": "https://m.media-amazon.com/images/I/818nUzGCGRL._AC_SX522_.jpg",
      "price": 5997.00,
      "in-stock": true,
    },
    {
      "id": 6,
      "name": "Nutuk",
      "description": "Nutuk Kitap",
      "photo":
          "https://img.kitapyurdu.com/v1/getImage/fn:11788244/wh:true/wi:220",
      "price": 181.25,
      "in-stock": true,
    },
    {
      "id": 7,
      "name": "Profesyonel Yabani Ot Fırçası",
      "description": "Profesyonel Yabani Ot Fırçası",
      "photo":
          "https://m.media-amazon.com/images/I/81LuFYU9ePL._AC_SL1000_.jpg",
      "price": 455.00,
      "in-stock": true,
    },
    {
      "id": 8,
      "name": "Futbol Topu - Şampiyonlar Ligi",
      "description": "Futbol Topu - Şampiyonlar Ligi",
      "photo":
          "https://contents.mediadecathlon.com/p2673824/k25d8e4de2dcf872e88bb9d5f33487cc0/sq/futbol-topu-sampiyonlar-ligi-2024-5-numara-adidas.jpg?format=auto&f=969x969",
      "price": 1500.00,
      "in-stock": true,
    },
    {
      "id": 9,
      "name": "Basketbol Topu",
      "description": "Basketbol Topu",
      "photo":
          "https://contents.mediadecathlon.com/p2591881/k/sq/basketbol-topu-7-numara-sari-siyah-resist-900-basketbol.jpg?format=auto&f=969x969",
      "price": 755.00,
      "in-stock": true,
    },
    {
      "id": 10,
      "name": "Cort Akustik Gitar",
      "description": "Cort Akustik Gitar",
      "photo": "https://m.media-amazon.com/images/I/61fPooC-2LL._AC_SY879_.jpg",
      "price": 5550.70,
      "in-stock": true,
    },
    {
      "id": 11,
      "name": "DeFacto Eşofman Altı Erkek",
      "description": "DeFacto Eşofman Altı Erkek",
      "photo": "https://m.media-amazon.com/images/I/61kouR1q+vL._AC_SY741_.jpg",
      "price": 550.00,
      "in-stock": true,
    },
    {
      "id": 12,
      "name": "Cort AD810OP Akustik Gitar",
      "description": "Cort AD810OP Akustik Gitar",
      "photo": "https://m.media-amazon.com/images/I/71aHoX9sr9L._AC_SY879_.jpg",
      "price": 5203.90,
      "in-stock": true,
    },
    {
      "id": 13,
      "name": " Düz Beyaz Erkek T-Shirt ",
      "description": "Düz Beyaz Erkek T-Shirt",
      "photo":
          "https://statics.boyner.com.tr/mnresize/1100/-/productimages/5002736917_100_01_900_1254.jpg",
      "price": 329.99,
      "in-stock": true,
    },
    {
      "id": 14,
      "name": "Cort Elektro Gitar X100 OPBB",
      "description": "Cort Elektro Gitar X100 OPBB",
      "photo": "https://m.media-amazon.com/images/I/61mMW2u-PfL._AC_SY879_.jpg",
      "price": 7288.90,
      "in-stock": true,
    },
    {
      "id": 15,
      "name": "Eraser Kapatıcı ",
      "description": "Eraser Kapatıcı",
      "photo": "https://m.media-amazon.com/images/I/61vWUDVGNjL._AC_SX679_.jpg",
      "price": 309.99,
      "in-stock": true,
    },
    {
      "id": 16,
      "name": " Hawk Gaming Oyuncu Koltuğu",
      "description": "Hawk Gaming Oyuncu Koltuğu",
      "photo": "https://m.media-amazon.com/images/I/618dEWc51GL._AC_SY879_.jpg",
      "price": 6900.00,
      "in-stock": true,
    },
    {
      "id": 17,
      "name": " HyperX Cloud II Oyuncu Kulaklığı",
      "description": "HyperX Cloud II Oyuncu Kulaklığı",
      "photo": "https://m.media-amazon.com/images/I/61fsEVFmu6L._AC_SX679_.jpg",
      "price": 6599.00,
      "in-stock": true,
    },
    {
      "id": 18,
      "name": "Logitech G G305 Oyuncu Mouse",
      "description": "Logitech G G305 Oyuncu Mouse",
      "photo": "https://m.media-amazon.com/images/I/51VpABY-b6L._AC_SX679_.jpg",
      "price": 1247.30,
      "in-stock": true,
    },
    {
      "id": 19,
      "name": "LOreal Paris Telescopic Maskara ",
      "description": "LOreal Paris Telescopic Maskara",
      "photo":
          "https://m.media-amazon.com/images/I/61qmkbOoLnL.__AC_SX300_SY300_QL70_ML2_.jpg",
      "price": 259.0,
      "in-stock": true,
    },
    {
      "id": 20,
      "name": "Kürk Mantolu Madonna",
      "description": "Kürk Mantolu Madonna",
      "photo":
          "https://i.dr.com.tr/cache/500x400-0/originals/0000000058245-1.jpg",
      "price": 18.10,
      "in-stock": true,
    },
    {
      "id": 21,
      "name": "İphone 14 Pro 256GB",
      "description": "İphone 14 Pro 256GB",
      "in-stock": true,
      "price": 69000.00,
      "photo":
          "https://www.notebookcheck-tr.com/typo3temp/_processed_/8/e/csm_Bild_Apple_iPhone_14_Pro-3956_797631d4b6.jpg",
    },
  ];

  final int id = int.parse(productId!);
  return products.firstWhere((product) => product["id"] == id);
}
