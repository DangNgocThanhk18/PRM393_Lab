import '../repositories/product_repository.dart';
import '../models/product.dart';

/// Exercise 1 – Product Model & Repository
/// Goal: Understand Futures and Streams with real-time updates
void exercise1_ProductRepository() async {
  print('\n' + '=' * 80);
  print('EXERCISE 1 – Product Model & Repository');
  print('=' * 80);

  final repository = ProductRepository();

  // Subscribe to real-time updates BEFORE adding products
  print('\n📡 Subscribing to live product updates...');
  final subscription = repository.liveAdded().listen((product) {
    print('  🔔 LIVE UPDATE: New product available! $product');
  });

  // Get all products (Future-based)
  print('\n📦 Fetching all products (Future)...');
  final allProducts = await repository.getAll();
  print('  Current products in stock:');
  for (var product in allProducts) {
    print('    $product');
  }

  // Add new products (will trigger stream events)
  print('\n➕ Adding new products...');
  await repository.addProduct(Product(id: 5, name: 'Headphones', price: 149.99));
  await repository.addProduct(Product(id: 6, name: 'Webcam', price: 89.99));

  // Give time for stream events to process
  await Future.delayed(const Duration(milliseconds: 100));

  // Get updated list
  print('\n📦 Fetching all products again after additions...');
  final updatedProducts = await repository.getAll();
  print('  Updated product list (${updatedProducts.length} products):');
  for (var product in updatedProducts) {
    print('    $product');
  }

  subscription.cancel();
  repository.dispose();
  print('\n✅ Exercise 1 completed!\n');
}