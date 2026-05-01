/// Singleton holding the "logged in" user.
/// Auth is excluded by the TA — we just store the role.
class Session {
  static int currentUserId = 1;
  static String currentRole = 'customer';

  static void loginAsCustomer() {
    currentUserId = 1;
    currentRole = 'customer';
  }

  static void loginAsVendor() {
    currentUserId = 2;
    currentRole = 'vendor';
  }

  static void loginAsAdmin() {
    currentUserId = 3;        // mock — admin is UI-only
    currentRole = 'admin';
  }

  static void loginAsDelivery() {
    currentUserId = 4;        // mock — delivery is UI-only
    currentRole = 'delivery';
  }
}