import 'package:get_it/get_it.dart';
import 'package:shamo_clone/data/datasources/auth_remote_data_source.dart';
import 'package:shamo_clone/data/datasources/product_remote_data_source.dart';
import 'package:shamo_clone/data/datasources/profile_remote_data_source.dart';
import 'package:shamo_clone/data/datasources/transaction_remote_data_source.dart';
import 'package:shamo_clone/data/datasources/wishlist_local_data_source.dart';
import 'package:shamo_clone/data/repositories/auth_repository_impl.dart';
import 'package:shamo_clone/data/repositories/cart_repository_impl.dart';
import 'package:shamo_clone/data/repositories/product_repository_impl.dart';
import 'package:shamo_clone/data/repositories/profile_repository_impl.dart';
import 'package:shamo_clone/data/repositories/transaction_repository_impl.dart';
import 'package:shamo_clone/data/repositories/wishlist_repository_impl.dart';
import 'package:shamo_clone/domain/repositories/auth_repository.dart';
import 'package:shamo_clone/domain/repositories/cart_repository.dart';
import 'package:shamo_clone/domain/repositories/product_repository.dart';
import 'package:shamo_clone/domain/repositories/profile_repository.dart';
import 'package:shamo_clone/domain/repositories/transaction_repository.dart';
import 'package:shamo_clone/domain/repositories/wishlist_repository.dart';
import 'package:shamo_clone/domain/usecases/checkout_order.dart';
import 'package:shamo_clone/domain/usecases/clear_cart.dart';
import 'package:shamo_clone/domain/usecases/clear_wishlist.dart';
import 'package:shamo_clone/domain/usecases/get_cart_by_id.dart';
import 'package:shamo_clone/domain/usecases/get_categories.dart';
import 'package:shamo_clone/domain/usecases/get_product_by_id.dart';
import 'package:shamo_clone/domain/usecases/get_products.dart';
import 'package:shamo_clone/domain/usecases/get_products_by_category.dart';
import 'package:shamo_clone/domain/usecases/get_profile.dart';
import 'package:shamo_clone/domain/usecases/get_transactions.dart';
import 'package:shamo_clone/domain/usecases/get_wishlist_by_id.dart';
import 'package:shamo_clone/domain/usecases/insert_cart.dart';
import 'package:shamo_clone/domain/usecases/insert_wishlist.dart';
import 'package:shamo_clone/domain/usecases/remove_cart.dart';
import 'package:shamo_clone/domain/usecases/remove_wishlist.dart';
import 'package:shamo_clone/domain/usecases/sign_in.dart';
import 'package:shamo_clone/domain/usecases/sign_up.dart';
import 'package:shamo_clone/domain/usecases/update_cart.dart';
import 'package:shamo_clone/domain/usecases/update_profile.dart';
import 'package:shamo_clone/helpers/cart_model_mapper.dart';
import 'package:shamo_clone/helpers/checkout_order_mapper.dart';
import 'package:shamo_clone/helpers/dio_helper.dart';
import 'package:shamo_clone/helpers/user_model_mapper.dart';
import 'package:shamo_clone/helpers/wishlist_model_mapper.dart';
import 'package:shamo_clone/presentation/providers/auth_provider.dart';
import 'package:shamo_clone/presentation/providers/cart_provider.dart';
import 'package:shamo_clone/presentation/providers/checkout_provider.dart';
import 'package:shamo_clone/presentation/providers/product_detail_provider.dart';
import 'package:shamo_clone/presentation/providers/home_page_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shamo_clone/presentation/providers/profile_provider.dart';
import 'package:shamo_clone/presentation/providers/transaction_provider.dart';
import 'package:shamo_clone/presentation/providers/wishlist_provider.dart';

import 'data/datasources/cart_local_data_source.dart';
import 'data/datasources/db/database_helper.dart';
import 'domain/usecases/get_cart.dart';
import 'domain/usecases/get_wishlist.dart';

final locator = GetIt.instance;
void init() {
  locator.registerFactory(
    () => HomePageProvider(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => AuthProvider(
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => ProfileProvider(
      getProfile: locator(),
      updateProfile: locator(),
      clearCart: locator(),
      clearWishlist: locator(),
    ),
  );
  locator.registerFactory(
    () => ProductDetailProvider(
      insertWishlist: locator(),
      getWishlistById: locator(),
      removeWishlist: locator(),
      getProductById: locator(),
      getCartById: locator(),
      insertCart: locator(),
      updateCart: locator(),
    ),
  );

  locator.registerFactory(
    () => WishlistProvider(
      removeWishlist: locator(),
      getWishlist: locator(),
    ),
  );

  locator.registerFactory(
    () => CartProvider(
      removeCart: locator(),
      updateCart: locator(),
      getCart: locator(),
    ),
  );

  locator.registerFactory(
    () => CheckoutProvider(
      checkout: locator(),
      clearCart: locator(),
    ),
  );

  locator.registerFactory(
    () => TransactionProvider(
      getTransactions: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(
    () => GetProducts(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => SignUp(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => SignIn(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetCategories(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetProductsByCategories(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetProfile(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateProfile(
      locator(),
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => InsertWishlist(
      locator(),
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => RemoveWishlist(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetWishlistById(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetWishlist(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetProductById(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetCart(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetCartById(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => RemoveCart(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => UpdateCart(
      locator(),
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => InsertCart(
      locator(),
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => CheckoutOrder(
      locator(),
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => ClearCart(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetTransactions(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => ClearWishlist(
      locator(),
    ),
  );

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      dataSource: locator(),
    ),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(
      dio: locator(),
    ),
  );
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSourceImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(
      locator(),
    ),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerSingleton<UserModelMapper>(UserModelMapper());
  locator.registerSingleton<WishlistMapper>(WishlistMapper());
  locator.registerSingleton<CartModelMapper>(CartModelMapper());
  locator.registerSingleton<CheckoutOrderMapper>(CheckoutOrderMapper());
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DioHelper().getDioClient());
}
