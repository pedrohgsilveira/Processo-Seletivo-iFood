import UIKit

public protocol SectionModelType {
    associatedtype Item

    var items: [Item] { get }
}

public protocol SectionAdapter {
    associatedtype Input
    associatedtype Section

    static func adapt(_ input: Input) -> [Section]
}

open class EndlessScrollTableView<Adapter, ViewModel>: UITableView
where
Adapter: SectionAdapter,
Adapter.Input == ViewModel,
Adapter.Section: SectionModelType & Hashable,
Adapter.Section.Item: Hashable {
    public typealias Section = Adapter.Section
    public typealias Item = Section.Item

    private var addedSessions: Set<Section> = []

    private let didEndScroll: () -> Void

    private lazy var tableViewDelegate = EndlessScrollTableViewDelegate(didEndScroll: didEndScroll)

    private var tableViewDataSource: UITableViewDiffableDataSource<Section, Item>?

    public init(
        didEndScroll: @escaping () -> Void
    ) {
        self.didEndScroll = didEndScroll

        super.init(frame: .zero, style: .plain)

        setupTableView()
        registerCells()
        configureDataSource()
    }

    @available (*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func registerCells() {
        preconditionFailure("This method must be overrided")
    }

    open func configureTableViewCell(
        _ tableView: UITableView,
        at indexPath: IndexPath,
        item: Item
    ) -> UITableViewCell {
        preconditionFailure("This method must be overrided")
    }

    public func appendSections(
        from viewModel: ViewModel
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()

        Adapter.adapt(viewModel).forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems(section.items, toSection: section)
        }

        tableViewDataSource?.apply(snapshot, animatingDifferences: false)
    }

    private func setupTableView() {
        separatorStyle = .singleLine
        delegate = tableViewDelegate
    }

    private func configureDataSource() {
        tableViewDataSource = UITableViewDiffableDataSource<Section, Item>(tableView: self) { [weak self] tableView, indexPath, item in
            guard let self else { return nil }

            return self.configureTableViewCell(tableView, at: indexPath, item: item)
        }

        dataSource = tableViewDataSource
    }
}
