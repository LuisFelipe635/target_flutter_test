import '../presentation/presenters/home_presenter.dart';
import '../presentation/screens/home_screen.dart';
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
  HomePresenter _createHomePresenter() => HomePresenter(_dataRepository);

  // Screen public factories
  LoginScreen newLoginScreen() => const LoginScreen();

  HomeScreen newHomeScreen() => HomeScreen(presenter: _createHomePresenter());
}
