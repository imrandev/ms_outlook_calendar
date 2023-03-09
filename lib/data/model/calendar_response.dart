class CalendarResponse {
  String? odataContext;
  String? id;
  String? name;
  String? color;
  String? hexColor;
  bool? isDefaultCalendar;
  String? changeKey;
  bool? canShare;
  bool? canViewPrivateItems;
  bool? canEdit;
  List<String>? allowedOnlineMeetingProviders;
  String? defaultOnlineMeetingProvider;
  bool? isTallyingResponses;
  bool? isRemovable;
  Owner? owner;
  bool? isSuccess;
  String? message;

  CalendarResponse(
      {this.odataContext,
        this.id,
        this.name,
        this.color,
        this.hexColor,
        this.isDefaultCalendar,
        this.changeKey,
        this.canShare,
        this.canViewPrivateItems,
        this.canEdit,
        this.allowedOnlineMeetingProviders,
        this.defaultOnlineMeetingProvider,
        this.isTallyingResponses,
        this.isRemovable,
        this.isSuccess,
        this.message,
        this.owner});

  CalendarResponse.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    id = json['id'];
    name = json['name'];
    color = json['color'];
    hexColor = json['hexColor'];
    isDefaultCalendar = json['isDefaultCalendar'];
    changeKey = json['changeKey'];
    canShare = json['canShare'];
    canViewPrivateItems = json['canViewPrivateItems'];
    canEdit = json['canEdit'];
    allowedOnlineMeetingProviders =
        json['allowedOnlineMeetingProviders'].cast<String>();
    defaultOnlineMeetingProvider = json['defaultOnlineMeetingProvider'];
    isTallyingResponses = json['isTallyingResponses'];
    isRemovable = json['isRemovable'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@odata.context'] = odataContext;
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['hexColor'] = hexColor;
    data['isDefaultCalendar'] = isDefaultCalendar;
    data['changeKey'] = changeKey;
    data['canShare'] = canShare;
    data['canViewPrivateItems'] = canViewPrivateItems;
    data['canEdit'] = canEdit;
    data['allowedOnlineMeetingProviders'] = allowedOnlineMeetingProviders;
    data['defaultOnlineMeetingProvider'] = defaultOnlineMeetingProvider;
    data['isTallyingResponses'] = isTallyingResponses;
    data['isRemovable'] = isRemovable;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    return data;
  }
}

class Owner {
  String? name;
  String? address;

  Owner({this.name, this.address});

  Owner.fromJson(Map<String, dynamic> json) {
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