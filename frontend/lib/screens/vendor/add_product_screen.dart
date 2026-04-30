import 'package:flutter/material.dart';
import '../../services/product_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/primary_button.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _stock = TextEditingController();
  final _imageUrl = TextEditingController();
  String? _category;
  bool _saving = false;

  static const _categories = [
    'Fruits', 'Vegetables', 'Dairy', 'Bakery', 'Meat', 'Grains',
  ];

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _price.dispose();
    _stock.dispose();
    _imageUrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) {
      _show('Product name is required');
      return;
    }
    final price = double.tryParse(_price.text);
    final stock = int.tryParse(_stock.text);
    if (price == null || price <= 0) {
      _show('Enter a valid price');
      return;
    }
    if (stock == null || stock < 0) {
      _show('Enter a valid stock');
      return;
    }
    setState(() => _saving = true);
    try {
      await ProductService.createProduct(
        name: _name.text.trim(),
        description: _description.text.trim().isEmpty
            ? null
            : _description.text.trim(),
        price: price,
        stock: stock,
        category: _category,
        imageUrl: _imageUrl.text.trim().isEmpty ? null : _imageUrl.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product "${_name.text}" created'),
          backgroundColor: AppColors.primaryContainer,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      _show('$e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _show(String msg) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: AppColors.error),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Add Product'),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.outlineVariant),
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('PRODUCT NAME'),
                      TextField(
                        controller: _name,
                        decoration: const InputDecoration(
                            hintText: 'e.g. Organic Fuji Apples'),
                      ),
                      const SizedBox(height: AppSpacing.gutter),
                      _label('DESCRIPTION'),
                      TextField(
                        controller: _description,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            hintText: 'Enter product details...'),
                      ),
                      const SizedBox(height: AppSpacing.gutter),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('PRICE'),
                                TextField(
                                  controller: _price,
                                  keyboardType: const TextInputType
                                      .numberWithOptions(decimal: true),
                                  decoration: const InputDecoration(
                                    hintText: '0.00',
                                    prefixText: '\$ ',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.gutter),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('STOCK'),
                                TextField(
                                  controller: _stock,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: 'Qty'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.gutter),
                      _label('CATEGORY'),
                      DropdownButtonFormField<String>(
                        value: _category,
                        hint: const Text('Select a category'),
                        items: _categories
                            .map((c) => DropdownMenuItem(
                          value: c,
                          child: Text(c),
                        ))
                            .toList(),
                        onChanged: (v) => setState(() => _category = v),
                      ),
                      const SizedBox(height: AppSpacing.gutter),
                      _label('IMAGE URL'),
                      TextField(
                        controller: _imageUrl,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                          hintText: 'https://...',
                          prefixIcon: Icon(Icons.link, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: 'Save Product',
              loading: _saving,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4, top: 4),
    child: Text(text,
        style: AppTextStyles.labelBold
            .copyWith(color: AppColors.onSurfaceVariant)),
  );
}