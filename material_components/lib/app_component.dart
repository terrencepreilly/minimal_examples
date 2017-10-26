import 'package:angular/angular.dart';

import 'package:material_components/multi_dropdown_select_component.dart';

@Component(
  selector: 'my-app',
  template:
      '''<multi-dropdown-select-example></multi-dropdown-select-example>''',
  styles: const [''''''],
  directives: const [MultiDropdownSelectComponent],
)
class AppComponent {}
