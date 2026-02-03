import 'package:computer_shop/view/comfirm_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:computer_shop/bloc/cart_bloc.dart';
import 'package:computer_shop/model/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => bloc.add(ClearCart()),
          ),
        ],
      ),

      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartList.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }

          // ✅ Subtotal 계산 (qty = product.stock 사용한 기준)
          double subTotal = 0;
          for (final p in state.cartList) {
            final price = p.price ?? 0;
            final qty = p.stock ?? 1; // you are showing stock as quantity
            subTotal += price * qty;
          }

          const double delivery = 2.00; // you can change
          final double total = subTotal + delivery;

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.cartList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final Product product = state.cartList[index];

                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.image ?? "",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.brand ?? "",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "\$${(product.price ?? 0).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            onPressed: () => bloc.add(Decrements(index: index)),
                            icon: const Icon(Icons.remove),
                          ),

                          Text("${product.stock ?? 1}"),

                          IconButton(
                            onPressed: () => bloc.add(Increments(index: index)),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // ✅ Summary + checkout (simple)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Subtotal: \$${subTotal.toStringAsFixed(2)}"),
                    const SizedBox(height: 6),
                    Text("Delivery: \$${delivery.toStringAsFixed(2)}"),
                    const Divider(height: 20),
                    Text(
                      "Total: \$${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: checkout action
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmOrder()));
                      },
                      child: const Text("Checkout"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
