import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/primary_button.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _price;
  late final TextEditingController _stock;
  late final TextEditingController _imageUrl;
  late String? _category;
  bool _saving = false;

  static const _categories = [
    'Fruits', 'Vegetables', 'Dairy', 'Bakery', 'Meat', 'Grains',
  ];

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.product.name);
    _description =
        TextEditingController(text: widget.product.description ?? '');
    _price = TextEditingController(text: widget.product.price.toString());
    _stock = TextEditingController(text: widget.product.stock.toString());
    _imageUrl = TextEditingController(text: widget.product.imageUrl ?? '');
    _category = widget.product.category;
    if (_category != null && !_categories.contains(_category)) {
      _category = null; // safety in case of unknown category from DB
    }
  }

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
    final price = double.tryParse(_price.text);
    final stock = int.tryParse(_stock.text);
    if (_name.text.trim().isEmpty) return _show('Name is required');
    if (price == null || price <= 0) return _show('Invalid price');
    if (stock == null || stock < 0) return _show('Invalid stock');

    setState(() => _saving = true);
    try {
      await ProductService.updateProduct(widget.product.id, {
        'name': _name.text.trim(),
        'description': _description.text.trim(),
        'price': price,
        'stock': stock,
        'category': _category,
        'image_url': _imageUrl.text.trim(),
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Updated ${_name.text}'),
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
      appBar: const AppTopBar(title: 'Edit Product'),
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
                    border: Border.all(color: AppColors.surfaceContainerHigh),
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: image preview + name/category
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                            child: SizedBox(
                              width: 96, height: 96,
                              child: widget.product.imageUrl != null
                                  ? CachedNetworkImage(
                                imageUrl: widget.product.imageUrl!,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) => Container(
                                  color: AppColors.surfaceContainer,
                                  child: const Icon(Icons.image),
                                ),
                              )
                                  : Container(
                                color: AppColors.surfaceContainer,
                                child: const Icon(Icons.image),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.gutter),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('PRODUCT NAME'),
                                TextField(controller: _name),
                                const SizedBox(height: AppSpacing.sm),
                                _label('CATEGORY'),
                                DropdownButtonFormField<String>(
                                  value: _category,
                                  items: _categories
                                      .map((c) => DropdownMenuItem(
                                      value: c, child: Text(c)))
                                      .toList(),
                                  onChanged: (v) => setState(() => _category = v),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _label('DESCRIPTION'),
                      TextField(controller: _description),
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
                                      prefixText: '\$ '),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.gutter),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('STOCK QUANTITY'),
                                TextField(
                                  controller: _stock,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.gutter),
                      _label('IMAGE URL'),
                      TextField(
                        controller: _imageUrl,
                        decoration: const InputDecoration(
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
              label: 'Update Product',
              loading: _saving,
              height: 56,
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