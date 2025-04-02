import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/core/network/network_info.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test(
      'should return true when connectivity result is not none',
      () async {
        // Arrange
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.wifi);

        // Act
        final result = await networkInfo.isConnected;

        // Assert
        expect(result, true);
        verify(() => mockConnectivity.checkConnectivity());
      },
    );

    test(
      'should return false when connectivity result is none',
      () async {
        // Arrange
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.none);

        // Act
        final result = await networkInfo.isConnected;

        // Assert
        expect(result, false);
        verify(() => mockConnectivity.checkConnectivity());
      },
    );

    test(
      'should return true for mobile data connection',
      () async {
        // Arrange
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.mobile);

        // Act
        final result = await networkInfo.isConnected;

        // Assert
        expect(result, true);
      },
    );

    test(
      'should return true for ethernet connection',
      () async {
        // Arrange
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.ethernet);

        // Act
        final result = await networkInfo.isConnected;

        // Assert
        expect(result, true);
      },
    );

    test(
      'should return true for bluetooth connection',
      () async {
        // Arrange
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.bluetooth);

        // Act
        final result = await networkInfo.isConnected;

        // Assert
        expect(result, true);
      },
    );

    test(
      'should return true for vpn connection',
      () async {
        // Arrange
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.vpn);

        // Act
        final result = await networkInfo.isConnected;

        // Assert
        expect(result, true);
      },
    );

    test(
      'should handle connectivity check errors',
      () async {
        // Arrange
        when(() => mockConnectivity.checkConnectivity())
            .thenThrow(Exception('Connection failed'));

        // Act
        final result = await networkInfo.isConnected;

        // Assert
        expect(result, false);
      },
    );
  });
}
