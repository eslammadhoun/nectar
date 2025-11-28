import 'package:nectar/V2/Core/utils/network_connection/network_connection_vm.dart';
import 'package:nectar/V2/Data/repositories/cart_repo.dart';
import 'package:nectar/V2/Data/repositories/favorite_repo.dart';
import 'package:nectar/V2/Data/repositories/products_repo.dart';
import 'package:nectar/V2/Data/services/auth_service.dart';
import 'package:nectar/V2/features/account/account_page.dart';
import 'package:nectar/V2/features/account/account_page_vm.dart';
import 'package:nectar/V2/features/cart/cart_page_vm.dart';
import 'package:nectar/V2/features/category/catecory_vm.dart';
import 'package:nectar/V2/features/favourite/favourite_page_vm.dart';
import 'package:nectar/V2/features/home/home_page_vm.dart';
import 'package:nectar/V2/features/location/location_page_vm.dart';
import 'package:nectar/V2/features/login/login_page_vm.dart';
import 'package:nectar/V2/features/product_details/product_details_vm.dart';
import 'package:nectar/V2/features/shop/shop_page_vm.dart';
import 'package:nectar/V2/features/signup/sign_up_vm.dart';
import 'package:nectar/V2/features/splash/splash_page_vm.dart';
import 'package:nectar/V2/features/widgets/cart_product/cart_product_vm.dart';
import 'package:nectar/V2/features/widgets/product_card/product_card_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  // ViewModels
  ChangeNotifierProvider(create: (_) => SplashPageVm()),
  ChangeNotifierProvider(create: (_) => HomePageVm()),
  ChangeNotifierProvider(create: (_) => LoginPageVm()),
  ChangeNotifierProvider(create: (_) => SignUpVm()),
  ChangeNotifierProvider(create: (_) => LocationPageVm()),
  ChangeNotifierProvider(create: (_) => NetworkViewModel()),

  // DI Providers
  ChangeNotifierProvider(create: (_) => ShopPageVm(productsRepo: ProductsRepo())),
  ChangeNotifierProvider(create: (_) => ProductCardVm(cartRepo: CartRepo())),
  ChangeNotifierProvider(create: (_) => ProductDetailsVm(cartRepo: CartRepo(), favoriteRepo: FavoriteRepo())),
  ChangeNotifierProvider(create: (_) => CategoryPageVm(productsRepo: ProductsRepo())),
  ChangeNotifierProvider(create: (_) => CartPageVm(cartRepo: CartRepo())),
  ChangeNotifierProvider(create: (_) => CartProductVm(cartRepo: CartRepo())),
  ChangeNotifierProvider(create: (_) => FavouritePageVm(favRepo: FavoriteRepo(), cartRepo: CartRepo())),
  ChangeNotifierProvider(create: (_) => AccountPageVm(authService: AuthService())),
];
