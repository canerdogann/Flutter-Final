import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../bloc/cart/cart_cubit.dart';
import '../bloc/client/client_cubit.dart';
import '../core/localizations.dart';
// ignore: unused_import
import '../../bloc/products/products_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ClientCubit clientCubit;
  late CartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    cartCubit = context.read<CartCubit>();
    clientCubit = context.read<ClientCubit>();
    clientCubit = context.read<ClientCubit>();
    cartCubit = context.read<CartCubit>();
  }

  Map<String, dynamic> states = {};

  Future<void> _signOut() async {
    GoRouter.of(context).go('/boarding');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
      return Scaffold(
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 5, 40, 70),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/profile');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                      ),
                      const Gap(20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PROFILE",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text('Home',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                selected: true,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.train,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: Text(
                    AppLocalizations.of(context).getTranslate("hakkımızda"),
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.help_center,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text('Iletisim',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SwitchListTile(
                value: clientCubit.state.darkMode,
                onChanged: (value) {
                  clientCubit.changeDarkMode(darkMode: value);
                },
                secondary: clientCubit.state.darkMode
                    ? const Icon(Icons.sunny)
                    : const Icon(Icons.nightlight),
                title: const Text('Gece Modu',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.credit_card,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text('Odeme',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {
                  GoRouter.of(context).push("/payment");
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text('Ayarlar',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {
                  GoRouter.of(context).push("/settings");
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.shopping_bag,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text('Ürünler',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {
                  GoRouter.of(context).push("/products");
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: Text(
                    AppLocalizations.of(context).getTranslate("sign-out"),
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                onTap: _signOut,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 5, 40, 70),
          title: Text(
            AppLocalizations.of(context).getTranslate("home_title"),
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  if (clientCubit.state.language == "tr") {
                    clientCubit.changeLanguage(language: "en");
                  } else {
                    clientCubit.changeLanguage(language: "tr");
                  }
                },
                icon: Icon(Icons.language),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            if (clientCubit.state.darkMode)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    clientCubit.changeDarkMode(darkMode: false);
                  },
                  icon: Icon(Icons.sunny),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    clientCubit.changeDarkMode(darkMode: true);
                  },
                  icon: Icon(Icons.nightlight),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () => GoRouter.of(context).push("/cart"),
                icon: Icon(Icons.shopping_cart),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SizedBox.expand(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style:
                        TextStyle(color: Colors.grey), 
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).getTranslate('Ara...'),
                      hintStyle: TextStyle(
                          color: Colors.grey[400]), 
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      filled: true, 
                      fillColor: Colors.white, 
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.grey[400]!, 
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.grey[400]!, // Açık gri
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.grey[400]!, // Açık gri
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context).getTranslate('Categories'),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 40, 70),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 16.0,
                    children: [
                      _buildCategoryItem(
                          Icons.directions_car,
                          AppLocalizations.of(context)
                              .getTranslate('Automotive'), () {
                        GoRouter.of(context).go('/automotive');
                      }),
                      _buildCategoryItem(Icons.book, AppLocalizations.of(context)
                              .getTranslate('Book'), () {
                        GoRouter.of(context).go('/book');
                      }),
                      _buildCategoryItem(Icons.local_florist, AppLocalizations.of(context).getTranslate('Cosmetics'), () {
                        GoRouter.of(context).go('/cosmetics');
                      }),
                      _buildCategoryItem(Icons.games_outlined, AppLocalizations.of(context).getTranslate('Gaming'), () {
                        GoRouter.of(context).go('/gaming');
                      }),
                      _buildCategoryItem(Icons.computer, AppLocalizations.of(context).getTranslate('Electronics'), () {
                        GoRouter.of(context).go('/electronics');
                      }),
                      _buildCategoryItem(Icons.food_bank, AppLocalizations.of(context).getTranslate('Garden'), () {
                        GoRouter.of(context).go('/garden');
                      }),
                      _buildCategoryItem(Icons.dry_cleaning_rounded, AppLocalizations.of(context).getTranslate('Fashion'),
                          () {
                        GoRouter.of(context).go('/fashion');
                      }),
                      _buildCategoryItem(Icons.music_note,  AppLocalizations.of(context).getTranslate('Music'), () {
                        GoRouter.of(context).go('/music');
                      }),
                      _buildCategoryItem(Icons.sports_soccer,  AppLocalizations.of(context).getTranslate('Sports'), () {
                        GoRouter.of(context).go('/sports');
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 26.0),
                Center(
                  child: Text(
                    AppLocalizations.of(context).getTranslate('Bütün ürünlere ulaşmak için'),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 40, 70),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context).getTranslate('Resme tıkla'),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 40, 70),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/products');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://www.shutterstock.com/image-vector/3d-vector-shopping-trolley-parcel-600nw-2181843267.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCategoryItem(IconData icon, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 3 - 16,
        height: 75,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          color: Color.fromARGB(255, 5, 40, 70),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
