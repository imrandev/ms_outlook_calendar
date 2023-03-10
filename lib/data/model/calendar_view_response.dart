class EventResponse {
  String? odataContext;
  List<Value>? value;
  String? odataNextLink;
  bool? isSuccess;
  String? message;
  String? availabilityView;
  String? owner;


  EventResponse({this.odataContext, this.value, this.odataNextLink,
    this.isSuccess, this.message, this.availabilityView, this.owner,});

  EventResponse.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(Value.fromJson(v));
      });
    }
    odataNextLink = json['@odata.nextLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@odata.context'] = odataContext;
    if (value != null) {
      data['value'] = value!.map((v) => v.toJson()).toList();
    }
    data['@odata.nextLink'] = odataNextLink;
    return data;
  }
}

class Value {
  String? odataEtag;
  String? id;
  String? createdDateTime;
  String? lastModifiedDateTime;
  String? changeKey;
  String? originalStartTimeZone;
  String? originalEndTimeZone;
  String? iCalUId;
  int? reminderMinutesBeforeStart;
  bool? isReminderOn;
  bool? hasAttachments;
  String? subject;
  String? bodyPreview;
  String? importance;
  String? sensitivity;
  bool? isAllDay;
  bool? isCancelled;
  bool? isOrganizer;
  bool? responseRequested;
  String? seriesMasterId;
  String? showAs;
  String? type;
  String? webLink;
  bool? isOnlineMeeting;
  String? onlineMeetingProvider;
  bool? allowNewTimeProposals;
  String? occurrenceId;
  bool? isDraft;
  bool? hideAttendees;
  ResponseStatus? responseStatus;
  Body? body;
  Start? start;
  Start? end;
  Location? location;
  List<Attendees>? attendees;
  Organizer? organizer;
  OnlineMeeting? onlineMeeting;

  Value(
      {this.odataEtag,
        this.id,
        this.createdDateTime,
        this.lastModifiedDateTime,
        this.changeKey,
        this.originalStartTimeZone,
        this.originalEndTimeZone,
        this.iCalUId,
        this.reminderMinutesBeforeStart,
        this.isReminderOn,
        this.hasAttachments,
        this.subject,
        this.bodyPreview,
        this.importance,
        this.sensitivity,
        this.isAllDay,
        this.isCancelled,
        this.isOrganizer,
        this.responseRequested,
        this.seriesMasterId,
        this.showAs,
        this.type,
        this.webLink,
        this.isOnlineMeeting,
        this.onlineMeetingProvider,
        this.allowNewTimeProposals,
        this.occurrenceId,
        this.isDraft,
        this.hideAttendees,
        this.responseStatus,
        this.body,
        this.start,
        this.end,
        this.location,
        this.attendees,
        this.organizer,
        this.onlineMeeting});

  Value.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    id = json['id'];
    createdDateTime = json['createdDateTime'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    changeKey = json['changeKey'];
    originalStartTimeZone = json['originalStartTimeZone'];
    originalEndTimeZone = json['originalEndTimeZone'];
    iCalUId = json['iCalUId'];
    reminderMinutesBeforeStart = json['reminderMinutesBeforeStart'];
    isReminderOn = json['isReminderOn'];
    hasAttachments = json['hasAttachments'];
    subject = json['subject'];
    bodyPreview = json['bodyPreview'];
    importance = json['importance'];
    sensitivity = json['sensitivity'];
    isAllDay = json['isAllDay'];
    isCancelled = json['isCancelled'];
    isOrganizer = json['isOrganizer'];
    responseRequested = json['responseRequested'];
    seriesMasterId = json['seriesMasterId'];
    showAs = json['showAs'];
    type = json['type'];
    webLink = json['webLink'];
    isOnlineMeeting = json['isOnlineMeeting'];
    onlineMeetingProvider = json['onlineMeetingProvider'];
    allowNewTimeProposals = json['allowNewTimeProposals'];
    occurrenceId = json['occurrenceId'];
    isDraft = json['isDraft'];
    hideAttendees = json['hideAttendees'];
    responseStatus = json['responseStatus'] != null
        ? ResponseStatus.fromJson(json['responseStatus'])
        : null;
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
    start = json['start'] != null ? Start.fromJson(json['start']) : null;
    end = json['end'] != null ? Start.fromJson(json['end']) : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    if (json['attendees'] != null) {
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(Attendees.fromJson(v));
      });
    }
    organizer = json['organizer'] != null
        ? Organizer.fromJson(json['organizer'])
        : null;
    onlineMeeting = json['onlineMeeting'] != null
        ? OnlineMeeting.fromJson(json['onlineMeeting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@odata.etag'] = odataEtag;
    data['id'] = id;
    data['createdDateTime'] = createdDateTime;
    data['lastModifiedDateTime'] = lastModifiedDateTime;
    data['changeKey'] = changeKey;
    data['originalStartTimeZone'] = originalStartTimeZone;
    data['originalEndTimeZone'] = originalEndTimeZone;
    data['iCalUId'] = iCalUId;
    data['reminderMinutesBeforeStart'] = reminderMinutesBeforeStart;
    data['isReminderOn'] = isReminderOn;
    data['hasAttachments'] = hasAttachments;
    data['subject'] = subject;
    data['bodyPreview'] = bodyPreview;
    data['importance'] = importance;
    data['sensitivity'] = sensitivity;
    data['isAllDay'] = isAllDay;
    data['isCancelled'] = isCancelled;
    data['isOrganizer'] = isOrganizer;
    data['responseRequested'] = responseRequested;
    data['seriesMasterId'] = seriesMasterId;
    data['showAs'] = showAs;
    data['type'] = type;
    data['webLink'] = webLink;
    data['isOnlineMeeting'] = isOnlineMeeting;
    data['onlineMeetingProvider'] = onlineMeetingProvider;
    data['allowNewTimeProposals'] = allowNewTimeProposals;
    data['occurrenceId'] = occurrenceId;
    data['isDraft'] = isDraft;
    data['hideAttendees'] = hideAttendees;
    if (responseStatus != null) {
      data['responseStatus'] = responseStatus!.toJson();
    }
    if (body != null) {
      data['body'] = body!.toJson();
    }
    if (start != null) {
      data['start'] = start!.toJson();
    }
    if (end != null) {
      data['end'] = end!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (attendees != null) {
      data['attendees'] = attendees!.map((v) => v.toJson()).toList();
    }
    if (organizer != null) {
      data['organizer'] = organizer!.toJson();
    }
    if (onlineMeeting != null) {
      data['onlineMeeting'] = onlineMeeting!.toJson();
    }
    return data;
  }
}

class ResponseStatus {
  String? response;
  String? time;

  ResponseStatus({this.response, this.time});

  ResponseStatus.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    data['time'] = time;
    return data;
  }
}

class Body {
  String? contentType;
  String? content;

  Body({this.contentType, this.content});

  Body.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contentType'] = contentType;
    data['content'] = content;
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

class Location {
  String? displayName;
  String? locationType;
  String? uniqueId;
  String? uniqueIdType;

  Location(
      {this.displayName, this.locationType, this.uniqueId, this.uniqueIdType});

  Location.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    locationType = json['locationType'];
    uniqueId = json['uniqueId'];
    uniqueIdType = json['uniqueIdType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['locationType'] = locationType;
    data['uniqueId'] = uniqueId;
    data['uniqueIdType'] = uniqueIdType;
    return data;
  }
}

class Attendees {
  String? type;
  ResponseStatus? status;
  EmailAddress? emailAddress;

  Attendees({this.type, this.status, this.emailAddress});

  Attendees.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status = json['status'] != null
        ? ResponseStatus.fromJson(json['status'])
        : null;
    emailAddress = json['emailAddress'] != null
        ? EmailAddress.fromJson(json['emailAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (emailAddress != null) {
      data['emailAddress'] = emailAddress!.toJson();
    }
    return data;
  }
}

class EmailAddress {
  String? name;
  String? address;

  EmailAddress({this.name, this.address});

  EmailAddress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}

class Organizer {
  EmailAddress? emailAddress;

  Organizer({this.emailAddress});

  Organizer.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'] != null
        ? EmailAddress.fromJson(json['emailAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (emailAddress != null) {
      data['emailAddress'] = emailAddress!.toJson();
    }
    return data;
  }
}

class OnlineMeeting {
  String? joinUrl;

  OnlineMeeting({this.joinUrl});

  OnlineMeeting.fromJson(Map<String, dynamic> json) {
    joinUrl = json['joinUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['joinUrl'] = joinUrl;
    return data;
  }
}