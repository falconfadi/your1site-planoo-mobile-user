import 'package:centro/features/category/data/model/activity/slot_details_model.dart';

class BookActivityModel {

  int? dayId;
  String? code;
  DateTime? date;
  List<SlotDetailsModel>? slots;
  int? slotIndex;
  String? note;

  BookActivityModel({
    this.dayId,
    this.code,
    this.date,
    this.slots,
    this.slotIndex,
    this.note
  });
}