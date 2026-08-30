import 'package:crafty_bay/app/providers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/category/presentation/providers/category_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../category/presentation/screens/category_screen.dart';
import '../../../home/presentation/providers/home_sliders_provider.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../wishlist/presentation/screens/wishlist_screen.dart';
import '../providers/main_nav_holder_provider.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});

  static const String name = '/main-nav-holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    WishlistScreen(),
  ];

  final HomeSlidersProvider _homeSlidersProvider = HomeSlidersProvider();
  final CategoryListProvider _categoryListProvider = CategoryListProvider();

  @override
  void initState() {
    super.initState();
    _homeSlidersProvider.getHomeSliders();
    _categoryListProvider.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _homeSlidersProvider),
        ChangeNotifierProvider.value(value: _categoryListProvider),
      ],
      child: Consumer<MainNavHolderProvider>(
        builder: (context, mainNavHolderProvider, _) {
          return Scaffold(
            body: _screens[mainNavHolderProvider.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: mainNavHolderProvider.selectedIndex,
              onTap: (index) async {
                if (index == 2 || index == 3) {
                 if (await AuthController.isLoggedIn() == false) {
                   Navigator.pushNamed(context, SignInScreen.name);
                   return;
                 }
                }

                mainNavHolderProvider.changeIndex(index);
              },
              selectedItemColor: AppColors.themeColor,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Carts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Wishlist',
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
