import 'dart:async';
import '../models/product.dart';

/// Repository that provides both Future-based and Stream-based data access
class ProductRepository {
  // Simulated database of products
  final List<Product> _products = [
    Product(id: 1, name: 'Laptop', price: 999.99),
    Product(id: 2, name: 'Mouse', price: 29.99),
    Product(id: 3, name: 'Keyboard', price: 79.99),
    Product(id: 4, name: 'Monitor', price: 299.99),
  ];

  // Broadcast stream controller for real-time product additions
  final StreamController<Product> _productController =
  StreamController<Product>.broadcast();

  /// Returns all products as a Future (simulates async database query)
  Future<List<Product>> getAll() async {
    // Simulate network/database delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_products);
  }

  /// Returns a stream that emits new products when added
  Stream<Product> liveAdded() => _productController.stream;

  /// Adds a new product and notifies all listeners
  Future<void> addProduct(Product product) async {
    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 200));
    _products.add(product);
    _productController.add(product);
    print('  [Repository] New product added: $product');
  }

  /// Close the stream controller when done
  void dispose() {
    _productController.close();
  }
}