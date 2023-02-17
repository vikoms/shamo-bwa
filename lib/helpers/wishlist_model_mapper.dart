import 'package:shamo_clone/data/models/wishlist_model.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';

class WishlistMapper {
  WishListModel fromEntity(Wishlist wishlist) => WishListModel(
        id: wishlist.id,
        name: wishlist.name,
        price: wishlist.price,
        photo: wishlist.photo,
      );
}
