part of 'cart_cubit.dart';

class CartState {
  final List<dynamic> sepet;
  final bool? paymentCard; 

 CartState({required this.sepet, this.paymentCard}); 


  CartState copyWith({List<dynamic>? sepet, bool? paymentCard}) {
    return CartState(
      sepet: sepet ?? this.sepet,
      paymentCard: paymentCard ?? this.paymentCard,
    );
  }
}