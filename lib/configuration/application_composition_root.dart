import '../presentation/presenters/main_presenter.dart';
import '../presentation/screens/main_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../store/data_repository.dart';
import '../store/standard_data_repository.dart';

class ApplicationCompositionRoot {
  ApplicationCompositionRoot._() {
    _dataRepository = _createDataRepository();
  }

  static final ApplicationCompositionRoot instance = _me;

  static final ApplicationCompositionRoot _me = ApplicationCompositionRoot._();

  late final DataRepository _dataRepository;

  // Repository factories
  DataRepository _createDataRepository() => StandardDataRepository();

  // Presenter factories
  MainPresenter _createMainPresenter() => MainPresenter(_dataRepository);

  // Screen public factories
  LoginScreen newLoginScreen() => const LoginScreen();

  MainScreen newMainScreen() => MainScreen(presenter: _createMainPresenter());
}
