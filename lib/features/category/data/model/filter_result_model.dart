import 'package:centro/core/constants/enum/sort_enum.dart';

class FilterResultModel {

  final SortOrder? priceOrder;
  final SortOrder? rateOrder;

  const FilterResultModel({
    this.priceOrder,
    this.rateOrder,
  });

}