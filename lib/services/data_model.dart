class LiveReservationDataModel {
  final int rsvnId;
  final String returnAirLine;
  final String make;
  final String model;
  final String plate;
  final String parkingStatus;
  final String checkinOrCheckout;
  final String checkInDateTime;
  final String checkOutDateTime;
  final String pickupDateTime;
  final double stayInDays;
  final String selfOrValet;
  final double totalPrice;
  final bool isPaid;
  final bool isCommented;
  final bool isCheckedIn;
  final String locRow;
  final String locStall;
  final int lateHours;
  final bool isLate;
  final double lateDays;
  final double earlyDays;
  final bool isArguedWithCustomer;
  final String claimId;
  final String lastName;
  final String firstName;
  final int passengersCount;
  final bool isDiscount;
  final String paymentType;
  final bool isDeleted;
  final String sourceRsvn;
  final String email;
  final String emailAddress;
  final String phone;
  final bool isHelpedCustomer;
  final bool isSameCustomer;
  final int visitTimes;
  final String timeForCheckin;
  final String colorClass;
  final String bookTime;
  final bool isMember;

  LiveReservationDataModel({
    required this.rsvnId,
    required this.returnAirLine,
    required this.make,
    required this.model,
    required this.plate,
    required this.parkingStatus,
    required this.checkinOrCheckout,
    required this.checkInDateTime,
    required this.checkOutDateTime,
    required this.pickupDateTime,
    required this.stayInDays,
    required this.selfOrValet,
    required this.totalPrice,
    required this.isPaid,
    required this.isCommented,
    required this.isCheckedIn,
    required this.locRow,
    required this.locStall,
    required this.lateHours,
    required this.isLate,
    required this.lateDays,
    required this.earlyDays,
    required this.isArguedWithCustomer,
    required this.claimId,
    required this.lastName,
    required this.firstName,
    required this.passengersCount,
    required this.isDiscount,
    required this.paymentType,
    required this.isDeleted,
    required this.sourceRsvn,
    required this.email,
    required this.emailAddress,
    required this.phone,
    required this.isHelpedCustomer,
    required this.isSameCustomer,
    required this.visitTimes,
    required this.timeForCheckin,
    required this.colorClass,
    required this.bookTime,
    required this.isMember,
  });

  factory LiveReservationDataModel.fromJson(Map<String, dynamic> json) {
    return LiveReservationDataModel(
      rsvnId: json['rsvnId'],
      returnAirLine: json['returnAirLine'] ?? "",
      make: json['make'] ?? "",
      model: json['model'] ?? "",
      plate: json['plate'] ?? "",
      parkingStatus: json['parkingStatus'] ?? "",
      checkinOrCheckout: json['checkinOrCheckout'] ?? "",
      checkInDateTime: json['checkInDateTime'] ?? "",
      checkOutDateTime: json['checkOutDateTime'] ?? "",
      pickupDateTime: json['pickupDateTime'] ?? "",
      stayInDays: json['stayInDays'] ?? 0.0,
      selfOrValet: json['selfOrValet'] ?? "",
      totalPrice: json['totalPrice'] ?? 0.0,
      isPaid: json['isPaid'] ?? false,
      isCommented: json['isCommented'] ?? false,
      isCheckedIn: json['isCheckedIn'] ?? false,
      locRow: json['locRow'] ?? "",
      locStall: json['locStall'] ?? "",
      lateHours: json['lateHours'] ?? 0,
      isLate: json['isLate'] ?? false,
      lateDays: json['lateDays'] ?? 0.0,
      earlyDays: json['earlyDays'] ?? 0.0,
      isArguedWithCustomer: json['isArguedWithCustomer'] ?? false,
      claimId: json['claimId'] ?? "",
      lastName: json['lastName'] ?? "",
      firstName: json['firstName'] ?? "",
      passengersCount: json['passengersCount'] ?? 0,
      isDiscount: json['isDiscount'] ?? false,
      paymentType: json['paymentType'] ?? "",
      isDeleted: json['isDeleted'] ?? false,
      sourceRsvn: json['sourceRsvn'] ?? "",
      email: json['email'] ?? "",
      emailAddress: json['emailAddress'] ?? "",
      phone: json['phone'] ?? "",
      isHelpedCustomer: json['isHelpedCustomer'] ?? false,
      isSameCustomer: json['isSameCustomer'] ?? false,
      visitTimes: json['visitTimes'] ?? 0,
      timeForCheckin: json['timeForCheckin'] ?? "",
      colorClass: json['colorClass'] ?? "",
      bookTime: json['bookTime'] ?? "",
      isMember: json['isMember'] ?? false,
    );
  }
}
