import 'package:shamo_clone/data/models/order_model.dart';
import 'package:shamo_clone/domain/entities/order.dart';

class CheckoutOrderMapper {
  OrderModel fromEntity(OrderEntity order) => OrderModel(
        address: order.address,
        items: order.items.map((e) => orderItemFromEntity(e)).toList(),
        status: order.status,
        totalPrice: order.totalPrice,
        shippingPrice: order.shippingPrice,
      );

  OrderItemModel orderItemFromEntity(OrderItem item) => OrderItemModel(
        id: item.id,
        quantity: item.quantity,
      );
}
