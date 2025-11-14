import 'package:bloc/bloc.dart';
import 'package:tapcounter/features/widgets/bottom_nav_bar.dart';

///manages state in[BottomNavBarPage]
class NavBarCubit extends Cubit<int> {
  NavBarCubit() : super(0);

  void setIndex(int index) => emit(index);
}
