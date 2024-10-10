enum Methods {
  newUri('newUri');

  final String value;

  const Methods(this.value);

  bool equals(String text) => text == value;
}
