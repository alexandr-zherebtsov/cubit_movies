import 'package:cubit_movies/data/remote/filter_service.dart';
import 'package:cubit_movies/domain/models/filter_model.dart';
import 'package:cubit_movies/domain/responses/genre_response.dart';
import 'package:cubit_movies/presentation/di/locator.dart';
import 'package:cubit_movies/presentation/ui/filter/filter_cubit.dart';
import 'package:cubit_movies/presentation/ui/filter/filter_state.dart';
import 'package:cubit_movies/presentation/ui/filter/widgets/filter_title_item.dart';
import 'package:cubit_movies/presentation/ui/filter/widgets/genre_item.dart';
import 'package:cubit_movies/shared/constants/strings_keys.dart';
import 'package:cubit_movies/shared/styles/colors.dart';
import 'package:cubit_movies/shared/styles/widgets.dart';
import 'package:cubit_movies/shared/widgets/app_button.dart';
import 'package:cubit_movies/shared/widgets/app_progress.dart';
import 'package:cubit_movies/shared/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<FilterModel?> showFilterBottomSheet({
  required BuildContext context,
  required FilterModel? filter,
}) async {
  final FilterModel? res = await showModalBottomSheet<FilterModel?>(
    context: context,
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(22),
        topRight: Radius.circular(22),
      ),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: FilterScreen(
          filter: filter,
        ),
      );
    },
  );
  return res;
}

Future<FilterModel?> showFilterAlertDialog({
  required BuildContext context,
  required FilterModel? filter,
}) async {
  final FilterModel? res = await showDialog<FilterModel?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        clipBehavior: Clip.hardEdge,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        content: SizedBox(
          width: 1000,
          child: FilterScreen(
            filter: filter,
          ),
        ),
      );
    },
  );
  return res;
}

class FilterScreen extends StatefulWidget {
  final FilterModel? filter;

  const FilterScreen({
    Key? key,
    required this.filter,
  }) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late final FilterCubit _filterCubit;
  late final FocusNode _yearFN;
  late final TextEditingController _yearTC;
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  final FilterService _filterService = locator<FilterService>();

  @override
  void initState() {
    _yearFN = FocusNode();
    _yearTC = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _filterCubit = FilterCubit(
      filterModel: widget.filter,
      filterService: _filterService,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _yearTC.dispose();
    _yearFN.dispose();
    _filterCubit.close();
  }

  void unFocus() => _yearFN.unfocus();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      bloc: _filterCubit,
      builder: (BuildContext context, FilterState state) {
        return GestureDetector(
          onTap: unFocus,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(StringsKeys.filter.tr()),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(
                  thickness: 1,
                  height: 1,
                  indent: 0,
                  color: AppColors.grey.withOpacity(0.4),
                ),
              ),
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              actions: [
                Padding(
                  padding: MediaQuery.of(context).size.width >= 540 ? const EdgeInsets.only(
                    right: 8,
                  ) : EdgeInsets.zero,
                  child: IconButton(
                    tooltip: StringsKeys.close.tr(),
                    icon: const Icon(Icons.clear),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (BuildContext context) {
                  if (state is FilterLoadingState) {
                    return const AppProgress();
                  } else if (state is FilterErrorState) {
                    return const AppErrorWidget();
                  } else if (state is FilterLoadedState) {
                    _yearTC.text = _filterCubit.yearText;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 22,
                          right: 22,
                          top: 22,
                          bottom: 80,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FilterTitleItem(
                              title: StringsKeys.year,
                            ),
                            SizedBox(
                              width: 120,
                              child: AppTextField(
                                maxLines: 1,
                                controller: _yearTC,
                                focusNode: _yearFN,
                                hint: StringsKeys.enterYear.tr(),
                                keyboardType: TextInputType.number,
                                backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
                                onChanged: (v) => _filterCubit.yearText = v,
                                padding: const EdgeInsets.only(
                                  top: 6,
                                  bottom: 26,
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4),
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                ],
                              ),
                            ),
                            const FilterTitleItem(
                              title: StringsKeys.genres,
                            ),
                            Wrap(
                              children: state.genres.map((genre) {
                                return GenreItem(
                                  value: _checkGenre(
                                    genre: genre,
                                    selected: state.selectedGenres,
                                  ),
                                  title: genre.name,
                                  onChanged: (value) => _filterCubit.setGenre(
                                    value: value ?? false,
                                    genre: genre,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Offstage();
                  }
                },
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: _filterCubit.selectedGenres.isNotEmpty ? AppButton(
              title: StringsKeys.apply.tr().toUpperCase(),
              onTap: () {
                final bool res = _filterCubit.applyFilter(_yearTC.text);
                if (res) {
                  Navigator.pop(context, _filterCubit.filter);
                }
              },
            ) : null,
          ),
        );
      },
    );
  }

  bool _checkGenre({
    required GenreResponse genre,
    required List<GenreResponse> selected,
  }) {
    Iterable<GenreResponse> res = selected.where((e) => e.id == genre.id);
    return res.isNotEmpty;
  }
}
