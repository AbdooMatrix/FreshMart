import 'package:flutter/material.dart';
import 'models/order.dart';
import 'models/product.dart';

// Auth
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

// Customer
import 'screens/customer/home_screen.dart';
import 'screens/customer/product_detail_screen.dart';
import 'screens/customer/cart_screen.dart';
import 'screens/customer/checkout_screen.dart';
import 'screens/customer/order_confirmed_screen.dart';

// Vendor (product CRUD)
import 'screens/vendor/manage_products_screen.dart';
import 'screens/vendor/add_product_screen.dart';
import 'screens/vendor/edit_product_screen.dart';

// Admin (prototype dashboards)
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/admin/reports_screen.dart';
import 'screens/admin/all_orders_screen.dart';
import 'screens/admin/user_management_screen.dart';

// Delivery (prototype dashboards)
import 'screens/delivery/delivery_dashboard_screen.dart';
import 'screens/delivery/active_orders_screen.dart';
import 'screens/delivery/order_details_screen.dart';

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
        // ───── Auth ─────
        '/login':                  (_) => const LoginScreen(),
        '/register':               (_) => const RegisterScreen(),

        // ───── Customer flow ─────
        '/home':                   (_) => const HomeScreen(),
        '/cart':                   (_) => const CartScreen(),
        '/checkout':               (_) => const CheckoutScreen(),

        // ───── Vendor flow (product CRUD) ─────
        '/vendor/products':        (_) => const ManageProductsScreen(),
        '/vendor/add-product':     (_) => const AddProductScreen(),

        // ───── Admin prototype ─────
        '/admin/dashboard':        (_) => const AdminDashboardScreen(),
        '/admin/reports':          (_) => const ReportsScreen(),              // 🆕
        '/admin/all-orders':       (_) => const AllOrdersScreen(),            // 🆕
        '/admin/user-management':  (_) => const UserManagementScreen(),       // 🆕

        // ───── Delivery prototype ─────
        '/delivery/dashboard':     (_) => const DeliveryDashboardScreen(),
        '/delivery/active-orders': (_) => const ActiveOrdersScreen(),         // 🆕
        '/delivery/order-details': (_) => const DeliveryOrderDetailsScreen(), // 🆕
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/product':
            return MaterialPageRoute(
              builder: (_) => ProductDetailScreen(
                productId: settings.arguments as int,
              ),
            );
          case '/vendor/edit-product':
            return MaterialPageRoute(
              builder: (_) => EditProductScreen(
                product: settings.arguments as Product,
              ),
            );
          case '/order-confirmed':
            return MaterialPageRoute(
              builder: (_) => OrderConfirmedScreen(
                order: settings.arguments as OrderModel,
              ),
            );
        }
        return null;
      },
    );
  }
}