class ApiUrlsReservations {
  //for reservation
  static const String reservationsForLot1 =
      'http://lot1.plg.parknjetseatac.com/reservations/today';
  // static const String reservationsForLot1 =
  //     'http://prodlot1.parknjetseatac.com:9000/jqmNewReservations';
  static const String reservationsForLot2 =
      'http://prodlot2.parknjetseatac.com:9000/jqmNewReservations';

  static List<String> reservationUrls = [
    reservationsForLot1,
    reservationsForLot2,
  ];
}
