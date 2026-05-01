import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ActiveOrdersScreen extends StatefulWidget {
  const ActiveOrdersScreen({super.key});

  @override
  State<ActiveOrdersScreen> createState() => _ActiveOrdersScreenState();
}

class _ActiveOrdersScreenState extends State<ActiveOrdersScreen> {
  int _selectedTab = 0;

  void _markDelivered(String orderId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order $orderId marked as delivered ✓'),
        backgroundColor: AppColors.primaryContainer,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          color: AppColors.tertiary,
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: Text('ACTIVE ORDERS',
                            style: AppTextStyles.h2
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // ───── Filter Tabs ─────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: _TabBtn(
                    label: 'Assigned (1)',
                    active: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _TabBtn(
                    label: 'In Transit (2)',
                    active: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                ),
              ],
            ),
          ),

          // ───── Orders ─────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
              children: [
                // ── New Assigned Order ──
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, '/delivery/order-details'),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(
                              color: AppColors.tertiary, width: 2),
                          borderRadius:
                          BorderRadius.circular(AppRadius.xl),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text('ORDER #1247',
                                        style: AppTextStyles.labelBold),
                                    Text('Assigned 2 min ago',
                                        style: AppTextStyles.bodyMd
                                            .copyWith(
                                            fontSize: 12,
                                            color: AppColors
                                                .onSurfaceVariant)),
                                  ],
                                ),
                                _StatusChip(
                                    label: 'Assigned',
                                    bg: AppColors.tertiary,
                                    fg: Colors.white),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _CustomerRow(
                                name: 'Sara Mohamed',
                                phone: '+20 100 123 4567'),
                            const SizedBox(height: AppSpacing.sm),
                            _AddressRow(
                                address: '15 Tahrir Square, Downtown',
                                sub: 'Cairo, 11511 · ~3.2 km away'),
                            const SizedBox(height: AppSpacing.sm),
                            const Divider(
                                color: AppColors.surfaceVariant,
                                height: 16),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text('3 items · COD',
                                    style: AppTextStyles.bodyMd.copyWith(
                                        color: AppColors
                                            .onSurfaceVariant)),
                                Text('\$24.50',
                                    style: AppTextStyles.h2.copyWith(
                                        color: AppColors.primary)),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.md),
                            ElevatedButton.icon(
                              onPressed: () => Navigator.pushNamed(
                                  context, '/delivery/order-details'),
                              icon: const Icon(Icons.arrow_forward,
                                  size: 18),
                              label: const Text('ACCEPT & START'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.tertiary,
                                foregroundColor: Colors.white,
                                minimumSize:
                                const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppRadius.xl)),
                                textStyle: AppTextStyles.buttonText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -8,
                        right: AppSpacing.md,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius:
                            BorderRadius.circular(AppRadius.full),
                          ),
                          child: Text('NEW',
                              style: AppTextStyles.labelBold.copyWith(
                                  fontSize: 10, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // ── In Transit #1 ──
                _InTransitCard(
                  orderId: '#1244',
                  pickedUp: 'Picked up 12 min ago',
                  customer: 'Mona Khaled',
                  phone: '+20 122 555 8899',
                  address: '42 Nile Corniche, Maadi',
                  addressSub:
                  'Cairo, 11431 · ~1.8 km away · ETA 8 min',
                  items: '5 items · COD',
                  amount: '\$42.30',
                  onTap: () => Navigator.pushNamed(
                      context, '/delivery/order-details'),
                  onDelivered: () => _markDelivered('#1244'),
                ),
                const SizedBox(height: AppSpacing.md),

                // ── In Transit #2 ──
                _InTransitCard(
                  orderId: '#1246',
                  pickedUp: 'Picked up 4 min ago',
                  customer: 'Ali Hassan',
                  phone: '+20 111 222 3344',
                  address: '7 Gameat Al-Dewal, Mohandessin',
                  addressSub:
                  'Giza, 12411 · ~5.4 km away · ETA 18 min',
                  items: '2 items · COD',
                  amount: '\$15.99',
                  onTap: () => Navigator.pushNamed(
                      context, '/delivery/order-details'),
                  onDelivered: () => _markDelivered('#1246'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _TabBtn(
      {required this.label, required this.active, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding:
      const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: active
            ? AppColors.tertiary
            : AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Text(label.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppTextStyles.labelBold.copyWith(
              color: active
                  ? Colors.white
                  : AppColors.onSurface)),
    ),
  );
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color bg, fg;
  const _StatusChip(
      {required this.label, required this.bg, required this.fg});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.full)),
    child: Text(label.toUpperCase(),
        style: AppTextStyles.labelBold
            .copyWith(fontSize: 10, color: fg)),
  );
}

class _CustomerRow extends StatelessWidget {
  final String name, phone;
  const _CustomerRow(
      {required this.name, required this.phone});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.sm),
    decoration: BoxDecoration(
      color: AppColors.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(AppRadius.lg),
    ),
    child: Row(
      children: [
        const Icon(Icons.person,
            color: AppColors.tertiary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name.toUpperCase(),
                  style: AppTextStyles.labelBold),
              Text(phone,
                  style: AppTextStyles.bodyMd.copyWith(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Calling $name...'),
                backgroundColor: AppColors.tertiary,
              ),
            );
          },
          child: Container(
            width: 36, height: 36,
            decoration: const BoxDecoration(
                color: AppColors.tertiary,
                shape: BoxShape.circle),
            child: const Icon(Icons.call,
                color: Colors.white, size: 18),
          ),
        ),
      ],
    ),
  );
}

class _AddressRow extends StatelessWidget {
  final String address, sub;
  const _AddressRow(
      {required this.address, required this.sub});
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.location_on,
          color: AppColors.tertiary, size: 18),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address,
                style: AppTextStyles.bodyMd),
            Text(sub,
                style: AppTextStyles.bodyMd.copyWith(
                    fontSize: 12,
                    color: AppColors.onSurfaceVariant)),
          ],
        ),
      ),
    ],
  );
}

class _InTransitCard extends StatelessWidget {
  final String orderId, pickedUp, customer, phone,
      address, addressSub, items, amount;
  final VoidCallback onTap;
  final VoidCallback onDelivered;

  const _InTransitCard({
    required this.orderId,
    required this.pickedUp,
    required this.customer,
    required this.phone,
    required this.address,
    required this.addressSub,
    required this.items,
    required this.amount,
    required this.onTap,
    required this.onDelivered,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppRadius.xl),
    child: Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.surfaceVariant),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ORDER $orderId',
                      style: AppTextStyles.labelBold),
                  Text(pickedUp,
                      style: AppTextStyles.bodyMd.copyWith(
                          fontSize: 12,
                          color: AppColors.onSurfaceVariant)),
                ],
              ),
              _StatusChip(
                  label: 'On the Way',
                  bg: AppColors.tertiary.withOpacity(0.15),
                  fg: AppColors.tertiary),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _CustomerRow(name: customer, phone: phone),
          const SizedBox(height: AppSpacing.sm),
          _AddressRow(address: address, sub: addressSub),
          const SizedBox(height: AppSpacing.sm),
          const Divider(
              color: AppColors.surfaceVariant, height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(items,
                  style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.onSurfaceVariant)),
              Text(amount,
                  style: AppTextStyles.h2.copyWith(
                      color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton.icon(
            onPressed: onDelivered,
            icon: const Icon(Icons.check_circle, size: 18),
            label: const Text('MARK AS DELIVERED'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(AppRadius.xl)),
              textStyle: AppTextStyles.buttonText,
            ),
          ),
        ],
      ),
    ),
  );
}