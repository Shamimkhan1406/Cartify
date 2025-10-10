
import 'package:cartify/models/subcategory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubcategoryProvider extends StateNotifier<List<SubCategory>> {
  SubcategoryProvider() : super([]);

  // method to set subcategories
  void setSubcategories(List<SubCategory> subCategories){
    state = subCategories;
  }
}

final subCategoryProvider = StateNotifierProvider<SubcategoryProvider, List<SubCategory>>((ref) => SubcategoryProvider(),);