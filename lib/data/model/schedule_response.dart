class ScheduleResponse {
  String? odataContext;
  List<Value>? value;
  bool? isSuccess = false;
  String? message;

  ScheduleResponse({this.odataContext, this.value, this.isSuccess, this.message});

  ScheduleResponse.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@odata.context'] = odataContext;
    if (value != null) {
      data['value'] = value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String? scheduleId;
  String? availabilityView;
  List<ScheduleItems>? scheduleItems;
  WorkingHours? workingHours;

  Value(
      {this.scheduleId,
        this.availabilityView,
        this.scheduleItems,
        this.workingHours});

  Value.fromJson(Map<String, dynamic> json) {
    scheduleId = json['scheduleId'];
    availabilityView = json['availabilityView'];
    if (json['scheduleItems'] != null) {
      scheduleItems = <ScheduleItems>[];
      json['scheduleItems'].forEach((v) {
        scheduleItems!.add(ScheduleItems.fromJson(v));
      });
    }
    workingHours = json['workingHours'] != null
        ? WorkingHours.fromJson(json['workingHours'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleId'] = scheduleId;
    data['availabilityView'] = availabilityView;
    if (scheduleItems != null) {
      data['scheduleItems'] =
          scheduleItems!.map((v) => v.toJson()).toList();
    }
    if (workingHours != null) {
      data['workingHours'] = workingHours!.toJson();
    }
    return data;
  }
}

class ScheduleItems {
  bool? isPrivate;
  String? status;
  String? subject;
  String? location;
  bool? isMeeting;
  bool? isRecurring;
  bool? isException;
  bool? isReminderSet;
  Start? start;
  Start? end;

  ScheduleItems(
      {this.isPrivate,
        this.status,
        this.subject,
        this.location,
        this.isMeeting,
        this.isRecurring,
        this.isException,
        this.isReminderSet,
        this.start,
        this.end});

  ScheduleItems.fromJson(Map<String, dynamic> json) {
    isPrivate = json['isPrivate'];
    status = json['status'];
    subject = json['subject'];
    location = json['location'];
    isMeeting = json['isMeeting'];
    isRecurring = json['isRecurring'];
    isException = json['isException'];
    isReminderSet = json['isReminderSet'];
    start = json['start'] != null ? Start.fromJson(json['start']) : null;
    end = json['end'] != null ? Start.fromJson(json['end']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isPrivate'] = isPrivate;
    data['status'] = status;
    data['subject'] = subject;
    data['location'] = location;
    data['isMeeting'] = isMeeting;
    data['isRecurring'] = isRecurring;
    data['isException'] = isException;
    data['isReminderSet'] = isReminderSet;
    if (start != null) {
      data['start'] = start!.toJson();
    }
    if (end != null) {
      data['end'] = end!.toJson();
    }
    return data;
  }
}

class Start {
  String? dateTime;
  String? timeZone;

  Start({this.dateTime, this.timeZone});

  Start.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    timeZone = json['timeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateTime'] = dateTime;
    data['timeZone'] = timeZone;
    return data;
  }
}

class WorkingHours {
  List<String>? daysOfWeek;
  String? startTime;
  String? endTime;
  TimeZone? timeZone;

  WorkingHours({this.daysOfWeek, this.startTime, this.endTime, this.timeZone});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    daysOfWeek = json['daysOfWeek'].cast<String>();
    startTime = json['startTime'];
    endTime = json['endTime'];
    timeZone = json['timeZone'] != null
        ? TimeZone.fromJson(json['timeZone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['daysOfWeek'] = daysOfWeek;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    if (timeZone != null) {
      data['timeZone'] = timeZone!.toJson();
    }
    return data;
  }
}

class TimeZone {
  String? name;

  TimeZone({this.name});

  TimeZone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}