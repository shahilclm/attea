import '/exporter/exporter.dart';
import '/extensions/app_theme_extensions.dart';
import '/features/paginated_home_screen/data/home_service.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedHomescreen extends StatefulWidget {
  final VoidCallback openDrawer;
  static const String path = '/home-screen';
  const PaginatedHomescreen({super.key, required this.openDrawer});

  @override
  State<PaginatedHomescreen> createState() => _PaginatedHomescreenState();
}

class _PaginatedHomescreenState extends State<PaginatedHomescreen> {
  final int _pageSize = 10;

  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // Calculate skip value based on pageKey
      final skip = pageKey * _pageSize;

      // Pass skip instead of page number
      final response = await HomeService.getPost(skip, _pageSize);

      if (response == null) {
        _pagingController.error = 'Failed to fetch data';
        return;
      }

      final products = response['products'];

      if (products == null || products is! List || products.isEmpty) {
        _pagingController.error = 'No products found';
        return;
      }

      final total = response['total'] ?? 0;
      final isLastPage = skip + products.length >= total;

      if (isLastPage) {
        _pagingController.appendLastPage(products);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(products, nextPageKey);
      }

      logSuccess("fetched page: $pageKey, skip: $skip");
    } catch (error) {
      logError(error);
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: appColors.dynamicIconColor),
          onPressed: widget.openDrawer,
        ),
        actions: [
          IconButton(
            onPressed: () => MyApp.toggleTheme(),
            icon: Icon(Icons.brightness_6, color: appColors.dynamicIconColor),
          ),
        ],
        title: Text('Home Screen',
            style: TextStyle(color: appColors.textContrastColor)),
        centerTitle: true,
        backgroundColor: appColors.background,
      ),
      body: PagedListView<int, dynamic>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
          animateTransitions: true,
          itemBuilder: (context, item, index) => ListTile(
            title: Text(
              item['title'],
              style: TextStyle(color: appColors.textContrastColor),
            ),
          ),
        ),
        separatorBuilder: (_, index) => Divider(),
      ),
    );
  }
}
