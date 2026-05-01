import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DeliveryOrderDetailsScreen extends StatelessWidget {
  const DeliveryOrderDetailsScreen({super.key});

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
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: Text('ORDER #1247',
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ───── Status Banner ─────
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.tertiary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.two_wheeler,
                            color: AppColors.tertiary, size: 28),
                        const SizedBox(width: AppSpacing.md),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CURRENT STATUS',
                                style: AppTextStyles.labelBold
                                    .copyWith(color: AppColors.tertiary)),
                            Text('ON THE WAY',
                                style: AppTextStyles.h2
                                    .copyWith(color: AppColors.tertiary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ───── Delivery Timeline ─────
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('DELIVERY TIMELINE',
                            style: AppTextStyles.labelBold.copyWith(
                                color: AppColors.primaryContainer)),
                        const SizedBox(height: AppSpacing.md),
                        const _TimelineStep(
                          label: 'ORDER ASSIGNED',
                          time: '2:15 PM · Today',
                          isDone: true,
                          isActive: false,
                          isLast: false,
                          lineColor: AppColors.primaryContainer,
                        ),
                        const _TimelineStep(
                          label: 'PICKED UP FROM STORE',
                          time: '2:28 PM · Today',
                          isDone: true,
                          isActive: false,
                          isLast: false,
                          lineColor: AppColors.tertiary,
                        ),
                        const _TimelineStep(
                          label: 'ON THE WAY',
                          time: 'In progress · ETA 8 min',
                          isDone: false,
                          isActive: true,
                          isLast: false,
                          lineColor: AppColors.outlineVariant,
                        ),
                        const _TimelineStep(
                          label: 'DELIVERED',
                          time: 'Pending',
                          isDone: false,
                          isActive: false,
                          isLast: true,
                          lineColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ───── Customer ─────
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CUSTOMER',
                            style: AppTextStyles.labelBold.copyWith(
                                color: AppColors.primaryContainer)),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person,
                                  color: Colors.white),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SARA MOHAMED',
                                      style: AppTextStyles.labelBold),
                                  Text('+20 100 123 4567',
                                      style: AppTextStyles.bodyMd.copyWith(
                                          fontSize: 12,
                                          color:
                                          AppColors.onSurfaceVariant)),
                                ],
                              ),
                            ),
                            _CircleBtn(
                              icon: Icons.call,
                              color: AppColors.tertiary,
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text('Calling customer...'),
                                  backgroundColor: AppColors.tertiary,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            _CircleBtn(
                              icon: Icons.chat,
                              color: AppColors.primaryContainer,
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text('Opening chat...'),
                                  backgroundColor:
                                  AppColors.primaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ───── Delivery Address ─────
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('DELIVERY ADDRESS',
                                style: AppTextStyles.labelBold.copyWith(
                                    color: AppColors.primaryContainer)),
                            GestureDetector(
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text('Opening navigation...'),
                                  backgroundColor: AppColors.tertiary,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.map,
                                      size: 16,
                                      color: AppColors.tertiary),
                                  const SizedBox(width: 4),
                                  Text('NAVIGATE',
                                      style: AppTextStyles.labelBold
                                          .copyWith(
                                          color: AppColors.tertiary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on,
                                color: AppColors.tertiary, size: 20),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('15 Tahrir Square, Downtown',
                                      style: AppTextStyles.bodyMd),
                                  Text('Cairo, 11511',
                                      style: AppTextStyles.bodyMd),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text('3.2 km away · ETA 8 min',
                                      style: AppTextStyles.bodyMd.copyWith(
                                          fontSize: 12,
                                          color:
                                          AppColors.onSurfaceVariant)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHigh,
                            borderRadius:
                            BorderRadius.circular(AppRadius.lg),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('DELIVERY NOTE',
                                  style: AppTextStyles.labelBold.copyWith(
                                      color: AppColors.onSurfaceVariant)),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                  'Please call when you arrive at the gate. Apartment 4B.',
                                  style: AppTextStyles.bodyMd),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ───── Items ─────
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ITEMS (3)',
                            style: AppTextStyles.labelBold.copyWith(
                                color: AppColors.primaryContainer)),
                        const _ItemRow(
                            name: 'Fresh Apples',
                            qty: 'Qty: 2',
                            price: '\$7.98'),
                        const Divider(color: AppColors.surfaceVariant),
                        const _ItemRow(
                            name: 'Whole Milk',
                            qty: 'Qty: 1',
                            price: '\$1.49'),
                        const Divider(color: AppColors.surfaceVariant),
                        const _ItemRow(
                            name: 'Sourdough Bread',
                            qty: 'Qty: 3',
                            price: '\$15.03'),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ───── Payment ─────
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PAYMENT',
                            style: AppTextStyles.labelBold.copyWith(
                                color: AppColors.primaryContainer)),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Method',
                                style: AppTextStyles.bodyMd.copyWith(
                                    color: AppColors.onSurfaceVariant)),
                            Row(
                              children: [
                                const Text('💵',
                                    style: TextStyle(fontSize: 18)),
                                const SizedBox(width: AppSpacing.xs),
                                Text('Cash on Delivery',
                                    style: AppTextStyles.bodyMd.copyWith(
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                            height: 24, color: AppColors.surfaceVariant),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Collect', style: AppTextStyles.h2),
                            Text('\$24.50',
                                style: AppTextStyles.h1.copyWith(
                                    color: AppColors.primary)),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color:
                            AppColors.errorContainer.withOpacity(0.5),
                            borderRadius:
                            BorderRadius.circular(AppRadius.lg),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info,
                                  size: 18, color: AppColors.error),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                    'Collect exact cash amount from customer',
                                    style: AppTextStyles.bodyMd
                                        .copyWith(fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ───── Bottom Action (WIRED) ─────
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: SafeArea(
              top: false,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order #1247 marked as delivered ✓'),
                      backgroundColor: AppColors.primaryContainer,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 800), () {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  });
                },
                icon: const Icon(Icons.check_circle, size: 18),
                label: const Text('MARK AS DELIVERED'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(AppRadius.xl)),
                  textStyle: AppTextStyles.buttonText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───── Helper Widgets ─────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.surfaceVariant),
      borderRadius: BorderRadius.circular(AppRadius.xl),
    ),
    child: child,
  );
}

class _TimelineStep extends StatelessWidget {
  final String label, time;
  final bool isDone, isActive, isLast;
  final Color lineColor;
  const _TimelineStep(
      {required this.label,
        required this.time,
        required this.isDone,
        required this.isActive,
        required this.isLast,
        required this.lineColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isDone
                    ? AppColors.primaryContainer
                    : isActive
                    ? AppColors.tertiary
                    : AppColors.surfaceContainerHigh,
                shape: BoxShape.circle,
                border: (!isDone && !isActive)
                    ? Border.all(color: AppColors.outlineVariant, width: 2)
                    : null,
              ),
              child: isDone
                  ? const Icon(Icons.check,
                  color: Colors.white, size: 14)
                  : isActive
                  ? const Icon(Icons.delivery_dining,
                  color: Colors.white, size: 14)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 32,
                color: lineColor,
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Padding(
            padding:
            EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppTextStyles.labelBold.copyWith(
                        color: isActive
                            ? AppColors.tertiary
                            : isLast
                            ? AppColors.onSurfaceVariant
                            : AppColors.onSurface)),
                Text(time,
                    style: AppTextStyles.bodyMd.copyWith(
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemRow extends StatelessWidget {
  final String name, qty, price;
  const _ItemRow(
      {required this.name, required this.qty, required this.price});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: const Icon(Icons.image, color: AppColors.outline),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name.toUpperCase(),
                  style: AppTextStyles.labelBold),
              Text(qty,
                  style: AppTextStyles.bodyMd.copyWith(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
        Text(price, style: AppTextStyles.bodyMd),
      ],
    ),
  );
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _CircleBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white),
    ),
  );
}