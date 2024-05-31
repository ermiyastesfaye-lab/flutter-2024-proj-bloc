// crop_bloc_test.dart

import 'package:agri_app_2/crop/bloc/crop_bloc.dart';
import 'package:agri_app_2/crop/bloc/crop_event.dart';
import 'package:agri_app_2/crop/bloc/crop_state.dart';
import 'package:agri_app_2/crop/domain/crop_model.dart';
import 'package:agri_app_2/crop/domain/update_crop_model.dart';
import 'package:agri_app_2/crop/infrastructure/repository/crop_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockCropRepository extends Mock implements CropRepository {}

// Fake classes
class FakeCrop extends Fake implements Crop {}
class FakeUpdateCropDto extends Fake implements UpdateCropDto {}

void main() {
  
  late CropBloc cropBloc;
  late MockCropRepository mockCropRepository;
  
  setUpAll(() {
    registerFallbackValue(FakeCrop());
    registerFallbackValue(FakeUpdateCropDto());
  });

  setUp(() {
    mockCropRepository = MockCropRepository();
    cropBloc = CropBloc(mockCropRepository);
  });

  tearDown(() {
    cropBloc.close();
  });

  group('CropBloc Tests', () {
    final testCrop = Crop(
  cropName: 'Test Crop',
  cropType: 'Type of Crop',
  plantingDate: '12/04/2024', // Example date, replace with actual DateTime value
  harvestingDate: '12/04/2024', // Example date, replace with actual DateTime value
  price: '50.0', // Example price, replace with actual double value
  userId: 1, // Example user ID, replace with actual user ID value
);

    final testUpdateCropDto = UpdateCropDto(
      cropName: 'Updated Crop',
      cropType: 'Type of Crop',
      plantingDate: '12/04/2024', // Example date, replace with actual DateTime value
      harvestingDate: '12/04/2024', // Example date, replace with actual DateTime value
      price: '60.0', // Example price, replace with actual double value
);


    blocTest<CropBloc, CropState>(
      'emits [CropLoadingState, CropSuccessState] when CreateCropEvent is added',
      build: () {
        when(() => mockCropRepository.createCrop(any(that: isA<Crop>())))
    .thenAnswer((_) async => Crop(
          cropName: 'Updated Crop',
          cropType: 'Type of Crop',
          plantingDate: '12/04/2024', // Example date, replace with actual DateTime value
          harvestingDate: '12/04/2024', // Example date, replace with actual DateTime value
          price: '60.0',
          userId: 1,
        ));
        return cropBloc;
      },
      act: (bloc) => bloc.add(CreateCropEvent(testCrop)),
      expect: () => [CropLoadingState(), const CropSuccessState('Crop created successfully!')],
    );

    blocTest<CropBloc, CropState>(
      'emits [CropLoadingState, CropSuccessState] when DeleteCropEvent is added',
      build: () {
        when(() => mockCropRepository.deleteCrop('1')).thenAnswer((_) async => {});
        return cropBloc;
      },
      act: (bloc) => bloc.add(const DeleteCropEvent('1')),
      expect: () => [CropLoadingState(), const CropSuccessState('Crop deleted successfully!')],
    );

    blocTest<CropBloc, CropState>(
      'emits [CropLoadingState, CropSuccessState] when UpdateCropEvent is added',
      build: () {
        when(() => mockCropRepository.updateCrop('1', any(that: isA<UpdateCropDto>())))
    .thenAnswer((_) async => UpdateCropDto(
          cropName: 'Updated Crop',
          cropType: 'Type of Crop',
          plantingDate: '12/04/2024', // Example date, replace with actual DateTime value
          harvestingDate: '12/04/2024', // Example date, replace with actual DateTime value
          price: '60.0',
        ));
        return cropBloc;
      },
      act: (bloc) => bloc.add(UpdateCropEvent(cropId: '1', crop: testUpdateCropDto)),
      expect: () => [CropLoadingState(), const CropSuccessState('Crop updated successfully!')],
    );

    blocTest<CropBloc, CropState>(
      'emits [CropLoadingState, CropLoadedState] when GetCropsByIdEvent is added',
      build: () {
        when(() => mockCropRepository.getCropById(1)).thenAnswer((_) async => [testCrop]);
        return cropBloc;
      },
      act: (bloc) => bloc.add(GetCropsByIdEvent(cropId: 1)),
      expect: () => [CropLoadingState(), CropLoadedState([testCrop])],
    );

    blocTest<CropBloc, CropState>(
      'emits [CropsLoadingState, CropLoadedState] when GetCropsEvent is added',
      build: () {
        when(() => mockCropRepository.getCrops()).thenAnswer((_) async => [testCrop]);
        return cropBloc;
      },
      act: (bloc) => bloc.add(const GetCropsEvent()),
      expect: () => [const CropsLoadingState(), CropLoadedState([testCrop])],
    );

    blocTest<CropBloc, CropState>(
      'emits [CropsLoadingState, CropLoadedState] when GetOrderCropsEvent is added',
      build: () {
        when(() => mockCropRepository.getOrderCrops()).thenAnswer((_) async => [testCrop]);
        return cropBloc;
      },
      act: (bloc) => bloc.add(const GetOrderCropsEvent()),
      expect: () => [const CropsLoadingState(), CropLoadedState([testCrop])],
    );
  });
}
