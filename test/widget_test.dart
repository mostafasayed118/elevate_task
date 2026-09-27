import 'package:elevate_task/features/products/data/models/product_model.dart';
import 'package:elevate_task/features/products/presentation/cubit/products_state.dart';
import 'package:elevate_task/features/products/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ProductModel parses fakestoreapi json', () {
    final model = ProductModel.fromJson({
      'id': 1,
      'title': 'Test Bag',
      'price': 109.95,
      'description': 'desc',
      'category': "men's clothing",
      'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      'rating': {'rate': 3.9, 'count': 120},
    });

    expect(model.id, 1);
    expect(model.title, 'Test Bag');
    expect(model.price, 109.95);
    expect(model.rate, 3.9);
    expect(model.oldPrice, greaterThan(model.price));
  });

  test('ProductModel parses dummyjson fallback', () {
    final model = ProductModel.fromDummyJson({
      'id': 1,
      'title': 'iPhone 9',
      'price': 549,
      'description': 'An apple mobile',
      'category': 'smartphones',
      'thumbnail': 'https://dummyjson.com/thumb.jpg',
      'images': ['https://dummyjson.com/img1.jpg'],
      'rating': 4.69,
      'stock': 94,
    });

    expect(model.title, 'iPhone 9');
    expect(model.image, 'https://dummyjson.com/img1.jpg');
    expect(model.rate, 4.69);
  });

  test('ProductsState filters by query', () {
    const p1 = ProductModel(
      id: 1,
      title: 'Fjallraven Backpack',
      price: 100,
      description: '',
      category: "men's clothing",
      image: '',
      rate: 4.0,
      count: 10,
    );
    const p2 = ProductModel(
      id: 2,
      title: 'Gold Ring',
      price: 200,
      description: '',
      category: 'jewelery',
      image: '',
      rate: 4.5,
      count: 5,
    );
    const state = ProductsState(
      status: ProductsStatus.success,
      products: [p1, p2],
      query: 'backpack',
    );

    expect(state.filtered.length, 1);
    expect(state.filtered.first.id, 1);
  });

  testWidgets('Home header shows search bar', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeHeader(onSearchChanged: _noop),
        ),
      ),
    );

    expect(find.text('Route'), findsOneWidget);
    expect(find.text('what do you search for?'), findsOneWidget);
  });
}

void _noop(String _) {}
