import UIFoundation

struct RepositoryListSectionAdapter: SectionAdapter {
    typealias Input = RepositoryListViewModel
    typealias Section = RepositoryListSection

    static func adapt(_ input: RepositoryListViewModel) -> [RepositoryListSection] {
        var sections = [RepositoryListSection]()

        let itemsSection = RepositoryListSection(items: input.items.map { RepositoryListSectionItem.repositoryListItem($0) })
        sections.append(itemsSection)

        return sections
    }
}
