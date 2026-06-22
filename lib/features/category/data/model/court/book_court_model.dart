import 'package:centro/features/category/data/model/court/slot_details_model.dart';

class BookCourtModel {

  int? dayId;
  String? code;
  DateTime? date;
  List<SlotDetailsModel>? slots;
  int? slotIndex;
  String? note;

  BookCourtModel({
    this.dayId,
    this.code,
    this.date,
    this.slots,
    this.slotIndex,
    this.note
  });
}