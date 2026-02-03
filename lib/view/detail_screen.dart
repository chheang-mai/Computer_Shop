import 'package:computer_shop/bloc/cart_bloc.dart';
import 'package:computer_shop/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_bloc.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
  
}



class _DetailScreenState extends State<DetailScreen> {
  @override
void initState() {
  super.initState();
  context.read<CounterBloc>().add(ResetCounter());
}

  Widget _specChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.product.price ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(title: Text(widget.product.name ?? "Detail"), centerTitle: true),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          final qty = state.count;
          final total = price * qty;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                    color: Colors.black.withOpacity(0.08),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: AspectRatio(
                        aspectRatio: 1.2,
                        child: Image.network(
                          widget.product.image ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.broken_image, size: 44),
                          ),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Text(
                          widget.product.brand ?? "",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          (widget.product.stock ?? 0) > 0
                              ? "Stock: ${widget.product.stock}"
                              : "Out of Stock",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: (widget.product.stock ?? 0) > 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      widget.product.name ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "\$${price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        if ((widget.product.cpu ?? "").isNotEmpty)
                          _specChip("CPU: ${widget.product.cpu}"),
                        if ((widget.product.ram ?? "").isNotEmpty)
                          _specChip("RAM: ${widget.product.ram}"),
                        if ((widget.product.storage ?? "").isNotEmpty)
                          _specChip("Storage: ${widget.product.storage}"),
                        if ((widget.product.gpu ?? "").isNotEmpty)
                          _specChip("GPU: ${widget.product.gpu}"),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              IconButton(
  onPressed: qty > 1
      ? () => context.read<CounterBloc>().add(Decrement())
      : null,
  icon: const Icon(Icons.remove),
),

                              Text(
                                qty.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<CounterBloc>().add(Increment());
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "\$${total.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),

                        // ✅ FIXED: use your bloc event
                        onPressed: (widget.product.stock ?? 0) <= 0
                            ? null
                            : () {
                                context.read<CartBloc>().add(
                                  AddToCart(item: Product(
                                    id: widget.product.id, 
                                    name:  widget.product.name, 
                                    brand:  widget.product.brand, 
                                    cpu:  widget.product.cpu, 
                                    ram:  widget.product.ram, 
                                    storage:  widget.product.storage, 
                                    gpu:  widget.product.gpu, 
                                    price:  widget.product.price, 
                                    stock: qty, 
                                    image:  widget.product.image, 
                                    created_at:  widget.product.created_at, 
                                    updated_at:  widget.product.updated_at
                                  )),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${widget.product.name} added to cart ✅",
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },

                        icon: const Icon(Icons.shopping_cart_checkout),
                        label: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
