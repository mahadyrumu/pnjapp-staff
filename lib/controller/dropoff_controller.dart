import 'package:intl/intl.dart';

class DropoffController {
  var lot1PickupOnVan = 0;
  var lot1PickupWaiting = 0;
  var lot2PickupOnVan = 0;
  var lot2PickupWaiting = 0;

  getMonthToInt(month) {
    List monthString = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    if (monthString.indexOf(month) <= 8) {
      return '0${monthString.indexOf(month) + 1}';
    } else {
      return (monthString.indexOf(month) + 1);
    }
  }

  getTimeString(time) {
    if (time[1] != ':') {
      return time;
    } else {
      return '0$time';
    }
  }

  getDayString(day) {
    if (day[1] != ',') {
      return day;
    } else {
      return '0$day';
    }
  }

  formateDateTime(dateTime) {
    var formatedDateTime = dateTime
        .toString()
        .split(" ")
        .map((String dateTime) => dateTime)
        .toList();
    // ignore: prefer_interpolation_to_compose_strings
    var newDateTime = formatedDateTime[2].toString() +
        "-" +
        getMonthToInt(formatedDateTime[0].toString()).toString() +
        '-' +
        getDayString(formatedDateTime[1].toString())
            .replaceAll(RegExp(r'[^\w\s]+'), '') +
        ' ' +
        getTimeString(formatedDateTime[3].toString());
    return DateTime.parse(newDateTime);
  }

  processDropoffSuccessResponse(response) {
    if (response['status'] == 'OK') {
      var dropoffTemp = response['data']['dispatchs'];

      for (var i = dropoffTemp.length - 1; i >= 0; i--) {
        dropoffTemp[i] = parseDropoffDispatch(dropoffTemp[i], 1);
      }

      var data = {
        'lot1PickupOnVan': lot1PickupOnVan,
        'lot1PickupWaiting': lot1PickupWaiting,
        'lot2PickupOnVan': lot2PickupOnVan,
        'lot2PickupWaiting': lot2PickupWaiting,
        'dropoffs': dropoffTemp,
      };
      return data;
    }
  }

  parseDropoffDispatch(dropoffDispatch, lotNo) {
    var returnDispatch = dropoffDispatch;
    returnDispatch['checkinTime'] = DateFormat.Hm()
        .format(formateDateTime(returnDispatch['actualCheckInDateTime']));

    if (returnDispatch['parkingStatus'] == "PRE_CHECK_IN") {
      returnDispatch['parkingStatus'] = "PRE";
      returnDispatch['parkingStatusBackground'] = "#FF9B00";
    } else if (returnDispatch['parkingStatus'] == "NEW" ||
        returnDispatch['parkingStatus'] == "TEMP") {
      returnDispatch['parkingStatusBackground'] = "#FF9B00";
    } else if (returnDispatch['parkingStatus'] == "IN") {
      returnDispatch['parkingStatusBackground'] = "#444444";
    } else {
      returnDispatch['parkingStatusBackground'] = "#387ef5";
    }
    return returnDispatch;
  }
}
