import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'app',
    directives: [MaterialTreeComponent],
    providers: [datepickerBindings],
    template: '''
  <div class="shadow" style="width: 400px; margin: 24px;">
        <div style="padding: 8px">
          <strong>Selected:</strong> {{singleSelection.selectedValues}}
        </div>
      </div>
      <div class="shadow" style="width: 400px; margin: 24px;">
          <material-tree
          [options]="nestedOptions"
          [selection]="singleSelection">
        </material-tree>
      </div>
  ''')
class AppComponent {
  final SelectionOptions nestedOptions = _nestedOptions;
  final SelectionModel singleSelection = SelectionModel.single();
}

final _commonParentChildrenMap = {
  'Animated Feature Films': [
    OptionGroup([
      'Cinderalla',
      'Alice In Wonderland',
      'Peter Pan',
      'Lady and the Tramp',
    ])
  ],
  'Live-Action Films': [
    OptionGroup(
        ['Treasure Island', 'The Littlest Outlaw', 'Old Yeller', 'Star Wars'])
  ],
  'Documentary Films': [
    OptionGroup(['Frank and Ollie', 'Sacred Planet'])
  ],
  'Star Wars': [
    OptionGroup(['By George Lucas'])
  ],
  'By George Lucas': [
    OptionGroup(['A New Hope', 'Empire Strikes Back', 'Return of the Jedi'])
  ]
};

/// An example data set of hierarchical data.
final SelectionOptions _nestedOptions = _NestedSelectionOptions([
  OptionGroup(
      ['Animated Feature Films', 'Live-Action Films', 'Documentary Films'])
], _commonParentChildrenMap);

/// An example implementation of [SelectionOptions] with [Parent].
class _NestedSelectionOptions<T> extends SelectionOptions<T>
    implements Parent<T, List<OptionGroup<T>>> {
  final Map<T, List<OptionGroup<T>>> _children;

  _NestedSelectionOptions(List<OptionGroup<T>> options, this._children)
      : super(options);

  @override
  bool hasChildren(T item) => _children.containsKey(item);

  @override
  DisposableFuture<List<OptionGroup<T>>> childrenOf(T parent, [_]) {
    return DisposableFuture<List<OptionGroup<T>>>.fromValue(_children[parent]);
  }
}
