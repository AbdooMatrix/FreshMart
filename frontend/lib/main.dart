import 'package:flutter/material.dart';
import 'models/order.dart';
import 'models/product.dart';
import 'screens/vendor/add_product_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/vendor/edit_product_screen.dart';
import 'screens/vendor/vendor_product_list_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/customer/cart_screen.dart';
import 'screens/customer/checkout_screen.dart';
import 'screens/customer/home_screen.dart';
import 'screens/customer/order_confirmation_screen.dart';
import 'screens/customer/product_detail_screen.dart';
import 'screens/delivery/delivery_dashboard_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const FreshMartApp());

class FreshMartApp extends StatelessWidget {
  const FreshMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreshMart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/login',
      routes: {
        '/login':              (_) => const LoginScreen(),
        '/register':           (_) => const RegisterScreen(),
        '/home':               (_) => const HomeScreen(),
        '/cart':               (_) => const CartScreen(),
        '/checkout':           (_) => const CheckoutScreen(),
        '/vendor/products':    (_) => const ManageProductsScreen(),
        '/vendor/add-product': (_) => const AddProductScreen(),
        '/admin/dashboard':    (_) => const AdminDashboardScreen(),    // 🆕
        '/delivery/dashboard': (_) => const DeliveryDashboardScreen(), // 🆕
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/product':
            return MaterialPageRoute(
              builder: (_) => ProductDetailScreen(productId: settings.arguments as int),
            );
          case '/vendor/edit-product':
            return MaterialPageRoute(
              builder: (_) => EditProductScreen(product: settings.arguments as Product),
            );
          case '/order-confirmed':
            return MaterialPageRoute(
              builder: (_) => OrderConfirmedScreen(order: settings.arguments as OrderModel),
            );
        }
        return null;
      },
    );
  }
}