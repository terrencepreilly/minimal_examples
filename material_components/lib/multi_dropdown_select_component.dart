/// This module gives an example of using an Angular Materials
/// dropdown select.  This is the minimal amount of code that
/// covers most of the use-cases I encounter.  It could be made
/// simpler (say by not updating a model dynamically, or by passing
/// the options directly into the template.  But, then it would
/// cover only a couple of marginal use-cases.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

const List<String> _options = const <String>[
  'Item 1',
  'Item 2',
  'Item 3',
];

/// The simplest way (That I can find) to implement a multi-select
/// to update a model with a material dropdown select.
///
/// This updates the model dynamically.  There is probably a way to
/// just grab the selected options all at once, say when a user
/// hits a submit button.  That would make this simpler, but then we
/// wouldn't be able to dynamically render a model (which I end up
/// doing much more often.)
@Component(
  selector: 'multi-dropdown-select-example',
  template: '''
  <material-dropdown-select
    buttonText="Select Something"
    [selection]="selectedItems"
    [itemRenderer]="renderer"
    [options]="options">
  </material-dropdown-select>
  ''',
  styles: const [''],
  directives: const [materialDirectives],

  /// Needed or else we get error for DomPopupSourceFactory.
  providers: const [materialProviders],
)
class MultiDropdownSelectComponent implements OnInit {
  /// The items which have been selected.  We have to listen
  /// to events from this model to actually do anything. (See [_onSelection])
  ///
  /// If we want to change to a single-select, then we would just change
  /// [allowMulti] to false.
  final SelectionModel<String> selectedItems =
      new SelectionModel<String>.withList(allowMulti: true);

  /// The options we want to select from.
  final SelectionOptions<String> options =
      new SelectionOptions.fromList(_options);

  /// How to render the options.  Since the options are just strings,
  /// we just use the identity function.
  ///
  /// If using a class-based approach, this would be replaced by
  /// a class which implements [HasUIDisplayName].  Then we would pass
  /// the instances of these options into a [StringSelectionOptions],
  /// and use that instead of the [SelectionOptions] above.
  ItemRenderer<String> renderer = (x) => x;

  /// The actual listener for changes done to the multi-select.
  /// We would use this to actually update our model.
  Future _onSelection(
      Stream<List<SelectionChangeRecord<String>>> stream) async {
    await for (List<SelectionChangeRecord<String>> records in stream) {
      for (SelectionChangeRecord<String> record in records) {
        for (String option in record.added) {
          print('Added $option');
        }
        for (String option in record.removed) {
          print('Removed $option');
        }
      }
    }
  }

  void ngOnInit() {
    /// Bind the listener when initializing the component to capture changes.
    _onSelection(selectedItems.selectionChanges);
  }
}
