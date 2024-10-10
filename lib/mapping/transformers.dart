/// Приводит данные к типу Map<String, dynamic> либо null
Map<String, dynamic>? transformToJsonMap(dynamic data) {
  if (data is! Map) {
    return null;
  }
  try {
    return data.cast<String, dynamic>();
  } catch (e) {
    return null;
  }
}

Uri? transformToUri(dynamic data) {
  final appLink = transformToJsonMap(data)?['uriStr'];

  return appLink == null ? null : Uri.parse(appLink!);
}
