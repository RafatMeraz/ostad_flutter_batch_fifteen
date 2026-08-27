import 'package:crafty_bay/features/category/presentation/providers/category_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_holder_provider.dart';
import '../../../shared/presentation/widgets/category_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final CategoryListProvider _categoryListProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _categoryListProvider = context.read<CategoryListProvider>();
    _categoryListProvider.getCategoryList();
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (_categoryListProvider.isLoading == false &&
        _scrollController.position.extentBefore < 300) {
      _categoryListProvider.getCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) => _backToHome(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Category'),
          leading: IconButton(
            onPressed: () => _backToHome(),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Consumer<CategoryListProvider>(
          builder: (context, categoryListProvider, _) {
            if (categoryListProvider.initialLoading) {
              return CenteredProgressIndicator();
            }

            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      categoryListProvider.refreshCategoryList();
                    },
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: categoryListProvider.categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return FittedBox(child: CategoryItem(
                          category: categoryListProvider.categories[index],
                        ));
                      },
                    ),
                  ),
                ),
                if (categoryListProvider.isLoadingMore)
                  LinearProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _backToHome() {
    context.read<MainNavHolderProvider>().backToHome();
  }
}
