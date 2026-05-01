import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  int _selectedFilter = 0;

  static const _filters = [
    'All (38)',
    'Pending (5)',
    'Confirmed (12)',
    'Out for Delivery (8)',
    'Delivered (13)',
  ];

  static const _orders = [
    _OrderData(
      id: '#1247',
      time: 'Today 2:15 PM',
      customer: 'Sara Mohamed',
      amount: '\$24.50',
      items: '3 items',
      status: 'Out for Delivery',
      statusType: _StatusType.delivery,
      note: 'Ahmed M.',
      noteIcon: Icons.delivery_dining,
    ),
    _OrderData(
      id: '#1248',
      time: 'Today 3:42 PM',
      customer: 'Test Customer',
      amount: '\$9.47',
      items: '2 items',
      status: 'Confirmed',
      statusType: _StatusType.confirmed,
      note: 'COD Pending',
      noteIcon: Icons.payments,
    ),
    _OrderData(
      id: '#1249',
      time: 'Today 4:08 PM',
      customer: 'Mona Khaled',
      amount: '\$42.30',
      items: '5 items',
      status: 'Pending',
      statusType: _StatusType.pending,
      note: 'Awaiting confirmation',
      noteIcon: Icons.warning_amber_rounded,
    ),
    _OrderData(
      id: '#1245',
      time: 'Yesterday 6:30 PM',
      customer: 'Ali Hassan',
      amount: '\$31.85',
      items: '4 items',
      status: 'Delivered',
      statusType: _StatusType.delivered,
      note: 'Delivered at 7:15 PM',
      noteIcon: Icons.check_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'All Orders'),
      body: Column(
        children: [
          // ───── Filter Chips ─────
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.sm, horizontal: AppSpacing.md),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_filters.length, (i) {
                  final active = i == _selectedFilter;
                  return Padding(
                    padding: EdgeInsets.only(right: i < _filters.length - 1 ? AppSpacing.sm : 0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md, vertical: 6),
                        decoration: BoxDecoration(
                          color: active ? AppColors.primaryContainer : Colors.transparent,
                          border: Border.all(
                              color: active
                                  ? AppColors.primaryContainer
                                  : AppColors.surfaceVariant),
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                        child: Text(_filters[i],
                            style: AppTextStyles.labelBold.copyWith(
                                color: active
                                    ? Colors.white
                                    : AppColors.onSurfaceVariant)),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // ───── Order List ─────
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _orders.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: AppSpacing.md),
              itemBuilder: (_, i) => _OrderCard(order: _orders[i]),
            ),
          ),
        ],
      ),
    );
  }
}

enum _StatusType { delivery, confirmed, pending, delivered }

class _OrderData {
  final String id, time, customer, amount, items, status, note;
  final IconData noteIcon;
  final _StatusType statusType;
  const _OrderData({
    required this.id, required this.time, required this.customer,
    required this.amount, required this.items, required this.status,
    required this.statusType, required this.note, required this.noteIcon,
  });
}

class _OrderCard extends StatelessWidget {
  final _OrderData order;
  const _OrderCard({required this.order});

  Color get _statusBg {
    switch (order.statusType) {
      case _StatusType.delivery:  return const Color(0xFFDBEAFE);
      case _StatusType.confirmed: return const Color(0xFFFEF3C7);
      case _StatusType.pending:   return const Color(0xFFFEE2E2);
      case _StatusType.delivered: return const Color(0xFFDCFCE7);
    }
  }

  Color get _statusFg {
    switch (order.statusType) {
      case _StatusType.delivery:  return const Color(0xFF1E40AF);
      case _StatusType.confirmed: return const Color(0xFF92400E);
      case _StatusType.pending:   return const Color(0xFF991B1B);
      case _StatusType.delivered: return const Color(0xFF166534);
    }
  }

  bool get _isPending => order.statusType == _StatusType.pending;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
            color: _isPending ? AppColors.error : AppColors.surfaceVariant),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: _isPending
                  ? AppColors.errorContainer.withOpacity(0.3)
                  : Colors.transparent,
              border: Border(
                  bottom: BorderSide(
                      color: _isPending
                          ? AppColors.error.withOpacity(0.2)
                          : AppColors.surfaceVariant)),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.xl - 1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ORDER ${order.id}',
                          style: AppTextStyles.h2.copyWith(
                              color: _isPending
                                  ? AppColors.onSurface
                                  : AppColors.primary)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 12, color: AppColors.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(order.time,
                              style: AppTextStyles.bodyMd.copyWith(
                                  fontSize: 12,
                                  color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusBg,
                    border: Border.all(color: _statusFg.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Text(order.status,
                      style: AppTextStyles.labelBold
                          .copyWith(fontSize: 11, color: _statusFg)),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person,
                          size: 18, color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(order.customer,
                          style: AppTextStyles.labelBold),
                    ),
                    Text(order.amount,
                        style: AppTextStyles.labelBold.copyWith(
                            fontSize: 14)),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: _isPending
                        ? AppColors.errorContainer.withOpacity(0.3)
                        : AppColors.surfaceContainerHigh,
                    border: _isPending
                        ? Border.all(
                        color: AppColors.error.withOpacity(0.2))
                        : null,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Row(
                    children: [
                      Icon(order.noteIcon,
                          size: 16,
                          color: _isPending
                              ? AppColors.error
                              : AppColors.primaryContainer),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(order.note,
                            style: AppTextStyles.bodyMd.copyWith(
                                fontSize: 13,
                                color: _isPending
                                    ? AppColors.error
                                    : AppColors.onSurface,
                                fontWeight: _isPending
                                    ? FontWeight.w600
                                    : FontWeight.w400)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(
                              color: _isPending
                                  ? AppColors.error.withOpacity(0.3)
                                  : AppColors.surfaceVariant),
                          borderRadius:
                          BorderRadius.circular(AppRadius.lg),
                        ),
                        child: Text(order.items,
                            style: AppTextStyles.labelBold
                                .copyWith(fontSize: 11)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}