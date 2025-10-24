// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:messenger_app/app/DI/register_module.dart' as _i315;
import 'package:messenger_app/app/navigation/app_router.dart' as _i912;
import 'package:messenger_app/features/auth_feature/data/datasources/auth_local_data_source.dart'
    as _i308;
import 'package:messenger_app/features/auth_feature/data/datasources/auth_remote_data_source.dart'
    as _i473;
import 'package:messenger_app/features/auth_feature/data/repos/auth_repo.dart'
    as _i330;
import 'package:messenger_app/features/auth_feature/domain/repos/auth_interface.dart'
    as _i344;
import 'package:messenger_app/features/auth_feature/domain/usecases/check_auth_status.dart'
    as _i472;
import 'package:messenger_app/features/auth_feature/domain/usecases/login.dart'
    as _i497;
import 'package:messenger_app/features/auth_feature/domain/usecases/logout.dart'
    as _i635;
import 'package:messenger_app/features/auth_feature/domain/usecases/register.dart'
    as _i457;
import 'package:messenger_app/features/auth_feature/ui/bloc/auth_bloc.dart'
    as _i401;
import 'package:messenger_app/features/chat_feature/data/repos/chat_repo.dart'
    as _i134;
import 'package:messenger_app/features/chat_feature/domain/repos/chat_interface.dart'
    as _i571;
import 'package:messenger_app/features/chat_feature/domain/usecases/get_messager.dart'
    as _i640;
import 'package:messenger_app/features/chat_feature/domain/usecases/send_message.dart'
    as _i424;
import 'package:messenger_app/features/chat_feature/ui/bloc/chat_bloc.dart'
    as _i350;
import 'package:messenger_app/features/home_feature/data/repos/home_repo.dart'
    as _i822;
import 'package:messenger_app/features/home_feature/domain/repos/home_interface.dart'
    as _i822;
import 'package:messenger_app/features/home_feature/domain/usecases/delete_chat.dart'
    as _i257;
import 'package:messenger_app/features/home_feature/domain/usecases/get_chats.dart'
    as _i545;
import 'package:messenger_app/features/home_feature/ui/bloc/home_bloc.dart'
    as _i409;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i912.AppRouter>(() => _i912.AppRouter());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i822.HomeInterface>(() => _i822.HomeRepositoryMock());
    gh.lazySingleton<_i473.AuthRemoteDataSource>(
      () => _i473.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i571.ChatInterface>(() => _i134.ChatRepository());
    gh.lazySingleton<_i640.GetMessages>(
      () => _i640.GetMessages(gh<_i571.ChatInterface>()),
    );
    gh.lazySingleton<_i424.SendMessage>(
      () => _i424.SendMessage(gh<_i571.ChatInterface>()),
    );
    gh.lazySingleton<_i308.AuthLocalDataSource>(
      () => _i308.AuthLocalDataSource(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i350.ChatBloc>(
      () => _i350.ChatBloc(
        gh<_i640.GetMessages>(),
        gh<_i424.SendMessage>(),
        gh<_i571.ChatInterface>(),
      ),
    );
    gh.lazySingleton<_i344.AuthInterface>(
      () => _i330.AuthRepositoryImpl(
        gh<_i473.AuthRemoteDataSource>(),
        gh<_i308.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i257.DeleteChat>(
      () => _i257.DeleteChat(gh<_i822.HomeInterface>()),
    );
    gh.lazySingleton<_i545.GetChats>(
      () => _i545.GetChats(gh<_i822.HomeInterface>()),
    );
    gh.factory<_i409.HomeBloc>(
      () => _i409.HomeBloc(
        getChats: gh<_i545.GetChats>(),
        repository: gh<_i822.HomeInterface>(),
      ),
    );
    gh.lazySingleton<_i472.CheckAuthStatus>(
      () => _i472.CheckAuthStatus(gh<_i344.AuthInterface>()),
    );
    gh.lazySingleton<_i497.Login>(() => _i497.Login(gh<_i344.AuthInterface>()));
    gh.lazySingleton<_i635.Logout>(
      () => _i635.Logout(gh<_i344.AuthInterface>()),
    );
    gh.lazySingleton<_i457.Register>(
      () => _i457.Register(gh<_i344.AuthInterface>()),
    );
    gh.lazySingleton<_i401.AuthBloc>(
      () => _i401.AuthBloc(
        gh<_i472.CheckAuthStatus>(),
        gh<_i497.Login>(),
        gh<_i457.Register>(),
        gh<_i635.Logout>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i315.RegisterModule {}
