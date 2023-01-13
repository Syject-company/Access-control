import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/features/data/api_provider.dart';
import 'package:safe_access/features/data/entities/responses/user_data_response_model.dart';
import 'package:safe_access/features/domain/exceptions/exceptions.dart';

mixin UserManager {
  Future<UserDataResponseModel> getUserData() => getIt<ApiProvider>()
      .getUserData()
      .timeout(getIt<ApiProvider>().timeout)
      .catchError(
          (dynamic onError) => throw error(onError, isGetUserData: true));
}
