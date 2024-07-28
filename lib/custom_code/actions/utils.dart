import 'package:flutter/material.dart';

String formatTimeOfDay(TimeOfDay time){
  return '${time.hour}:${time.minute}';
}

extension Compare on TimeOfDay{
  bool isBefore(TimeOfDay t){
    if(this.hour < t.hour){
      return true;
    }else if(this.hour == t.hour){
      return this.minute < t.minute;
    }else{
      return false;
    }
  }

  bool isAfter(TimeOfDay t){
    if(this.hour > t.hour){
      return true;
    }else if(this.hour == t.hour){
      return this.minute > t.minute;
    }else{
      return false;
    }
  }

  bool isAtOrAfter(TimeOfDay t){
    return this.isAfter(t) || this == t;
  }

  bool isAtOrBefore(TimeOfDay t){
    return this.isBefore(t) || this == t;
  }
}
