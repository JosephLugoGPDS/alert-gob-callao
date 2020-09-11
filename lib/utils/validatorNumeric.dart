
bool isNumeric( String s) {
  if (s.isEmpty) return false;
  //parseamos a numero
  // final n = num.tryParse(s);
  final n = int.parse(s);

  return (n == null)? false: true;

}