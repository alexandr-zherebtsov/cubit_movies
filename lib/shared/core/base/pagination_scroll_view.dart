import 'package:cubit_movies/shared/widgets/app_progress.dart';
import 'package:cubit_movies/shared/core/base/pagination_scroll_controller.dart';
import 'package:cubit_movies/shared/enums/scroll_view_enums.dart';
import 'package:cubit_movies/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class PaginationScrollView extends StatelessWidget {
  final ScrollController scrollController;
  final ScrollViewEnums type;
  final bool paginationLoader;
  final EdgeInsetsGeometry padding;
  final List<Widget> children;

  const PaginationScrollView({
    Key? key,
    required this.scrollController,
    required this.type,
    required this.paginationLoader,
    required this.padding,
    required this.children,
  }) : super(key: key);

  Widget _buildByType(BuildContext context) {
    switch (type) {
      case ScrollViewEnums.wrap:
        return Center(
          child: Wrap(
            children: children..add(
              _loader(),
            ),
          ),
        );
      case ScrollViewEnums.column:
      default:
        return Column(
          children: children..add(
            _loader(),
          ),
        );
    }
  }

  Widget _loader() {
    return Offstage(
      offstage: !paginationLoader,
      child: const Padding(
        padding: EdgeInsets.only(top: 24, bottom: 28),
        child: AppProgress(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: padding,
        child: _buildByType(context),
      ),
    );
  }
}

void setToCircularIndicator(PaginationScrollController pagSC) async {
  await futureDelayed(milliseconds: 16);
  pagSC.animateTo(
    pagSC.position.maxScrollExtent - 4,
    duration: const Duration(milliseconds: 160),
    curve: Curves.fastOutSlowIn,
  );
}
