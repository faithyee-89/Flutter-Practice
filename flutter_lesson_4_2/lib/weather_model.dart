class WeatherModel {
  String? code;
  String? message;
  String? redirect;
  List<Value>? value;

  WeatherModel({this.code, this.message, this.redirect, this.value});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(new Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['redirect'] = this.redirect;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String? city;
  int? cityid;
  List<Indexes>? indexes;
  Pm25? pm25;
  String? provinceName;
  Realtime? realtime;
  WeatherDetailsInfo? weatherDetailsInfo;
  List<Weathers>? weathers;

  Value(
      {this.city,
      this.cityid,
      this.indexes,
      this.pm25,
      this.provinceName,
      this.realtime,
      this.weatherDetailsInfo,
      this.weathers});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['alarms'] != null) {
      json['alarms'].forEach((v) {});
    }
    city = json['city'];
    cityid = json['cityid'];
    if (json['indexes'] != null) {
      indexes = <Indexes>[];
      json['indexes'].forEach((v) {
        indexes!.add(new Indexes.fromJson(v));
      });
    }
    pm25 = json['pm25'] != null ? new Pm25.fromJson(json['pm25']) : null;
    provinceName = json['provinceName'];
    realtime = json['realtime'] != null
        ? new Realtime.fromJson(json['realtime'])
        : null;
    weatherDetailsInfo = json['weatherDetailsInfo'] != null
        ? new WeatherDetailsInfo.fromJson(json['weatherDetailsInfo'])
        : null;
    if (json['weathers'] != null) {
      weathers = <Weathers>[];
      json['weathers'].forEach((v) {
        weathers!.add(new Weathers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['cityid'] = this.cityid;
    if (this.indexes != null) {
      data['indexes'] = this.indexes!.map((v) => v.toJson()).toList();
    }
    if (this.pm25 != null) {
      data['pm25'] = this.pm25!.toJson();
    }
    data['provinceName'] = this.provinceName;
    if (this.realtime != null) {
      data['realtime'] = this.realtime!.toJson();
    }
    if (this.weatherDetailsInfo != null) {
      data['weatherDetailsInfo'] = this.weatherDetailsInfo!.toJson();
    }
    if (this.weathers != null) {
      data['weathers'] = this.weathers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Indexes {
  String? abbreviation;
  String? alias;
  String? content;
  String? level;
  String? name;

  Indexes({this.abbreviation, this.alias, this.content, this.level, this.name});

  Indexes.fromJson(Map<String, dynamic> json) {
    abbreviation = json['abbreviation'];
    alias = json['alias'];
    content = json['content'];
    level = json['level'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abbreviation'] = this.abbreviation;
    data['alias'] = this.alias;
    data['content'] = this.content;
    data['level'] = this.level;
    data['name'] = this.name;
    return data;
  }
}

class Pm25 {
  String? advice;
  String? aqi;
  int? citycount;
  int? cityrank;
  String? co;
  String? color;
  String? level;
  String? no2;
  String? o3;
  String? pm10;
  String? pm25;
  String? quality;
  String? so2;
  String? timestamp;
  String? upDateTime;

  Pm25(
      {this.advice,
      this.aqi,
      this.citycount,
      this.cityrank,
      this.co,
      this.color,
      this.level,
      this.no2,
      this.o3,
      this.pm10,
      this.pm25,
      this.quality,
      this.so2,
      this.timestamp,
      this.upDateTime});

  Pm25.fromJson(Map<String, dynamic> json) {
    advice = json['advice'];
    aqi = json['aqi'];
    citycount = json['citycount'];
    cityrank = json['cityrank'];
    co = json['co'];
    color = json['color'];
    level = json['level'];
    no2 = json['no2'];
    o3 = json['o3'];
    pm10 = json['pm10'];
    pm25 = json['pm25'];
    quality = json['quality'];
    so2 = json['so2'];
    timestamp = json['timestamp'];
    upDateTime = json['upDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advice'] = this.advice;
    data['aqi'] = this.aqi;
    data['citycount'] = this.citycount;
    data['cityrank'] = this.cityrank;
    data['co'] = this.co;
    data['color'] = this.color;
    data['level'] = this.level;
    data['no2'] = this.no2;
    data['o3'] = this.o3;
    data['pm10'] = this.pm10;
    data['pm25'] = this.pm25;
    data['quality'] = this.quality;
    data['so2'] = this.so2;
    data['timestamp'] = this.timestamp;
    data['upDateTime'] = this.upDateTime;
    return data;
  }
}

class Realtime {
  String? img;
  String? sD;
  String? sendibleTemp;
  String? temp;
  String? time;
  String? wD;
  String? wS;
  String? weather;
  String? ziwaixian;

  Realtime(
      {this.img,
      this.sD,
      this.sendibleTemp,
      this.temp,
      this.time,
      this.wD,
      this.wS,
      this.weather,
      this.ziwaixian});

  Realtime.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    sD = json['sD'];
    sendibleTemp = json['sendibleTemp'];
    temp = json['temp'];
    time = json['time'];
    wD = json['wD'];
    wS = json['wS'];
    weather = json['weather'];
    ziwaixian = json['ziwaixian'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['sD'] = this.sD;
    data['sendibleTemp'] = this.sendibleTemp;
    data['temp'] = this.temp;
    data['time'] = this.time;
    data['wD'] = this.wD;
    data['wS'] = this.wS;
    data['weather'] = this.weather;
    data['ziwaixian'] = this.ziwaixian;
    return data;
  }
}

class WeatherDetailsInfo {
  String? publishTime;
  List<Weather3HoursDetailsInfos>? weather3HoursDetailsInfos;

  WeatherDetailsInfo({this.publishTime, this.weather3HoursDetailsInfos});

  WeatherDetailsInfo.fromJson(Map<String, dynamic> json) {
    publishTime = json['publishTime'];
    if (json['weather3HoursDetailsInfos'] != null) {
      weather3HoursDetailsInfos = <Weather3HoursDetailsInfos>[];
      json['weather3HoursDetailsInfos'].forEach((v) {
        weather3HoursDetailsInfos!
            .add(new Weather3HoursDetailsInfos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishTime'] = this.publishTime;
    if (this.weather3HoursDetailsInfos != null) {
      data['weather3HoursDetailsInfos'] =
          this.weather3HoursDetailsInfos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weather3HoursDetailsInfos {
  String? endTime;
  String? highestTemperature;
  String? img;
  String? isRainFall;
  String? lowerestTemperature;
  String? precipitation;
  String? startTime;
  String? wd;
  String? weather;
  String? ws;

  Weather3HoursDetailsInfos(
      {this.endTime,
      this.highestTemperature,
      this.img,
      this.isRainFall,
      this.lowerestTemperature,
      this.precipitation,
      this.startTime,
      this.wd,
      this.weather,
      this.ws});

  Weather3HoursDetailsInfos.fromJson(Map<String, dynamic> json) {
    endTime = json['endTime'];
    highestTemperature = json['highestTemperature'];
    img = json['img'];
    isRainFall = json['isRainFall'];
    lowerestTemperature = json['lowerestTemperature'];
    precipitation = json['precipitation'];
    startTime = json['startTime'];
    wd = json['wd'];
    weather = json['weather'];
    ws = json['ws'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['endTime'] = this.endTime;
    data['highestTemperature'] = this.highestTemperature;
    data['img'] = this.img;
    data['isRainFall'] = this.isRainFall;
    data['lowerestTemperature'] = this.lowerestTemperature;
    data['precipitation'] = this.precipitation;
    data['startTime'] = this.startTime;
    data['wd'] = this.wd;
    data['weather'] = this.weather;
    data['ws'] = this.ws;
    return data;
  }
}

class Weathers {
  String? date;
  String? img;
  String? sunDownTime;
  String? sunRiseTime;
  String? tempDayC;
  String? tempDayF;
  String? tempNightC;
  String? tempNightF;
  String? wd;
  String? weather;
  String? week;
  String? ws;

  Weathers(
      {this.date,
      this.img,
      this.sunDownTime,
      this.sunRiseTime,
      this.tempDayC,
      this.tempDayF,
      this.tempNightC,
      this.tempNightF,
      this.wd,
      this.weather,
      this.week,
      this.ws});

  Weathers.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    img = json['img'];
    sunDownTime = json['sun_down_time'];
    sunRiseTime = json['sun_rise_time'];
    tempDayC = json['temp_day_c'];
    tempDayF = json['temp_day_f'];
    tempNightC = json['temp_night_c'];
    tempNightF = json['temp_night_f'];
    wd = json['wd'];
    weather = json['weather'];
    week = json['week'];
    ws = json['ws'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['img'] = this.img;
    data['sun_down_time'] = this.sunDownTime;
    data['sun_rise_time'] = this.sunRiseTime;
    data['temp_day_c'] = this.tempDayC;
    data['temp_day_f'] = this.tempDayF;
    data['temp_night_c'] = this.tempNightC;
    data['temp_night_f'] = this.tempNightF;
    data['wd'] = this.wd;
    data['weather'] = this.weather;
    data['week'] = this.week;
    data['ws'] = this.ws;
    return data;
  }
}
