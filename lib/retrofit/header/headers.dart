dynamic loginHeader({required String deviceId, required String userType}) {
  dynamic header = {
    'DeviceID': deviceId,
    'is_driver': userType,
    'Content-Type': 'application/json; charset=utf-8'
  };
  return header;
}
