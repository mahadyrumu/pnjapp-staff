import 'package:intl/intl.dart';

class PickupsController {
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

  processPickupSuccessResponse(response) {
    if (response['status'] == 'OK') {
      var pickupsTemp = response['data']['dispatchs'];

      for (var i = pickupsTemp.length - 1; i >= 0; i--) {
        pickupsTemp[i] = parsePickupDispatch(pickupsTemp[i], 1);
      }
      // sortPickups(lot1PickupsTemp);
      var data = {
        'lot1PickupOnVan': lot1PickupOnVan,
        'lot1PickupWaiting': lot1PickupWaiting,
        'lot2PickupOnVan': lot2PickupOnVan,
        'lot2PickupWaiting': lot2PickupWaiting,
        'pickups': pickupsTemp,
      };
      return data;
    }
  }

  parsePickupDispatch(pickupDispatch, lotNo) {
    var returnDispatch = pickupDispatch;

    returnDispatch['start'] = '--';
    returnDispatch['requestForPickup'] = '--';
    returnDispatch['onVan'] = '--';
    returnDispatch['onVanRoleColorCode'] = '#FF0000';
    returnDispatch['onVanRole'] = 'NA';
    returnDispatch['offVan'] = '--';
    returnDispatch['lotNo'] = lotNo;

    var isWaiting = true;
    var isClosed = false;
    returnDispatch['defaultEventsCompleted'] = false;
    for (var index = 0;
        index < returnDispatch['pickupDispatchEvents'].length;
        ++index) {
      var pickupEvent = returnDispatch['pickupDispatchEvents'][index];

      if (pickupEvent['eventConstant']['constantKey'] == "REQUEST_FOR_PICKUP") {
        returnDispatch['pickUpDifference'] =
            (formateDateTime(pickupEvent['createdAt']).difference(
                    formateDateTime(returnDispatch['checkOutDateTime'])))
                .inDays;

        // moment(pickupEvent['createdAt'], 'MMM D, YYYY hh:mm:ss A').diff(
        //     moment(returnDispatch['checkOutDateTime'],
        //         'MMM D, YYYY hh:mm:ss A'),
        //     'days');
        returnDispatch['requestForPickup'] =
            DateFormat.Hm().format(formateDateTime(pickupEvent['createdAt']));

        returnDispatch['late'] = 'onTime';
        if (returnDispatch['pickUpDifference'] < 0) {
          returnDispatch['late'] = 'early';
        } else if (returnDispatch['pickUpDifference'] > 0) {
          returnDispatch['late'] = 'late';
        }

        // Now There is a chance that a pickup dispatch is created by an employee
        // or a user by twillio so it is better to check these following values
        returnDispatch['requestForPickupUser'] = "";
        returnDispatch['requestForPickupRole'] = "";
        returnDispatch['requestForPickupRoleColorCode'] = "";

        if (pickupEvent['createdBy'] != null) {
          returnDispatch['requestForPickupUser'] = pickupEvent['createdBy'];
        }

        if (pickupEvent['roleConstant'] != null) {
          returnDispatch['requestForPickupRole'] =
              pickupEvent['roleConstant']['constantValue'];
          returnDispatch['requestForPickupRoleColorCode'] =
              '#' + pickupEvent['roleConstant']['colorCode'];
        } else {
          returnDispatch['requestForPickupRole'] = 'Customer';
          returnDispatch['requestForPickupRoleColorCode'] = '#000000';
        }
      }

      if (pickupEvent['eventConstant']['constantKey'] == "GET_ON_VAN") {
        returnDispatch['onVan'] =
            DateFormat.Hm().format(formateDateTime(pickupEvent['createdAt']));
        returnDispatch['onVanUser'] = pickupEvent['createdBy'];
        var roleSplitArray =
            pickupEvent['roleConstant']['constantValue'].split(' ');
        returnDispatch['onVanRole'] = roleSplitArray[roleSplitArray.length - 1];
        returnDispatch['onVanRoleColorCode'] =
            '#' + pickupEvent['roleConstant']['colorCode'];

        isWaiting = false;
      }

      if (pickupEvent['eventConstant']['constantKey'] == "GET_OFF_VAN") {
        returnDispatch['offVan'] =
            DateFormat.Hm().format(formateDateTime(pickupEvent['createdAt']));
        returnDispatch['lotTime'] =
            DateFormat.Hm().format(formateDateTime(pickupEvent['createdAt']));
        returnDispatch['offVanUser'] = pickupEvent['createdBy'];
        returnDispatch['offVanRole'] =
            pickupEvent['roleConstant']['constantValue'];
        returnDispatch['offVanRoleColorCode'] =
            '#' + pickupEvent['roleConstant']['colorCode'];
        returnDispatch['defaultEventsCompleted'] = true;
        isClosed = true;
      }
    }

    if (!isClosed) {
      if (isWaiting) {
        if (returnDispatch['lotNo'] == 1) {
          lot1PickupWaiting =
              (lot1PickupWaiting + returnDispatch['passengers']).toInt();
        } else {
          lot2PickupWaiting =
              (lot2PickupWaiting + returnDispatch['passengers']).toInt();
        }
      } else {
        if (returnDispatch['lotNo'] == 1) {
          lot1PickupOnVan =
              (lot1PickupOnVan + returnDispatch['passengers']).toInt();
        } else {
          lot2PickupOnVan =
              (lot2PickupOnVan + returnDispatch['passengers']).toInt();
        }
      }
    }

    return returnDispatch;
  }
}
