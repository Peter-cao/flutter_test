class Utils {

  static String format(String timestr){
    var d1 = DateTime.parse(timestr);
    var d2 = DateTime.now();
    var difference = d2.difference(d1);
    // print(difference.inDays);
    // print(difference.inHours);
    // print(difference.inMicroseconds);
    if(difference.inDays>0){
      return difference.inDays.toString()+"天前";
    }else if(difference.inHours>0){
      return difference.inHours.toString()+"小时前";
    }else if(difference.inMicroseconds>0){
      return difference.inMicroseconds.toString()+"分钟前";
    }else{
      return "刚刚";
    }
  }
}