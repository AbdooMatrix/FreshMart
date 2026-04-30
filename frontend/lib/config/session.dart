class Session {
  static int currentUserId = 1;     // 1 = customer, 2 = vendor
  static String currentRole = 'customer';

  static void loginAsCustomer() {
    currentUserId = 1;
    currentRole = 'customer';
  }

  static void loginAsVendor() {
    currentUserId = 2;
    currentRole = 'vendor';
  }
}