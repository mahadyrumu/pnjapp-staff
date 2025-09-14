import 'package:intl/intl.dart';

class CheckInController {
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

  processCheckInSuccessResponse(response) {
    if (response['status'] == 'OK') {
      var checkInTemp = response['data']['dispatchs'];
      for (var i = checkInTemp.length - 1; i >= 0; i--) {
        checkInTemp = parseCheckInDispatch(checkInTemp[i], 1, i);
      }
      var data = {
        'lot1PickupOnVan': lot1PickupOnVan,
        'lot1PickupWaiting': lot1PickupWaiting,
        'lot2PickupOnVan': lot2PickupOnVan,
        'lot2PickupWaiting': lot2PickupWaiting,
        'checkInData': checkInTemp,
      };
      return data;
    }
  }

  parseCheckInDispatch(checkInDispatch, lotNo, actualIndex) {
    var dropOffDispatch = checkInDispatch ?? {};
    // print(dropOffDispatch.toString());
    if (dropOffDispatch.containsKey('dropOffDispatchEvents')) {
      if (dropOffDispatch['dropOffDispatchEvents'] is List) {
        print(dropOffDispatch['dropOffDispatchEvents'].length.toString());
        for (var index = 0;
            index < dropOffDispatch['dropOffDispatchEvents'].length;
            ++index) {
          if (index < dropOffDispatch['dropOffDispatchEvents'].length) {
            var dropOffEvent = dropOffDispatch['dropOffDispatchEvents'][index];
            if (dropOffEvent['eventConstant']['constantKey'] ==
                    "KEY_STORED_IN_CABINETE" ||
                dropOffEvent['eventConstant']['constantKey'] ==
                    "PARKING_VERIFIED") {
              // if (lotNo == 2) {
              //   $scope.lot2DropOffs.splice(actualIndex, 1);
              // } else {
              //   $scope.lot2DropOffs.splice(actualIndex, 1);
              // }
            }
          }
        }
      }
    }

    if (dropOffDispatch['parkingStatus'] == "PRE_CHECK_IN") {
      dropOffDispatch['parkingStatus'] = "PRE";
      dropOffDispatch['parkingStatusBackground'] = "rgb(255, 155, 0)";
    } else if (dropOffDispatch['parkingStatus'] == "NEW" ||
        dropOffDispatch['parkingStatus'] == "TEMP") {
      dropOffDispatch['parkingStatusBackground'] = "rgb(255, 155, 0)";
    } else if (dropOffDispatch['parkingStatus'] == "IN") {
      dropOffDispatch['parkingStatusBackground'] = "#444444";
    } else {
      dropOffDispatch['parkingStatusBackground'] = "#387ef5";
    }

    dropOffDispatch['checkinTime'] = DateFormat.Hm()
        .format(formateDateTime(dropOffDispatch['actualCheckInDateTime']));
    dropOffDispatch['lotNo'] = lotNo;
    return dropOffDispatch;
  }
}
