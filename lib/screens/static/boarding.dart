import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:preload_page_view/preload_page_view.dart';

// ignore: unused_import
import '../../core/storage.dart';
import '../../widgets/page/boarding_item.dart';
// ignore: unused_import
import '../client/register.dart'; // RegisterScreen'ı import ediyoruz

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final boardingData = [
    {
      "image":
          "https://img.freepik.com/premium-vector/people-choosing-items-laptop-screen-computer-app-online-shopping-digital-marketing-ecommerce-concept_48369-42209.jpg?w=900",
      "title": "One best app for all your needs",
      "description":
          "eays shopping for all your needs just in hand, trusted by millions of people in the world",
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/online-purchase-illustration-concept-flat-illustration-isolated-white-background_701961-9664.jpg?w=996",
      "title": "Get real-time updates for all deliveries",
      "description":
          "Eays shopping for all your needs just in hand, trusted by millions of people in the world",
    },
    {
      "image":
          "https://img.freepik.com/premium-vector/deliveryman-checking-delivery-order_701961-9189.jpg?w=996",
      "title": "Follow and get update from favorite store",
      "description":
          "Eays shopping for all your needs just in hand, trusted by millions of people in the world",
    },
  ];

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(0), // AppBar'ın yüksekliğini 0 olarak ayarla
        child: AppBar(
          backgroundColor:
              Colors.transparent, // AppBar'ın arka planını şeffaf yap
          elevation: 0, // Gölgelendirmeyi kaldır
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PreloadPageView.builder(
                itemCount: boardingData.length,
                preloadPagesCount: boardingData.length,
                onPageChanged: (value) {
                  setState(() {
                    page = value;
                  });
                },
                itemBuilder: (context, index) => BoardingItem(
                  image: boardingData[index]["image"]!,
                  title: boardingData[index]["title"]!,
                  description: boardingData[index]["description"]!,
                ),
              ),
            ),
            // Ekranın altında sıralı olarak gösterilecek olan sayfa işaretçileri
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  boardingData.length,
                  (index) => Container(
                    width: 20,
                    height: 4,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: page == index
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : Color.fromARGB(255, 92, 92, 92),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
            // Kaydolma sayfasına yönlendiren buton
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go(
                    '/login'); // /register yerine /login olarak değiştirildi
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Get Started',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 5, 40, 70)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "By tapping 'Get Started' and using the ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    " Shopline app, you're agreeing to our",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Terms of Service',
                        style: TextStyle(
                          color: Color.fromARGB(255, 223, 216, 154),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        ' and ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigasyon işlemleri için burada gerekli kodlar
                        },
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: Color.fromARGB(255, 223, 216, 154),
                            fontSize: 12,
                          ),
                        ),
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
