import 'package:design_patterns/patterns/fecade/model/user_profile.dart';

final class UserProfileService {
  Future<UserProfile> getUserProfile() {
    return Future.value(UserProfile());
  }
}
