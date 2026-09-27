import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../cubit/products_cubit.dart';
import '../cubit/products_state.dart';
import '../widgets/home_header.dart';
import '../widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductsCubit>()..loadProducts(),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Column(
            children: [
              HomeHeader(
                onSearchChanged: (q) =>
                    context.read<ProductsCubit>().search(q),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case ProductsStatus.initial:
                      case ProductsStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ProductsStatus.failure:
                        return Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 40,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Failed to load products',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  state.errorMessage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () => context
                                      .read<ProductsCubit>()
                                      .loadProducts(),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        );
                      case ProductsStatus.success:
                        final items = state.filtered;
                        if (items.isEmpty) {
                          return const Center(
                            child: Text('No products match your search'),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: () =>
                              context.read<ProductsCubit>().refresh(),
                          child: GridView.builder(
                            padding: const EdgeInsets.only(bottom: 12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.68,
                            ),
                            itemCount: items.length,
                            itemBuilder: (_, i) =>
                                ProductCard(product: items[i]),
                          ),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
