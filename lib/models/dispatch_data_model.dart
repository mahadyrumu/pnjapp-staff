class DispatchDataModel {
  final String dayText;
  final String timeText;
  final int pickupVehicleCount;
  final int pickupPaxCount;
  final int dropoffVehicleCount;
  final int dropoffPaxCount;

  DispatchDataModel({
    required this.dayText,
    required this.timeText,
    required this.pickupVehicleCount,
    required this.pickupPaxCount,
    required this.dropoffVehicleCount,
    required this.dropoffPaxCount,
  });

  factory DispatchDataModel.fromJson(Map<String, dynamic> json) {
    return DispatchDataModel(
      dayText: json['dayText'],
      timeText: json['timeText'],
      pickupVehicleCount: json['pickupVehicleCount'],
      pickupPaxCount: json['pickupPaxCount'],
      dropoffVehicleCount: json['dropoffVehicleCount'],
      dropoffPaxCount: json['dropoffPaxCount'],
    );
  }
}
