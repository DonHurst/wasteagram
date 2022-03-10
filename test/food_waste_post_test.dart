// import 'package: test/test.dart';
import 'package:wasteagram/models/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final date = DateTime.parse('2020-01-01');
  const url = 'FAKE';
  const quantity = 1;
  const latitude = 1.0;
  const longitude = 2.0;

  final wasteagram_post = WasteagramPost(
      imageURL: url,
      date: DateTime.parse('2020-01-01'),
      quantity: quantity,
      latitude: latitude,
      longitude: longitude);
  test('Post created from Map should have appropriate property values', () {
    expect(wasteagram_post.date, date);
    expect(wasteagram_post.imageURL, url);
    expect(wasteagram_post.quantity, quantity);
    expect(wasteagram_post.latitude, latitude);
    expect(wasteagram_post.longitude, longitude);
  });

  test(' Expect the post to have a quantity of 1', () {
    expect(wasteagram_post.quantity, 1);
  });

  test('Expect we have the correct latitude(1.0) and longitude(2.0)', () {
    expect(wasteagram_post.latitude, 1.0);
    expect(wasteagram_post.longitude, 2.0);
  });
}
