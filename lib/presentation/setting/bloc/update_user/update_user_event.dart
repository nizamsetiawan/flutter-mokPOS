part of 'update_user_bloc.dart';

@freezed
class UpdateUserEvent with _$UpdateUserEvent {
  const factory UpdateUserEvent.started() = _Started;

  const factory UpdateUserEvent.updateUser(
      RegisterRequestModel dataUser, XFile image) = _UpdateUser;
}
