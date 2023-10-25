import 'package:hive_flutter/hive_flutter.dart';

import 'flow/built_list_node_adapter.dart';
import 'flow/built_list_text_adapter.dart';
import 'flow/login_flow_adapter.dart';
import 'flow/registration_flow_adapter.dart';
import 'flow/ui_container_adapter.dart';
import 'flow/ui_node_adapter.dart';
import 'flow/ui_text_adapter.dart';
import 'flow/verification_flow_adapter.dart';
import 'general/map_json_object_adapter.dart';
import 'identity/built_list_recovery_identity_address_adapter.dart';
import 'identity/built_list_verifiable_identity_address_adapter.dart';
import 'identity/identity_adapter.dart';
import 'identity/identity_credentials_adapter.dart';
import 'identity/identity_state_adapter.dart';
import 'identity/recovery_address_adapter.dart';
import 'identity/verifiable_identity_address_adapter.dart';
import 'session/authenticator_assurance_level_adapter.dart';
import 'session/built_list_authentication_method_adapter.dart';
import 'session/session_adapter.dart';
import 'session/session_authentication_method_adapter.dart';
import 'session/session_authentication_method_method_enum_adapter.dart';

class AdaptersRegistrar {
  AdaptersRegistrar();

  static void registerGeneralAdapters() {
    Hive.registerAdapter(MapJsonObjectAdapter());
  }

  static void registerFlowAdapters() {
    Hive
      ..registerAdapter(UINodeAdapter())
      ..registerAdapter(BuiltListNodeAdapter())
      ..registerAdapter(UITextAdapter())
      ..registerAdapter(BuiltListTextAdapter())
      ..registerAdapter(UIContainerAdapter())
      ..registerAdapter(LoginFlowAdapter())
      ..registerAdapter(RegistrationFlowAdapter())
      ..registerAdapter(VerificationFlowAdapter());
  }

  static void registerIdentityAdapters() {
    Hive
      ..registerAdapter(RecoveryAddressAdapter())
      ..registerAdapter(BuiltListRecoveryAddressAdapter())
      ..registerAdapter(VerifiableIdentityAddressAdapter())
      ..registerAdapter(BuiltListVerifiableIdentityAddressAdapter())
      ..registerAdapter(IdentityCredentialsAdapter())
      ..registerAdapter(IdentityStateAdapter())
      ..registerAdapter(IdentityAdapter());
  }

  static void registerSessionAdapters() {
    Hive
      ..registerAdapter(AuthenticatorAssuranceLevelAdapter())
      ..registerAdapter(SessionAuthenticationMethodAdapter())
      ..registerAdapter(BuiltListSessionAuthenticationMethodAdapter())
      ..registerAdapter(SessionAuthenticationMethodMethodEnumAdapter())
      ..registerAdapter(SessionAdapter());
  }
}
