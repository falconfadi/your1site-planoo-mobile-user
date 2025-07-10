
// todo remove later
class ActivityModel {
  final String name;
  final double price;
  final String type;
  final String description;
  final List<ServiceTime> times;

  ActivityModel({
    required this.name,
    required this.price,
    required this.type,
    required this.description,
    required this.times,
  });
}

class ServiceTime {
  final String day;
  final String time;
  final String? court;

  ServiceTime({required this.day, required this.time,this.court});
}
