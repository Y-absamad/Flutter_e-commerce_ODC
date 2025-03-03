import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_odc/core/widgets/custom_button.dart';
import 'package:flutter_ecommerce_odc/feature/card/logic/cart_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../profile/presentation/screens/payment_method.dart';
import '../data/model/product_card_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.watch<CartCubit>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: ConditionalBuilder(
              condition: cubit.products.isNotEmpty,
              builder: (context) => Column(
                children: [
                  _buildAddressSection(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.products.length,
                    itemBuilder: (context, index) {
                      final product = cubit.products[index];
                      return _buildCartItem(product, cubit, index);
                    },
                  ),
                  _buildShippingSection(),
                  _buildPaymentSummary(cubit),
                ],
              ),
              fallback: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 180),
                    SvgPicture.asset('assets/imageSvg/cartempty.svg'),
                    const SizedBox(height: 10),
                    Text(
                      "Your cart is an empty!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('Looks like you haven\'t added anything to your cart yet'),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: cubit.products.isEmpty
              ? SizedBox()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: CustomButton(
                    label: 'Pay \$${(cubit.totalPrice + 8).toStringAsFixed(2)}',
                    onPressed: () {},
                  ),
                ),
        );
      },
    );
  }

  Widget _buildAddressSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.home, color: Colors.black87, size: 30),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '123 Main Street, Maderd City',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.edit, size: 18, color: Colors.blue),
                      label: const Text(
                        'Edit Address',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(ProductCartModel product, CartCubit cubit, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Image.network(
            product.image ?? '',
            width: 80,
            height: 80,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    maxLines: 1,
                    product.title ?? 'No Title',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('\$${product.price?.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () =>
                    cubit.updateQuantity(product.id!, product.quantity! - 1),
              ),
              Text('${product.quantity}'),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () =>
                    cubit.updateQuantity(product.id!, product.quantity! + 1),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => cubit.deleteProduct(product.id!, index),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Shipping',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.local_shipping),
            title: const Text('J&T Express'),
            subtitle:
                const Text('Regular (\$8)\nEstimate delivery: Q1-Q3 November'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(CartCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Payment Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
              'Subtotal', '\$${cubit.totalPrice.toStringAsFixed(2)}'),
          _buildSummaryRow('Delivery Fee', '\$8.00'),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payment Methed',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text((cubit.totalPrice + 8).toStringAsFixed(2),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 10),
          const Align(
              alignment: Alignment.centerLeft,
              child: CustomMyCard(
                pathIamge: 'assets/imageSvg/wallet3.svg',
                visaName: 'MasterCard',
                visaPass: '**** 1234',
              )),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
