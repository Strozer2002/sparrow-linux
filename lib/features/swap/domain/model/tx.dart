class Tx {
  String from;

  String to;

  String data;

  String value;

  int gas;

  String gasPrice;

  Tx({
    required this.data,
    required this.from,
    required this.gas,
    required this.gasPrice,
    required this.to,
    required this.value,
  });
}
