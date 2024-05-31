import 'package:agri_app_2/crop/domain/crop_model.dart';
import 'package:agri_app_2/crop/domain/update_crop_model.dart';
import 'package:agri_app_2/crop/infrastructure/data_provider/crop_data_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'crop_data_provider_test.dart.mocks.dart';

@GenerateMocks([Dio, SharedPreferences])
void main() {
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;
  late CropDataProvider cropDataProvider;

  setUp(() {
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();
    cropDataProvider = CropDataProvider(mockDio, mockSharedPreferences);
  });

  group('CropDataProvider', () {
    group('createCrop', () {
      test('should return Crop when createCrop is successful', () async {
        // Arrange
        final crop = Crop(
          cropId: '1',
          cropName: 'Test Crop',
          cropType: 'Type of Crop',
          plantingDate:
              '12/04/2024', // Example date, replace with actual DateTime value
          harvestingDate:
              '12/04/2024', // Example date, replace with actual DateTime value
          price: '50.0', // Example price, replace with actual double value
          userId: 1, // Example user ID, replace with actual user ID value
        );
        final responsePayload = {
          'id': 1,
          "createdAt": "2024-06-16T17:00:40.779Z",
          "updatedAt": "2024-06-16T17:00:40.779Z",
          'cropName': 'Test Crop',
          'cropType': 'Type of Crop',
          'plantingDate':
              '12/04/2024', // Example date, replace with actual DateTime value
          'harvestingDate':
              '12/04/2024', // Example date, replace with actual DateTime value
          'price': '50.0', // Example price, replace with actual double value
          'userId': 1, // Example user ID, replace with actual user ID value
        };

        when(mockSharedPreferences.getString(any)).thenReturn('token');
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
              data: responsePayload,
              statusCode: 201,
              requestOptions: RequestOptions(path: ''),
            ));

        // Act
        final result = await cropDataProvider.createCrop(crop);

        // Assert
        expect(result, isA<Crop>());
        expect(result.cropId, crop.cropId);
        verify(mockDio.post(any,
                data: anyNamed('data'), options: anyNamed('options')))
            .called(1);
      });

    });
  }); 

    group('deleteCrop', () {
      test('should call Dio.delete when deleteCrop is successful', () async {
        // Arrange
        when(mockSharedPreferences.getString(any)).thenReturn('token');
        when(mockDio.delete(any, options: anyNamed('options')))
            .thenAnswer((_) async => Response(
                  data: 'Crop 1 is deleted!',
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        await cropDataProvider.deleteCrop('1');

        // Assert
        verify(mockDio.delete(any, options: anyNamed('options'))).called(1);
      });

    group('updateCrop', () {
      test('should return UpdateCropDto when updateCrop is successful',
          () async {
        // Arrange
        final updateCropDto = UpdateCropDto(
            cropName: 'Updated Crop',
            cropType: 'Type of Crop',
            plantingDate: '12/04/2024', // Example date, replace with actual DateTime value
            harvestingDate: '12/04/2024', // Example date, replace with actual DateTime value
            price: '60.0',
      );
        final responsePayload = {
          'id': 1,
          "createdAt": "2024-06-16T17:00:40.779Z",
          "updatedAt": "2024-06-16T17:02:43.930Z",
          'cropName': 'Updated Crop',
          'cropType': 'Type of Crop',
          'plantingDate':
              '12/04/2024', // Example date, replace with actual DateTime value
          'harvestingDate':
              '12/04/2024', // Example date, replace with actual DateTime value
          'price': '50.0', // Example price, replace with actual double value
          'userId': 1,
        };

        when(mockSharedPreferences.getString(any)).thenReturn('token');
        when(mockDio.patch(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
              data: responsePayload,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ));

        // Act
        final result = await cropDataProvider.updateCrop('1', updateCropDto);

        // Assert
        expect(result, isA<UpdateCropDto>());
        expect(result.cropName, updateCropDto.cropName);
        verify(mockDio.patch(any,
                data: anyNamed('data'), options: anyNamed('options')))
            .called(1);
      });
    });

    group('getCropById', () {
      test('should return List<Crop> when getCropById is successful', () async {
        // Arrange
        final responsePayload = [
          {'id': 1,
          "createdAt": "2024-06-16T17:00:40.779Z",
          "updatedAt": "2024-06-16T17:02:43.930Z", 
          'cropName': 'Test Crop',
          'cropType': 'Type of Crop',
          'plantingDate':
              '12/04/2024', // Example date, replace with actual DateTime value
          'harvestingDate':
              '12/04/2024', // Example date, replace with actual DateTime value
          'price': '50.0', // Example price, replace with actual double value
          'userId': 1,}
        ];

        when(mockSharedPreferences.getString(any)).thenReturn('token');
        when(mockDio.get(any, options: anyNamed('options')))
            .thenAnswer((_) async => Response(
                  data: responsePayload,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        // Act
        final result = await cropDataProvider.getCropById(1);

        // Assert
        expect(result, isA<List<Crop>>());
        expect(result.first.cropId, '1');
        verify(mockDio.get(any, options: anyNamed('options'))).called(1);
      });
    });

    group('getCrops', () {
      test('should return List<Crop> when getCrops is successful', () async {
        // Arrange
        final responsePayload = [
          {'id': 1,
          "createdAt": "2024-06-16T17:00:40.779Z",
          "updatedAt": "2024-06-16T17:02:43.930Z",
           'cropName': 'Test Crop',
          'cropType': 'Type of Crop',
          'plantingDate':
              '12/04/2024', // Example date, replace with actual DateTime value
          'harvestingDate':
              '12/04/2024', // Example date, replace with actual DateTime value
          'price': '50.0', // Example price, replace with actual double value
          'userId': 1,}
        ];

        when(mockSharedPreferences.getString(any)).thenReturn('token');
        when(mockDio.get(any, options: anyNamed('options')))
            .thenAnswer((_) async => Response(
                  data: responsePayload,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: ''),
                ));

        // Act
        final result = await cropDataProvider.getCrops();

        // Assert
        expect(result, isA<List<Crop>>());
        expect(result.first.cropId, '1');
        verify(mockDio.get(any, options: anyNamed('options'))).called(1);
      });
    });
  });
}
