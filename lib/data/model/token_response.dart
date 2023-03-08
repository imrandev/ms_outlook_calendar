class TokenResponse {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? scope;
  String? refreshToken;
  bool? isSuccess = false;
  String? message;

  TokenResponse(
      {this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.scope,
        this.message,
        this.isSuccess,
        this.refreshToken});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['scope'] = scope;
    data['refresh_token'] = refreshToken;
    return data;
  }
}